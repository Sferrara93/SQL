-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new_schema` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `new_schema` ;

-- -----------------------------------------------------
-- Table `new_schema`.`impiegato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`impiegato` (
  `CodiceFiscale` CHAR(16) NOT NULL,
  `Nome` VARCHAR(50) NULL DEFAULT NULL,
  `TitoloStudio` VARCHAR(50) NULL DEFAULT NULL,
  `Recapito` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`CodiceFiscale`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `new_schema`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`store` (
  `CodiceStore` INT NOT NULL,
  `IndirizzoFisico` VARCHAR(50) NULL DEFAULT NULL,
  `NumeroTelefono` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`CodiceStore`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `new_schema`.`servizio_impiegato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`servizio_impiegato` (
  `IdServizio` INT NOT NULL AUTO_INCREMENT,
  `CodiceFiscale` CHAR(16) NULL DEFAULT NULL,
  `CodiceStore` INT NULL DEFAULT NULL,
  `DataInizio` DATE NULL DEFAULT NULL,
  `DataFine` DATE NULL DEFAULT NULL,
  `Carica` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`IdServizio`),
  INDEX `CodiceFiscale` (`CodiceFiscale` ASC) VISIBLE,
  INDEX `CodiceStore` (`CodiceStore` ASC) VISIBLE,
  CONSTRAINT `servizio_impiegato_ibfk_1`
    FOREIGN KEY (`CodiceFiscale`)
    REFERENCES `new_schema`.`impiegato` (`CodiceFiscale`),
  CONSTRAINT `servizio_impiegato_ibfk_2`
    FOREIGN KEY (`CodiceStore`)
    REFERENCES `new_schema`.`store` (`CodiceStore`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `new_schema`.`videogioco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`videogioco` (
  `Titolo` VARCHAR(30) NOT NULL,
  `Sviluppatore` VARCHAR(30) NULL DEFAULT NULL,
  `AnnoDistribuzione` DATE NULL DEFAULT NULL,
  `CostoAcquisto` DOUBLE NULL DEFAULT NULL,
  `Genere` VARCHAR(30) NULL DEFAULT NULL,
  `RemakeDi` VARCHAR(30) NULL DEFAULT NULL,
  `CodiceStore` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Titolo`),
  INDEX `CodiceStore` (`CodiceStore` ASC) VISIBLE,
  CONSTRAINT `videogioco_ibfk_1`
    FOREIGN KEY (`CodiceStore`)
    REFERENCES `new_schema`.`store` (`CodiceStore`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
