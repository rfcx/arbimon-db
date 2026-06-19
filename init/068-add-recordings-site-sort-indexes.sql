-- Support fast server-side sorting of the project recordings list
-- (audiodata/recordings) by Filename and Uploaded, scoped to a project's
-- sites (WHERE site_id IN (...)).
--
-- Why: the list query first selects a page of recording_id in the requested
-- order. Without a (site_id, <col>) composite, the optimizer falls back to a
-- single-column index and full-scans the ~273M-row recordings table, tripping
-- max_statement_time -> the list comes back empty ("0 Recordings"). A
-- site-leading composite keeps the project-scoped sort fast (~50-80ms).
--
-- `site` and `datetime` sorts are already covered by the existing
-- `recordings_site_datetime_idx (site_id, datetime)`.
--
-- Filename: the value shown in the UI's Filename column is the recording's
-- meta.filename (e.g. "20220202_043000.WAV"), NOT the uri basename (an opaque
-- UUID). meta is a JSON TEXT blob, so we expose it as a VIRTUAL generated
-- column and index that. VIRTUAL (not STORED/PERSISTENT) so the column can be
-- added INSTANT (no table rebuild on 273M rows) and stays in sync with meta
-- automatically -- the index materializes the extracted value.
--
-- Uploaded: index (site_id, upload_time).
--
-- `recorder` is intentionally NOT made sortable (no composite; value also
-- lives in meta).
--
-- Applied online to rfcx-local production on 2026-06-19:
--   - ADD COLUMN filename ... VIRTUAL          -> ALGORITHM=INSTANT (instant)
--   - ADD INDEX recordings_site_filename_idx   -> INPLACE/LOCK=NONE
--   - ADD INDEX recordings_site_upload_time_idx-> INPLACE/LOCK=NONE
-- IF NOT EXISTS keeps re-runs safe where they already exist.

ALTER TABLE `arbimon2`.`recordings`
  ADD COLUMN IF NOT EXISTS `filename` VARCHAR(255)
    AS (JSON_VALUE(`meta`, '$.filename')) VIRTUAL,
  ALGORITHM=INSTANT;

ALTER TABLE `arbimon2`.`recordings`
  ADD INDEX IF NOT EXISTS `recordings_site_filename_idx` (`site_id`, `filename`),
  ALGORITHM=INPLACE, LOCK=NONE;

ALTER TABLE `arbimon2`.`recordings`
  ADD INDEX IF NOT EXISTS `recordings_site_upload_time_idx` (`site_id`, `upload_time`),
  ALGORITHM=INPLACE, LOCK=NONE;
