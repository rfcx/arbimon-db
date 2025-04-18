ALTER TABLE `arbimon2`.`training_sets`
ADD COLUMN `source_project_id` INT(10) unsigned DEFAULT NULL;

ALTER TABLE `arbimon2`.`training_sets`
ADD CONSTRAINT `fk_source_project_id` FOREIGN KEY (`source_project_id`) REFERENCES `projects`(`project_id`);
