CREATE DATABASE IF NOT EXISTS statistics;
USE `statistics`;
#SET GLOBAL explicit_defaults_for_timestamp = 1;

CREATE TABLE IF NOT EXISTS `disk_usage` (
  `Used` VARCHAR(20) NOT NULL,
  `Free` VARCHAR(20) NOT NULL,
  `Taken_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX(`Taken_at`)
);

CREATE TABLE IF NOT EXISTS `mem_usage` (
  `Used` VARCHAR(20) NOT NULL,
  `Free` VARCHAR(20) NOT NULL,
  `Taken_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX(`Taken_at`)
);

CREATE TABLE IF NOT EXISTS `cpu_usage` (
  `Usage` VARCHAR(20) NOT NULL,
  `Taken_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
#  `Taken_at` VARCHAR(20) NOT NULL,
  INDEX(`Taken_at`)
);
