-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: foodiedelightdb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `AgentRatings`
--

DROP TABLE IF EXISTS `AgentRatings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AgentRatings` (
  `RatingID` int NOT NULL AUTO_INCREMENT,
  `AgentID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Rating` float DEFAULT NULL,
  `RatingDate` datetime DEFAULT NULL,
  PRIMARY KEY (`RatingID`),
  KEY `fk_agent` (`AgentID`),
  KEY `fk_user` (`UserID`),
  CONSTRAINT `fk_agent` FOREIGN KEY (`AgentID`) REFERENCES `Agents` (`AgentID`),
  CONSTRAINT `fk_user` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AgentRatings`
--

LOCK TABLES `AgentRatings` WRITE;
/*!40000 ALTER TABLE `AgentRatings` DISABLE KEYS */;
/*!40000 ALTER TABLE `AgentRatings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Agents`
--

DROP TABLE IF EXISTS `Agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Agents` (
  `AgentID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ProfileURL` text COLLATE utf8mb4_unicode_ci,
  `Status` enum('Online','Offline') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AverageRatings` float DEFAULT NULL,
  PRIMARY KEY (`AgentID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `agents_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Agents`
--

LOCK TABLES `Agents` WRITE;
/*!40000 ALTER TABLE `Agents` DISABLE KEYS */;
/*!40000 ALTER TABLE `Agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cuisines`
--

DROP TABLE IF EXISTS `Cuisines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cuisines` (
  `CuisineID` int NOT NULL AUTO_INCREMENT,
  `CuisineName` varchar(55) DEFAULT NULL,
  `CuisineDescription` varchar(255) DEFAULT NULL,
  `CuisineUrl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CuisineID`),
  UNIQUE KEY `CuisineName_UNIQUE` (`CuisineName`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cuisines`
--

LOCK TABLES `Cuisines` WRITE;
/*!40000 ALTER TABLE `Cuisines` DISABLE KEYS */;
INSERT INTO `Cuisines` VALUES (1,'Pure Veg','A vegetarian paradise loaded with options to satisfy your cravings.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029858/PC_Creative%20refresh/3D_bau/banners_new/Pure_Veg.png'),(2,'South Indian','Explore hot & spicy dishes that are a specialty of South India.\nExplore hot & spicy dishes that are a specialty of South India','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1675667626/PC_Creative%20refresh/South_Indian_4.png'),(3,'Chinese','Transport your taste buds to the heart of Chinese cuisine with these scrumptious dishes.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029848/PC_Creative%20refresh/3D_bau/banners_new/Chinese.png'),(4,'Ice cream','Flavourful ice creams that will make you smile a bit wider.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029851/PC_Creative%20refresh/3D_bau/banners_new/Ice_Creams.png'),(5,'Burger','Satisfy your cravings with these fresh and flavoursome burgers.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029845/PC_Creative%20refresh/3D_bau/banners_new/Burger.png'),(6,'Pizza','Cheesilicious pizzas to make every day extraordinary.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029856/PC_Creative%20refresh/3D_bau/banners_new/Pizza.png'),(7,'Biryani','Taste these delectable classics, delectable biryanis to make your day.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1675667625/PC_Creative%20refresh/Biryani_2.png'),(8,'North Indian','Indulge with the best of North Indian cuisines.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1675667625/PC_Creative%20refresh/North_Indian_4.png'),(9,'Cakes','Feast on amazing cakes to satisfy your sweet tooth.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029845/PC_Creative%20refresh/3D_bau/banners_new/Cakes.png'),(10,'Dosa','Satisfy your cravings for South Indian breakfast with these crispy & buttery Dosas.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029850/PC_Creative%20refresh/3D_bau/banners_new/Dosa.png'),(11,'Pav Bhaji','Flavourful Pav Bhaji that will remind you of the streets of Mumbai in every bite.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029854/PC_Creative%20refresh/3D_bau/banners_new/Pav_Bhaji.png'),(12,'Salad','Give a healthy twist to your diet and order these delicious ranges of salads.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029859/PC_Creative%20refresh/3D_bau/banners_new/Salad.png'),(13,'Sandwich','Bring home fresh and filling sandwiches to munch on.','https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_288,h_360/v1674029860/PC_Creative%20refresh/3D_bau/banners_new/Sandwich.png');
/*!40000 ALTER TABLE `Cuisines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeliveryInfo`
--

DROP TABLE IF EXISTS `DeliveryInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DeliveryInfo` (
  `DeliveryID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `DeliveryPersonnelID` int DEFAULT NULL,
  `EstimatedDeliveryTime` time DEFAULT NULL,
  `Status` enum('Out For Delivery','Delivered','Failed') DEFAULT NULL,
  `DeliverDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`DeliveryID`),
  KEY `DeliveryPersonnelID` (`DeliveryPersonnelID`),
  KEY `fk_deliveryinfo_order` (`OrderID`),
  CONSTRAINT `deliveryinfo_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`),
  CONSTRAINT `deliveryinfo_ibfk_2` FOREIGN KEY (`DeliveryPersonnelID`) REFERENCES `Users` (`UserID`),
  CONSTRAINT `fk_deliveryinfo_order` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DeliveryInfo`
--

LOCK TABLES `DeliveryInfo` WRITE;
/*!40000 ALTER TABLE `DeliveryInfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `DeliveryInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MenuItems`
--

DROP TABLE IF EXISTS `MenuItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MenuItems` (
  `ItemID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` text,
  `Price` decimal(10,2) DEFAULT NULL,
  `PhotoURL` varchar(255) DEFAULT NULL,
  `Status` enum('Available','Not Available') DEFAULT 'Available',
  `Type` enum('Veg','Non-Veg') NOT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `RestaurantID` (`RestaurantID`),
  CONSTRAINT `menuitems_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `Restaurants` (`RestaurantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MenuItems`
--

LOCK TABLES `MenuItems` WRITE;
/*!40000 ALTER TABLE `MenuItems` DISABLE KEYS */;
/*!40000 ALTER TABLE `MenuItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderItems`
--

DROP TABLE IF EXISTS `OrderItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OrderItems` (
  `OrderItemID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Quantity` int DEFAULT NULL,
  `ItemTotalPrice` decimal(10,2) DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  PRIMARY KEY (`OrderItemID`),
  KEY `orderitems_ibfk_2` (`ItemID`),
  KEY `fk_orderitems_order` (`OrderID`),
  CONSTRAINT `fk_orderitems_order` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`ItemID`) REFERENCES `MenuItems` (`ItemID`) ON DELETE CASCADE,
  CONSTRAINT `orderitems_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderItems`
--

LOCK TABLES `OrderItems` WRITE;
/*!40000 ALTER TABLE `OrderItems` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrderItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `OrderDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `DeliveryAddress` text,
  `Subtotal` decimal(10,2) DEFAULT NULL,
  `GST` decimal(10,2) DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `Status` enum('Pending','In Progress','Delivered','Cancelled') DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `UserID` (`UserID`),
  KEY `fk_RestaurantID` (`RestaurantID`),
  CONSTRAINT `fk_RestaurantID` FOREIGN KEY (`RestaurantID`) REFERENCES `Restaurants` (`RestaurantID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PaymentDetails`
--

DROP TABLE IF EXISTS `PaymentDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PaymentDetails` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `PaymentMethod` enum('Card','UPI','Cash','Other') DEFAULT NULL,
  `Status` enum('Processed','Failed','Pending') DEFAULT NULL,
  `TransactionDate` datetime DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `fk_paymentdetails_order` (`OrderID`),
  CONSTRAINT `fk_paymentdetails_order` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`),
  CONSTRAINT `paymentdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PaymentDetails`
--

LOCK TABLES `PaymentDetails` WRITE;
/*!40000 ALTER TABLE `PaymentDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `PaymentDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RatingsReviews`
--

DROP TABLE IF EXISTS `RatingsReviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RatingsReviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `Rating` float DEFAULT NULL,
  `ReviewText` text,
  `ReviewDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `RestaurantID` (`RestaurantID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `ratingsreviews_ibfk_1` FOREIGN KEY (`RestaurantID`) REFERENCES `Restaurants` (`RestaurantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RatingsReviews`
--

LOCK TABLES `RatingsReviews` WRITE;
/*!40000 ALTER TABLE `RatingsReviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `RatingsReviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restaurants`
--

DROP TABLE IF EXISTS `Restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Restaurants` (
  `RestaurantID` int NOT NULL AUTO_INCREMENT,
  `OwnerID` int DEFAULT NULL,
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ContactInfo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AverageRating` float DEFAULT NULL,
  `ETA` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AverageCost` decimal(10,2) DEFAULT '119.00',
  `CuisineTypes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Status` enum('Open','Closed','Temporarily Closed') COLLATE utf8mb4_unicode_ci DEFAULT 'Temporarily Closed',
  `OrderStatus` enum('Accepting','Not Accepting') COLLATE utf8mb4_unicode_ci DEFAULT 'Not Accepting',
  `Discounts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CityName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `State` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PinCode` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Type` enum('Veg','Non-Veg','Both') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ImageURL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` text COLLATE utf8mb4_unicode_ci,
  `OpeningTime` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ClosingTime` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Tags` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`RestaurantID`),
  KEY `OwnerID` (`OwnerID`),
  CONSTRAINT `restaurants_ibfk_1` FOREIGN KEY (`OwnerID`) REFERENCES `Users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurants`
--

LOCK TABLES `Restaurants` WRITE;
/*!40000 ALTER TABLE `Restaurants` DISABLE KEYS */;
/*!40000 ALTER TABLE `Restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(55) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `UserName` varchar(12) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `UserRole` enum('Customer','SuperAdmin','RestaurantOwner','DeliveryPerson') DEFAULT 'Customer',
  `Status` enum('Active','Inactive','Suspended') DEFAULT 'Active',
  `Address` varchar(255) DEFAULT NULL,
  `Street` varchar(55) DEFAULT NULL,
  `CityName` varchar(55) DEFAULT NULL,
  `State` varchar(55) DEFAULT NULL,
  `PinCode` varchar(6) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `LastLogin` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Sachin Nimbal','9900140463','sknsachin','72d583721f16f7e4f0f117e1c21d89d7ecef082752ac0b0063ed5aed3be3f07e','SuperAdmin','Active','Near Maddhuramma Temple Tavarakere','BTM Layout','Bengaluru','Karnataka','560029','2024-04-11 22:27:01',NULL),(2,'Sachin','9900140463','sachin','5faf402082607c7e017e2f6cebf2506129b27caa3818b4738196c0e24962664b','RestaurantOwner','Active',NULL,NULL,NULL,NULL,NULL,'2024-06-25 19:38:23',NULL);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-25 19:44:48
