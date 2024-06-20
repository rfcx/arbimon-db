DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS site_log_files;
DROP TABLE IF EXISTS site_data_log;
DROP TABLE IF EXISTS site_event_log;


ALTER TABLE projects
DROP description, DROP project_type_id, DROP is_enabled, DROP current_plan,
DROP storage_usage, DROP processing_usage, DROP pattern_matching_enabled,
DROP cnn_enabled, DROP aed_enabled, DROP clustering_enabled,
DROP featured, COLUMN image, DROP reports_enabled;
