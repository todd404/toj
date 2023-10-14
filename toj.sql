CREATE DATABASE  IF NOT EXISTS `oj` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `oj`;
-- MySQL dump 10.13  Distrib 5.7.39, for Win64 (x86_64)
--
-- Host: localhost    Database: oj
-- ------------------------------------------------------
-- Server version	5.7.39-log

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `problem_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `is_read` tinyint(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_comment_user_id_idx` (`user_id`),
  KEY `fk_comment_problem_id_idx` (`problem_id`),
  KEY `comment_parent_id_fk_idx` (`parent_id`),
  CONSTRAINT `comment_parent_id_fk` FOREIGN KEY (`parent_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_problem_id_fk` FOREIGN KEY (`problem_id`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (0,0,0,0,'',0,'2023-06-18 20:32:30'),(4,2,1,0,'测试',0,'2023-06-18 20:38:08'),(5,2,1,4,'子回复测试',1,'2023-06-18 20:42:23'),(7,2,1,0,'回复捏',0,'2023-06-18 20:43:54'),(9,2,1,4,'zzzz',1,'2023-06-18 21:42:16'),(10,2,1,0,'1234',0,'2023-06-19 17:46:52'),(11,2,1,0,'123456',0,'2023-06-19 17:56:09'),(12,2,1,11,'789',0,'2023-06-19 17:56:56'),(15,2,1,7,'真的回复吗',1,'2023-06-19 18:04:01'),(16,3,1,4,'你好',1,'2023-06-21 12:58:50'),(17,3,1,0,'友善的回复',0,'2023-06-21 13:06:39'),(18,3,1,7,'你好',1,'2023-06-21 13:06:49'),(19,3,1,10,'你好',1,'2023-06-28 16:47:38');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_like` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `like_comment_id_idx` (`comment_id`),
  KEY `like_user_id_idx` (`user_id`),
  CONSTRAINT `like_comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `like_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
INSERT INTO `comment_like` VALUES (1,4,2,1),(2,5,2,1),(6,7,2,1),(7,11,2,0),(8,4,3,1),(9,17,3,1);
/*!40000 ALTER TABLE `comment_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `problem_id` int(11) NOT NULL,
  `language` varchar(50) NOT NULL,
  `code` text NOT NULL,
  `execute_time` double NOT NULL,
  `memory` int(11) NOT NULL,
  `result` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_idx` (`user_id`),
  KEY `problem_id_idx` (`problem_id`),
  CONSTRAINT `history_problem_id` FOREIGN KEY (`problem_id`) REFERENCES `problem` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `history_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,2,1,'cpp','test',2000,20000,'通过','2023-06-18 16:59:33'),(2,2,1,'cpp','test',2000,20000,'错误','2023-06-18 17:06:21'),(3,1,1,'cpp','test',2000,20000,'错误','2023-06-18 17:07:21'),(12,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\", a + b);\n  }\n\n  return 0;\n}',-1,-1,'答案错误','2023-06-20 18:55:08'),(13,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\", a + b);\n  }\n\n  return 0;\n}',-1,-1,'答案错误','2023-06-20 18:56:50'),(14,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2944,'通过','2023-06-20 18:57:22'),(19,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2984,'通过','2023-06-20 19:07:40'),(20,3,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,3112,'通过','2023-06-21 13:01:41'),(21,3,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2940,'通过','2023-06-22 00:13:13'),(22,3,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(1);\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',-1,-1,'超过运行时间限制','2023-06-22 00:16:26'),(23,3,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2928,'通过','2023-06-22 00:21:04'),(24,3,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,3016,'通过','2023-06-22 00:27:19'),(25,3,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2892,'通过','2023-06-22 00:27:52'),(30,1,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,3056,'通过','2023-06-24 23:15:33'),(31,1,3,'cpp','#include <stdio.h>\n\nint main(){\n  int a[31] = {-1};\n  int n = 0;\n  a[0] = 0;\n  a[1] = 1;\n\n  for(scanf(\"%d\", &n) != EOF){\n    if(a[n] != -1){\n      printf(\"%d\\n\", a[n]);\n    }else{\n      for(int i = 2; i <= n; i++){\n        if(a[i] != -1){\n          continue;\n        }\n\n        a[i] = a[i - 1] + a[i -2];\n      }\n\n      printf(\"%d\\n\", a[n]);\n    }\n  }\n}',-1,-1,'编译错误','2023-06-24 23:56:39'),(32,1,3,'cpp','#include <stdio.h>\n\nint main(){\n  int a[31] = {-1};\n  int n = 0;\n  a[0] = 0;\n  a[1] = 1;\n\n  while(scanf(\"%d\", &n) != EOF){\n    if(a[n] != -1){\n      printf(\"%d\\n\", a[n]);\n    }else{\n      for(int i = 2; i <= n; i++){\n        if(a[i] != -1){\n          continue;\n        }\n\n        a[i] = a[i - 1] + a[i -2];\n      }\n\n      printf(\"%d\\n\", a[n]);\n    }\n  }\n}',-1,-1,'答案错误','2023-06-24 23:59:57'),(33,1,3,'cpp','#include <stdio.h>\n\nint main(){\n  std::vector<int> a(31, -1);\n  int n = 0;\n  a[0] = 0;\n  a[1] = 1;\n\n  while(scanf(\"%d\", &n) != EOF){\n    if(a[n] != -1){\n      printf(\"%d\\n\", a[n]);\n    }else{\n      for(int i = 2; i <= n; i++){\n        if(a[i] != -1){\n          continue;\n        }\n\n        a[i] = a[i - 1] + a[i -2];\n      }\n\n      printf(\"%d\\n\", a[n]);\n    }\n  }\n}',-1,-1,'编译错误','2023-06-25 00:05:45'),(34,1,3,'cpp','#include <stdio.h>\n#include <vector>\n\nint main(){\n  std::vector<int> a(31, -1);\n  int n = 0;\n  a[0] = 0;\n  a[1] = 1;\n\n  while(scanf(\"%d\", &n) != EOF){\n    if(a[n] != -1){\n      printf(\"%d\\n\", a[n]);\n    }else{\n      for(int i = 2; i <= n; i++){\n        if(a[i] != -1){\n          continue;\n        }\n\n        a[i] = a[i - 1] + a[i -2];\n      }\n\n      printf(\"%d\\n\", a[n]);\n    }\n  }\n}',-1,-1,'答案错误','2023-06-25 00:06:00'),(35,1,3,'cpp','#include <stdio.h>\n#include <vector>\n\nint main(){\n  std::vector<int> a(31, -1);\n  int n = 0;\n  a[0] = 0;\n  a[1] = 1;\n\n  while(scanf(\"%d\", &n) != EOF){\n    if(a[n] != -1){\n      printf(\"%d\\n\", a[n]);\n    }else{\n      for(int i = 2; i <= n; i++){\n        if(a[i] != -1){\n          continue;\n        }\n\n        a[i] = a[i - 1] + a[i -2];\n      }\n\n      printf(\"%d\\n\", a[n]);\n    }\n  }\n}',0,3112,'通过','2023-06-25 00:14:20'),(36,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0.01,2948,'通过','2023-06-25 08:41:59'),(37,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0.01,3060,'通过','2023-06-25 09:10:28'),(38,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a * b);\n  }\n\n  return 0;\n}',-1,-1,'答案错误','2023-06-25 09:28:32'),(39,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0.01,2888,'通过','2023-06-25 09:28:46'),(40,2,3,'cpp','#include <stdio.h>\n#include <vector>\n\nint main(){\n  std::vector<int> a(31, -1);\n  int n = 0;\n  a[0] = 0;\n  a[1] = 1;\n\n  while(scanf(\"%d\", &n) != EOF){\n    if(a[n] != -1){\n      printf(\"%d\\n\", a[n]);\n    }else{\n      for(int i = 2; i <= n; i++){\n        if(a[i] != -1){\n          continue;\n        }\n\n        a[i] = a[i - 1] + a[i -2];\n      }\n\n      printf(\"%d\\n\", a[n]);\n    }\n  }\n}',0.01,3108,'通过','2023-06-25 09:30:24'),(41,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2892,'通过','2023-06-28 16:50:05'),(42,2,1,'cpp','#include <stdio.h>\n\nint main(){\n  int a = 0, b = 0;\n\n  while(scanf(\"%d %d\", &a, &b) != EOF){\n    printf(\"%d\\n\", a + b);\n  }\n\n  return 0;\n}',0,2960,'通过','2023-06-28 16:50:10'),(43,2,1,'cpp','#include <stdio.h>\n\nint main(){\n	int a = 0, b = 0;\n\n	while(scanf(\"%d %d\", &a, &b) != EOF){\n  		printf(\"%d\\n\", a + b);\n	}\n\n	return 0;\n}',-1,-1,'判题中...','2023-09-11 22:41:57'),(45,2,1,'cpp','#include <stdio.h>\n\nint main(){\n	int a = 0, b = 0;\n\n	while(scanf(\"%d %d\", &a, &b) != EOF){\n  		printf(\"%d\\n\", a + b);\n	}\n\n	return 0;\n}',-1,-1,'判题中...','2023-09-11 22:43:54'),(48,2,1,'cpp','#include <stdio.h>\n\nint main(){\n	int a = 0, b = 0;\n\n	while(scanf(\"%d %d\", &a, &b) != EOF){\n  		printf(\"%d\\n\", a + b);\n	}\n\n	return 0;\n}',0,2936,'通过','2023-09-11 22:46:05');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `difficulty` int(11) NOT NULL,
  `time_limit` double NOT NULL DEFAULT '5000',
  `memory_limit` int(11) NOT NULL DEFAULT '20000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
INSERT INTO `problem` VALUES (0,'','',1,0,0),(1,'两数之和','# 两数之和\n每行输出两个数字，用空格间隔，对应每行输出这两个数字的和\n## 输入示例\n> 1 2\n> \n> 3 4\n\n## 输出示例\n> 3\n> \n> 7\n\n* 提示: 使用scanf返回EOF则输入结束\n~~~cpp\nwhile(scanf(\"%d %d\") != EOF){\n  //你的代码\n}\n~~~',1,2001,50001),(2,'两数之积','123',2,2000,50000),(3,'斐波那契数列','**斐波那契数** （通常用 F(n) 表示）形成的序列称为 **斐波那契数列** 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：\n> F(0) = 0，F(1) = 1\n>\n> F(n) = F(n - 1) + F(n - 2)，其中 n > 1\n> \n每行给定一个n，每行输出F(n)\n## 输入示例：\n> 2\n> \n> 3\n> \n> 4\n>\n## 输出示例：\n> 1\n> \n> 2\n> \n> 3\n* 提示：\n> 0 <= n <= 30',1,5000,20000);
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'','ea62951a5a7243cbba62c9fbd0a2f9d3',0),(1,'admin','f6fdffe48c908deb0f4c3bd36c032e72',1),(2,'toddwu','16995b98616d81230753801fba34fa6a',0),(3,'todd7066','16995b98616d81230753801fba34fa6a',0);
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

-- Dump completed on 2023-10-13 20:46:30
