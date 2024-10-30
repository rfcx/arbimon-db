ALTER TABLE projects DROP FOREIGN KEY `projects_ibfk_2`;
DROP INDEX project_type_id ON projects;
ALTER TABLE projects DROP description, DROP project_type_id, DROP is_enabled, DROP storage_usage, 
    DROP processing_usage, DROP pattern_matching_enabled, DROP cnn_enabled, DROP aed_enabled, 
    DROP clustering_enabled, DROP featured, DROP image, DROP reports_enabled;
DROP TABLE IF EXISTS `arbimon2`.`project_types`;