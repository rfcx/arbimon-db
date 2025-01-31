CREATE TABLE `job_params_retraining` (
  `job_id` bigint(20) unsigned NOT NULL,
  `trained_model_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  KEY `trained_model_id` (`trained_model_id`),
  CONSTRAINT `job_params_training_ibfk_5` FOREIGN KEY (`trained_model_id`) REFERENCES `models` (`model_id`)
);