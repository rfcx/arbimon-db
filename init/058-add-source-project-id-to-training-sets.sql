ALTER TABLE `arbimon2`.`training_sets`
ADD COLUMN `source_project_id` INT(10) unsigned DEFAULT NULL;

CREATE INDEX training_sets_source_project_id ON training_sets(source_project_id);
