CREATE DATABASE  IF NOT EXISTS `pocketdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `pocketdb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pocketdb
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `expensedetail`
--

DROP TABLE IF EXISTS `expensedetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expensedetail` (
  `expense_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `added_by_id` varchar(255) DEFAULT NULL,
  `paid_by_id` varchar(255) DEFAULT NULL,
  `paid_for_id` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `added_date` date DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `activation_flag` varchar(255) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `Sys_creation_date` date DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expensedetail`
--

LOCK TABLES `expensedetail` WRITE;
/*!40000 ALTER TABLE `expensedetail` DISABLE KEYS */;
INSERT INTO `expensedetail` VALUES (1,1,'rish8795@outlook.com','rish8795@outlook.com','rushitpandya@gmail.com',15,'EWA1','2017-11-17','Dinning','image158.png','A',30,'2017-11-17','Note'),(1,1,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',15,'EWA1','2017-11-17','Dinning','image158.png','A',30,'2017-11-17','Note'),(1,1,'rish8795@outlook.com','rish8795@outlook.com','rish8795@outlook.com',0,'EWA1','2017-11-17','Dinning','image158.png','A',30,'2017-11-17','Note'),(2,1,'rish8795@outlook.com','rushitpandya@gmail.com','rushitpandya@gmail.com',0,'EWA1','2017-11-17','Grocery','No File Selected','A',100,'2017-11-17',''),(2,1,'rish8795@outlook.com','rushitpandya@gmail.com','divyapatel8401@gmail.com',0,'EWA1','2017-11-17','Grocery','No File Selected','A',100,'2017-11-17',''),(2,1,'rish8795@outlook.com','rushitpandya@gmail.com','rish8795@outlook.com',100,'EWA1','2017-11-17','Grocery','No File Selected','A',100,'2017-11-17',''),(3,0,'rish8795@outlook.com','rish8795@outlook.com','rushitpandya@gmail.com',33.333,'EWA3','2017-11-17','Dinning','No File Selected','A',100,'2017-11-17',''),(3,0,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',33.333,'EWA3','2017-11-17','Dinning','No File Selected','A',100,'2017-11-17',''),(3,0,'rish8795@outlook.com','rish8795@outlook.com','rish8795@outlook.com',33.333,'EWA3','2017-11-17','Dinning','No File Selected','A',100,'2017-11-17',''),(4,0,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',15,'Bill 1','2017-11-17','Services','image826.png','A',30,'2017-11-17',''),(4,0,'rish8795@outlook.com','rish8795@outlook.com','rish8795@outlook.com',15,'Bill 1','2017-11-17','Services','image826.png','A',30,'2017-11-17',''),(5,0,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',100,'Ewa_Demo_Settle_Up_aaaaaaa','2017-11-17','Other','image542.png','A',100,'2017-11-17','Settle_Up'),(6,0,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',17,'Food','2017-11-17','Dinning','image182.png','A',34,'2017-11-17','Please have a look'),(6,0,'rish8795@outlook.com','rish8795@outlook.com','rish8795@outlook.com',17,'Food','2017-11-17','Dinning','image182.png','A',34,'2017-11-17','Please have a look'),(7,2,'rish8795@outlook.com','rish8795@outlook.com','rushitpandya@gmail.com',16.667,'Foods','2017-11-17','Dinning','image247.png','A',50,'2017-11-17','India foodie'),(7,2,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',16.667,'Foods','2017-11-17','Dinning','image247.png','A',50,'2017-11-17','India foodie'),(7,2,'rish8795@outlook.com','rish8795@outlook.com','rish8795@outlook.com',16.667,'Foods','2017-11-17','Dinning','image247.png','A',50,'2017-11-17','India foodie'),(8,3,'rish8795@outlook.com','rish8795@outlook.com','rushitpandya@gmail.com',40,'Food','2017-11-17','Dinning','image412.png','A',120,'2017-11-17',''),(8,3,'rish8795@outlook.com','rish8795@outlook.com','divyapatel8401@gmail.com',40,'Food','2017-11-17','Dinning','image412.png','A',120,'2017-11-17',''),(8,3,'rish8795@outlook.com','rish8795@outlook.com','rish8795@outlook.com',40,'Food','2017-11-17','Dinning','image412.png','A',120,'2017-11-17',''),(9,0,'rish8795@outlook.com','rish8795@outlook.com','rushitpandya@gmail.com',100,'Ewa_Demo_Settle_Up_aaaaaaa','2017-11-17','Other','','A',100,'2017-11-17','');
/*!40000 ALTER TABLE `expensedetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupdetail`
--

DROP TABLE IF EXISTS `groupdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupdetail` (
  `group_id` int(11) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupdetail`
--

LOCK TABLES `groupdetail` WRITE;
/*!40000 ALTER TABLE `groupdetail` DISABLE KEYS */;
INSERT INTO `groupdetail` VALUES (1,'rish8795@outlook.com','EWA'),(1,'rushitpandya@gmail.com','EWA'),(1,'divyapatel8401@gmail.com','EWA'),(2,'rish8795@outlook.com','EWA1'),(2,'rushitpandya@gmail.com','EWA1'),(2,'divyapatel8401@gmail.com','EWA1'),(3,'rish8795@outlook.com','Buddies'),(3,'rushitpandya@gmail.com','Buddies'),(3,'divyapatel8401@gmail.com','Buddies');
/*!40000 ALTER TABLE `groupdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdetail`
--

DROP TABLE IF EXISTS `userdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userdetail` (
  `email_id` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `security_question` varchar(255) DEFAULT NULL,
  `security_answer` varchar(255) DEFAULT NULL,
  `activation_flag` varchar(255) DEFAULT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  `signup_flag` varchar(255) DEFAULT NULL,
  `fb_id` varchar(255) DEFAULT NULL,
  `gmail_id` varchar(255) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `expense_limit` double DEFAULT NULL,
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdetail`
--

LOCK TABLES `userdetail` WRITE;
/*!40000 ALTER TABLE `userdetail` DISABLE KEYS */;
INSERT INTO `userdetail` VALUES ('divyapatel8401@gmail.com','123','Divya','Patel',NULL,NULL,'A','4AEF6983-1362-4A85-91E7-94CD737E2199|pocket|divyapatel8401@gmail.com','P','','','user.jpg',0),('rish8795@gmail.com','123','Rish','Shah',NULL,NULL,'A','7B98E67C-6DCA-421F-978B-A48B7D737B2C|pocket|rish8795@gmail.com','P','','','user.jpg',0),('rish8795@outlook.com',NULL,'Rishabh','Shah',NULL,NULL,'A','EAAVPx3c0VUMBAFixEGv1q5VIb6VTY69rWnk5CQMcoeSFmeDSB2WZATZB9OOULJ8ylrOXoB1ZCDZCVHjAIrgJq3xFV7c5apQNZAspcMjZCFVAQCBNMEoAzBQoCO3n3Lvp0l5B0UMidN5bk0K4x6jPRoZCjSRZBwZAZArs00aOb1ZB07eSgZDZD','F','1729693343741565',NULL,NULL,2000),('rshah92@hawk.iit.edu',NULL,'','',NULL,NULL,'A','ya29.GlsHBUsTp59zAlMGwb1Z5DGcDYMekAAFQek21i3KP_5-tjWwGUl2UA_czwInFkHdPz2mXWsN6DLDM6PdxnnkZiivrtI0lCjlBa7hvSCr7VxsYfqnQhl9NrJb7pkZ','G',NULL,'114666907211692981678','https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg',1500),('rushitpandya@gmail.com','123','Rushit','Pandya',NULL,NULL,'A','1B8B8C38-16C4-44E7-96F1-B9876C75043B|rushitpandya@gmailcom|','P','','','rushitpandya@gmail.com.jpg',0),('shah.preyang@gmail.com','123','Preyang','Shah',NULL,NULL,'A','FA60B66D-E1D9-4D56-BBD5-F28C8F9DA8A7|pocket|shah.preyang@gmail.com','P','','','user.jpg',0);
/*!40000 ALTER TABLE `userdetail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-29 16:56:17
