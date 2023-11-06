DROP VIEW IF EXISTS `project_plan_owner`;

ALTER TABLE `arbimon2`.`projects` DROP FOREIGN KEY `projects_ibfk_3`;
DROP INDEX current_plan ON projects;
ALTER TABLE `arbimon2`.`projects` DROP COLUMN `current_plan`;

DROP TABLE `arbimon2`.`project_plans`;
