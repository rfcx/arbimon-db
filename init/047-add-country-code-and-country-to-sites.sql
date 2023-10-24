ALTER TABLE `arbimon2`.`sites`
ADD COLUMN `country_code` VARCHAR(2) DEFAULT NULL;

ALTER TABLE `arbimon2`.`sites`
ADD COLUMN `country` VARCHAR(255) DEFAULT NULL;
