-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: jsp_project2021
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `no` int NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `writer` varchar(20) DEFAULT NULL,
  `writeDate` date DEFAULT NULL,
  `viewCount` int DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,'tt','tt','test','2021-11-27',18),(2,'테스트중입니다....JSP 프로젝트 화이팅하자...!!!','아자아자 화이팅','test123','2021-12-03',10),(3,'세 번째 게시글입니다.','이렇게 테스트중','test','2021-12-03',5),(4,'12345678901234567890123456789012345678901234567890','1234567890','test','2021-12-03',5),(5,'asdf','asdf\r\n<asdfasdfasef\r\n134>134134\r\nasdge','test','2021-12-04',5),(6,'포트폴리오 작성하기~','오늘은 월요일, 시스템 분석 및 설계 시험을 본 날이다~\r\n좀 실수한 부분이 있는 것 같지만 그래도 만족스러운 시험이다~!','201844045','2021-12-07',17),(7,'시스템 분석 및 설계','시험 끝~','201844045','2021-12-07',1),(8,'운영체제','비대면일까 대면일까!?','201844045','2021-12-07',1),(9,'수라국수','인하대 후문에 있는 수라국수 집','201844045','2021-12-07',1),(10,'야식 추천','야식으로 무엇을 먹을까..','201844045','2021-12-07',1),(11,'마스크 벗고싶다..','코로나 빨리 끝나라!!','201844045','2021-12-07',1),(12,'이번주는 15주차','보강주까지 플젝 두개 더...','201844045','2021-12-07',0),(13,'로스트아크라는 게임','호감도','201844045','2021-12-07',0),(14,'돋보기 버튼 이미지','ㅈㄱㄴ','201844045','2021-12-07',0),(15,'pdf, txt, exe 등등','이런 파일은 안올라가용~','201844045','2021-12-07',1),(16,'애초에 파일 선택 시 이미지만 선택되게 해놨습니다.','열심히 찾아봤습니당','201844045','2021-12-07',0);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardimg`
--

DROP TABLE IF EXISTS `boardimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardimg` (
  `no` int DEFAULT NULL,
  `fileRealName` varchar(100) DEFAULT NULL,
  `imgNo` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardimg`
--

LOCK TABLES `boardimg` WRITE;
/*!40000 ALTER TABLE `boardimg` DISABLE KEYS */;
INSERT INTO `boardimg` VALUES (1,NULL,5),(1,NULL,4),(1,NULL,3),(1,NULL,2),(1,'AC.jpg',1),(2,NULL,5),(2,NULL,4),(2,NULL,3),(2,'수라국수.png',2),(2,NULL,1),(3,NULL,5),(3,NULL,4),(3,'cat.gif',3),(3,NULL,2),(3,NULL,1),(4,NULL,5),(4,NULL,4),(4,NULL,3),(4,NULL,2),(4,NULL,1),(5,NULL,5),(5,NULL,4),(5,NULL,3),(5,NULL,2),(5,NULL,1),(6,NULL,5),(6,NULL,4),(6,'잠금화면1.jpg',3),(6,'Image.jpeg',2),(6,NULL,1),(7,NULL,5),(7,NULL,4),(7,NULL,3),(7,NULL,2),(7,NULL,1),(8,NULL,5),(8,NULL,4),(8,NULL,3),(8,NULL,2),(8,NULL,1),(9,NULL,5),(9,NULL,4),(9,'수라국수1.png',3),(9,NULL,2),(9,NULL,1),(10,NULL,5),(10,NULL,4),(10,NULL,3),(10,NULL,2),(10,NULL,1),(11,NULL,5),(11,NULL,4),(11,NULL,3),(11,NULL,2),(11,NULL,1),(12,NULL,5),(12,NULL,4),(12,NULL,3),(12,NULL,2),(12,NULL,1),(13,NULL,5),(13,NULL,4),(13,'호감도 골드.jpg',3),(13,NULL,2),(13,NULL,1),(14,NULL,5),(14,NULL,4),(14,'search.png',3),(14,NULL,2),(14,NULL,1),(15,NULL,5),(15,NULL,4),(15,NULL,3),(15,NULL,2),(15,NULL,1),(16,NULL,5),(16,NULL,4),(16,NULL,3),(16,NULL,2),(16,NULL,1);
/*!40000 ALTER TABLE `boardimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna` (
  `no` int NOT NULL,
  `question` varchar(100) DEFAULT NULL,
  `answer` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

LOCK TABLES `qna` WRITE;
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
INSERT INTO `qna` VALUES (1,'오늘 뭐 먹었어?','갈비 먹었어'),(2,'나 심심해','그럴 땐 게임이지'),(3,'커피 추천해 줘','아샷추'),(4,'오늘 뭐 먹지?','피자'),(5,'나 심심해','공부나 해'),(6,'오늘 뭐 먹었어?','수육!!'),(7,'기분이 안 좋아','가끔은 멈춰 서서 여유를 가지는 것은 어때?'),(8,'오미크론이 뭐야?','스파이크 단백질에 돌연변이 32개가 발생한 코로나19 변이 바이러스'),(9,'코로나가 뭐야?','코로나 바이러스(CoV)는 사람과 다양한 동물에 감염될 수 있는 바이러스로서 유전자 크기 27~32kb의 RNA 바이러스(출처 : http://ncov.mohw.go.kr/baroView.do)'),(10,'나 심심해','나랑 놀자'),(11,'오늘은 우산을 챙겨야 할까?','아니'),(12,'배고파','야식 시켜 먹어'),(13,'오늘은 우산을 챙겨야 할까?','우산보단 우비지'),(14,'코로나가 뭐야?','중국 우한에서부터 시작된 바이러스'),(15,'치킨 추천해 줘','고추바사삭이 맛있더라'),(16,'7은 피보나치 수열이야?','아니지'),(17,'애국가','1. 동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세  2. 남산 위에 저 소나무 철갑을 두른 듯 바람 서리 불변함은 우리 기상일세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세  3. 가을 하늘 공활한데 높고 구름 없이 밝은 달은 우리 가슴 일편단심일세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세  4. 이 기상과 이 맘으로 충성을 다하여 괴로우나 즐거우나 나라 사랑하세 무궁화 삼천리 화려 강산 대한 사람 대한으로 길이 보전하세'),(18,'오늘은 우산을 챙겨야 할까?','챙기지마!'),(19,'애국가','대한민국의 국가');
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undefined_qna`
--

DROP TABLE IF EXISTS `undefined_qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undefined_qna` (
  `no` int NOT NULL,
  `question` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undefined_qna`
--

LOCK TABLES `undefined_qna` WRITE;
/*!40000 ALTER TABLE `undefined_qna` DISABLE KEYS */;
INSERT INTO `undefined_qna` VALUES (1,'기분이 안 좋아'),(2,'나 심심해'),(3,'코로나가 뭐야?'),(4,'오미크론이 뭐야?'),(5,'커피 추천해 줘'),(6,'무릎이 아파'),(7,'오늘 뭐 먹었어?'),(8,'오늘 뭐 먹지?'),(9,'배고파'),(10,'치킨 추천해 줘'),(11,'7은 피보나치 수열이야?'),(12,'오늘은 우산을 챙겨야 할까?'),(13,'애국가');
/*!40000 ALTER TABLE `undefined_qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` varchar(20) DEFAULT NULL,
  `userPassword` varchar(20) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `userEmail` varchar(40) DEFAULT NULL,
  `userGender` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('test','123','김연욱','cc@cc','남자'),('test123','123','이새봄','bb@bb','여자'),('201844045','dusdnr123','김연욱','201844045@itc.ac.kr','남자');
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

-- Dump completed on 2021-12-07  4:11:55
