DROP TABLE IF EXISTS sessions;

ALTER TABLE `arbimon2`.`projects` DROP COLUMN `description`;
ALTER TABLE `arbimon2`.`projects` DROP FOREIGN KEY `projects_ibfk_2`;
DROP INDEX project_type_id ON `arbimon2`.`projects`;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN project_type_id;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN is_enabled;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN storage_usage;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN processing_usage;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN pattern_matching_enabled;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN cnn_enabled;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN aed_enabled;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN clustering_enabled;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN featured;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN `image`;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN reports_enabled;
