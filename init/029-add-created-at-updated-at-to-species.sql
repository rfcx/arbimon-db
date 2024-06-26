ALTER TABLE `arbimon2`.`species`
ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

CREATE TRIGGER species_update BEFORE UPDATE ON `arbimon2`.`species` FOR EACH ROW SET NEW.updated_at = NOW();
