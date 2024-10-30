DROP TABLE IF EXISTS sessions;

ALTER TABLE projects DROP COLUMN description;
ALTER TABLE projects DROP COLUMN project_type_id;
ALTER TABLE projects DROP COLUMN is_enabled;
ALTER TABLE projects DROP COLUMN current_plan;
ALTER TABLE projects DROP COLUMN storage_usage;
ALTER TABLE projects DROP COLUMN processing_usage;
ALTER TABLE projects DROP COLUMN pattern_matching_enabled;
ALTER TABLE projects DROP COLUMN cnn_enabled;
ALTER TABLE projects DROP COLUMN aed_enabled;
ALTER TABLE projects DROP COLUMN clustering_enabled;
ALTER TABLE projects DROP COLUMN featured;
ALTER TABLE projects DROP COLUMN image;
ALTER TABLE projects DROP COLUMN reports_enabled;
