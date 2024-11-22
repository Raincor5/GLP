-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: glp_alpha_1.1
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
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar` (
  `round` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `date` date NOT NULL,
  `cal_tname_home` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `cal_tname_away` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `cal_league_lname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`round`,`date`,`cal_tname_home`,`cal_tname_away`,`cal_league_lname`),
  KEY `cal_tname_away_tname_FK_idx` (`cal_tname_away`),
  KEY `cal_league_lname_lname_FK_idx` (`cal_league_lname`),
  KEY `cal_tname_home_tname_FK_idx` (`cal_tname_home`),
  CONSTRAINT `cal_league_lname_lname_FK` FOREIGN KEY (`cal_league_lname`) REFERENCES `teams` (`League_lid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cal_tname_away_tname_FK` FOREIGN KEY (`cal_tname_away`) REFERENCES `teams` (`tname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cal_tname_home_tname_FK` FOREIGN KEY (`cal_tname_home`) REFERENCES `teams` (`tname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_matches`
--

DROP TABLE IF EXISTS `football_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_matches` (
  `fmatch_round` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `fmatch_ht` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `fmatch_at` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`fmatch_round`,`date`),
  KEY `fmatch_round_idx` (`fmatch_round`),
  KEY `fmatch_ht_idx` (`fmatch_ht`) /*!80000 INVISIBLE */,
  KEY `fmatch_at_idx` (`fmatch_at`),
  CONSTRAINT `fmatch_round` FOREIGN KEY (`fmatch_round`) REFERENCES `calendar` (`round`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_matches`
--

LOCK TABLES `football_matches` WRITE;
/*!40000 ALTER TABLE `football_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `football_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `football_matches_results`
--

DROP TABLE IF EXISTS `football_matches_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `football_matches_results` (
  `fmr_round` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `fmr_ht` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `fmr_at` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `fmr_ht_score` int NOT NULL,
  `fmr_at_score` int NOT NULL,
  PRIMARY KEY (`fmr_round`,`fmr_ht`,`fmr_at`),
  KEY `fmr_ht_ht_FK_idx` (`fmr_ht`),
  KEY `fmr_at_at_FK_idx` (`fmr_at`),
  CONSTRAINT `fmr_at_at_FK` FOREIGN KEY (`fmr_at`) REFERENCES `football_matches` (`fmatch_at`),
  CONSTRAINT `fmr_ht_ht_FK` FOREIGN KEY (`fmr_ht`) REFERENCES `football_matches` (`fmatch_ht`),
  CONSTRAINT `fmr_round_round_FK` FOREIGN KEY (`fmr_round`) REFERENCES `football_matches` (`fmatch_round`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `football_matches_results`
--

LOCK TABLES `football_matches_results` WRITE;
/*!40000 ALTER TABLE `football_matches_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `football_matches_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_table`
--

DROP TABLE IF EXISTS `league_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league_table` (
  `Teams_tname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `gamesPlayed` int NOT NULL DEFAULT '0',
  `W` int NOT NULL DEFAULT '0',
  `D` int NOT NULL DEFAULT '0',
  `L` int NOT NULL DEFAULT '0',
  `goalsScored` int NOT NULL DEFAULT '0',
  `goalsConceded` int NOT NULL DEFAULT '0',
  `goalDIfference` bigint NOT NULL DEFAULT '0',
  `Pts` int NOT NULL DEFAULT '0',
  `lname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `round` varchar(20) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`Teams_tname`,`lname`),
  UNIQUE KEY `Teams_tname_UNIQUE` (`Teams_tname`),
  KEY `lt_lname_lname_FK_idx` (`lname`),
  KEY `lt_round_round_FK_idx` (`round`),
  CONSTRAINT `lt_lname_lname_FK` FOREIGN KEY (`lname`) REFERENCES `calendar` (`cal_league_lname`),
  CONSTRAINT `lt_round_round_FK` FOREIGN KEY (`round`) REFERENCES `calendar` (`round`),
  CONSTRAINT `lt_Teams_tname_tname_FK` FOREIGN KEY (`Teams_tname`) REFERENCES `teams` (`tname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
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
  `lname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`lid`,`lname`),
  UNIQUE KEY `lname_UNIQUE` (`lname`),
  UNIQUE KEY `lid_UNIQUE` (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leagues`
--

LOCK TABLES `leagues` WRITE;
/*!40000 ALTER TABLE `leagues` DISABLE KEYS */;
/*!40000 ALTER TABLE `leagues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_forms`
--

DROP TABLE IF EXISTS `match_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_forms` (
  `mf_id` int NOT NULL AUTO_INCREMENT,
  `mf_tname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `mf_round` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `pname_GK` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `pname_FW1` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `pname_FW2` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `pname_FW3` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `startDate` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `endDate` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`mf_id`,`mf_tname`,`mf_round`),
  UNIQUE KEY `mf_id_UNIQUE` (`mf_id`),
  KEY `mf_tname_tname_FK_idx` (`mf_tname`),
  KEY `mf_round_round_FK_idx` (`mf_round`),
  KEY `pname_GK_pname_FK_idx` (`pname_GK`),
  KEY `pname_FW1_pname_FK_idx` (`pname_FW1`),
  KEY `pname_FW2_pname_FK_idx` (`pname_FW2`),
  KEY `pname_FW3_pname_FK_idx` (`pname_FW3`),
  CONSTRAINT `mf_round_round_FK` FOREIGN KEY (`mf_round`) REFERENCES `calendar` (`round`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mf_tname_tname_FK` FOREIGN KEY (`mf_tname`) REFERENCES `teams` (`tname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pname_FW1_pname_FK` FOREIGN KEY (`pname_FW1`) REFERENCES `players` (`pname`),
  CONSTRAINT `pname_FW2_pname_FK` FOREIGN KEY (`pname_FW2`) REFERENCES `players` (`pname`),
  CONSTRAINT `pname_FW3_pname_FK` FOREIGN KEY (`pname_FW3`) REFERENCES `players` (`pname`),
  CONSTRAINT `pname_GK_pname_FK` FOREIGN KEY (`pname_GK`) REFERENCES `players` (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_forms`
--

LOCK TABLES `match_forms` WRITE;
/*!40000 ALTER TABLE `match_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_forms_fw`
--

DROP TABLE IF EXISTS `match_forms_fw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_forms_fw` (
  `mf_FW_id` int NOT NULL AUTO_INCREMENT,
  `mf_FW_round` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `mf_FW_tname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `FW_pname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `FW_match1_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `FW_match1_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `FW_match1_ht_score` int DEFAULT NULL,
  `FW_match1_at_score` int DEFAULT NULL,
  `FW_match2_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `FW_match2_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `FW_mathc2_ht_score` int DEFAULT NULL,
  `FW_mathc2_at_score` int DEFAULT NULL,
  `FW_goals` int DEFAULT NULL,
  PRIMARY KEY (`mf_FW_id`,`mf_FW_round`,`mf_FW_tname`,`FW_pname`),
  UNIQUE KEY `mfr_id_UNIQUE` (`mf_FW_id`),
  KEY `mf_FW_pname_pname_FK_idx` (`FW_pname`),
  KEY `mf_FW_round_round_FK_idx` (`mf_FW_round`),
  KEY `mf_FW_tname_tname_FK_idx` (`mf_FW_tname`),
  CONSTRAINT `mf_FW_pname_pname_FK` FOREIGN KEY (`FW_pname`) REFERENCES `players` (`pname`),
  CONSTRAINT `mf_FW_round_round_FK` FOREIGN KEY (`mf_FW_round`) REFERENCES `match_forms` (`mf_round`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mf_FW_tname_tname_FK` FOREIGN KEY (`mf_FW_tname`) REFERENCES `match_forms` (`mf_tname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_forms_fw`
--

LOCK TABLES `match_forms_fw` WRITE;
/*!40000 ALTER TABLE `match_forms_fw` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_forms_fw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match_forms_gk`
--

DROP TABLE IF EXISTS `match_forms_gk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `match_forms_gk` (
  `mf_GK_id` int NOT NULL AUTO_INCREMENT,
  `mf_GK_round` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `mf_GK_tname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `GK_pname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `GK_match1_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match1_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match1_ht_score` int DEFAULT NULL,
  `GK_match1_at_score` int DEFAULT NULL,
  `GK_match2_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match2_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match2_ht_score` int DEFAULT NULL,
  `GK_match2_at_score` int DEFAULT NULL,
  `GK_match3_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match3_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match3_ht_score` int DEFAULT NULL,
  `GK_match3_at_score` int DEFAULT NULL,
  `GK_match4_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match4_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match4_ht_score` int DEFAULT NULL,
  `GK_match4_at_score` int DEFAULT NULL,
  `GK_match5_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match5_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match5_ht_score` int DEFAULT NULL,
  `GK_match5_at_score` int DEFAULT NULL,
  `GK_match6_ht` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match6_at` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `GK_match6_ht_score` int DEFAULT NULL,
  `GK_match6_at_score` int DEFAULT NULL,
  `GK_saves` int DEFAULT NULL,
  PRIMARY KEY (`mf_GK_id`,`mf_GK_round`,`mf_GK_tname`,`GK_pname`),
  UNIQUE KEY `mf_GK_id_UNIQUE` (`mf_GK_id`),
  KEY `mf_GK_round_round_FK_idx` (`mf_GK_round`),
  KEY `mf_GK_tname_tname_FK_idx` (`mf_GK_tname`),
  KEY `mf_GK_pname_pname_FK_idx` (`GK_pname`),
  CONSTRAINT `mf_GK_pname_pname_FK` FOREIGN KEY (`GK_pname`) REFERENCES `players` (`pname`),
  CONSTRAINT `mf_GK_round_round_FK` FOREIGN KEY (`mf_GK_round`) REFERENCES `calendar` (`round`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mf_GK_tname_tname_FK` FOREIGN KEY (`mf_GK_tname`) REFERENCES `teams` (`tname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match_forms_gk`
--

LOCK TABLES `match_forms_gk` WRITE;
/*!40000 ALTER TABLE `match_forms_gk` DISABLE KEYS */;
/*!40000 ALTER TABLE `match_forms_gk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `pname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `pusername` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `Teams_tid` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `pDOB` date DEFAULT NULL,
  `jerseyNo` int DEFAULT NULL,
  `ppos` enum('GK','FW') COLLATE latin1_general_ci NOT NULL,
  `prole` enum('Player','Coach','Owner') COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`pname`,`Teams_tid`),
  UNIQUE KEY `pusername_UNIQUE` (`pusername`),
  KEY `players_Teams_tname_tname_FK_idx` (`Teams_tid`),
  CONSTRAINT `players_Teams_tname_tname_FK` FOREIGN KEY (`Teams_tid`) REFERENCES `teams` (`tname`),
  CONSTRAINT `pusername_pusername_FK` FOREIGN KEY (`pusername`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `tid` int NOT NULL AUTO_INCREMENT,
  `League_lid` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `tabbrv` varchar(5) COLLATE latin1_general_ci NOT NULL,
  `tname` varchar(45) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`tid`,`League_lid`,`tname`),
  UNIQUE KEY `tid_UNIQUE` (`tid`),
  UNIQUE KEY `tname_UNIQUE` (`tname`),
  KEY `teams_lid_lid_FK_idx` (`League_lid`),
  CONSTRAINT `teams_lid_lid_FK` FOREIGN KEY (`League_lid`) REFERENCES `leagues` (`lname`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `password` varchar(45) COLLATE latin1_general_ci NOT NULL,
  `e-mail` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `e-mail_UNIQUE` (`e-mail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-28 21:20:10
