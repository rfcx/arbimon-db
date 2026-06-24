-- Archiving (Phase A): introduce a soft "archived" tier for recordings.
--
-- Until now `recordings` had no soft-delete column and the user/API "delete"
-- hard-dropped the row (+ analysis children + S3 audio). We are replacing that
-- with an "Archive" concept: archived recordings stay in the table but are
-- excluded from all primary/active read paths by default. `archived_at IS NULL`
-- means active; a non-null timestamp means archived. `archived_by` records the
-- acting user_id (nullable; system/API archives may leave it null).
--
-- This migration is ADDITIVE (no row rewrite of existing data) and introduces
-- NO behavior change on its own -- the read paths are made archive-aware
-- separately in arbimon-legacy (Phase A code change). See rfcx-local
-- runbooks/DESIGN-archiving-instead-of-delete-arbimon-2026-06-16.md.
--
-- MariaDB has no partial indexes (no `... WHERE archived_at IS NULL`), so we add
-- a composite index leading with the columns the active recording queries filter
-- on (site_id, archived_at) plus a plain archived_at index for the "View
-- Archived" (archived=only) listing.
--
-- IMPORTANT -- live-apply procedure (rfcx-local production, ~298M-row table):
--   A plain `ADD COLUMN archived_at ...` is NOT instant here, because the table
--   carries an INDEXED VIRTUAL column (`recordings_site_filename_idx` on the
--   generated `filename` column, migration 068). An indexed virtual column
--   forces a full table rebuild for any column add, and MariaDB rejects both
--   ALGORITHM=INSTANT and LOCK=NONE for that rebuild (only LOCK=SHARED, which
--   blocks writes to the system-of-record for the whole rebuild). To keep the
--   add ONLINE with no write block, applied 2026-06-24 in this order:
--     1. DROP INDEX recordings_site_filename_idx          (INPLACE, LOCK=NONE)
--        -- filename sort degrades to default order via the arbimon-legacy
--           defensive .catch fallback for the brief window
--     2. ADD COLUMN archived_at, archived_by              (ALGORITHM=INSTANT)
--        -- now metadata-only, no rebuild, no write block
--     3. re-CREATE INDEX recordings_site_filename_idx     (INPLACE, LOCK=NONE)
--     4. ADD INDEX recs_active_by_site, recs_archived_at  (INPLACE, LOCK=NONE)
--   On a FRESH bootstrap (no rows / no filename index yet) the simple form below
--   is instant and the drop/recreate dance is unnecessary -- IF NOT EXISTS keeps
--   re-runs safe either way.

ALTER TABLE `arbimon2`.`recordings`
  ADD COLUMN IF NOT EXISTS `archived_at` DATETIME DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `archived_by` INT UNSIGNED DEFAULT NULL,
  ALGORITHM=INSTANT;

-- Keeps the default "active only" recording listing selective as the archived
-- set grows (mirrors the existing site-leading composite access patterns).
ALTER TABLE `arbimon2`.`recordings`
  ADD INDEX IF NOT EXISTS `recs_active_by_site` (`site_id`, `archived_at`),
  ALGORITHM=INPLACE, LOCK=NONE;

-- Backs the "View Archived" (archived=only) listing.
ALTER TABLE `arbimon2`.`recordings`
  ADD INDEX IF NOT EXISTS `recs_archived_at` (`archived_at`),
  ALGORITHM=INPLACE, LOCK=NONE;
