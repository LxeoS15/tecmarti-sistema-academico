-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: tecmarti
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `idalumnos` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apaterno` varchar(100) NOT NULL,
  `amaterno` varchar(100) NOT NULL,
  `curp` varchar(18) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `correo` varchar(100) NOT NULL,
  PRIMARY KEY (`idalumnos`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (1,'Leonardo Daniel','Nuñez','Vasquez','NUVL041024HEXMRL01','2311000001','2004-10-24','leonardo.nv@tecnm.mx'),(2,'Juan Carlos','Arcos','Arcos','ARCA040512HEXRRN02','2311000002','2004-05-12','juancarlos.aa@tecnm.mx'),(3,'Jayro','Landa','Hernández','LAHJ040815HEXRRN03','2311000003','2004-08-15','jayro.lh@tecnm.mx'),(4,'Diana Laura','Molina','Arcos','MOAD041120HEXRRN04','2311000004','2004-11-20','diana.ma@tecnm.mx'),(5,'Adrian','Pozos','Costeño','POCA040303HEXRRN05','2311000005','2004-03-03','adrian.pc@tecnm.mx'),(6,'Roberto Carlos','Sanchez','Bonilla','SABR040707HEXRRN06','2311000006','2004-07-07','roberto.sb@tecnm.mx');
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificaciones` (
  `IdCalificaciones` int NOT NULL AUTO_INCREMENT,
  `IdAlumnos` int NOT NULL,
  `IdMateria` int NOT NULL,
  `TipoCalificacion` varchar(50) NOT NULL,
  `Calificacion` decimal(5,2) NOT NULL,
  `Idgrupo` int NOT NULL,
  PRIMARY KEY (`IdCalificaciones`),
  KEY `fk_calif_alumnos` (`IdAlumnos`),
  KEY `fk_calif_materia` (`IdMateria`),
  KEY `fk_calif_grupo` (`Idgrupo`),
  CONSTRAINT `fk_calif_alumnos` FOREIGN KEY (`IdAlumnos`) REFERENCES `alumnos` (`idalumnos`),
  CONSTRAINT `fk_calif_grupo` FOREIGN KEY (`Idgrupo`) REFERENCES `grupo` (`Idgrupo`),
  CONSTRAINT `fk_calif_materia` FOREIGN KEY (`IdMateria`) REFERENCES `materia` (`IdMateria`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (1,1,1,'Ordinario',100.00,1),(2,2,1,'Ordinario',100.00,1),(3,3,1,'Ordinario',100.00,1),(4,4,1,'Ordinario',100.00,1),(5,5,1,'Ordinario',100.00,1),(6,6,1,'Ordinario',100.00,1),(7,1,2,'Ordinario',100.00,1),(8,2,2,'Ordinario',100.00,1),(9,3,2,'Ordinario',100.00,1),(10,4,2,'Ordinario',100.00,1),(11,5,2,'Ordinario',100.00,1),(12,6,2,'Ordinario',100.00,1),(13,1,3,'Ordinario',100.00,1),(14,2,3,'Ordinario',100.00,1),(15,3,3,'Ordinario',100.00,1),(16,4,3,'Ordinario',100.00,1),(17,5,3,'Ordinario',100.00,1),(18,6,3,'Ordinario',100.00,1),(19,1,4,'Ordinario',100.00,1),(20,2,4,'Ordinario',100.00,1),(21,3,4,'Ordinario',100.00,1),(22,4,4,'Ordinario',100.00,1),(23,5,4,'Ordinario',100.00,1),(24,6,4,'Ordinario',100.00,1),(25,1,5,'Ordinario',100.00,1),(26,2,5,'Ordinario',100.00,1),(27,3,5,'Ordinario',100.00,1),(28,4,5,'Ordinario',100.00,1),(29,5,5,'Ordinario',100.00,1),(30,6,5,'Ordinario',100.00,1),(31,1,6,'Ordinario',100.00,1),(32,2,6,'Ordinario',100.00,1),(33,3,6,'Ordinario',100.00,1),(34,4,6,'Ordinario',100.00,1),(35,5,6,'Ordinario',100.00,1),(36,6,6,'Ordinario',100.00,1);
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carga`
--

DROP TABLE IF EXISTS `carga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carga` (
  `IdCarga` int NOT NULL AUTO_INCREMENT,
  `Idgrupo` int NOT NULL,
  `IdAlumnos` int NOT NULL,
  `IdMateria` int NOT NULL,
  PRIMARY KEY (`IdCarga`),
  KEY `fk_carga_grupo` (`Idgrupo`),
  KEY `fk_carga_alumnos` (`IdAlumnos`),
  KEY `fk_carga_materia` (`IdMateria`),
  CONSTRAINT `fk_carga_alumnos` FOREIGN KEY (`IdAlumnos`) REFERENCES `alumnos` (`idalumnos`),
  CONSTRAINT `fk_carga_grupo` FOREIGN KEY (`Idgrupo`) REFERENCES `grupo` (`Idgrupo`),
  CONSTRAINT `fk_carga_materia` FOREIGN KEY (`IdMateria`) REFERENCES `materia` (`IdMateria`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carga`
--

LOCK TABLES `carga` WRITE;
/*!40000 ALTER TABLE `carga` DISABLE KEYS */;
INSERT INTO `carga` VALUES (1,1,1,1),(2,1,2,1),(3,1,3,1),(4,1,4,1),(5,1,5,1),(6,1,6,1),(7,1,1,2),(8,1,2,2),(9,1,3,2),(10,1,4,2),(11,1,5,2),(12,1,6,2),(13,1,1,3),(14,1,2,3),(15,1,3,3),(16,1,4,3),(17,1,5,3),(18,1,6,3),(19,1,1,4),(20,1,2,4),(21,1,3,4),(22,1,4,4),(23,1,5,4),(24,1,6,4),(25,1,1,5),(26,1,2,5),(27,1,3,5),(28,1,4,5),(29,1,5,5),(30,1,6,5),(31,1,1,6),(32,1,2,6),(33,1,3,6),(34,1,4,6),(35,1,5,6),(36,1,6,6);
/*!40000 ALTER TABLE `carga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrera`
--

DROP TABLE IF EXISTS `carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrera` (
  `IdCarrera` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  PRIMARY KEY (`IdCarrera`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` VALUES (1,'Ingeniería en Sistemas Computacionales');
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciclo`
--

DROP TABLE IF EXISTS `ciclo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclo` (
  `Idciclo` int NOT NULL AUTO_INCREMENT,
  `Fechainicio` date NOT NULL,
  `Fechafin` date NOT NULL,
  PRIMARY KEY (`Idciclo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclo`
--

LOCK TABLES `ciclo` WRITE;
/*!40000 ALTER TABLE `ciclo` DISABLE KEYS */;
INSERT INTO `ciclo` VALUES (1,'2024-09-02','2025-01-24'),(2,'2025-02-03','2025-06-27'),(3,'2025-09-01','2026-01-23'),(4,'2026-02-02','2026-06-26'),(5,'2026-09-01','2027-01-22'),(6,'2027-02-01','2027-06-25'),(7,'2027-09-01','2028-01-21'),(8,'2028-02-01','2028-06-23');
/*!40000 ALTER TABLE `ciclo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `Idgrupo` int NOT NULL AUTO_INCREMENT,
  `grado` int NOT NULL,
  `grupo` varchar(10) NOT NULL,
  `IdCarrera` int NOT NULL,
  `Idciclo` int NOT NULL,
  PRIMARY KEY (`Idgrupo`),
  KEY `fk_grupo_carrera` (`IdCarrera`),
  KEY `fk_grupo_ciclo` (`Idciclo`),
  CONSTRAINT `fk_grupo_carrera` FOREIGN KEY (`IdCarrera`) REFERENCES `carrera` (`IdCarrera`),
  CONSTRAINT `fk_grupo_ciclo` FOREIGN KEY (`Idciclo`) REFERENCES `ciclo` (`Idciclo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
INSERT INTO `grupo` VALUES (1,1,'F',1,1),(2,2,'F',1,2),(3,3,'F',1,3),(4,4,'F',1,4),(5,5,'F',1,5),(6,6,'F',1,6),(7,7,'F',1,7),(8,8,'F',1,8);
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materia` (
  `IdMateria` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Creditos` int NOT NULL,
  PRIMARY KEY (`IdMateria`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia`
--

LOCK TABLES `materia` WRITE;
/*!40000 ALTER TABLE `materia` DISABLE KEYS */;
INSERT INTO `materia` VALUES (1,'Fundamentos de investigación',4),(2,'Taller de ética',4),(3,'Taller de administración',4),(4,'Matemáticas discretas',5),(5,'Fundamentos de programación',5),(6,'Cálculo diferencial',5),(7,'Desarrollo sustentable',5),(8,'Cálculo vectorial',5),(9,'Investigación de operaciones',4),(10,'Física general',5),(11,'Estructura de datos',5),(12,'Cultura empresarial',4),(13,'Taller de bases de datos',4),(14,'Sistemas operativos',4),(15,'Graficación',4),(16,'Fundamentos de telecomunicaciones',4),(17,'Fundamentos de ingeniería de software',4),(18,'Arquitectura de computadoras',5),(19,'Taller de investigación I',4),(20,'Tecnologías emergentes y transformación digital',5),(21,'Sistemas programables',5),(22,'Lenguajes y autómatas II',5),(23,'Gestión de proyectos de software',5),(24,'Conmutación y enrutamiento de redes',5),(25,'Análisis y exploración de datos',5);
/*!40000 ALTER TABLE `materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `Idpersona` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Apaterno` varchar(100) NOT NULL,
  `Amaterno` varchar(100) NOT NULL,
  `Curp` varchar(18) NOT NULL,
  `Fechanacimiento` date NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  PRIMARY KEY (`Idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,'Leonardo Daniel','Nuñez','Vasquez','NUVL041024HEXMRL01','2004-10-24','leonardo.nv@tecnm.mx','2311000001'),(2,'Juan Carlos','Arcos','Arcos','ARCA040512HEXRRN02','2004-05-12','juancarlos.aa@tecnm.mx','2311000002'),(3,'Jayro','Landa','Hernández','LAHJ040815HEXRRN03','2004-08-15','jayro.lh@tecnm.mx','2311000003'),(4,'Diana Laura','Molina','Arcos','MOAD041120HEXRRN04','2004-11-20','diana.ma@tecnm.mx','2311000004'),(5,'Adrian','Pozos','Costeño','POCA040303HEXRRN05','2004-03-03','adrian.pc@tecnm.mx','2311000005'),(6,'Roberto Carlos','Sanchez','Bonilla','SABR040707HEXRRN06','2004-07-07','roberto.sb@tecnm.mx','2311000006'),(7,'Keila Elena','Ocaña','Drouaillet','OCDK800101HEXRRN01','1980-01-01','keila.ocana@tecnm.mx','2312000001'),(8,'Víctor Fabián','Cañas','Correa','CACV810202HEXRRN02','1981-02-02','victor.canas@tecnm.mx','2312000002'),(9,'Ángel','Salas','Martínez','SAMA820303HEXRRN03','1982-03-03','angel.salas@tecnm.mx','2312000003'),(10,'José','Lameiras','Pleites','LAPJ830404HEXRRN04','1983-04-04','jose.lameiras@tecnm.mx','2312000004'),(11,'Laura Elena','Huesca','Lagunés','HULL840505HEXRRN05','1984-05-05','laura.huesca@tecnm.mx','2312000005'),(12,'Francisco Javier','Yáñez','Bringas','YABF850606HEXRRN06','1985-06-06','francisco.yanez@tecnm.mx','2312000006'),(13,'Yenzuny Magdalena','Hernández','Berré','HEBY860707HEXRRN07','1986-07-07','yenzuny.hernandez@tecnm.mx','2312000007'),(14,'Sofía Isabel','Fernández','Gregorio','FEGS870808HEXRRN08','1987-08-08','sofia.fernandez@tecnm.mx','2312000008');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-03  1:45:27
