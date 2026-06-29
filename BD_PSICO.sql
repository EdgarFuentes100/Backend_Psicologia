-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: sistemapsicologia
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `idArea` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idArea`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Psicología',NULL,1),(2,'Área Legal',NULL,1);
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `idCita` int NOT NULL AUTO_INCREMENT,
  `idPaciente` int NOT NULL,
  `idDoctor` int NOT NULL,
  `idServicio` int NOT NULL,
  `fecha` date NOT NULL,
  `horaInicio` time NOT NULL,
  `horaFin` time NOT NULL,
  `estado` enum('Pendiente','Confirmada','Finalizada','Cancelada') DEFAULT 'Pendiente',
  `observaciones` text,
  `fechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCita`),
  KEY `idPaciente` (`idPaciente`),
  KEY `idDoctor` (`idDoctor`),
  KEY `idServicio` (`idServicio`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`idPaciente`) REFERENCES `personas` (`idPersona`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`idDoctor`) REFERENCES `doctores` (`idDoctor`),
  CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`idServicio`) REFERENCES `servicios` (`idServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `idConsulta` int NOT NULL AUTO_INCREMENT,
  `idCita` int NOT NULL,
  `motivoConsulta` text,
  `diagnostico` text,
  `tratamiento` text,
  `observaciones` text,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConsulta`),
  KEY `idCita` (`idCita`),
  CONSTRAINT `consultas_ibfk_1` FOREIGN KEY (`idCita`) REFERENCES `citas` (`idCita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_servicio`
--

DROP TABLE IF EXISTS `doctor_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_servicio` (
  `idDoctorServicio` int NOT NULL AUTO_INCREMENT,
  `idDoctor` int NOT NULL,
  `idServicio` int NOT NULL,
  PRIMARY KEY (`idDoctorServicio`),
  UNIQUE KEY `idDoctor` (`idDoctor`,`idServicio`),
  KEY `idServicio` (`idServicio`),
  CONSTRAINT `doctor_servicio_ibfk_1` FOREIGN KEY (`idDoctor`) REFERENCES `doctores` (`idDoctor`),
  CONSTRAINT `doctor_servicio_ibfk_2` FOREIGN KEY (`idServicio`) REFERENCES `servicios` (`idServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_servicio`
--

LOCK TABLES `doctor_servicio` WRITE;
/*!40000 ALTER TABLE `doctor_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctores`
--

DROP TABLE IF EXISTS `doctores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctores` (
  `idDoctor` int NOT NULL AUTO_INCREMENT,
  `idPersona` int NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `numeroColegiado` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idDoctor`),
  KEY `idPersona` (`idPersona`),
  CONSTRAINT `doctores_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `personas` (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctores`
--

LOCK TABLES `doctores` WRITE;
/*!40000 ALTER TABLE `doctores` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios` (
  `idHorario` int NOT NULL AUTO_INCREMENT,
  `idDoctor` int NOT NULL,
  `diaSemana` enum('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo') DEFAULT NULL,
  `horaInicio` time DEFAULT NULL,
  `horaFin` time DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idHorario`),
  KEY `idDoctor` (`idDoctor`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`idDoctor`) REFERENCES `doctores` (`idDoctor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `idPago` int NOT NULL AUTO_INCREMENT,
  `idCita` int NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `metodoPago` enum('Efectivo','Tarjeta','Transferencia') DEFAULT NULL,
  `estado` enum('Pendiente','Pagado') DEFAULT 'Pendiente',
  `fechaPago` datetime DEFAULT NULL,
  PRIMARY KEY (`idPago`),
  KEY `idCita` (`idCita`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`idCita`) REFERENCES `citas` (`idCita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `idPersona` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `dui` varchar(10) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `sexo` enum('Masculino','Femenino') DEFAULT NULL,
  `direccion` text,
  PRIMARY KEY (`idPersona`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,1,'Edgar','Fuentes',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Control total del sistema',1),(2,'Doctor','Gestiona sus citas',1),(3,'Paciente','Agenda citas',1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `idServicio` int NOT NULL AUTO_INCREMENT,
  `idArea` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) NOT NULL,
  `duracionMinutos` int NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idServicio`),
  KEY `idArea` (`idArea`),
  CONSTRAINT `servicios_ibfk_1` FOREIGN KEY (`idArea`) REFERENCES `areas` (`idArea`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,1,'Consulta Psicológica Inicial',NULL,25.00,60,1),(2,1,'Consulta de Seguimiento',NULL,20.00,45,1),(3,1,'Evaluación Psicológica',NULL,40.00,90,1),(4,2,'Asesoría Legal',NULL,35.00,60,1);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `idRol` int NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fechaRegistro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `idRol` (`idRol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idRol`) REFERENCES `roles` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,3,'Edgar','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',1,'2026-06-28 15:39:20');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-28 21:36:40
