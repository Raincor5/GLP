-- MySQL Script generated by MySQL Workbench
-- Fri Apr 23 13:14:13 2021
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
  `Fixtures_homeID` INT NOT NULL,
  `Fixtures_awayID` INT NOT NULL,
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
  `homeID` INT NOT NULL,
  `awayID` INT NOT NULL,
  `Seasons_seasonid` INT NOT NULL,
  `Leagues_lid` INT NOT NULL,
  `date` DATE NOT NULL,
  `venue` VARCHAR(45) NULL,
  PRIMARY KEY (`fid`, `homeID`, `awayID`, `date`, `Seasons_seasonid`, `Leagues_lid`),
  INDEX `Leagues_idx` (`Leagues_lid` ASC) INVISIBLE,
  INDEX `INDEXawayID` (`awayID` ASC) INVISIBLE,
  INDEX `INDEXhomeID` (`homeID` ASC) VISIBLE,
  CONSTRAINT `Leagues`
    FOREIGN KEY (`Leagues_lid`)
    REFERENCES `GLP`.`Leagues` (`lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Goalsavers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Goalsavers` (
  `saveid` INT NOT NULL,
  `Fr_id` INT NOT NULL,
  `Players_pid` INT NOT NULL,
  PRIMARY KEY (`saveid`, `Fr_id`, `Players_pid`),
  INDEX `Goalsavers_Fr_rid_idx` (`Fr_id` ASC) VISIBLE,
  INDEX `Goalsavers_Players_pid_idx` (`Players_pid` ASC) VISIBLE,
  CONSTRAINT `Fr_rid`
    FOREIGN KEY (`Fr_id`)
    REFERENCES `GLP`.`Fixture_results` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Players_pid`
    FOREIGN KEY (`Players_pid`)
    REFERENCES `GLP`.`Players` (`pid`)
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
  `Players_pid` INT NOT NULL,
  `goalsScored` ENUM("1", "2") NOT NULL,
  PRIMARY KEY (`goalid`, `Fr_rid`, `Players_pid`),
  INDEX `Goalscorers_Fr_rid_idx` (`Fr_rid` ASC) VISIBLE,
  INDEX `Goalscorers_Players_pid_idx` (`Players_pid` ASC) VISIBLE,
  CONSTRAINT `FK_Fr_rid`
    FOREIGN KEY (`Fr_rid`)
    REFERENCES `GLP`.`Fixture_results` (`rid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Players_pid`
    FOREIGN KEY (`Players_pid`)
    REFERENCES `GLP`.`Players` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`League_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`League_table` (
  `Team_tid` INT NOT NULL AUTO_INCREMENT,
  `gamesPlayed` INT ZEROFILL NOT NULL,
  `W` INT ZEROFILL NOT NULL,
  `D` INT ZEROFILL NOT NULL,
  `L` INT ZEROFILL NOT NULL,
  `goalsScored` INT ZEROFILL NOT NULL,
  `goalsConceded` INT ZEROFILL NOT NULL,
  `goalDifference` INT ZEROFILL NOT NULL,
  `Pts` INT ZEROFILL NOT NULL,
  `Leagues_lid` INT NOT NULL,
  PRIMARY KEY (`Team_tid`, `Leagues_lid`),
  INDEX `LEAGUE_FK` () INVISIBLE,
  INDEX `FK_lid_idx` (`Leagues_lid` ASC) VISIBLE,
  CONSTRAINT `Team_tid`
    FOREIGN KEY (`Team_tid`)
    REFERENCES `GLP`.`Teams` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_lid`
    FOREIGN KEY (`Leagues_lid`)
    REFERENCES `GLP`.`Leagues` (`lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Leagues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Leagues` (
  `lid` INT NOT NULL AUTO_INCREMENT,
  `lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lid`),
  UNIQUE INDEX `lname_UNIQUE` (`lname` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Players` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `Teams_tid` INT NOT NULL,
  `pname` VARCHAR(45) NULL,
  `pDOB` DATE NULL,
  `jerseyNo` INT NOT NULL,
  `ppos` ENUM("GK", "FW") NOT NULL,
  `prole` ENUM("P", "C", "O") NOT NULL,
  `puserName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`pid`, `puserName`, `Teams_tid`),
  UNIQUE INDEX `puserName_UNIQUE` (`puserName` ASC) VISIBLE,
  INDEX `Teams_tid_idx` (`Teams_tid` ASC) VISIBLE,
  CONSTRAINT `Teams_tid`
    FOREIGN KEY (`Teams_tid`)
    REFERENCES `GLP`.`Teams` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Users`
    FOREIGN KEY (`puserName`)
    REFERENCES `GLP`.`Users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Season_awards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Season_awards` (
  `idSeasonAwards` INT NULL AUTO_INCREMENT,
  `Seasons_seasonid` INT NULL,
  `Players_pid` INT NULL,
  `awardName` VARCHAR(45) NULL,
  PRIMARY KEY (`idSeasonAwards`, `Players_pid`, `Seasons_seasonid`),
  UNIQUE INDEX `awardName_UNIQUE` (`awardName` ASC) VISIBLE,
  INDEX `SA_Players_pid_idx` (`Players_pid` ASC) VISIBLE,
  CONSTRAINT `FK_Players_pid_FK`
    FOREIGN KEY (`Players_pid`)
    REFERENCES `GLP`.`Players` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Teams` (
  `tid` INT NOT NULL AUTO_INCREMENT,
  `tname` VARCHAR(45) NULL,
  `tabbrv` VARCHAR(4) NULL,
  `League_lid` INT NOT NULL,
  `Seasons_seasonid` INT NOT NULL,
  PRIMARY KEY (`tid`, `Seasons_seasonid`, `League_lid`),
  UNIQUE INDEX `tname_UNIQUE` (`tname` ASC) VISIBLE,
  INDEX `League_lid_idx` (`League_lid` ASC) VISIBLE,
  CONSTRAINT `League_lid`
    FOREIGN KEY (`League_lid`)
    REFERENCES `GLP`.`Leagues` (`lid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GLP`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GLP`.`Users` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
