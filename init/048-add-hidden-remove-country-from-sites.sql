ALTER TABLE `arbimon2`.`sites`
ADD COLUMN `hidden` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE `arbimon2`.`sites`
DROP COLUMN `country`;
