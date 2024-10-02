-- uri_image = 'audio_events/prod/detection/33604/png/3450166/3.png'

ALTER TABLE `arbimon2`.`audio_event_detections_clustering`
ADD COLUMN `uri_param` int DEFAULT NULL;

UPDATE `arbimon2`.`audio_event_detections_clustering`
SET uri_image = SELECT substring_index(substring_index(uri_image, '/', -1), '.', 1);

UPDATE `arbimon2`.`audio_event_detections_clustering`
SET uri_param = uri_image;

ALTER TABLE `arbimon2`.`audio_event_detections_clustering`
DROP uri_image;

