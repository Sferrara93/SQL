-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema gestionale
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gestionale
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gestionale` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `gestionale` ;

-- -----------------------------------------------------
-- Table `gestionale`.`clienti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestionale`.`clienti` (
  `IdCliente` INT NOT NULL,
  `Nome` VARCHAR(50) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Email` VARCHAR(100) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  PRIMARY KEY (`IdCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestionale`.`prodotti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestionale`.`prodotti` (
  `IdProdotto` INT NOT NULL,
  `NomeProdotto` VARCHAR(100) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Prezzo` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`IdProdotto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestionale`.`ordini`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestionale`.`ordini` (
  `IDOrdine` INT NOT NULL,
  `IDProdotto` INT NULL DEFAULT NULL,
  `IDCliente` INT NULL DEFAULT NULL,
  `Quantità` INT NULL DEFAULT NULL,
  PRIMARY KEY (`IDOrdine`),
  INDEX `IDProdotto` (`IDProdotto` ASC) VISIBLE,
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  CONSTRAINT `ordini_ibfk_1`
    FOREIGN KEY (`IDProdotto`)
    REFERENCES `gestionale`.`prodotti` (`IdProdotto`),
  CONSTRAINT `ordini_ibfk_2`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `gestionale`.`clienti` (`IdCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `gestionale`.`dettaglioordine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gestionale`.`dettaglioordine` (
  `IDOrdine` INT NOT NULL,
  `IDProdotto` INT NOT NULL,
  `IDCliente` INT NOT NULL,
  `PrezzoTotale` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`IDOrdine`, `IDProdotto`, `IDCliente`),
  INDEX `IDProdotto` (`IDProdotto` ASC) VISIBLE,
  INDEX `IDCliente` (`IDCliente` ASC) VISIBLE,
  CONSTRAINT `dettaglioordine_ibfk_1`
    FOREIGN KEY (`IDOrdine`)
    REFERENCES `gestionale`.`ordini` (`IDOrdine`),
  CONSTRAINT `dettaglioordine_ibfk_2`
    FOREIGN KEY (`IDProdotto`)
    REFERENCES `gestionale`.`prodotti` (`IdProdotto`),
  CONSTRAINT `dettaglioordine_ibfk_3`
    FOREIGN KEY (`IDCliente`)
    REFERENCES `gestionale`.`clienti` (`IdCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
