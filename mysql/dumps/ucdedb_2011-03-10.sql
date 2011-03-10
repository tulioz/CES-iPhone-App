# Sequel Pro dump
# Version 2492
# http://code.google.com/p/sequel-pro
#
# Host: 127.0.0.1 (MySQL 5.5.9)
# Database: ucdedb
# Generation Time: 2011-03-10 00:53:25 -0800
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table hospitals
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hospitals`;

CREATE TABLE `hospitals` (
  `id` int(11) NOT NULL,
  `type` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `hours` varchar(256) NOT NULL,
  `imageURL` varchar(512) NOT NULL,
  `address` varchar(512) NOT NULL,
  `city` varchar(256) NOT NULL,
  `country` varchar(256) NOT NULL,
  `phone` varchar(256) NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `mapsURL` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` (`id`,`type`,`name`,`hours`,`imageURL`,`address`,`city`,`country`,`phone`,`longitude`,`latitude`,`mapsURL`)
VALUES
	(1,'Emergency','Sutter Hospital','','','54321 Fake St.','Davis CA','United States','',0,0,'');

/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table restaurants
# ------------------------------------------------------------

DROP TABLE IF EXISTS `restaurants`;

CREATE TABLE `restaurants` (
  `id` int(11) NOT NULL,
  `type` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `hours` varchar(256) NOT NULL,
  `imageURL` varchar(512) NOT NULL,
  `address` varchar(512) NOT NULL,
  `city` varchar(256) NOT NULL,
  `country` varchar(256) NOT NULL,
  `phone` varchar(256) NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `mapsURL` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` (`id`,`type`,`name`,`hours`,`imageURL`,`address`,`city`,`country`,`phone`,`longitude`,`latitude`,`mapsURL`)
VALUES
	(3,'Chinese','Panda Express','11:00AM - 10:00PM','','54321 Fake St.','Davis CA','United States','5305551234',0,0,''),
	(1,'Chinese','Hunan Restaurant','9:00AM - 9:00PM','','12345 Fake St.','Davis CA','United States','5305554321',0,0,''),
	(2,'Mexican','Dos Coyotes','11:00AM - 10:30PM','','15243 Fake St.','Davis CA','United States','5305554132',0,0,''),
	(4,'Mexican','Taco Bell','11:00AM - 10:30PM','','15243 Fake St.','Davis CA','United States','5305554132',0,0,'');

/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;





/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
