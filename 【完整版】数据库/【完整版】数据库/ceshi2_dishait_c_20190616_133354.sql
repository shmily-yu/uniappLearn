-- MySQL dump 10.13  Distrib 5.5.57, for Linux (x86_64)
--
-- Host: localhost    Database: ceshi2_dishait_c
-- ------------------------------------------------------
-- Server version	5.5.57-log

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
-- Table structure for table `adsense`
--

DROP TABLE IF EXISTS `adsense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adsense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 动态轮播图 1个人中心',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adsense`
--

LOCK TABLES `adsense` WRITE;
/*!40000 ALTER TABLE `adsense` DISABLE KEYS */;
INSERT INTO `adsense` VALUES (1,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/banner1.jpg','#',0,NULL),(2,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/banner2.jpg','#',0,NULL),(3,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/banner3.jpg','#',0,NULL),(4,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/demo20.jpg','#',1,NULL);
/*!40000 ALTER TABLE `adsense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blacklist`
--

DROP TABLE IF EXISTS `blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `black_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '拉黑id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blacklist`
--

LOCK TABLES `blacklist` WRITE;
/*!40000 ALTER TABLE `blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned NOT NULL DEFAULT '0' COMMENT '发布人',
  `fid` int(20) unsigned NOT NULL DEFAULT '0' COMMENT '回复id',
  `fnum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被回复数',
  `data` varchar(225) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,12,0,3,'1111',1556711049,1),(4,12,0,1,'dasdasd',1556711049,1),(5,12,1,2,'dasdasd',1556711061,1),(6,13,0,1,'11111111',1558098716,1),(7,13,5,1,'11111111',1558098755,1),(8,17,0,1,'你好啊',1560014096,1),(9,17,0,2,'帅哥',1560014106,1),(10,17,4,1,'哈哈哈',1560015924,1),(11,17,10,0,'你好',1560016025,1),(12,17,6,0,'哈哈',1560016102,1),(13,17,9,1,'你好',1560016108,1),(14,17,8,1,'再试试',1560016180,1),(15,17,9,0,'再来哈哈哈哈',1560016344,1),(16,17,1,1,'哦哦哦',1560016387,1),(17,17,16,2,'够帅',1560016394,1),(18,17,17,0,'哈哈哈',1560061449,1),(19,17,0,1,'试试',1560061495,1),(20,17,7,1,'你好',1560061507,1),(21,17,17,0,'哦哦',1560061515,1),(22,17,20,1,'再来试试',1560061550,1),(23,17,22,0,'试试就试试',1560061564,1),(24,17,19,1,'不错哦',1560061595,1),(25,17,24,1,'够帅',1560061601,1),(26,17,13,0,'你好啊',1560061612,1),(27,17,0,1,'我来发言',1560061627,2),(28,17,1,0,'测试监听',1560062094,1),(29,17,27,0,'测试监听',1560062159,2),(30,13,14,0,'你好',1560169056,1),(31,17,0,2,'你好啊',1560344714,1),(32,17,5,0,'你好啊啊啊啊啊啊啊啊啊啊啊啊',1560345250,1),(33,17,31,1,'你也好',1560345471,1),(34,17,0,1,'试一下评论',1560348300,3),(35,25,0,1,'你好',1560474507,1),(36,25,35,0,'1',1560474532,1),(37,25,31,0,'2',1560474538,1),(38,25,33,0,'3',1560474544,1),(39,25,25,0,'4',1560474552,1),(40,22,0,0,'111',1560513600,13),(41,25,0,0,'要不要',1560562889,3),(42,25,34,0,'你好',1560562900,3);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接受id',
  `from_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送id',
  `data` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,0,13,'反馈信息',1558188172),(2,0,13,'你好',1559632845),(3,0,13,'请问现在几点了',1559632859),(4,0,13,'你好啊',1560247142),(5,0,13,'哈哈',1560247201),(6,0,13,'哦哦哦',1560247277),(7,0,25,'1',1560474823);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follow_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (55,13,17,1560428142),(60,7,17,1560430016),(61,12,17,1560430043),(64,12,25,1560474575),(65,7,25,1560581302);
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/1.jpg',NULL,12),(2,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/2.jpg',NULL,12),(3,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/3.jpg',NULL,12),(4,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg',NULL,12),(5,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/5.jpg',NULL,12),(6,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/6.jpg',NULL,12),(7,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/7.jpg',NULL,12),(8,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/8.jpg',NULL,12),(9,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/9.jpg',NULL,12),(10,'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/10.jpg',NULL,12),(11,'uploads\\20190502\\ba3320c975c195bba33fe491dfbf2fd8.png',1556788050,12),(12,'uploads\\20190502\\016544b1652debb7aa8da51fdb9b28c0.png',1556788202,12),(13,'uploads\\20190503\\81f7298baf56d037abbc1d2e549a7323.png',1556868076,12),(14,'uploads\\20190503\\7201f83cbc5b84c728471eddde3e88ec.png',1556868214,12),(15,'uploads\\20190503\\5939e872ddcb0c0ef11d2f059eee7006.png',1556868936,12),(16,'uploads\\20190503\\76d975acc31e0e0cd7a7714cfa949bf7.png',1556868936,12),(17,'uploads\\20190503\\ec8011cd419379f8df094ccf36814a69.png',1556869096,12),(18,'uploads\\20190503\\9bb3590d57c6f65bc0c739606ecabeac.png',1556869096,12),(19,'uploads\\20190503\\827850ec0c58089b7081119d86f5cb65.png',1556869301,7),(20,'uploads\\20190503\\2e1619e6da0b7bcd1bb102096cb0c781.png',1556869301,12),(21,'uploads\\20190511\\f00ad77d26d9379ada780ef8f7788505.png',1557578888,14),(22,'uploads\\20190511\\1ea9d6e263a29477086aa640c08e02e8.png',1557578971,14),(23,'uploads\\20190511\\65c531a93b20c630fddf22efec560079.png',1557578971,14),(24,'uploads\\20190511\\4309ef7756ed5a8022d3d2258eeb9ecd.png',1557578971,14),(25,'uploads\\20190518\\0304fb7d8eb09b7f38d104b995bdd58c.png',1558180658,13),(26,'uploads/20190603/7c15ebe98312a27644b8fdc753caf199.png',1559572921,13),(27,'uploads/20190603/c967112789be2a19772e32a1bf32307b.png',1559573381,13),(28,'uploads/20190603/e770436061fecea3917ee09b2209030c.png',1559573600,13),(29,'uploads/20190604/4303abe3d6ae150f6bf88b82834652db.png',1559581414,13),(30,'uploads/20190604/a2f3b3222b5a3e783691bcd8675f7572.png',1559581505,13),(31,'uploads/20190604/b0a541f5bde2e9640819020853484e03.jpg',1559581651,13),(32,'uploads/20190604/134b59e4b6fc9a4d083ac9ae93e8e267.jpg',1559581710,13),(33,'uploads/20190604/ef18eca2d7921f8e5c59937729a5bf09.jpg',1559581765,13),(34,'uploads/20190604/daa1e7ba44cb443d45f3a4bb1a1ec3e2.png',1559581800,13),(35,'uploads/20190608/769fac2c72866b4466c5fe0dc874d960.jpg',1560003072,17),(36,'uploads/20190608/62a2e606a37eda8c58bdd717365b34a7.jpg',1560003096,17),(37,'uploads/20190608/f4f7da474cf17838ab805704a3f36ff3.jpg',1560003223,17),(38,'uploads/20190608/0d9679ea64feae1c7aaf1552d14a3ce6.jpg',1560003821,17),(39,'uploads/20190608/15104d8c1bdd6b029eccd0625632c545.jpg',1560003821,17),(40,'uploads/20190608/0798115c6ebc8ac791be4fb06a34a7eb.jpg',1560004732,17),(41,'uploads/20190608/51ed2092b3d47de01390b54b2f6957cf.jpg',1560004732,17),(42,'uploads/20190608/992fbde9f0e1599e616ffbf8b8ea7f26.jpg',1560005123,17),(43,'uploads/20190608/f91f3dcede9bed959377d73c25d3b92c.jpg',1560005378,17),(44,'uploads/20190608/af58f09f2c6223d23649f775f0a47dd7.jpg',1560005378,17),(45,'uploads/20190608/61b7c11361ec68d2d8a47fc3df9eada9.jpg',1560006190,17),(46,'uploads/20190608/c8f3eedff3924d6129493dae4515027a.jpg',1560006190,17),(47,'uploads/20190609/5611bd51e4c2dd54403e7953dfe4172e.jpg',1560060374,17),(48,'uploads/20190609/cc882964d56a9b227fdfa821f238b87b.jpg',1560060374,17),(49,'uploads/20190609/bfd506c1ff8cc950e8c201464cec4aa2.jpg',1560060374,17),(50,'uploads/20190609/639f586b168ca69b9d864aa4b1c5e679.jpg',1560060374,17),(51,'uploads/20190609/fea4a602e4f5f1e89ee2cd9d34fe4aa1.jpg',1560060659,17),(52,'uploads/20190609/33cfde9a25338320c2d588dddc8552e9.jpg',1560060659,17),(53,'uploads/20190610/864a20e07426c7fe8ba9dbd332133197.jpg',1560169147,13),(54,'uploads/20190610/7fc981ec6d88626262d8e8b909200835.jpg',1560169195,13),(55,'uploads/20190611/4b274586ac6b39104c707ac0c5b28f8f.jpg',1560244727,13),(56,'uploads/20190611/67a60206c7cca6c7aebe2439a63e49fe.jpg',1560265394,13),(57,'uploads/20190611/10531cdb45c17e8c957d24936f21f025.jpg',1560265395,13),(58,'uploads/20190612/b5df904c172419b8f947c34741460c88.jpg',1560342951,17),(59,'uploads/20190612/9872d95cc552a6f5b8a5fbb92004fde7.jpg',1560342968,17),(60,'uploads/20190612/662f678b0a096d2335a75e1c60c87d65.jpg',1560342968,17),(61,'uploads/20190614/34f17d3ce66c92c3e003e2d7605b9e09.jpg',1560474642,25),(62,'uploads/20190614/7a06ac99a71de63d83ce947c71f5ba76.jpg',1560474642,25),(63,'uploads/20190614/ea9a848e1db826bcc9a0fd9367867cc1.png',1560525184,25);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned NOT NULL DEFAULT '0' COMMENT '发布人',
  `title` varchar(80) NOT NULL,
  `titlepic` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `sharenum` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 图文 1分享',
  `create_time` int(11) DEFAULT NULL,
  `post_class_id` int(11) DEFAULT NULL,
  `share_id` int(11) unsigned DEFAULT '0',
  `isopen` tinyint(1) DEFAULT '1' COMMENT '1开放，0仅自己可见',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,12,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东深圳',0,NULL,1,0,1),(2,7,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东佛山',0,NULL,1,0,1),(3,12,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东-广州-白云11',0,NULL,1,0,1),(4,12,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东-广州-白云11',0,NULL,1,0,1),(5,12,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东-广州-白云11',0,NULL,1,0,1),(8,12,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东-广州-白云11',0,NULL,1,0,1),(9,12,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'广东-广州-白云11',0,NULL,1,0,1),(10,14,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'未知',0,0,1,0,1),(11,14,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'未知',0,0,1,0,1),(12,14,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'未知',0,1557581053,1,0,1),(13,14,'最前线 | 微信调整公众号分成比例，收入不设上限留住好内容','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg','uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。',0,'未知',0,1557581932,1,0,1),(14,17,'12132','','12132',0,'广东广州',0,1560005478,2,0,0),(15,17,'12132','','12132',0,'广东广州',0,1560005579,2,0,0),(16,17,'测试一下发布信息','','测试一下发布信息',0,'广东广州',0,1560006203,2,0,0),(17,17,'再来发一篇文章','','再来发一篇文章',0,'广东广州',0,1560060388,2,0,1),(18,17,'哈哈哈哈','','哈哈哈哈',0,'广东广州',0,1560060668,2,0,0),(21,17,'哦哦哦','','哦哦哦',0,'广东广州',0,1560063314,2,0,0),(22,13,'哈哈哈哈嗝','','哈哈哈哈嗝',0,'河北省-石家庄市-新华区',0,1560265417,3,0,1),(23,17,'试一下发布','','试一下发布',0,'广东广州',0,1560343579,1,0,1),(24,17,'哈哈哈哈哈哈','','哈哈哈哈哈哈',0,'广东广州',0,1560343652,2,0,1),(25,25,'美丽的姑娘啊','','美丽的姑娘啊',0,'未知',0,1560474675,2,0,1);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_class`
--

DROP TABLE IF EXISTS `post_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_class`
--

LOCK TABLES `post_class` WRITE;
/*!40000 ALTER TABLE `post_class` DISABLE KEYS */;
INSERT INTO `post_class` VALUES (1,'关注',1,NULL),(2,'推荐',1,NULL),(3,'体育',1,NULL),(4,'热点',1,NULL),(5,'财经',1,NULL),(6,'娱乐',1,NULL);
/*!40000 ALTER TABLE `post_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_image`
--

DROP TABLE IF EXISTS `post_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '帖子id',
  `image_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片id',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_image`
--

LOCK TABLES `post_image` WRITE;
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
INSERT INTO `post_image` VALUES (1,1,1,NULL),(2,1,2,NULL),(3,1,3,NULL),(4,2,4,NULL),(5,2,5,NULL),(6,3,19,NULL),(7,3,20,NULL),(8,4,19,0),(9,4,20,0),(10,5,19,1556872203),(11,5,20,1556872203),(12,8,20,1556872774),(13,9,20,1556872856),(14,14,43,1560005478),(15,14,44,1560005478),(16,15,43,1560005579),(17,15,44,1560005579),(18,16,46,1560006203),(19,16,45,1560006203),(20,17,47,1560060388),(21,17,48,1560060388),(22,17,49,1560060388),(23,17,50,1560060388),(24,18,51,1560060668),(25,18,52,1560060668),(26,22,56,1560265417),(27,22,57,1560265417),(28,23,58,1560343579),(29,23,59,1560343579),(30,24,58,1560343652),(31,24,59,1560343652),(32,25,62,1560474675),(33,25,61,1560474675);
/*!40000 ALTER TABLE `post_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support`
--

DROP TABLE IF EXISTS `support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布人',
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '帖子id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 顶 1踩',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support`
--

LOCK TABLES `support` WRITE;
/*!40000 ALTER TABLE `support` DISABLE KEYS */;
INSERT INTO `support` VALUES (43,13,14,0,1560265096),(44,13,15,0,1560265117),(45,17,1,0,1560348266),(46,17,3,0,1560348288),(47,25,1,0,1560474594),(48,25,2,1,1560562864);
/*!40000 ALTER TABLE `support` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `titlepic` varchar(255) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` datetime DEFAULT NULL,
  `topic_class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (1,'话题名称哈哈哈','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1),(2,'话题名称','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1),(3,'话题名称哈哈哈','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1),(4,'话题名称哈哈哈','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1),(5,'话题名称哈哈哈','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1),(6,'话题名称哈哈哈','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1),(7,'话题名称哈哈哈','https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg','话题描述',1,NULL,1);
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_class`
--

DROP TABLE IF EXISTS `topic_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_class`
--

LOCK TABLES `topic_class` WRITE;
/*!40000 ALTER TABLE `topic_class` DISABLE KEYS */;
INSERT INTO `topic_class` VALUES (1,'关注',1,NULL),(2,'推荐',1,NULL),(3,'体育',1,NULL),(4,'热点',1,NULL),(5,'财经',1,NULL),(6,'娱乐',1,NULL);
/*!40000 ALTER TABLE `topic_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic_post`
--

DROP TABLE IF EXISTS `topic_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题id',
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '帖子id',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic_post`
--

LOCK TABLES `topic_post` WRITE;
/*!40000 ALTER TABLE `topic_post` DISABLE KEYS */;
INSERT INTO `topic_post` VALUES (1,1,1,NULL),(2,1,2,NULL),(3,1,21,0),(4,2,22,0),(5,1,23,1560343579),(6,2,24,1560343652),(7,4,25,1560474675);
/*!40000 ALTER TABLE `topic_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `update`
--

DROP TABLE IF EXISTS `update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `update` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0未上线 1上线',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `update`
--

LOCK TABLES `update` WRITE;
/*!40000 ALTER TABLE `update` DISABLE KEYS */;
INSERT INTO `update` VALUES (1,'http://www.baidu.com','1.0.1',1,NULL);
/*!40000 ALTER TABLE `update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `userpic` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (7,'zcmcss','http://pic136.nipic.com/file/20170725/10673188_152559977000_2.jpg','','13450772004','123@qq.com',1,NULL),(12,'测试1','http://img3.duitang.com/uploads/item/201605/07/20160507191419_J2m8R.thumb.700_0.jpeg','$2y$10$04f9Ay2fQPKr1pEFA0KMcedx7mKXeZn01iTk7Opw39TwFveoU3q/W','13450772007','1236@qq.com',1,1556431201),(13,'昵111称','http://img.52z.com/upload/news/image/20181108/20181108204521_83402.jpg','$2y$10$Wtnl6fUcWn9FVJ0HeUcMEeYrUxAHxaXgXRb62T4wjvR6uG18qdRRW','13450772008','111@qq.com',1,1556790013),(14,'123456','http://b-ssl.duitang.com/uploads/item/201608/21/20160821230024_MyCYK.thumb.700_0.jpeg','$2y$10$f1CR90N6Ocstrc42rYj.wuxSBQHLNm3vq1oamQaN2XcSxdDwYR0Ge','13450772011','',1,1556974137),(15,'13450772009','http://img0.imgtn.bdimg.com/it/u=533012005,1605503981&fm=26&gp=0.jpg','','13450772009',NULL,1,1558078514),(17,'13450772012','http://m.360buyimg.com/pop/jfs/t23434/230/1763906670/10667/55866a07/5b697898N78cd1466.jpg','','13450772012',NULL,1,1558084499),(18,'13450772013',NULL,'$2y$10$9.KtKNdViCzg7UEeBooZNuxoNBufcwBJaQwV7g6e2gsCnCJEPeHyK','13450772013',NULL,1,1559474168),(19,'13656457563',NULL,'','13656457563',NULL,1,1559655420),(20,'13450772022',NULL,'','13450772022',NULL,1,1559655600),(21,'13450772023',NULL,'','13450772023',NULL,1,1559655843),(22,'13450772024',NULL,'$2y$10$y76WPQI2GY8x4G9BdRB2se0kWknPBsosJnWW9ZODtONyd/s/gkV32','13450772024','1112@qq.com',1,1559655964),(23,'13711111111',NULL,'','13711111111',NULL,1,1560235719),(24,'13122222222',NULL,'','13122222222',NULL,1,1560388448),(25,'18300000000','https://ceshi2.dishait.cn//uploads/20190614/ea9a848e1db826bcc9a0fd9367867cc1.png','','18327681010',NULL,1,1560474455);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_bind`
--

DROP TABLE IF EXISTS `user_bind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_bind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `user_id` int(10) unsigned DEFAULT '0',
  `nickname` varchar(50) DEFAULT NULL,
  `avatarurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_bind`
--

LOCK TABLES `user_bind` WRITE;
/*!40000 ALTER TABLE `user_bind` DISABLE KEYS */;
INSERT INTO `user_bind` VALUES (1,'weixin','oRrdQt3HS3Ns2TFCVLMOyxbR9DcM',12,'楚绵','http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132'),(2,'sinaweibo','5385242162',17,'楚绵','http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132'),(3,'qq','5385242162',0,'楚绵','http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132'),(6,'weixin','oU5Yytz7ielo7Xw00LMgZsPeSDkQ',17,'楚绵222','http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132'),(7,'weixin','oRrdQt3HS3Ns2TFCVLMO22yxbR9DcM',13,'楚绵1111','http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132'),(8,'qq','D88CA39C2E51B37A3069A9A5D1FFC3B2',0,'mcz','http://qzapp.qlogo.cn/qzapp/1104455702/D88CA39C2E51B37A3069A9A5D1FFC3B2/30'),(9,'weixin','oU5Yyt95Owu3xcBDjMrEoM6RuKRc',25,'舒','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKkArlpiaIrFcPv33UWlkIiaoYsESkImGtbs1StJHdGibicG2yicibG6sDS2nod91jxk554eribzttu2wkTw/132'),(10,'weixin','oU5YytzQpxi4QI70F3-XwSLsIrhI',0,'张兆军','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIsDC08TPexGOKQ51UxWdjolEJzzZFjFHiarnpkFg8IYefrKYTL6XMmL6OM6OibNbic0AQuCs7XIQctA/132'),(11,'weixin','oU5Yyt3yiQPyN4zP-IKVFrcHYbvo',0,'漳州便民网','http://thirdwx.qlogo.cn/mmopen/vi_32/ibxIAqWnynPsVT4vVx4SjpssCwFU3LWyDqHQTgM0PibGib2P7U77oloc08AzrmxHzHcSx31cJpsQK6icf1ejMgVP8Q/132'),(12,'weixin','oU5Yyt-DKeV-jsfOmmjwEnFX2N5I',0,'鹏程万里','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKbzreFQt2bPRaQPiaxQYWuyhkiaUoutAUlCX4E3hC6EEMDUibRicVRM0bdOAfxc5gkoQPia3iaP22vAOOg/132');
/*!40000 ALTER TABLE `user_bind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `age` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '年龄',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '0 男 1女 2不限',
  `qg` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不限',
  `job` varchar(10) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfo`
--

LOCK TABLES `userinfo` WRITE;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` VALUES (1,7,0,2,0,NULL,NULL,NULL),(2,12,0,1,1,'IT','广东-广州-白云11','1997-11-10'),(3,13,0,1,0,'IT','河北省-石家庄市-新华区','1991-11-21'),(5,14,0,2,0,NULL,NULL,NULL),(6,15,0,0,0,'IT','广东广州','1990-11-11'),(7,17,0,0,0,'IT','广东广州','1990-11-11'),(8,18,0,2,0,NULL,NULL,NULL),(9,19,0,2,0,NULL,NULL,NULL),(10,20,0,2,0,NULL,NULL,NULL),(11,21,0,2,0,NULL,NULL,NULL),(12,22,0,2,0,NULL,NULL,NULL),(13,23,0,2,0,NULL,NULL,NULL),(14,24,0,2,0,NULL,NULL,NULL),(15,25,0,2,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-16 13:33:54
