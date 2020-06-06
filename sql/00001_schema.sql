-- MySQL Script generated by MySQL Workbench
-- Sat Jun  6 16:50:38 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema extotosql
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `extotosql` ;

-- -----------------------------------------------------
-- Schema extotosql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `extotosql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `extotosql` ;

-- -----------------------------------------------------
-- Table `generic_object_revset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `generic_object_revset` ;

CREATE TABLE IF NOT EXISTS `generic_object_revset` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `create_timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `generic_object`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `generic_object` ;

CREATE TABLE IF NOT EXISTS `generic_object` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `create_revset_id` BIGINT(20) UNSIGNED NOT NULL,
  `current_revset_id` BIGINT(20) UNSIGNED NOT NULL,
  `revset_count` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_generic_object_2_idx` (`current_revset_id` ASC),
  INDEX `fk_generic_object_1_idx` (`create_revset_id` ASC),
  CONSTRAINT `fk_generic_object_2`
    FOREIGN KEY (`current_revset_id`)
    REFERENCES `generic_object_revset` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_generic_object_1`
    FOREIGN KEY (`create_revset_id`)
    REFERENCES `generic_object_revset` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `filesystem_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `filesystem_metadata` ;

CREATE TABLE IF NOT EXISTS `filesystem_metadata` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `object_id` BIGINT(20) UNSIGNED NOT NULL,
  `fs_uuid` BINARY(16) NOT NULL,
  `version` VARCHAR(45) NULL,
  `root_directory_object_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_filesystem_metadata_3_idx` (`object_id` ASC),
  INDEX `fk_filesystem_metadata_4_idx` (`root_directory_object_id` ASC),
  CONSTRAINT `fk_filesystem_metadata_3`
    FOREIGN KEY (`object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_filesystem_metadata_4`
    FOREIGN KEY (`root_directory_object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `file_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `file_metadata` ;

CREATE TABLE IF NOT EXISTS `file_metadata` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `object_id` BIGINT(20) UNSIGNED NOT NULL,
  `parent_object_id` BIGINT(20) UNSIGNED NOT NULL,
  `file_name` TEXT NULL,
  `file_size_bytes` BIGINT(20) UNSIGNED NOT NULL,
  `file_ondisk_dev` VARCHAR(255) NULL,
  `file_ondisk_offset` BIGINT(20) UNSIGNED NULL,
  `file_ondisk_inode` BIGINT(20) UNSIGNED NULL,
  `file_ondisk_pathname` TEXT NULL,
  `file_compression_scheme` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_file_metadata_1_idx` (`object_id` ASC),
  INDEX `fk_file_metadata_2_idx` (`parent_object_id` ASC),
  CONSTRAINT `fk_file_metadata_1`
    FOREIGN KEY (`object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_file_metadata_2`
    FOREIGN KEY (`parent_object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `directory_entry_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `directory_entry_metadata` ;

CREATE TABLE IF NOT EXISTS `directory_entry_metadata` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `object_id` BIGINT(20) UNSIGNED NOT NULL,
  `directory_id` BIGINT(20) UNSIGNED NULL,
  `prev_entry_id` BIGINT(20) UNSIGNED NULL,
  `next_entry_id` BIGINT(20) UNSIGNED NULL,
  `ref_object_id` BIGINT(20) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_directory_entry_metadata_1_idx` (`object_id` ASC),
  INDEX `fk_directory_entry_metadata_2_idx` (`directory_id` ASC),
  INDEX `fk_directory_entry_metadata_3_idx` (`prev_entry_id` ASC),
  INDEX `fk_directory_entry_metadata_4_idx` (`next_entry_id` ASC),
  INDEX `fk_directory_entry_metadata_5_idx` (`ref_object_id` ASC),
  CONSTRAINT `fk_directory_entry_metadata_1`
    FOREIGN KEY (`object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_directory_entry_metadata_2`
    FOREIGN KEY (`directory_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_directory_entry_metadata_3`
    FOREIGN KEY (`prev_entry_id`)
    REFERENCES `directory_entry_metadata` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_directory_entry_metadata_4`
    FOREIGN KEY (`next_entry_id`)
    REFERENCES `directory_entry_metadata` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_directory_entry_metadata_5`
    FOREIGN KEY (`ref_object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `directory_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `directory_metadata` ;

CREATE TABLE IF NOT EXISTS `directory_metadata` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `object_id` BIGINT(20) UNSIGNED NOT NULL,
  `parent_object_id` BIGINT(20) UNSIGNED NULL,
  `directory_name` TEXT NULL,
  `entry_count` BIGINT(20) UNSIGNED NULL,
  `first_entry_id` BIGINT(20) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_directory_metadata_1_idx` (`object_id` ASC),
  INDEX `fk_directory_metadata_2_idx` (`parent_object_id` ASC),
  INDEX `fk_directory_metadata_3_idx` (`first_entry_id` ASC),
  INDEX `index5` (`directory_name` ASC),
  CONSTRAINT `fk_directory_metadata_1`
    FOREIGN KEY (`object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_directory_metadata_2`
    FOREIGN KEY (`parent_object_id`)
    REFERENCES `generic_object` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_directory_metadata_3`
    FOREIGN KEY (`first_entry_id`)
    REFERENCES `directory_entry_metadata` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
