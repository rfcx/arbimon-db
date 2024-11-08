ALTER TABLE `arbimon2`.`audio_event_detections_clustering`
ADD COLUMN `validated` tinyint(1) DEFAULT NULL;

UPDATE `arbimon2`.`audio_event_detections_clustering` SET `validated` = 1
WHERE `species_id` is not null and `songtype_id` is not null;

ALTER TABLE `arbimon2`.`audio_event_detections_clustering`
CHANGE cluster_number aed_number bigint(20);
