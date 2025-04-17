ALTER TABLE `arbimon2`.`pattern_matching_rois_synced_backup`
ADD COLUMN `uri_param1` int unsigned not null DEFAULT 0;

ALTER TABLE `arbimon2`.`pattern_matching_rois_synced_backup`
ADD COLUMN `uri_param2` smallint unsigned null;

