-- Composite indexes to support server-side sorting of the project recordings
-- list (audiodata/recordings) by Filename and Uploaded, scoped to a project's
-- sites (WHERE site_id IN (...)).
--
-- Why: the list query first selects a page of recording_id in the requested
-- order. Without a (site_id, <col>) composite, the optimizer falls back to a
-- single-column index (uri / upload_time) and full-scans the ~273M-row table,
-- tripping max_statement_time -> the list comes back empty ("0 Recordings").
-- A site-leading composite lets the project-scoped sort stay fast (~50-80ms).
--
-- `site` and `datetime` sorts are already covered by the existing
-- `recordings_site_datetime_idx (site_id, datetime)`. `recorder` is not made
-- sortable (no composite, and the displayed value lives in meta JSON).
--
-- Applied online to production on 2026-06-19 with
--   ALGORITHM=INPLACE, LOCK=NONE
-- (recordings_site_uri_idx ~27m, recordings_site_upload_time_idx ~16m).
-- IF NOT EXISTS makes re-running safe where they already exist.

ALTER TABLE `arbimon2`.`recordings`
  ADD INDEX IF NOT EXISTS `recordings_site_uri_idx` (`site_id`, `uri`),
  ALGORITHM=INPLACE, LOCK=NONE;

ALTER TABLE `arbimon2`.`recordings`
  ADD INDEX IF NOT EXISTS `recordings_site_upload_time_idx` (`site_id`, `upload_time`),
  ALGORITHM=INPLACE, LOCK=NONE;
