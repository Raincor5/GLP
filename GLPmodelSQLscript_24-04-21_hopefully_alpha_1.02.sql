-- MySQL Script generated by MySQL Workbench
-- Sun Apr 25 01:21:03 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GLP
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema GLP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GLP` DEFAULT CHARACTER SET utf8 ;
USE `GLP` ;

-- -----------------------------------------------------
-- Table `GLP`.`Fixture_results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Fixture_results` (
  `rid` INT NOT NULL AUTO_INCREMENT,
  `Fixtures_fid` INT NOT NULL,
  `Fixtures_homeID` VARCHAR(45) NOT NULL,
  `Fixtures_awayID` VARCHAR(45) NOT NULL,
  `isW1` TINYINT ZEROFILL NOT NULL,
  `isX` TINYINT ZEROFILL NOT NULL,
  `isW2` TINYINT ZEROFILL NOT NULL,
  PRIMARY KEY (`rid`, `Fixtures_homeID`, `Fixtures_awayID`, `Fixtures_fid`),
  INDEX `FR_Fixtures_fid_idx` (`Fixtures_fid` ASC) VISIBLE,
  INDEX `FR_Fixtures_homeID_idx` (`Fixtures_homeID` ASC) VISIBLE,
  INDEX `FR_Fixture_awayID_idx` (`Fixtures_awayID` ASC) VISIBLE,
  CONSTRAINT `Fixtures_fid`
    FOREIGN KEY (`Fixtures_fid`)
    REFERENCES `GLP`.`Fixtures` (`fid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fixtures_homeID`
    FOREIGN KEY (`Fixtures_homeID`)
    REFERENCES `GLP`.`Fixtures` (`homeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Fixture_awayID`
    FOREIGN KEY (`Fixtures_awayID`)
    REFERENCES `GLP`.`Fixtures` (`awayID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Fixtures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Fixtures` (
  `fid` INT NOT NULL AUTO_INCREMENT,
  `homeID` VARCHAR(45) NOT NULL,
  `awayID` VARCHAR(45) NOT NULL,
  `Leagues_lid` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `venue` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fid`, `homeID`, `awayID`, `date`, `Leagues_lid`, `venue`),
  INDEX `INDEXawayID` (`awayID` ASC) INVISIBLE,
  INDEX `INDEXhomeID` (`homeID` ASC) VISIBLE,
  INDEX `Leagues_idx` (`Leagues_lid` ASC) VISIBLE,
  CONSTRAINT `Leagues`
    FOREIGN KEY (`Leagues_lid`)
    REFERENCES `GLP`.`Leagues` (`lname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `homeID_FK`
    FOREIGN KEY (`homeID`)
    REFERENCES `GLP`.`Teams` (`tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `awayID_FK`
    FOREIGN KEY (`awayID`)
    REFERENCES `GLP`.`Teams` (`tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Goalsavers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Goalsavers` (
  `saveid` INT NOT NULL,
  `Fr_id` INT NOT NULL,
  `Players_pid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`saveid`, `Fr_id`, `Players_pid`),
  INDEX `Goalsavers_Fr_rid_idx` (`Fr_id` ASC) VISIBLE,
  INDEX `Players_pid_idx` (`Players_pid` ASC) VISIBLE,
  CONSTRAINT `Fr_rid`
    FOREIGN KEY (`Fr_id`)
    REFERENCES `GLP`.`Fixture_results` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Players_pid`
    FOREIGN KEY (`Players_pid`)
    REFERENCES `GLP`.`Players` (`pname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'q';


-- -----------------------------------------------------
-- Table `GLP`.`Goalscorers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Goalscorers` (
  `goalid` INT NOT NULL AUTO_INCREMENT,
  `Fr_rid` INT NOT NULL,
  `Players_pid` VARCHAR(45) NOT NULL,
  `goalsScored` ENUM("1", "2") NOT NULL,
  PRIMARY KEY (`goalid`, `Fr_rid`, `Players_pid`),
  INDEX `Goalscorers_Fr_rid_idx` (`Fr_rid` ASC) VISIBLE,
  INDEX `FK_Players_pid_idx` (`Players_pid` ASC) VISIBLE,
  CONSTRAINT `FK_Fr_rid`
    FOREIGN KEY (`Fr_rid`)
    REFERENCES `GLP`.`Fixture_results` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Players_pid`
    FOREIGN KEY (`Players_pid`)
    REFERENCES `GLP`.`Players` (`pname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`League_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`League_table` (
  `gamesPlayed` INT NOT NULL DEFAULT 0,
  `W` INT NOT NULL DEFAULT 0,
  `D` INT NOT NULL DEFAULT 0,
  `L` INT NOT NULL DEFAULT 0,
  `goalsScored` INT NOT NULL DEFAULT 0,
  `goalsConceded` INT NOT NULL DEFAULT 0,
  `goalDifference` BIGINT NOT NULL DEFAULT 0,
  `Pts` INT NOT NULL DEFAULT 0,
  `Leagues_lid` VARCHAR(45) NOT NULL,
  `Round` INT NULL,
  `Teams_tname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Leagues_lid`, `Teams_tname`),
  INDEX `Team_tname_FK_idx` (`Teams_tname` ASC) VISIBLE,
  CONSTRAINT `FK_lid`
    FOREIGN KEY (`Leagues_lid`)
    REFERENCES `GLP`.`Leagues` (`lname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Team_tname_FK`
    FOREIGN KEY (`Teams_tname`)
    REFERENCES `GLP`.`Teams` (`tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Leagues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Leagues` (
  `lid` INT NOT NULL AUTO_INCREMENT,
  `lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lid`, `lname`),
  UNIQUE INDEX `lname_UNIQUE` (`lname` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Players` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `Teams_tid` VARCHAR(45) NOT NULL,
  `pname` VARCHAR(45) NOT NULL,
  `pDOB` DATE NULL,
  `jerseyNo` INT NOT NULL,
  `ppos` ENUM("GK", "FW") NOT NULL,
  `prole` ENUM("P", "C", "O") NOT NULL,
  `puserName` VARCHAR(20) NULL,
  PRIMARY KEY (`pid`, `Teams_tid`, `pname`),
  UNIQUE INDEX `puserName_UNIQUE` (`puserName` ASC) INVISIBLE,
  UNIQUE INDEX `pname_UNIQUE` (`pname` ASC) VISIBLE,
  INDEX `Teams_tid_FK_idx` (`Teams_tid` ASC) VISIBLE,
  CONSTRAINT `Teams_tid_FK`
    FOREIGN KEY (`Teams_tid`)
    REFERENCES `GLP`.`Teams` (`tname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Username_FK`
    FOREIGN KEY (`puserName`)
    REFERENCES `GLP`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Season_awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Season_awards` (
  `idSeasonAwards` INT NOT NULL AUTO_INCREMENT,
  `Players_pid` VARCHAR(45) NOT NULL,
  `awardName` VARCHAR(45) NULL,
  PRIMARY KEY (`idSeasonAwards`, `Players_pid`),
  UNIQUE INDEX `awardName_UNIQUE` (`awardName` ASC) VISIBLE,
  INDEX `FK_Players_pid_FK_idx` (`Players_pid` ASC) VISIBLE,
  CONSTRAINT `FK_Players_pid_FK`
    FOREIGN KEY (`Players_pid`)
    REFERENCES `GLP`.`Players` (`pname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Teams` (
  `tid` INT NOT NULL AUTO_INCREMENT,
  `tname` VARCHAR(45) NOT NULL,
  `tabbrv` VARCHAR(4) NULL,
  `League_lid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`, `League_lid`, `tname`),
  UNIQUE INDEX `tname_UNIQUE` (`tname` ASC) VISIBLE,
  UNIQUE INDEX `tid_UNIQUE` (`tid` ASC) VISIBLE,
  INDEX `League_lid_idx` (`League_lid` ASC) VISIBLE,
  CONSTRAINT `League_lid`
    FOREIGN KEY (`League_lid`)
    REFERENCES `GLP`.`Leagues` (`lname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
