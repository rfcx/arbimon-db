CREATE TABLE `job_params_retraining` (
  `job_id` bigint(20) unsigned NOT NULL,
  `trained_job_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`job_id`),
  KEY `trained_job_id` (`trained_job_id`),
  CONSTRAINT `job_params_retraining_ibfk_1` FOREIGN KEY (`trained_job_id`) REFERENCES `jobs` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
