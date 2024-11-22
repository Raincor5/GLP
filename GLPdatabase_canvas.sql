-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: glp
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fixture_results`
--

DROP TABLE IF EXISTS `fixture_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixture_results` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `Fixtures_fid` int NOT NULL,
  `Fixtures_homeID` varchar(45) NOT NULL,
  `Fixtures_awayID` varchar(45) NOT NULL,
  `isW1` tinyint(3) unsigned zerofill NOT NULL,
  `isX` tinyint(3) unsigned zerofill NOT NULL,
  `isW2` tinyint(3) unsigned zerofill NOT NULL,
  PRIMARY KEY (`rid`,`Fixtures_homeID`,`Fixtures_awayID`,`Fixtures_fid`),
  KEY `FR_Fixtures_fid_idx` (`Fixtures_fid`),
  KEY `FR_Fixtures_homeID_idx` (`Fixtures_homeID`),
  KEY `FR_Fixture_awayID_idx` (`Fixtures_awayID`),
  CONSTRAINT `Fixture_awayID` FOREIGN KEY (`Fixtures_awayID`) REFERENCES `fixtures` (`awayID`),
  CONSTRAINT `Fixtures_fid` FOREIGN KEY (`Fixtures_fid`) REFERENCES `fixtures` (`fid`),
  CONSTRAINT `Fixtures_homeID` FOREIGN KEY (`Fixtures_homeID`) REFERENCES `fixtures` (`homeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixture_results`
--

LOCK TABLES `fixture_results` WRITE;
/*!40000 ALTER TABLE `fixture_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixture_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixtures`
--

DROP TABLE IF EXISTS `fixtures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixtures` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `homeID` varchar(45) NOT NULL,
  `awayID` varchar(45) NOT NULL,
  `Leagues_lid` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `venue` varchar(45) NOT NULL,
  PRIMARY KEY (`fid`,`homeID`,`awayID`,`date`,`Leagues_lid`,`venue`),
  KEY `INDEXawayID` (`awayID`) /*!80000 INVISIBLE */,
  KEY `INDEXhomeID` (`homeID`),
  KEY `Leagues_idx` (`Leagues_lid`),
  CONSTRAINT `awayID_FK` FOREIGN KEY (`awayID`) REFERENCES `teams` (`tname`),
  CONSTRAINT `homeID_FK` FOREIGN KEY (`homeID`) REFERENCES `teams` (`tname`),
  CONSTRAINT `Leagues` FOREIGN KEY (`Leagues_lid`) REFERENCES `leagues` (`lname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixtures`
--

LOCK TABLES `fixtures` WRITE;
/*!40000 ALTER TABLE `fixtures` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixtures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goalsavers`
--

DROP TABLE IF EXISTS `goalsavers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goalsavers` (
  `saveid` int NOT NULL,
  `Fr_id` int NOT NULL,
  `Players_pid` varchar(45) NOT NULL,
  PRIMARY KEY (`saveid`,`Fr_id`,`Players_pid`),
  KEY `Goalsavers_Fr_rid_idx` (`Fr_id`),
  KEY `Players_pid_idx` (`Players_pid`),
  CONSTRAINT `Fr_rid` FOREIGN KEY (`Fr_id`) REFERENCES `fixture_results` (`rid`),
  CONSTRAINT `Players_pid` FOREIGN KEY (`Players_pid`) REFERENCES `players` (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='q';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goalsavers`
--

LOCK TABLES `goalsavers` WRITE;
/*!40000 ALTER TABLE `goalsavers` DISABLE KEYS */;
/*!40000 ALTER TABLE `goalsavers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goalscorers`
--

DROP TABLE IF EXISTS `goalscorers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goalscorers` (
  `goalid` int NOT NULL AUTO_INCREMENT,
  `Fr_rid` int NOT NULL,
  `Players_pid` varchar(45) NOT NULL,
  `goalsScored` enum('1','2') NOT NULL,
  PRIMARY KEY (`goalid`,`Fr_rid`,`Players_pid`),
  KEY `Goalscorers_Fr_rid_idx` (`Fr_rid`),
  KEY `FK_Players_pid_idx` (`Players_pid`),
  CONSTRAINT `FK_Fr_rid` FOREIGN KEY (`Fr_rid`) REFERENCES `fixture_results` (`rid`),
  CONSTRAINT `FK_Players_pid` FOREIGN KEY (`Players_pid`) REFERENCES `players` (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goalscorers`
--

LOCK TABLES `goalscorers` WRITE;
/*!40000 ALTER TABLE `goalscorers` DISABLE KEYS */;
/*!40000 ALTER TABLE `goalscorers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_table`
--

DROP TABLE IF EXISTS `league_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league_table` (
  `gamesPlayed` int(10) unsigned zerofill NOT NULL,
  `W` int(10) unsigned zerofill NOT NULL,
  `D` int(10) unsigned zerofill NOT NULL,
  `L` int(10) unsigned zerofill NOT NULL,
  `goalsScored` int(10) unsigned zerofill NOT NULL,
  `goalsConceded` int(10) unsigned zerofill NOT NULL,
  `goalDifference` int(10) unsigned zerofill NOT NULL,
  `Pts` int(10) unsigned zerofill NOT NULL,
  `Leagues_lid` varchar(45) NOT NULL,
  `Round` int DEFAULT NULL,
  `Teams_tname` varchar(45) NOT NULL,
  PRIMARY KEY (`Leagues_lid`,`Teams_tname`),
  KEY `Team_tname_FK_idx` (`Teams_tname`),
  CONSTRAINT `FK_lid` FOREIGN KEY (`Leagues_lid`) REFERENCES `leagues` (`lname`),
  CONSTRAINT `Team_tname_FK` FOREIGN KEY (`Teams_tname`) REFERENCES `teams` (`tname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_table`
--

LOCK TABLES `league_table` WRITE;
/*!40000 ALTER TABLE `league_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `league_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leagues`
--

DROP TABLE IF EXISTS `leagues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leagues` (
  `lid` int NOT NULL AUTO_INCREMENT,
  `lname` varchar(45) NOT NULL,
  PRIMARY KEY (`lid`,`lname`),
  UNIQUE KEY `lname_UNIQUE` (`lname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leagues`
--

LOCK TABLES `leagues` WRITE;
/*!40000 ALTER TABLE `leagues` DISABLE KEYS */;
/*!40000 ALTER TABLE `leagues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `Teams_tid` varchar(45) NOT NULL,
  `pname` varchar(45) NOT NULL,
  `pDOB` date DEFAULT NULL,
  `jerseyNo` int NOT NULL,
  `ppos` enum('GK','FW') NOT NULL,
  `prole` enum('P','C','O') NOT NULL,
  `puserName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pid`,`Teams_tid`,`pname`),
  UNIQUE KEY `pname_UNIQUE` (`pname`),
  UNIQUE KEY `puserName_UNIQUE` (`puserName`) /*!80000 INVISIBLE */,
  KEY `Teams_tid_FK_idx` (`Teams_tid`),
  CONSTRAINT `Teams_tid_FK` FOREIGN KEY (`Teams_tid`) REFERENCES `teams` (`tname`),
  CONSTRAINT `Username_FK` FOREIGN KEY (`puserName`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season_awards`
--

DROP TABLE IF EXISTS `season_awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season_awards` (
  `idSeasonAwards` int NOT NULL AUTO_INCREMENT,
  `Players_pid` varchar(45) NOT NULL,
  `awardName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSeasonAwards`,`Players_pid`),
  UNIQUE KEY `awardName_UNIQUE` (`awardName`),
  KEY `FK_Players_pid_FK_idx` (`Players_pid`),
  CONSTRAINT `FK_Players_pid_FK` FOREIGN KEY (`Players_pid`) REFERENCES `players` (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season_awards`
--

LOCK TABLES `season_awards` WRITE;
/*!40000 ALTER TABLE `season_awards` DISABLE KEYS */;
/*!40000 ALTER TABLE `season_awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `tid` int NOT NULL AUTO_INCREMENT,
  `tname` varchar(45) NOT NULL,
  `tabbrv` varchar(4) DEFAULT NULL,
  `League_lid` varchar(45) NOT NULL,
  PRIMARY KEY (`tid`,`League_lid`,`tname`),
  UNIQUE KEY `tname_UNIQUE` (`tname`),
  UNIQUE KEY `tid_UNIQUE` (`tid`),
  KEY `League_lid_idx` (`League_lid`),
  CONSTRAINT `League_lid` FOREIGN KEY (`League_lid`) REFERENCES `leagues` (`lname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-25  0:09:00
