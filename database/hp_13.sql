-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2026 a las 22:47:28
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hp_13`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliografia`
--

CREATE TABLE `bibliografia` (
  `id_bibliografia` int(11) NOT NULL,
  `nombre_bibliografia` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bibliografia`
--

INSERT INTO `bibliografia` (`id_bibliografia`, `nombre_bibliografia`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Pressman, R. S. (2010). Ingeniería del software: un enfoque práctico.', '2026-04-27 20:47:16', NULL, '1'),
(2, 'Sommerville, I. (2011). Ingeniería de software.', '2026-04-27 20:47:16', NULL, '1'),
(3, 'Deitel, P., & Deitel, H. (2012). Java Cómo Programar.', '2026-04-27 20:47:16', NULL, '1'),
(4, 'Silberschatz, A. (2014). Fundamentos de Sistemas Operativos.', '2026-04-27 20:47:16', NULL, '1'),
(5, 'Elmasri, R., & Navathe, S. (2011). Fundamentos de Sistemas de Bases de Datos.', '2026-04-27 20:47:16', NULL, '1'),
(6, 'Tanenbaum, A. S. (2012). Redes de Computadoras.', '2026-04-27 20:47:16', NULL, '1'),
(7, 'Stallings, W. (2010). Organización y Arquitectura de Computadores.', '2026-04-27 20:47:16', NULL, '1'),
(8, 'Patterson, D. A. (2014). Estructura y diseño de computadores.', '2026-04-27 20:50:40', NULL, '1'),
(9, 'Kurose, J. F. (2013). Redes de computadoras: un enfoque descendente.', '2026-04-27 20:50:40', NULL, '1'),
(10, 'Gamma, E. (1994). Patrones de diseño: elementos de software orientado a objetos.', '2026-04-27 20:50:40', NULL, '1'),
(11, 'Fowler, M. (2018). Refactoring: Improving the Design of Existing Code.', '2026-04-27 20:50:40', NULL, '1'),
(12, 'Martin, R. C. (2008). Clean Code: A Handbook of Agile Software Craftsmanship.', '2026-04-27 20:50:40', NULL, '1'),
(13, 'Martin, R. C. (2008). Clean Code.', '2026-05-10 20:22:12', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `id_bitacora` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `modulo_afectado_bitacora` varchar(255) DEFAULT NULL,
  `tabla_afectada_bitacora` text DEFAULT NULL,
  `id_registro_afectado_bitacora` text DEFAULT NULL,
  `accion_bitacora` enum('CREAR','MODIFICAR','MOSTRAR','ELIMINAR','LOGIN','LOGOUT','REPORTE') DEFAULT NULL,
  `valores_anteriores_bitacora` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_anteriores_bitacora`)),
  `valores_nuevos_bitacora` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_nuevos_bitacora`)),
  `ip_origen_bitacora` varchar(45) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bitacora`
--

INSERT INTO `bitacora` (`id_bitacora`, `id_usuario`, `modulo_afectado_bitacora`, `tabla_afectada_bitacora`, `id_registro_afectado_bitacora`, `accion_bitacora`, `valores_anteriores_bitacora`, `valores_nuevos_bitacora`, `ip_origen_bitacora`, `fecha_creacion`, `estatus`) VALUES
(1, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-24 04:25:12', '1'),
(2, 0, 'Seguridad', 'users', '43327', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-03-24 04:33:06', '1'),
(3, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-24 04:33:30', '1'),
(4, 0, 'Seguridad', 'users', '43327', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-03-24 04:53:04', '1'),
(5, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-24 04:53:18', '1'),
(6, 43327, 'Roles (Permisos)', 'rol_permiso', '1', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"69\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.184932Z\",\"id_rol_permiso\":1}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(7, 43327, 'Roles (Permisos)', 'rol_permiso', '2', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"45\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.194625Z\",\"id_rol_permiso\":2}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(8, 43327, 'Roles (Permisos)', 'rol_permiso', '3', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"46\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.201197Z\",\"id_rol_permiso\":3}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(9, 43327, 'Roles (Permisos)', 'rol_permiso', '4', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"44\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.203839Z\",\"id_rol_permiso\":4}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(10, 43327, 'Roles (Permisos)', 'rol_permiso', '5', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"47\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.205939Z\",\"id_rol_permiso\":5}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(11, 43327, 'Roles (Permisos)', 'rol_permiso', '6', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"61\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.208523Z\",\"id_rol_permiso\":6}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(12, 43327, 'Roles (Permisos)', 'rol_permiso', '7', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"14\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.210598Z\",\"id_rol_permiso\":7}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(13, 43327, 'Roles (Permisos)', 'rol_permiso', '8', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"15\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.212852Z\",\"id_rol_permiso\":8}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(14, 43327, 'Roles (Permisos)', 'rol_permiso', '9', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"13\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.214954Z\",\"id_rol_permiso\":9}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(15, 43327, 'Roles (Permisos)', 'rol_permiso', '10', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"18\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.217130Z\",\"id_rol_permiso\":10}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(16, 43327, 'Roles (Permisos)', 'rol_permiso', '11', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"17\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.219119Z\",\"id_rol_permiso\":11}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(17, 43327, 'Roles (Permisos)', 'rol_permiso', '12', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"16\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.221056Z\",\"id_rol_permiso\":12}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(18, 43327, 'Roles (Permisos)', 'rol_permiso', '13', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"62\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.223203Z\",\"id_rol_permiso\":13}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(19, 43327, 'Roles (Permisos)', 'rol_permiso', '14', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"49\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.225107Z\",\"id_rol_permiso\":14}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(20, 43327, 'Roles (Permisos)', 'rol_permiso', '15', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"50\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.227054Z\",\"id_rol_permiso\":15}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(21, 43327, 'Roles (Permisos)', 'rol_permiso', '16', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"48\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.228848Z\",\"id_rol_permiso\":16}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(22, 43327, 'Roles (Permisos)', 'rol_permiso', '17', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.230626Z\",\"id_rol_permiso\":17}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(23, 43327, 'Roles (Permisos)', 'rol_permiso', '18', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"51\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-24T00:58:45.232526Z\",\"id_rol_permiso\":18}', '127.0.0.1', '2026-03-24 04:58:45', '1'),
(24, 43327, 'CalendarioAcademico', 'calendario_academico', '1', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-03-01\",\"dia_fin_calendario_academico\":\"2026-03-31\",\"fecha_creacion\":\"2026-03-24T01:05:02.999740Z\",\"estatus\":\"1\",\"id_calendario_academico\":1}', '127.0.0.1', '2026-03-24 05:05:03', '1'),
(25, 43327, 'Evento', 'evento', '1', 'CREAR', NULL, '{\"id_calendario\":1,\"dia_inicio_evento\":\"2026-03-18\",\"dia_fin_evento\":\"2026-03-21\",\"descripcion_evento\":\"dsd\",\"tipo_evento\":\"1\",\"fecha_creacion\":\"2026-03-24T01:05:46.510227Z\",\"estatus\":\"1\",\"id_evento\":1}', '127.0.0.1', '2026-03-24 05:05:46', '1'),
(26, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-25 05:23:50', '1'),
(27, 43327, 'Roles (Permisos)', 'rol_permiso', '19', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"61\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.447882Z\",\"id_rol_permiso\":19}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(28, 43327, 'Roles (Permisos)', 'rol_permiso', '20', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"14\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.453328Z\",\"id_rol_permiso\":20}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(29, 43327, 'Roles (Permisos)', 'rol_permiso', '21', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"15\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.455904Z\",\"id_rol_permiso\":21}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(30, 43327, 'Roles (Permisos)', 'rol_permiso', '22', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"13\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.463826Z\",\"id_rol_permiso\":22}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(31, 43327, 'Roles (Permisos)', 'rol_permiso', '23', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"18\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.470426Z\",\"id_rol_permiso\":23}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(32, 43327, 'Roles (Permisos)', 'rol_permiso', '24', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"17\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.472387Z\",\"id_rol_permiso\":24}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(33, 43327, 'Roles (Permisos)', 'rol_permiso', '25', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"16\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-25T01:30:31.474118Z\",\"id_rol_permiso\":25}', '127.0.0.1', '2026-03-25 05:30:31', '1'),
(34, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-28 15:26:21', '1'),
(35, 43327, 'Roles (Permisos)', 'rol_permiso', '26', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"62\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-28T11:50:50.467915Z\",\"id_rol_permiso\":26}', '127.0.0.1', '2026-03-28 15:50:50', '1'),
(36, 43327, 'Roles (Permisos)', 'rol_permiso', '27', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"49\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-28T11:50:50.473816Z\",\"id_rol_permiso\":27}', '127.0.0.1', '2026-03-28 15:50:50', '1'),
(37, 43327, 'Roles (Permisos)', 'rol_permiso', '28', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"50\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-28T11:50:50.477336Z\",\"id_rol_permiso\":28}', '127.0.0.1', '2026-03-28 15:50:50', '1'),
(38, 43327, 'Roles (Permisos)', 'rol_permiso', '29', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"48\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-28T11:50:50.481293Z\",\"id_rol_permiso\":29}', '127.0.0.1', '2026-03-28 15:50:50', '1'),
(39, 43327, 'Roles (Permisos)', 'rol_permiso', '30', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-28T11:50:50.488747Z\",\"id_rol_permiso\":30}', '127.0.0.1', '2026-03-28 15:50:50', '1'),
(40, 43327, 'Roles (Permisos)', 'rol_permiso', '31', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"51\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-28T11:50:50.492067Z\",\"id_rol_permiso\":31}', '127.0.0.1', '2026-03-28 15:50:50', '1'),
(41, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-07 14:58:22', '1'),
(42, 43325, 'Roles (Permisos)', 'rol_permiso', '19', 'MODIFICAR', '{\"id_rol_permiso\":19,\"id_permiso\":61,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:32:43.844281Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:32:43', '1'),
(43, 43325, 'Roles (Permisos)', 'rol_permiso', '20', 'MODIFICAR', '{\"id_rol_permiso\":20,\"id_permiso\":14,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:32:43.860660Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:32:43', '1'),
(44, 43325, 'Roles (Permisos)', 'rol_permiso', '21', 'MODIFICAR', '{\"id_rol_permiso\":21,\"id_permiso\":15,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:32:43.863778Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:32:43', '1'),
(45, 43325, 'Roles (Permisos)', 'rol_permiso', '23', 'MODIFICAR', '{\"id_rol_permiso\":23,\"id_permiso\":18,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:32:43.866415Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:32:43', '1'),
(46, 43325, 'Roles (Permisos)', 'rol_permiso', '24', 'MODIFICAR', '{\"id_rol_permiso\":24,\"id_permiso\":17,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:32:43.869147Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:32:43', '1'),
(47, 43325, 'Roles (Permisos)', 'rol_permiso', '1', 'MODIFICAR', '{\"id_rol_permiso\":1,\"id_permiso\":69,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.743673Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(48, 43325, 'Roles (Permisos)', 'rol_permiso', '2', 'MODIFICAR', '{\"id_rol_permiso\":2,\"id_permiso\":45,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.749532Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(49, 43325, 'Roles (Permisos)', 'rol_permiso', '3', 'MODIFICAR', '{\"id_rol_permiso\":3,\"id_permiso\":46,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.752910Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(50, 43325, 'Roles (Permisos)', 'rol_permiso', '4', 'MODIFICAR', '{\"id_rol_permiso\":4,\"id_permiso\":44,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.755523Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(51, 43325, 'Roles (Permisos)', 'rol_permiso', '5', 'MODIFICAR', '{\"id_rol_permiso\":5,\"id_permiso\":47,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.758395Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(52, 43325, 'Roles (Permisos)', 'rol_permiso', '13', 'MODIFICAR', '{\"id_rol_permiso\":13,\"id_permiso\":62,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.761837Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(53, 43325, 'Roles (Permisos)', 'rol_permiso', '14', 'MODIFICAR', '{\"id_rol_permiso\":14,\"id_permiso\":49,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.764721Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(54, 43325, 'Roles (Permisos)', 'rol_permiso', '15', 'MODIFICAR', '{\"id_rol_permiso\":15,\"id_permiso\":50,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.767064Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(55, 43325, 'Roles (Permisos)', 'rol_permiso', '16', 'MODIFICAR', '{\"id_rol_permiso\":16,\"id_permiso\":48,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.775474Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(56, 43325, 'Roles (Permisos)', 'rol_permiso', '17', 'MODIFICAR', '{\"id_rol_permiso\":17,\"id_permiso\":19,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.778080Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(57, 43325, 'Roles (Permisos)', 'rol_permiso', '18', 'MODIFICAR', '{\"id_rol_permiso\":18,\"id_permiso\":51,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"fecha_actualizacion\":\"2026-04-07T11:36:33.780579Z\",\"estatus\":\"3\"}', '127.0.0.1', '2026-04-07 15:36:33', '1'),
(58, 43325, 'Roles (Permisos)', 'rol_permiso', '32', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"66\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.292787Z\",\"id_rol_permiso\":32}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(59, 43325, 'Roles (Permisos)', 'rol_permiso', '33', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"33\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.303988Z\",\"id_rol_permiso\":33}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(60, 43325, 'Roles (Permisos)', 'rol_permiso', '34', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"34\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.321373Z\",\"id_rol_permiso\":34}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(61, 43325, 'Roles (Permisos)', 'rol_permiso', '35', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"32\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.323443Z\",\"id_rol_permiso\":35}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(62, 43325, 'Roles (Permisos)', 'rol_permiso', '36', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"35\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.332366Z\",\"id_rol_permiso\":36}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(63, 43325, 'Roles (Permisos)', 'rol_permiso', '37', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"29\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.335411Z\",\"id_rol_permiso\":37}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(64, 43325, 'Roles (Permisos)', 'rol_permiso', '38', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"30\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.338325Z\",\"id_rol_permiso\":38}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(65, 43325, 'Roles (Permisos)', 'rol_permiso', '39', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"28\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.341128Z\",\"id_rol_permiso\":39}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(66, 43325, 'Roles (Permisos)', 'rol_permiso', '40', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"65\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.344028Z\",\"id_rol_permiso\":40}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(67, 43325, 'Roles (Permisos)', 'rol_permiso', '41', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"31\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.346087Z\",\"id_rol_permiso\":41}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(68, 43325, 'Roles (Permisos)', 'rol_permiso', '42', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"67\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.348046Z\",\"id_rol_permiso\":42}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(69, 43325, 'Roles (Permisos)', 'rol_permiso', '43', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"37\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.349876Z\",\"id_rol_permiso\":43}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(70, 43325, 'Roles (Permisos)', 'rol_permiso', '44', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"38\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.351858Z\",\"id_rol_permiso\":44}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(71, 43325, 'Roles (Permisos)', 'rol_permiso', '45', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"36\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.354758Z\",\"id_rol_permiso\":45}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(72, 43325, 'Roles (Permisos)', 'rol_permiso', '46', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"39\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.357789Z\",\"id_rol_permiso\":46}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(73, 43325, 'Roles (Permisos)', 'rol_permiso', '47', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"68\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.360815Z\",\"id_rol_permiso\":47}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(74, 43325, 'Roles (Permisos)', 'rol_permiso', '48', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"41\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.363821Z\",\"id_rol_permiso\":48}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(75, 43325, 'Roles (Permisos)', 'rol_permiso', '49', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"42\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.366669Z\",\"id_rol_permiso\":49}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(76, 43325, 'Roles (Permisos)', 'rol_permiso', '50', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"40\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.370071Z\",\"id_rol_permiso\":50}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(77, 43325, 'Roles (Permisos)', 'rol_permiso', '51', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"43\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:38:53.372520Z\",\"id_rol_permiso\":51}', '127.0.0.1', '2026-04-07 15:38:53', '1'),
(78, 43325, 'Roles (Permisos)', 'rol_permiso', '52', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"16\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:40:35.038237Z\",\"id_rol_permiso\":52}', '127.0.0.1', '2026-04-07 15:40:35', '1'),
(79, 43325, 'Roles (Permisos)', 'rol_permiso', '53', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"13\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:40:35.049715Z\",\"id_rol_permiso\":53}', '127.0.0.1', '2026-04-07 15:40:35', '1'),
(80, 43325, 'Roles (Permisos)', 'rol_permiso', '54', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"59\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:49:15.867736Z\",\"id_rol_permiso\":54}', '127.0.0.1', '2026-04-07 15:49:15', '1'),
(81, 43325, 'Roles (Permisos)', 'rol_permiso', '55', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"8\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:49:15.874932Z\",\"id_rol_permiso\":55}', '127.0.0.1', '2026-04-07 15:49:15', '1'),
(82, 43325, 'Roles (Permisos)', 'rol_permiso', '56', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"9\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:49:15.878413Z\",\"id_rol_permiso\":56}', '127.0.0.1', '2026-04-07 15:49:15', '1'),
(83, 43325, 'Roles (Permisos)', 'rol_permiso', '57', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"7\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:49:15.881815Z\",\"id_rol_permiso\":57}', '127.0.0.1', '2026-04-07 15:49:15', '1'),
(84, 43325, 'Roles (Permisos)', 'rol_permiso', '58', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"10\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T11:49:15.885198Z\",\"id_rol_permiso\":58}', '127.0.0.1', '2026-04-07 15:49:15', '1'),
(85, 43325, 'Recurso', 'recurso', '1', 'CREAR', NULL, '{\"nombre_recurso\":\"dsdd\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T12:01:56.314873Z\",\"fecha_actualizacion\":\"2026-04-07T12:01:56.314888Z\",\"id_recurso\":1}', '127.0.0.1', '2026-04-07 16:01:56', '1'),
(86, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-08 00:57:12', '1'),
(87, 43325, 'Roles (Permisos)', 'rol_permiso', '59', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"62\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T21:12:40.632940Z\",\"id_rol_permiso\":59}', '127.0.0.1', '2026-04-08 01:12:40', '1'),
(88, 43325, 'Roles (Permisos)', 'rol_permiso', '60', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"49\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T21:12:40.639109Z\",\"id_rol_permiso\":60}', '127.0.0.1', '2026-04-08 01:12:40', '1'),
(89, 43325, 'Roles (Permisos)', 'rol_permiso', '61', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"50\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T21:12:40.641954Z\",\"id_rol_permiso\":61}', '127.0.0.1', '2026-04-08 01:12:40', '1'),
(90, 43325, 'Roles (Permisos)', 'rol_permiso', '62', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"48\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T21:12:40.644626Z\",\"id_rol_permiso\":62}', '127.0.0.1', '2026-04-08 01:12:40', '1'),
(91, 43325, 'Roles (Permisos)', 'rol_permiso', '63', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T21:12:40.647520Z\",\"id_rol_permiso\":63}', '127.0.0.1', '2026-04-08 01:12:40', '1'),
(92, 43325, 'Roles (Permisos)', 'rol_permiso', '64', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"51\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-07T21:12:40.650259Z\",\"id_rol_permiso\":64}', '127.0.0.1', '2026-04-08 01:12:40', '1'),
(93, 43325, 'CalendarioAcademico', 'calendario_academico', '2', 'CREAR', NULL, '{\"semana_calendario_academico\":1,\"dia_inicio_calendario_academico\":\"2026-04-07\",\"dia_fin_calendario_academico\":\"2026-04-08\",\"fecha_creacion\":\"2026-04-07T21:28:48.644100Z\",\"estatus\":\"1\",\"id_calendario_academico\":2}', '127.0.0.1', '2026-04-08 01:28:48', '1'),
(94, 43325, 'CalendarioAcademico', 'calendario_academico', '1', 'MOSTRAR', '{\"id_calendario_academico\":1,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-03-01\",\"dia_fin_calendario_academico\":\"2026-03-31\",\"fecha_creacion\":\"2026-03-24 01:05:02\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-04-08 01:30:59', '1'),
(95, 43325, 'CalendarioAcademico', 'calendario_academico', '2', 'MODIFICAR', '{\"id_calendario_academico\":2,\"semana_calendario_academico\":1,\"dia_inicio_calendario_academico\":\"2026-04-07\",\"dia_fin_calendario_academico\":\"2026-04-08\",\"fecha_creacion\":\"2026-04-07 21:28:48\",\"estatus\":\"1\"}', '{\"dia_fin_calendario_academico\":\"2026-04-07\"}', '127.0.0.1', '2026-04-08 01:37:04', '1'),
(96, 43325, 'CalendarioAcademico', 'calendario_academico', '1', 'MOSTRAR', '{\"id_calendario_academico\":1,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-03-01\",\"dia_fin_calendario_academico\":\"2026-03-31\",\"fecha_creacion\":\"2026-03-24 01:05:02\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-04-08 01:51:28', '1'),
(97, 43325, 'CalendarioAcademico', 'calendario_academico', '2', 'MOSTRAR', '{\"id_calendario_academico\":2,\"semana_calendario_academico\":1,\"dia_inicio_calendario_academico\":\"2026-04-07\",\"dia_fin_calendario_academico\":\"2026-04-07\",\"fecha_creacion\":\"2026-04-07 21:28:48\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-08 01:51:34', '1'),
(98, 43325, 'CalendarioAcademico', 'calendario_academico', '2', 'MOSTRAR', '{\"id_calendario_academico\":2,\"semana_calendario_academico\":1,\"dia_inicio_calendario_academico\":\"2026-04-07\",\"dia_fin_calendario_academico\":\"2026-04-07\",\"fecha_creacion\":\"2026-04-07 21:28:48\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-08 01:51:44', '1'),
(99, 43325, 'CalendarioAcademico', 'calendario_academico', '2', 'MOSTRAR', '{\"id_calendario_academico\":2,\"semana_calendario_academico\":1,\"dia_inicio_calendario_academico\":\"2026-04-07\",\"dia_fin_calendario_academico\":\"2026-04-07\",\"fecha_creacion\":\"2026-04-07 21:28:48\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-08 02:01:31', '1'),
(100, 43325, 'CalendarioAcademico', 'calendario_academico', '2', 'MOSTRAR', '{\"id_calendario_academico\":2,\"semana_calendario_academico\":1,\"dia_inicio_calendario_academico\":\"2026-04-07\",\"dia_fin_calendario_academico\":\"2026-04-07\",\"fecha_creacion\":\"2026-04-07 21:28:48\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-08 02:01:54', '1'),
(101, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-08 03:20:59', '1'),
(102, 1, 'CalendarioAcademico', 'calendario_academico', '3', 'CREAR', NULL, '{\"semana_calendario_academico\":4,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-22\",\"fecha_creacion\":\"2026-04-07T23:33:01.199930Z\",\"estatus\":\"1\",\"id_calendario_academico\":3}', '127.0.0.1', '2026-04-08 03:33:01', '1'),
(103, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-08 03:33:23', '1'),
(104, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-08 03:37:13', '1'),
(105, 1, 'CalendarioAcademico', 'calendario_academico', '4', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-02\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-08T00:58:18.820138Z\",\"estatus\":\"1\",\"id_calendario_academico\":4}', '127.0.0.1', '2026-04-08 04:58:18', '1'),
(106, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-08 04:58:20', '1'),
(107, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-10 19:40:57', '1'),
(108, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-11 01:50:29', '1'),
(109, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-11 02:51:20', '1'),
(110, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-11 02:52:17', '1'),
(111, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-11 02:52:21', '1'),
(112, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-11 02:52:55', '1'),
(113, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-11 02:53:07', '1'),
(114, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-11 02:53:44', '1'),
(115, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-11 02:53:58', '1'),
(116, 39195, 'Roles (Permisos)', 'rol_permiso', '19', 'MODIFICAR', '{\"id_rol_permiso\":19,\"id_permiso\":61,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":\"2026-04-07 11:32:43\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-10T22:57:37.900176Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-11 02:57:37', '1'),
(117, 39195, 'Roles (Permisos)', 'rol_permiso', '20', 'MODIFICAR', '{\"id_rol_permiso\":20,\"id_permiso\":14,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":\"2026-04-07 11:32:43\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-10T22:57:37.909357Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-11 02:57:37', '1'),
(118, 39195, 'Roles (Permisos)', 'rol_permiso', '21', 'MODIFICAR', '{\"id_rol_permiso\":21,\"id_permiso\":15,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":\"2026-04-07 11:32:43\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-10T22:57:37.911821Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-11 02:57:37', '1'),
(119, 39195, 'Roles (Permisos)', 'rol_permiso', '24', 'MODIFICAR', '{\"id_rol_permiso\":24,\"id_permiso\":17,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":\"2026-04-07 11:32:43\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-10T22:57:37.914544Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-11 02:57:37', '1'),
(120, 39195, 'Roles (Permisos)', 'rol_permiso', '23', 'MODIFICAR', '{\"id_rol_permiso\":23,\"id_permiso\":18,\"id_rol\":4,\"fecha_creacion\":\"2026-03-25 01:30:31\",\"fecha_actualizacion\":\"2026-04-07 11:32:43\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-10T22:57:37.922834Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-11 02:57:37', '1'),
(121, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-15 19:23:48', '1'),
(122, 39195, 'Roles (Permisos)', 'rol_permiso', '1', 'MODIFICAR', '{\"id_rol_permiso\":1,\"id_permiso\":69,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-15T15:29:02.549441Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-15 19:29:02', '1'),
(123, 39195, 'Roles (Permisos)', 'rol_permiso', '2', 'MODIFICAR', '{\"id_rol_permiso\":2,\"id_permiso\":45,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-15T15:29:02.555147Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-15 19:29:02', '1'),
(124, 39195, 'Roles (Permisos)', 'rol_permiso', '3', 'MODIFICAR', '{\"id_rol_permiso\":3,\"id_permiso\":46,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-15T15:29:02.558046Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-15 19:29:02', '1'),
(125, 39195, 'Roles (Permisos)', 'rol_permiso', '4', 'MODIFICAR', '{\"id_rol_permiso\":4,\"id_permiso\":44,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-15T15:29:02.560967Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-15 19:29:02', '1'),
(126, 39195, 'Roles (Permisos)', 'rol_permiso', '5', 'MODIFICAR', '{\"id_rol_permiso\":5,\"id_permiso\":47,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-15T15:29:02.563877Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-15 19:29:02', '1'),
(127, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-15 22:07:16', '1'),
(128, 0, 'Seguridad', 'users', '43327', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-15 22:38:59', '1'),
(129, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-15 22:40:23', '1'),
(130, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-15 22:41:47', '1'),
(131, 0, 'Seguridad', 'users', '43327', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-15 22:42:49', '1'),
(132, 0, 'Seguridad', 'users', '43327', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-15 22:43:28', '1'),
(133, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-15 22:48:11', '1'),
(134, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-17 21:27:00', '1'),
(135, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-17 21:42:29', '1'),
(136, 1, 'CalendarioAcademico', 'calendario_academico', '5', 'CREAR', NULL, '{\"semana_calendario_academico\":15,\"dia_inicio_calendario_academico\":\"2026-05-06\",\"dia_fin_calendario_academico\":\"2026-08-14\",\"fecha_creacion\":\"2026-04-17T19:02:39.033421Z\",\"estatus\":\"1\",\"id_calendario_academico\":5}', '127.0.0.1', '2026-04-17 23:02:39', '1'),
(137, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-17 23:02:46', '1'),
(138, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-17 23:03:50', '1'),
(139, 1, 'CalendarioAcademico', 'calendario_academico', '6', 'CREAR', NULL, '{\"semana_calendario_academico\":29,\"dia_inicio_calendario_academico\":\"2026-02-03\",\"dia_fin_calendario_academico\":\"2026-08-22\",\"fecha_creacion\":\"2026-04-17T19:10:52.401487Z\",\"estatus\":\"1\",\"id_calendario_academico\":6}', '127.0.0.1', '2026-04-17 23:10:52', '1'),
(140, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-17 23:10:54', '1'),
(141, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-17 23:52:53', '1'),
(142, 0, 'Seguridad', 'users', '39161', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-17 23:54:34', '1'),
(143, 0, 'Seguridad', 'users', '39161', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-17 23:54:34', '1'),
(144, 0, 'Seguridad', 'users', '39161', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-17 23:58:33', '1'),
(145, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-17 23:58:57', '1'),
(146, 43325, 'Roles (Permisos)', 'rol_permiso', '65', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"58\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-17T20:07:08.605792Z\",\"id_rol_permiso\":65}', '127.0.0.1', '2026-04-18 00:07:08', '1'),
(147, 43325, 'Roles (Permisos)', 'rol_permiso', '66', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"4\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-17T20:07:08.611190Z\",\"id_rol_permiso\":66}', '127.0.0.1', '2026-04-18 00:07:08', '1'),
(148, 43325, 'Roles (Permisos)', 'rol_permiso', '67', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"5\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-17T20:07:08.616339Z\",\"id_rol_permiso\":67}', '127.0.0.1', '2026-04-18 00:07:08', '1'),
(149, 43325, 'Roles (Permisos)', 'rol_permiso', '68', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"3\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-17T20:07:08.619030Z\",\"id_rol_permiso\":68}', '127.0.0.1', '2026-04-18 00:07:08', '1'),
(150, 43325, 'Roles (Permisos)', 'rol_permiso', '69', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"6\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-17T20:07:08.621165Z\",\"id_rol_permiso\":69}', '127.0.0.1', '2026-04-18 00:07:08', '1'),
(151, 43325, 'Tema', 'tema_unidad', '1', 'CREAR', NULL, '{\"id_unidad_curricular\":\"2\",\"titulo_tema\":\"ahasdhais\",\"unidad_tema\":\"1\",\"fecha_creacion\":\"2026-04-17T20:07:30.020037Z\",\"fecha_actualizacion\":null,\"estatus\":\"1\",\"id_tema_unidad\":1}', '127.0.0.1', '2026-04-18 00:07:30', '1'),
(152, 43325, 'Contenido', 'contenido', '1', 'CREAR', NULL, '{\"titulo_contenido\":\"kfhfihfajiaiiad\",\"fecha_creacion\":\"2026-04-17T20:07:49.623648Z\",\"estatus\":\"1\",\"id_contenido\":1}', '127.0.0.1', '2026-04-18 00:07:49', '1'),
(153, 43325, 'Estrategia', 'tecnica_actividad', '1', 'CREAR', NULL, '{\"nombre_tecnica_actividad\":\"pppppppppp\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-17T20:14:28.418775Z\",\"fecha_actualizacion\":\"2026-04-17T20:14:28.418792Z\",\"id_tecnica_actividad\":1}', '127.0.0.1', '2026-04-18 00:14:28', '1'),
(154, 1, 'CalendarioAcademico', 'calendario_academico', '7', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-19T12:51:01.555631Z\",\"estatus\":\"1\",\"id_calendario_academico\":7}', '127.0.0.1', '2026-04-19 16:51:01', '1'),
(155, 1, 'CalendarioAcademico', 'calendario_academico', '8', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-19T14:18:38.725505Z\",\"estatus\":\"1\",\"id_calendario_academico\":8}', '127.0.0.1', '2026-04-19 18:18:38', '1'),
(156, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-19 18:18:40', '1'),
(157, 0, 'Seguridad', 'users', '39195', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-19 20:13:02', '1'),
(158, 1, 'CalendarioAcademico', 'calendario_academico', '9', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-19T16:32:22.010781Z\",\"estatus\":\"1\",\"id_calendario_academico\":9}', '127.0.0.1', '2026-04-19 20:32:22', '1'),
(159, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-19 20:32:30', '1'),
(160, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-19 20:34:19', '1'),
(161, 1, 'CalendarioAcademico', 'calendario_academico', '10', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-19T16:50:51.424871Z\",\"estatus\":\"1\",\"id_calendario_academico\":10}', '127.0.0.1', '2026-04-19 20:50:51', '1'),
(162, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-19 20:50:54', '1'),
(163, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-19 20:52:25', '1'),
(164, 1, 'CalendarioAcademico', 'calendario_academico', '10', 'MODIFICAR', '{\"id_calendario_academico\":10,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-19 16:50:51\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-19 20:52:28', '1'),
(165, 1, 'CalendarioAcademico', 'calendario_academico', '11', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"fecha_creacion\":\"2026-04-19T16:53:07.041000Z\",\"estatus\":\"1\",\"id_calendario_academico\":11}', '127.0.0.1', '2026-04-19 20:53:07', '1'),
(166, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-19 20:53:08', '1'),
(167, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-19 20:55:00', '1'),
(168, 1, 'CalendarioAcademico', 'calendario_academico', '12', 'CREAR', NULL, '{\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"fecha_creacion\":\"2026-04-19T16:55:42.564150Z\",\"estatus\":\"1\",\"id_calendario_academico\":12}', '127.0.0.1', '2026-04-19 20:55:42', '1'),
(169, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-19 20:55:51', '1'),
(170, 43325, 'Roles (Permisos)', 'rol_permiso', '70', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"69\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-19T16:57:03.936785Z\",\"id_rol_permiso\":70}', '127.0.0.1', '2026-04-19 20:57:03', '1'),
(171, 43325, 'Roles (Permisos)', 'rol_permiso', '71', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"45\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-19T16:57:03.940581Z\",\"id_rol_permiso\":71}', '127.0.0.1', '2026-04-19 20:57:03', '1'),
(172, 43325, 'Roles (Permisos)', 'rol_permiso', '72', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"46\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-19T16:57:03.942966Z\",\"id_rol_permiso\":72}', '127.0.0.1', '2026-04-19 20:57:03', '1'),
(173, 43325, 'Roles (Permisos)', 'rol_permiso', '73', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"44\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-19T16:57:03.950172Z\",\"id_rol_permiso\":73}', '127.0.0.1', '2026-04-19 20:57:03', '1'),
(174, 43325, 'Roles (Permisos)', 'rol_permiso', '74', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"47\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-19T16:57:03.952366Z\",\"id_rol_permiso\":74}', '127.0.0.1', '2026-04-19 20:57:03', '1'),
(175, 43325, 'CalendarioAcademico', 'calendario_academico', '12', 'MOSTRAR', '{\"id_calendario_academico\":12,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"fecha_creacion\":\"2026-04-19 16:55:42\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-19 20:57:15', '1'),
(176, 1, 'CalendarioAcademico', 'calendario_academico', '12', 'MODIFICAR', '{\"id_calendario_academico\":12,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"fecha_creacion\":\"2026-04-19 16:55:42\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-19 20:59:41', '1'),
(177, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-19 20:59:44', '1'),
(178, 1, 'CalendarioAcademico', 'calendario_academico', '13', 'CREAR', NULL, '{\"semana_calendario_academico\":13,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-06-30\",\"fecha_creacion\":\"2026-04-19T17:00:31.648598Z\",\"estatus\":\"1\",\"id_calendario_academico\":13}', '127.0.0.1', '2026-04-19 21:00:31', '1'),
(179, 1, 'Evento', 'evento', '2', 'CREAR', NULL, '{\"id_calendario\":13,\"dia_inicio_evento\":\"2026-04-01\",\"dia_fin_evento\":\"2026-04-09\",\"descripcion_evento\":\"pop\",\"tipo_evento\":\"Cierre de Notas\",\"fecha_creacion\":\"2026-04-19T17:00:31.658766Z\",\"estatus\":\"1\",\"id_evento\":2}', '127.0.0.1', '2026-04-19 21:00:31', '1'),
(180, 1, 'Evento', 'evento', '3', 'CREAR', NULL, '{\"id_calendario\":13,\"dia_inicio_evento\":\"2026-05-15\",\"dia_fin_evento\":\"2026-05-15\",\"descripcion_evento\":\"ki\",\"tipo_evento\":\"Otro\",\"fecha_creacion\":\"2026-04-19T17:00:31.667185Z\",\"estatus\":\"1\",\"id_evento\":3}', '127.0.0.1', '2026-04-19 21:00:31', '1'),
(181, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-19 21:00:33', '1'),
(182, 0, 'Seguridad', 'users', '39114', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 00:28:22', '1'),
(183, 39114, 'Recurso', 'recurso', '2', 'CREAR', NULL, '{\"nombre_recurso\":\"Maikol\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:48:55.904386Z\",\"fecha_actualizacion\":\"2026-04-22T21:48:55.904418Z\",\"id_recurso\":2}', '127.0.0.1', '2026-04-23 01:48:55', '1'),
(184, 39114, 'Recurso', 'recurso', '3', 'CREAR', NULL, '{\"nombre_recurso\":\"hola\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:51:47.456620Z\",\"fecha_actualizacion\":\"2026-04-22T21:51:47.456635Z\",\"id_recurso\":3}', '127.0.0.1', '2026-04-23 01:51:47', '1'),
(185, 39114, 'Roles (Permisos)', 'rol_permiso', '75', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"57\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:10.957578Z\",\"id_rol_permiso\":75}', '127.0.0.1', '2026-04-23 01:54:10', '1'),
(186, 39114, 'Roles (Permisos)', 'rol_permiso', '76', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"2\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:10.990541Z\",\"id_rol_permiso\":76}', '127.0.0.1', '2026-04-23 01:54:10', '1'),
(187, 39114, 'Roles (Permisos)', 'rol_permiso', '77', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"59\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:10.994211Z\",\"id_rol_permiso\":77}', '127.0.0.1', '2026-04-23 01:54:10', '1'),
(188, 39114, 'Roles (Permisos)', 'rol_permiso', '78', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"8\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:10.998054Z\",\"id_rol_permiso\":78}', '127.0.0.1', '2026-04-23 01:54:10', '1'),
(189, 39114, 'Roles (Permisos)', 'rol_permiso', '79', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"9\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.006278Z\",\"id_rol_permiso\":79}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(190, 39114, 'Roles (Permisos)', 'rol_permiso', '80', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"7\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.186444Z\",\"id_rol_permiso\":80}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(191, 39114, 'Roles (Permisos)', 'rol_permiso', '81', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"10\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.189574Z\",\"id_rol_permiso\":81}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(192, 39114, 'Roles (Permisos)', 'rol_permiso', '82', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"74\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.193003Z\",\"id_rol_permiso\":82}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(193, 39114, 'Roles (Permisos)', 'rol_permiso', '83', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"73\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.196913Z\",\"id_rol_permiso\":83}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(194, 39114, 'Roles (Permisos)', 'rol_permiso', '84', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"72\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.200487Z\",\"id_rol_permiso\":84}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(195, 39114, 'Roles (Permisos)', 'rol_permiso', '85', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"56\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.204304Z\",\"id_rol_permiso\":85}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(196, 39114, 'Roles (Permisos)', 'rol_permiso', '86', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"1\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.207797Z\",\"id_rol_permiso\":86}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(197, 39114, 'Roles (Permisos)', 'rol_permiso', '87', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"63\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.222413Z\",\"id_rol_permiso\":87}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(198, 39114, 'Roles (Permisos)', 'rol_permiso', '88', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"21\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.225678Z\",\"id_rol_permiso\":88}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(199, 39114, 'Roles (Permisos)', 'rol_permiso', '89', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"22\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.229140Z\",\"id_rol_permiso\":89}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(200, 39114, 'Roles (Permisos)', 'rol_permiso', '90', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"20\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.232508Z\",\"id_rol_permiso\":90}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(201, 39114, 'Roles (Permisos)', 'rol_permiso', '91', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"23\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.235849Z\",\"id_rol_permiso\":91}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(202, 39114, 'Roles (Permisos)', 'rol_permiso', '92', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"58\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.312185Z\",\"id_rol_permiso\":92}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(203, 39114, 'Roles (Permisos)', 'rol_permiso', '93', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"4\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.320154Z\",\"id_rol_permiso\":93}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(204, 39114, 'Roles (Permisos)', 'rol_permiso', '94', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"5\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.323282Z\",\"id_rol_permiso\":94}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(205, 39114, 'Roles (Permisos)', 'rol_permiso', '95', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"3\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.326677Z\",\"id_rol_permiso\":95}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(206, 39114, 'Roles (Permisos)', 'rol_permiso', '96', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"6\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.329978Z\",\"id_rol_permiso\":96}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(207, 39114, 'Roles (Permisos)', 'rol_permiso', '13', 'MODIFICAR', '{\"id_rol_permiso\":13,\"id_permiso\":62,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-22T21:54:11.333230Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(208, 39114, 'Roles (Permisos)', 'rol_permiso', '14', 'MODIFICAR', '{\"id_rol_permiso\":14,\"id_permiso\":49,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-22T21:54:11.336920Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(209, 39114, 'Roles (Permisos)', 'rol_permiso', '16', 'MODIFICAR', '{\"id_rol_permiso\":16,\"id_permiso\":48,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-22T21:54:11.340542Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(210, 39114, 'Roles (Permisos)', 'rol_permiso', '17', 'MODIFICAR', '{\"id_rol_permiso\":17,\"id_permiso\":19,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-22T21:54:11.352203Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-23 01:54:11', '1');
INSERT INTO `bitacora` (`id_bitacora`, `id_usuario`, `modulo_afectado_bitacora`, `tabla_afectada_bitacora`, `id_registro_afectado_bitacora`, `accion_bitacora`, `valores_anteriores_bitacora`, `valores_nuevos_bitacora`, `ip_origen_bitacora`, `fecha_creacion`, `estatus`) VALUES
(211, 39114, 'Roles (Permisos)', 'rol_permiso', '18', 'MODIFICAR', '{\"id_rol_permiso\":18,\"id_permiso\":51,\"id_rol\":3,\"fecha_creacion\":\"2026-03-24 00:58:45\",\"fecha_actualizacion\":\"2026-04-07 11:36:33\",\"estatus\":\"3\"}', '{\"fecha_actualizacion\":\"2026-04-22T21:54:11.355780Z\",\"estatus\":\"1\"}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(212, 39114, 'Roles (Permisos)', 'rol_permiso', '97', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"71\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.359513Z\",\"id_rol_permiso\":97}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(213, 39114, 'Roles (Permisos)', 'rol_permiso', '98', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"54\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.362904Z\",\"id_rol_permiso\":98}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(214, 39114, 'Roles (Permisos)', 'rol_permiso', '99', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"55\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.366400Z\",\"id_rol_permiso\":99}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(215, 39114, 'Roles (Permisos)', 'rol_permiso', '100', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"64\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.369750Z\",\"id_rol_permiso\":100}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(216, 39114, 'Roles (Permisos)', 'rol_permiso', '101', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"25\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.372923Z\",\"id_rol_permiso\":101}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(217, 39114, 'Roles (Permisos)', 'rol_permiso', '102', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"26\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.379180Z\",\"id_rol_permiso\":102}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(218, 39114, 'Roles (Permisos)', 'rol_permiso', '103', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"24\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.387490Z\",\"id_rol_permiso\":103}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(219, 39114, 'Roles (Permisos)', 'rol_permiso', '104', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"27\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.390671Z\",\"id_rol_permiso\":104}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(220, 39114, 'Roles (Permisos)', 'rol_permiso', '105', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"60\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.393984Z\",\"id_rol_permiso\":105}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(221, 39114, 'Roles (Permisos)', 'rol_permiso', '106', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"11\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.397358Z\",\"id_rol_permiso\":106}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(222, 39114, 'Roles (Permisos)', 'rol_permiso', '107', 'CREAR', NULL, '{\"id_rol\":\"3\",\"id_permiso\":\"12\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T21:54:11.400649Z\",\"id_rol_permiso\":107}', '127.0.0.1', '2026-04-23 01:54:11', '1'),
(223, 39114, 'Estrategia', 'tecnica_actividad', '2', 'CREAR', NULL, '{\"nombre_tecnica_actividad\":\"tigresabbb\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T22:00:16.869471Z\",\"fecha_actualizacion\":\"2026-04-22T22:00:16.869488Z\",\"id_tecnica_actividad\":2}', '127.0.0.1', '2026-04-23 02:00:16', '1'),
(224, 39114, 'Recurso', 'recurso', '4', 'CREAR', NULL, '{\"nombre_recurso\":\"mantequilla\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T22:00:32.880824Z\",\"fecha_actualizacion\":\"2026-04-22T22:00:32.880841Z\",\"id_recurso\":4}', '127.0.0.1', '2026-04-23 02:00:32', '1'),
(225, 39114, 'Estrategia', 'tecnica_actividad', '3', 'CREAR', NULL, '{\"nombre_tecnica_actividad\":\"manteca\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T22:04:47.154244Z\",\"fecha_actualizacion\":\"2026-04-22T22:04:47.154270Z\",\"id_tecnica_actividad\":3}', '127.0.0.1', '2026-04-23 02:04:47', '1'),
(226, 39114, 'Recurso', 'recurso', '5', 'CREAR', NULL, '{\"nombre_recurso\":\"arepa\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-04-22T22:06:20.757016Z\",\"fecha_actualizacion\":\"2026-04-22T22:06:20.757031Z\",\"id_recurso\":5}', '127.0.0.1', '2026-04-23 02:06:20', '1'),
(227, 39114, 'Contenido', 'contenido', '2', 'CREAR', NULL, '{\"titulo_contenido\":\"html css php js\",\"fecha_creacion\":\"2026-04-22T22:22:26.328864Z\",\"estatus\":\"1\",\"id_contenido\":2}', '127.0.0.1', '2026-04-23 02:22:26', '1'),
(228, 0, 'Seguridad', 'users', '39114', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-26 02:11:26', '1'),
(229, 0, 'Seguridad', 'users', '39114', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-26 03:36:28', '1'),
(230, 0, 'Seguridad', 'users', '39114', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-26 03:37:03', '1'),
(231, 0, 'Seguridad', 'users', '39114', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-26 04:04:08', '1'),
(232, 0, 'Seguridad', 'users', '39114', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-26 04:05:52', '1'),
(233, 39114, 'CalendarioAcademico', 'calendario_academico', '12', 'MOSTRAR', '{\"id_calendario_academico\":12,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"fecha_creacion\":\"2026-04-19 16:55:42\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-04-26 04:13:50', '1'),
(234, 39114, 'CalendarioAcademico', 'calendario_academico', '13', 'MOSTRAR', '{\"id_calendario_academico\":13,\"semana_calendario_academico\":13,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-06-30\",\"fecha_creacion\":\"2026-04-19 17:00:31\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-26 04:14:04', '1'),
(235, 0, 'Seguridad', 'users', '39114', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-26 08:10:53', '1'),
(236, 0, 'Seguridad', 'users', '39114', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-26 08:25:52', '1'),
(237, 0, 'Seguridad', 'users', '39114', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-26 08:27:37', '1'),
(238, 0, 'Seguridad', 'users', '39161', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-27 20:04:33', '1'),
(239, 39161, 'Roles (Permisos)', 'rol_permiso', '327', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"60\",\"estatus\":\"1\",\"id_rol_permiso\":327}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(240, 39161, 'Roles (Permisos)', 'rol_permiso', '328', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"11\",\"estatus\":\"1\",\"id_rol_permiso\":328}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(241, 39161, 'Roles (Permisos)', 'rol_permiso', '329', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"12\",\"estatus\":\"1\",\"id_rol_permiso\":329}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(242, 39161, 'Roles (Permisos)', 'rol_permiso', '330', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"68\",\"estatus\":\"1\",\"id_rol_permiso\":330}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(243, 39161, 'Roles (Permisos)', 'rol_permiso', '331', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"41\",\"estatus\":\"1\",\"id_rol_permiso\":331}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(244, 39161, 'Roles (Permisos)', 'rol_permiso', '332', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"42\",\"estatus\":\"1\",\"id_rol_permiso\":332}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(245, 39161, 'Roles (Permisos)', 'rol_permiso', '333', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"40\",\"estatus\":\"1\",\"id_rol_permiso\":333}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(246, 39161, 'Roles (Permisos)', 'rol_permiso', '334', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"43\",\"estatus\":\"1\",\"id_rol_permiso\":334}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(247, 39161, 'Roles (Permisos)', 'rol_permiso', '335', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"59\",\"estatus\":\"1\",\"id_rol_permiso\":335}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(248, 39161, 'Roles (Permisos)', 'rol_permiso', '336', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"8\",\"estatus\":\"1\",\"id_rol_permiso\":336}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(249, 39161, 'Roles (Permisos)', 'rol_permiso', '337', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"9\",\"estatus\":\"1\",\"id_rol_permiso\":337}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(250, 39161, 'Roles (Permisos)', 'rol_permiso', '338', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"7\",\"estatus\":\"1\",\"id_rol_permiso\":338}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(251, 39161, 'Roles (Permisos)', 'rol_permiso', '339', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"10\",\"estatus\":\"1\",\"id_rol_permiso\":339}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(252, 39161, 'Roles (Permisos)', 'rol_permiso', '340', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"67\",\"estatus\":\"1\",\"id_rol_permiso\":340}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(253, 39161, 'Roles (Permisos)', 'rol_permiso', '341', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"37\",\"estatus\":\"1\",\"id_rol_permiso\":341}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(254, 39161, 'Roles (Permisos)', 'rol_permiso', '342', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"38\",\"estatus\":\"1\",\"id_rol_permiso\":342}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(255, 39161, 'Roles (Permisos)', 'rol_permiso', '343', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"36\",\"estatus\":\"1\",\"id_rol_permiso\":343}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(256, 39161, 'Roles (Permisos)', 'rol_permiso', '344', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"39\",\"estatus\":\"1\",\"id_rol_permiso\":344}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(257, 39161, 'Roles (Permisos)', 'rol_permiso', '345', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"57\",\"estatus\":\"1\",\"id_rol_permiso\":345}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(258, 39161, 'Roles (Permisos)', 'rol_permiso', '346', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"2\",\"estatus\":\"1\",\"id_rol_permiso\":346}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(259, 39161, 'Roles (Permisos)', 'rol_permiso', '347', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"65\",\"estatus\":\"1\",\"id_rol_permiso\":347}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(260, 39161, 'Roles (Permisos)', 'rol_permiso', '348', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"29\",\"estatus\":\"1\",\"id_rol_permiso\":348}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(261, 39161, 'Roles (Permisos)', 'rol_permiso', '349', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"30\",\"estatus\":\"1\",\"id_rol_permiso\":349}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(262, 39161, 'Roles (Permisos)', 'rol_permiso', '350', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"28\",\"estatus\":\"1\",\"id_rol_permiso\":350}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(263, 39161, 'Roles (Permisos)', 'rol_permiso', '351', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"31\",\"estatus\":\"1\",\"id_rol_permiso\":351}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(264, 39161, 'Roles (Permisos)', 'rol_permiso', '352', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"61\",\"estatus\":\"1\",\"id_rol_permiso\":352}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(265, 39161, 'Roles (Permisos)', 'rol_permiso', '353', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"14\",\"estatus\":\"1\",\"id_rol_permiso\":353}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(266, 39161, 'Roles (Permisos)', 'rol_permiso', '354', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"15\",\"estatus\":\"1\",\"id_rol_permiso\":354}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(267, 39161, 'Roles (Permisos)', 'rol_permiso', '355', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"18\",\"estatus\":\"1\",\"id_rol_permiso\":355}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(268, 39161, 'Roles (Permisos)', 'rol_permiso', '356', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"17\",\"estatus\":\"1\",\"id_rol_permiso\":356}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(269, 39161, 'Roles (Permisos)', 'rol_permiso', '357', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"74\",\"estatus\":\"1\",\"id_rol_permiso\":357}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(270, 39161, 'Roles (Permisos)', 'rol_permiso', '358', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"73\",\"estatus\":\"1\",\"id_rol_permiso\":358}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(271, 39161, 'Roles (Permisos)', 'rol_permiso', '359', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"72\",\"estatus\":\"1\",\"id_rol_permiso\":359}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(272, 39161, 'Roles (Permisos)', 'rol_permiso', '360', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"56\",\"estatus\":\"1\",\"id_rol_permiso\":360}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(273, 39161, 'Roles (Permisos)', 'rol_permiso', '361', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"1\",\"estatus\":\"1\",\"id_rol_permiso\":361}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(274, 39161, 'Roles (Permisos)', 'rol_permiso', '362', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"63\",\"estatus\":\"1\",\"id_rol_permiso\":362}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(275, 39161, 'Roles (Permisos)', 'rol_permiso', '363', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"21\",\"estatus\":\"1\",\"id_rol_permiso\":363}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(276, 39161, 'Roles (Permisos)', 'rol_permiso', '364', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"22\",\"estatus\":\"1\",\"id_rol_permiso\":364}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(277, 39161, 'Roles (Permisos)', 'rol_permiso', '365', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"20\",\"estatus\":\"1\",\"id_rol_permiso\":365}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(278, 39161, 'Roles (Permisos)', 'rol_permiso', '366', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"23\",\"estatus\":\"1\",\"id_rol_permiso\":366}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(279, 39161, 'Roles (Permisos)', 'rol_permiso', '367', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"64\",\"estatus\":\"1\",\"id_rol_permiso\":367}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(280, 39161, 'Roles (Permisos)', 'rol_permiso', '368', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"25\",\"estatus\":\"1\",\"id_rol_permiso\":368}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(281, 39161, 'Roles (Permisos)', 'rol_permiso', '369', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"26\",\"estatus\":\"1\",\"id_rol_permiso\":369}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(282, 39161, 'Roles (Permisos)', 'rol_permiso', '370', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"24\",\"estatus\":\"1\",\"id_rol_permiso\":370}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(283, 39161, 'Roles (Permisos)', 'rol_permiso', '371', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"27\",\"estatus\":\"1\",\"id_rol_permiso\":371}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(284, 39161, 'Roles (Permisos)', 'rol_permiso', '372', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"71\",\"estatus\":\"1\",\"id_rol_permiso\":372}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(285, 39161, 'Roles (Permisos)', 'rol_permiso', '373', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"54\",\"estatus\":\"1\",\"id_rol_permiso\":373}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(286, 39161, 'Roles (Permisos)', 'rol_permiso', '374', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"55\",\"estatus\":\"1\",\"id_rol_permiso\":374}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(287, 39161, 'Roles (Permisos)', 'rol_permiso', '375', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"62\",\"estatus\":\"1\",\"id_rol_permiso\":375}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(288, 39161, 'Roles (Permisos)', 'rol_permiso', '376', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"49\",\"estatus\":\"1\",\"id_rol_permiso\":376}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(289, 39161, 'Roles (Permisos)', 'rol_permiso', '377', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"48\",\"estatus\":\"1\",\"id_rol_permiso\":377}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(290, 39161, 'Roles (Permisos)', 'rol_permiso', '378', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"id_rol_permiso\":378}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(291, 39161, 'Roles (Permisos)', 'rol_permiso', '379', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"51\",\"estatus\":\"1\",\"id_rol_permiso\":379}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(292, 39161, 'Roles (Permisos)', 'rol_permiso', '380', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"58\",\"estatus\":\"1\",\"id_rol_permiso\":380}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(293, 39161, 'Roles (Permisos)', 'rol_permiso', '381', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"4\",\"estatus\":\"1\",\"id_rol_permiso\":381}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(294, 39161, 'Roles (Permisos)', 'rol_permiso', '382', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"5\",\"estatus\":\"1\",\"id_rol_permiso\":382}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(295, 39161, 'Roles (Permisos)', 'rol_permiso', '383', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"3\",\"estatus\":\"1\",\"id_rol_permiso\":383}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(296, 39161, 'Roles (Permisos)', 'rol_permiso', '384', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"6\",\"estatus\":\"1\",\"id_rol_permiso\":384}', '127.0.0.1', '2026-04-27 20:05:27', '1'),
(297, 39161, 'Roles (Permisos)', 'rol_permiso', '385', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"66\",\"estatus\":\"1\",\"id_rol_permiso\":385}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(298, 39161, 'Roles (Permisos)', 'rol_permiso', '386', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"33\",\"estatus\":\"1\",\"id_rol_permiso\":386}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(299, 39161, 'Roles (Permisos)', 'rol_permiso', '387', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"34\",\"estatus\":\"1\",\"id_rol_permiso\":387}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(300, 39161, 'Roles (Permisos)', 'rol_permiso', '388', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"32\",\"estatus\":\"1\",\"id_rol_permiso\":388}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(301, 39161, 'Roles (Permisos)', 'rol_permiso', '389', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"35\",\"estatus\":\"1\",\"id_rol_permiso\":389}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(302, 39161, 'Roles (Permisos)', 'rol_permiso', '390', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"69\",\"estatus\":\"1\",\"id_rol_permiso\":390}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(303, 39161, 'Roles (Permisos)', 'rol_permiso', '391', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"45\",\"estatus\":\"1\",\"id_rol_permiso\":391}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(304, 39161, 'Roles (Permisos)', 'rol_permiso', '392', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"46\",\"estatus\":\"1\",\"id_rol_permiso\":392}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(305, 39161, 'Roles (Permisos)', 'rol_permiso', '393', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"44\",\"estatus\":\"1\",\"id_rol_permiso\":393}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(306, 39161, 'Roles (Permisos)', 'rol_permiso', '394', 'CREAR', NULL, '{\"id_rol\":\"4\",\"id_permiso\":\"47\",\"estatus\":\"1\",\"id_rol_permiso\":394}', '127.0.0.1', '2026-04-27 20:05:28', '1'),
(307, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-27 21:08:47', '1'),
(308, 0, 'Seguridad', 'users', '43336', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-27 21:11:46', '1'),
(309, 0, 'Seguridad', 'users', '39161', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-27 21:14:41', '1'),
(310, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 00:10:17', '1'),
(311, 43332, 'Recurso', 'recurso', '6', 'CREAR', NULL, '{\"nombre_recurso\":\"proyector\",\"estatus\":\"1\",\"id_recurso\":6}', '127.0.0.1', '2026-04-28 00:31:40', '1'),
(312, 43332, 'Recurso', 'recurso', '7', 'CREAR', NULL, '{\"nombre_recurso\":\"Pizarra\",\"estatus\":\"1\",\"id_recurso\":7}', '127.0.0.1', '2026-04-28 00:31:51', '1'),
(313, 43332, 'Recurso', 'recurso', '8', 'CREAR', NULL, '{\"nombre_recurso\":\"Maquetas\",\"estatus\":\"1\",\"id_recurso\":8}', '127.0.0.1', '2026-04-28 00:32:08', '1'),
(314, 43332, 'Recurso', 'recurso', '9', 'CREAR', NULL, '{\"nombre_recurso\":\"Simuladores Virtuales\",\"estatus\":\"1\",\"id_recurso\":9}', '127.0.0.1', '2026-04-28 00:32:20', '1'),
(315, 43332, 'Recurso', 'recurso', '10', 'CREAR', NULL, '{\"nombre_recurso\":\"Documentos PDF\",\"estatus\":\"1\",\"id_recurso\":10}', '127.0.0.1', '2026-04-28 00:32:47', '1'),
(316, 43332, 'Recurso', 'recurso', '11', 'CREAR', NULL, '{\"nombre_recurso\":\"Infograf\\u00edas\",\"estatus\":\"1\",\"id_recurso\":11}', '127.0.0.1', '2026-04-28 00:32:53', '1'),
(317, 43332, 'Recurso', 'recurso', '12', 'CREAR', NULL, '{\"nombre_recurso\":\"Google Meet\",\"estatus\":\"1\",\"id_recurso\":12}', '127.0.0.1', '2026-04-28 00:33:03', '1'),
(318, 43332, 'Recurso', 'recurso', '1', 'MODIFICAR', '{\"id_recurso\":1,\"nombre_recurso\":\"dsdd\",\"fecha_creacion\":\"2026-04-07 12:01:56\",\"fecha_actualizacion\":\"2026-04-07 12:01:56\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 00:33:31', '1'),
(319, 43332, 'Recurso', 'recurso', '2', 'MODIFICAR', '{\"id_recurso\":2,\"nombre_recurso\":\"Maikol\",\"fecha_creacion\":\"2026-04-22 21:48:55\",\"fecha_actualizacion\":\"2026-04-22 21:48:55\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 00:33:34', '1'),
(320, 43332, 'Estrategia', 'tecnica_actividad', '4', 'CREAR', NULL, '{\"nombre_tecnica_actividad\":\"Aprendizaje Basado en Proyectos (ABP)\",\"estatus\":\"1\",\"id_tecnica_actividad\":4}', '127.0.0.1', '2026-04-28 00:38:15', '1'),
(321, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 00:56:40', '1'),
(322, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:24:50', '1'),
(323, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:25:11', '1'),
(324, 0, 'Seguridad', 'users', '43336', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 01:29:43', '1'),
(325, 0, 'Seguridad', 'users', '39161', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:34:31', '1'),
(326, 39161, 'Roles (Permisos)', 'rol_permiso', '327', 'MODIFICAR', '{\"id_rol_permiso\":327,\"id_permiso\":60,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(327, 39161, 'Roles (Permisos)', 'rol_permiso', '328', 'MODIFICAR', '{\"id_rol_permiso\":328,\"id_permiso\":11,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(328, 39161, 'Roles (Permisos)', 'rol_permiso', '329', 'MODIFICAR', '{\"id_rol_permiso\":329,\"id_permiso\":12,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(329, 39161, 'Roles (Permisos)', 'rol_permiso', '330', 'MODIFICAR', '{\"id_rol_permiso\":330,\"id_permiso\":68,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(330, 39161, 'Roles (Permisos)', 'rol_permiso', '331', 'MODIFICAR', '{\"id_rol_permiso\":331,\"id_permiso\":41,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(331, 39161, 'Roles (Permisos)', 'rol_permiso', '332', 'MODIFICAR', '{\"id_rol_permiso\":332,\"id_permiso\":42,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(332, 39161, 'Roles (Permisos)', 'rol_permiso', '333', 'MODIFICAR', '{\"id_rol_permiso\":333,\"id_permiso\":40,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(333, 39161, 'Roles (Permisos)', 'rol_permiso', '334', 'MODIFICAR', '{\"id_rol_permiso\":334,\"id_permiso\":43,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(334, 39161, 'Roles (Permisos)', 'rol_permiso', '335', 'MODIFICAR', '{\"id_rol_permiso\":335,\"id_permiso\":59,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(335, 39161, 'Roles (Permisos)', 'rol_permiso', '336', 'MODIFICAR', '{\"id_rol_permiso\":336,\"id_permiso\":8,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(336, 39161, 'Roles (Permisos)', 'rol_permiso', '337', 'MODIFICAR', '{\"id_rol_permiso\":337,\"id_permiso\":9,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(337, 39161, 'Roles (Permisos)', 'rol_permiso', '338', 'MODIFICAR', '{\"id_rol_permiso\":338,\"id_permiso\":7,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(338, 39161, 'Roles (Permisos)', 'rol_permiso', '339', 'MODIFICAR', '{\"id_rol_permiso\":339,\"id_permiso\":10,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(339, 39161, 'Roles (Permisos)', 'rol_permiso', '340', 'MODIFICAR', '{\"id_rol_permiso\":340,\"id_permiso\":67,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(340, 39161, 'Roles (Permisos)', 'rol_permiso', '341', 'MODIFICAR', '{\"id_rol_permiso\":341,\"id_permiso\":37,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(341, 39161, 'Roles (Permisos)', 'rol_permiso', '342', 'MODIFICAR', '{\"id_rol_permiso\":342,\"id_permiso\":38,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(342, 39161, 'Roles (Permisos)', 'rol_permiso', '343', 'MODIFICAR', '{\"id_rol_permiso\":343,\"id_permiso\":36,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(343, 39161, 'Roles (Permisos)', 'rol_permiso', '344', 'MODIFICAR', '{\"id_rol_permiso\":344,\"id_permiso\":39,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(344, 39161, 'Roles (Permisos)', 'rol_permiso', '345', 'MODIFICAR', '{\"id_rol_permiso\":345,\"id_permiso\":57,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(345, 39161, 'Roles (Permisos)', 'rol_permiso', '346', 'MODIFICAR', '{\"id_rol_permiso\":346,\"id_permiso\":2,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(346, 39161, 'Roles (Permisos)', 'rol_permiso', '347', 'MODIFICAR', '{\"id_rol_permiso\":347,\"id_permiso\":65,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(347, 39161, 'Roles (Permisos)', 'rol_permiso', '348', 'MODIFICAR', '{\"id_rol_permiso\":348,\"id_permiso\":29,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(348, 39161, 'Roles (Permisos)', 'rol_permiso', '349', 'MODIFICAR', '{\"id_rol_permiso\":349,\"id_permiso\":30,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(349, 39161, 'Roles (Permisos)', 'rol_permiso', '350', 'MODIFICAR', '{\"id_rol_permiso\":350,\"id_permiso\":28,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(350, 39161, 'Roles (Permisos)', 'rol_permiso', '351', 'MODIFICAR', '{\"id_rol_permiso\":351,\"id_permiso\":31,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(351, 39161, 'Roles (Permisos)', 'rol_permiso', '352', 'MODIFICAR', '{\"id_rol_permiso\":352,\"id_permiso\":61,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(352, 39161, 'Roles (Permisos)', 'rol_permiso', '353', 'MODIFICAR', '{\"id_rol_permiso\":353,\"id_permiso\":14,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(353, 39161, 'Roles (Permisos)', 'rol_permiso', '354', 'MODIFICAR', '{\"id_rol_permiso\":354,\"id_permiso\":15,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(354, 39161, 'Roles (Permisos)', 'rol_permiso', '357', 'MODIFICAR', '{\"id_rol_permiso\":357,\"id_permiso\":74,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(355, 39161, 'Roles (Permisos)', 'rol_permiso', '358', 'MODIFICAR', '{\"id_rol_permiso\":358,\"id_permiso\":73,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(356, 39161, 'Roles (Permisos)', 'rol_permiso', '359', 'MODIFICAR', '{\"id_rol_permiso\":359,\"id_permiso\":72,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(357, 39161, 'Roles (Permisos)', 'rol_permiso', '360', 'MODIFICAR', '{\"id_rol_permiso\":360,\"id_permiso\":56,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(358, 39161, 'Roles (Permisos)', 'rol_permiso', '361', 'MODIFICAR', '{\"id_rol_permiso\":361,\"id_permiso\":1,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(359, 39161, 'Roles (Permisos)', 'rol_permiso', '362', 'MODIFICAR', '{\"id_rol_permiso\":362,\"id_permiso\":63,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(360, 39161, 'Roles (Permisos)', 'rol_permiso', '363', 'MODIFICAR', '{\"id_rol_permiso\":363,\"id_permiso\":21,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(361, 39161, 'Roles (Permisos)', 'rol_permiso', '364', 'MODIFICAR', '{\"id_rol_permiso\":364,\"id_permiso\":22,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(362, 39161, 'Roles (Permisos)', 'rol_permiso', '365', 'MODIFICAR', '{\"id_rol_permiso\":365,\"id_permiso\":20,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(363, 39161, 'Roles (Permisos)', 'rol_permiso', '366', 'MODIFICAR', '{\"id_rol_permiso\":366,\"id_permiso\":23,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(364, 39161, 'Roles (Permisos)', 'rol_permiso', '367', 'MODIFICAR', '{\"id_rol_permiso\":367,\"id_permiso\":64,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(365, 39161, 'Roles (Permisos)', 'rol_permiso', '368', 'MODIFICAR', '{\"id_rol_permiso\":368,\"id_permiso\":25,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(366, 39161, 'Roles (Permisos)', 'rol_permiso', '369', 'MODIFICAR', '{\"id_rol_permiso\":369,\"id_permiso\":26,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(367, 39161, 'Roles (Permisos)', 'rol_permiso', '370', 'MODIFICAR', '{\"id_rol_permiso\":370,\"id_permiso\":24,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(368, 39161, 'Roles (Permisos)', 'rol_permiso', '371', 'MODIFICAR', '{\"id_rol_permiso\":371,\"id_permiso\":27,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(369, 39161, 'Roles (Permisos)', 'rol_permiso', '372', 'MODIFICAR', '{\"id_rol_permiso\":372,\"id_permiso\":71,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(370, 39161, 'Roles (Permisos)', 'rol_permiso', '373', 'MODIFICAR', '{\"id_rol_permiso\":373,\"id_permiso\":54,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(371, 39161, 'Roles (Permisos)', 'rol_permiso', '374', 'MODIFICAR', '{\"id_rol_permiso\":374,\"id_permiso\":55,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(372, 39161, 'Roles (Permisos)', 'rol_permiso', '375', 'MODIFICAR', '{\"id_rol_permiso\":375,\"id_permiso\":62,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(373, 39161, 'Roles (Permisos)', 'rol_permiso', '376', 'MODIFICAR', '{\"id_rol_permiso\":376,\"id_permiso\":49,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(374, 39161, 'Roles (Permisos)', 'rol_permiso', '377', 'MODIFICAR', '{\"id_rol_permiso\":377,\"id_permiso\":48,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(375, 39161, 'Roles (Permisos)', 'rol_permiso', '378', 'MODIFICAR', '{\"id_rol_permiso\":378,\"id_permiso\":19,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(376, 39161, 'Roles (Permisos)', 'rol_permiso', '379', 'MODIFICAR', '{\"id_rol_permiso\":379,\"id_permiso\":51,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(377, 39161, 'Roles (Permisos)', 'rol_permiso', '380', 'MODIFICAR', '{\"id_rol_permiso\":380,\"id_permiso\":58,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(378, 39161, 'Roles (Permisos)', 'rol_permiso', '381', 'MODIFICAR', '{\"id_rol_permiso\":381,\"id_permiso\":4,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(379, 39161, 'Roles (Permisos)', 'rol_permiso', '382', 'MODIFICAR', '{\"id_rol_permiso\":382,\"id_permiso\":5,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(380, 39161, 'Roles (Permisos)', 'rol_permiso', '383', 'MODIFICAR', '{\"id_rol_permiso\":383,\"id_permiso\":3,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(381, 39161, 'Roles (Permisos)', 'rol_permiso', '384', 'MODIFICAR', '{\"id_rol_permiso\":384,\"id_permiso\":6,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:27\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(382, 39161, 'Roles (Permisos)', 'rol_permiso', '385', 'MODIFICAR', '{\"id_rol_permiso\":385,\"id_permiso\":66,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(383, 39161, 'Roles (Permisos)', 'rol_permiso', '386', 'MODIFICAR', '{\"id_rol_permiso\":386,\"id_permiso\":33,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(384, 39161, 'Roles (Permisos)', 'rol_permiso', '387', 'MODIFICAR', '{\"id_rol_permiso\":387,\"id_permiso\":34,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(385, 39161, 'Roles (Permisos)', 'rol_permiso', '388', 'MODIFICAR', '{\"id_rol_permiso\":388,\"id_permiso\":32,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(386, 39161, 'Roles (Permisos)', 'rol_permiso', '389', 'MODIFICAR', '{\"id_rol_permiso\":389,\"id_permiso\":35,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(387, 39161, 'Roles (Permisos)', 'rol_permiso', '390', 'MODIFICAR', '{\"id_rol_permiso\":390,\"id_permiso\":69,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(388, 39161, 'Roles (Permisos)', 'rol_permiso', '391', 'MODIFICAR', '{\"id_rol_permiso\":391,\"id_permiso\":45,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(389, 39161, 'Roles (Permisos)', 'rol_permiso', '392', 'MODIFICAR', '{\"id_rol_permiso\":392,\"id_permiso\":46,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(390, 39161, 'Roles (Permisos)', 'rol_permiso', '393', 'MODIFICAR', '{\"id_rol_permiso\":393,\"id_permiso\":44,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(391, 39161, 'Roles (Permisos)', 'rol_permiso', '394', 'MODIFICAR', '{\"id_rol_permiso\":394,\"id_permiso\":47,\"id_rol\":4,\"fecha_creacion\":\"2026-04-27 12:05:28\",\"fecha_actualizacion\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 01:35:12', '1'),
(392, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:39:01', '1'),
(393, 0, 'Seguridad', 'users', '43336', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 01:40:27', '1'),
(394, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:42:48', '1'),
(395, 0, 'Seguridad', 'users', '43332', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 01:44:11', '1'),
(396, 0, 'Seguridad', 'users', '39161', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:44:28', '1'),
(397, 0, 'Seguridad', 'users', '39161', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 01:44:46', '1'),
(398, 0, 'Seguridad', 'users', '43337', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 01:57:40', '1'),
(399, 0, 'Seguridad', 'users', '43337', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 02:00:37', '1'),
(400, 0, 'Seguridad', 'users', '43337', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:01:03', '1'),
(401, 0, 'Seguridad', 'users', '43337', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 02:01:21', '1'),
(402, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:01:45', '1'),
(403, 43332, 'Roles (Permisos)', 'rol_permiso', '395', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"61\",\"estatus\":\"1\",\"id_rol_permiso\":395}', '127.0.0.1', '2026-04-28 02:09:02', '1'),
(404, 43332, 'Roles (Permisos)', 'rol_permiso', '396', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"16\",\"estatus\":\"1\",\"id_rol_permiso\":396}', '127.0.0.1', '2026-04-28 02:09:02', '1'),
(405, 43332, 'Roles (Permisos)', 'rol_permiso', '397', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"17\",\"estatus\":\"1\",\"id_rol_permiso\":397}', '127.0.0.1', '2026-04-28 02:09:02', '1'),
(406, 43332, 'Roles (Permisos)', 'rol_permiso', '398', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"13\",\"estatus\":\"1\",\"id_rol_permiso\":398}', '127.0.0.1', '2026-04-28 02:09:02', '1'),
(407, 0, 'Seguridad', 'users', '43332', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 02:11:34', '1'),
(408, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:12:18', '1'),
(409, 0, 'Seguridad', 'users', '43336', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 02:12:31', '1'),
(410, 0, 'Seguridad', 'users', '43337', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:15:02', '1'),
(411, 0, 'Seguridad', 'users', '43337', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 02:16:07', '1'),
(412, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:16:42', '1'),
(413, 0, 'Seguridad', 'users', '43332', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 02:16:55', '1'),
(414, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:17:43', '1'),
(415, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-28 02:23:52', '1'),
(416, 43332, 'Roles (Permisos)', 'rol_permiso', '399', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"71\",\"estatus\":\"1\",\"id_rol_permiso\":399}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(417, 43332, 'Roles (Permisos)', 'rol_permiso', '400', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"54\",\"estatus\":\"1\",\"id_rol_permiso\":400}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(418, 43332, 'Roles (Permisos)', 'rol_permiso', '401', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"55\",\"estatus\":\"1\",\"id_rol_permiso\":401}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(419, 43332, 'Roles (Permisos)', 'rol_permiso', '402', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"64\",\"estatus\":\"1\",\"id_rol_permiso\":402}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(420, 43332, 'Roles (Permisos)', 'rol_permiso', '403', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"25\",\"estatus\":\"1\",\"id_rol_permiso\":403}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(421, 43332, 'Roles (Permisos)', 'rol_permiso', '404', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"26\",\"estatus\":\"1\",\"id_rol_permiso\":404}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(422, 43332, 'Roles (Permisos)', 'rol_permiso', '405', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"24\",\"estatus\":\"1\",\"id_rol_permiso\":405}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(423, 43332, 'Roles (Permisos)', 'rol_permiso', '406', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"27\",\"estatus\":\"1\",\"id_rol_permiso\":406}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(424, 43332, 'Roles (Permisos)', 'rol_permiso', '407', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"id_rol_permiso\":407}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(425, 43332, 'Roles (Permisos)', 'rol_permiso', '408', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"58\",\"estatus\":\"1\",\"id_rol_permiso\":408}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(426, 43332, 'Roles (Permisos)', 'rol_permiso', '409', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"4\",\"estatus\":\"1\",\"id_rol_permiso\":409}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(427, 43332, 'Roles (Permisos)', 'rol_permiso', '410', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"5\",\"estatus\":\"1\",\"id_rol_permiso\":410}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(428, 43332, 'Roles (Permisos)', 'rol_permiso', '411', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"3\",\"estatus\":\"1\",\"id_rol_permiso\":411}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(429, 43332, 'Roles (Permisos)', 'rol_permiso', '412', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"6\",\"estatus\":\"1\",\"id_rol_permiso\":412}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(430, 43332, 'Roles (Permisos)', 'rol_permiso', '413', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"66\",\"estatus\":\"1\",\"id_rol_permiso\":413}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(431, 43332, 'Roles (Permisos)', 'rol_permiso', '414', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"33\",\"estatus\":\"1\",\"id_rol_permiso\":414}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(432, 43332, 'Roles (Permisos)', 'rol_permiso', '415', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"34\",\"estatus\":\"1\",\"id_rol_permiso\":415}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(433, 43332, 'Roles (Permisos)', 'rol_permiso', '416', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"32\",\"estatus\":\"1\",\"id_rol_permiso\":416}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(434, 43332, 'Roles (Permisos)', 'rol_permiso', '417', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"35\",\"estatus\":\"1\",\"id_rol_permiso\":417}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(435, 43332, 'Roles (Permisos)', 'rol_permiso', '141', 'MODIFICAR', '{\"id_rol_permiso\":141,\"id_permiso\":46,\"id_rol\":31,\"fecha_creacion\":\"2026-04-25 19:56:13\",\"fecha_actualizacion\":\"2026-04-26 00:03:44\",\"estatus\":\"3\"}', '{\"estatus\":\"1\"}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(436, 43332, 'Roles (Permisos)', 'rol_permiso', '418', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"63\",\"estatus\":\"1\",\"id_rol_permiso\":418}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(437, 43332, 'Roles (Permisos)', 'rol_permiso', '419', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"21\",\"estatus\":\"1\",\"id_rol_permiso\":419}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(438, 43332, 'Roles (Permisos)', 'rol_permiso', '420', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"22\",\"estatus\":\"1\",\"id_rol_permiso\":420}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(439, 43332, 'Roles (Permisos)', 'rol_permiso', '421', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"20\",\"estatus\":\"1\",\"id_rol_permiso\":421}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(440, 43332, 'Roles (Permisos)', 'rol_permiso', '422', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"23\",\"estatus\":\"1\",\"id_rol_permiso\":422}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(441, 43332, 'Roles (Permisos)', 'rol_permiso', '423', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"56\",\"estatus\":\"1\",\"id_rol_permiso\":423}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(442, 43332, 'Roles (Permisos)', 'rol_permiso', '424', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"1\",\"estatus\":\"1\",\"id_rol_permiso\":424}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(443, 43332, 'Roles (Permisos)', 'rol_permiso', '425', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"14\",\"estatus\":\"1\",\"id_rol_permiso\":425}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(444, 43332, 'Roles (Permisos)', 'rol_permiso', '426', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"15\",\"estatus\":\"1\",\"id_rol_permiso\":426}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(445, 43332, 'Roles (Permisos)', 'rol_permiso', '427', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"18\",\"estatus\":\"1\",\"id_rol_permiso\":427}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(446, 43332, 'Roles (Permisos)', 'rol_permiso', '428', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"65\",\"estatus\":\"1\",\"id_rol_permiso\":428}', '127.0.0.1', '2026-04-28 02:25:36', '1');
INSERT INTO `bitacora` (`id_bitacora`, `id_usuario`, `modulo_afectado_bitacora`, `tabla_afectada_bitacora`, `id_registro_afectado_bitacora`, `accion_bitacora`, `valores_anteriores_bitacora`, `valores_nuevos_bitacora`, `ip_origen_bitacora`, `fecha_creacion`, `estatus`) VALUES
(447, 43332, 'Roles (Permisos)', 'rol_permiso', '429', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"29\",\"estatus\":\"1\",\"id_rol_permiso\":429}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(448, 43332, 'Roles (Permisos)', 'rol_permiso', '430', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"30\",\"estatus\":\"1\",\"id_rol_permiso\":430}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(449, 43332, 'Roles (Permisos)', 'rol_permiso', '431', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"28\",\"estatus\":\"1\",\"id_rol_permiso\":431}', '127.0.0.1', '2026-04-28 02:25:36', '1'),
(450, 43332, 'Roles (Permisos)', 'rol_permiso', '432', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"31\",\"estatus\":\"1\",\"id_rol_permiso\":432}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(451, 43332, 'Roles (Permisos)', 'rol_permiso', '433', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"57\",\"estatus\":\"1\",\"id_rol_permiso\":433}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(452, 43332, 'Roles (Permisos)', 'rol_permiso', '434', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"2\",\"estatus\":\"1\",\"id_rol_permiso\":434}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(453, 43332, 'Roles (Permisos)', 'rol_permiso', '435', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"67\",\"estatus\":\"1\",\"id_rol_permiso\":435}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(454, 43332, 'Roles (Permisos)', 'rol_permiso', '436', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"37\",\"estatus\":\"1\",\"id_rol_permiso\":436}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(455, 43332, 'Roles (Permisos)', 'rol_permiso', '437', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"38\",\"estatus\":\"1\",\"id_rol_permiso\":437}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(456, 43332, 'Roles (Permisos)', 'rol_permiso', '438', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"36\",\"estatus\":\"1\",\"id_rol_permiso\":438}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(457, 43332, 'Roles (Permisos)', 'rol_permiso', '439', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"39\",\"estatus\":\"1\",\"id_rol_permiso\":439}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(458, 43332, 'Roles (Permisos)', 'rol_permiso', '440', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"59\",\"estatus\":\"1\",\"id_rol_permiso\":440}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(459, 43332, 'Roles (Permisos)', 'rol_permiso', '441', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"8\",\"estatus\":\"1\",\"id_rol_permiso\":441}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(460, 43332, 'Roles (Permisos)', 'rol_permiso', '442', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"9\",\"estatus\":\"1\",\"id_rol_permiso\":442}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(461, 43332, 'Roles (Permisos)', 'rol_permiso', '443', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"7\",\"estatus\":\"1\",\"id_rol_permiso\":443}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(462, 43332, 'Roles (Permisos)', 'rol_permiso', '444', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"10\",\"estatus\":\"1\",\"id_rol_permiso\":444}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(463, 43332, 'Roles (Permisos)', 'rol_permiso', '445', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"68\",\"estatus\":\"1\",\"id_rol_permiso\":445}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(464, 43332, 'Roles (Permisos)', 'rol_permiso', '446', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"41\",\"estatus\":\"1\",\"id_rol_permiso\":446}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(465, 43332, 'Roles (Permisos)', 'rol_permiso', '447', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"42\",\"estatus\":\"1\",\"id_rol_permiso\":447}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(466, 43332, 'Roles (Permisos)', 'rol_permiso', '448', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"40\",\"estatus\":\"1\",\"id_rol_permiso\":448}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(467, 43332, 'Roles (Permisos)', 'rol_permiso', '449', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"43\",\"estatus\":\"1\",\"id_rol_permiso\":449}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(468, 43332, 'Roles (Permisos)', 'rol_permiso', '450', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"60\",\"estatus\":\"1\",\"id_rol_permiso\":450}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(469, 43332, 'Roles (Permisos)', 'rol_permiso', '451', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"11\",\"estatus\":\"1\",\"id_rol_permiso\":451}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(470, 43332, 'Roles (Permisos)', 'rol_permiso', '452', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"12\",\"estatus\":\"1\",\"id_rol_permiso\":452}', '127.0.0.1', '2026-04-28 02:25:37', '1'),
(471, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-03 23:14:36', '1'),
(472, 0, 'Seguridad', 'users', '43332', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-03 23:25:43', '1'),
(473, 0, 'Seguridad', 'users', '43332', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-03 23:26:08', '1'),
(474, 0, 'Seguridad', 'users', '43332', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-03 23:56:15', '1'),
(475, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-04 00:02:11', '1'),
(476, 43336, 'Planificacion', 'planificacion', '1', 'CREAR', NULL, '{\"id_profesor_asignado\":\"60998\",\"fecha_creacion\":\"2026-05-03T20:31:41.139454Z\",\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"id_planificacion\":1}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(477, 43336, 'UnidadCorte', 'unidad_corte', '1', 'CREAR', NULL, '{\"id_planificacion\":1,\"numero_unidad_corte\":1,\"indicador_logro_unidad_corte\":\"sefsfgsrgdrgegefefr\",\"estatus\":\"2\",\"id_unidad_corte\":1}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(478, 43336, 'DetalleContenido', 'detalle_contenido', '1', 'CREAR', NULL, '{\"id_unidad_corte\":1,\"id_contenido\":\"3\",\"estatus\":\"1\",\"id_detalle_contenido\":1}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(479, 43336, 'UnidadCorte', 'unidad_corte', '1', 'MODIFICAR', '{\"id_planificacion\":1,\"numero_unidad_corte\":1,\"indicador_logro_unidad_corte\":\"sefsfgsrgdrgegefefr\",\"estatus\":\"2\",\"id_unidad_corte\":1}', '{\"id_tecnica_actividad\":\"8\",\"descripcion_actividad_unidad_corte\":\"sefsefsefsefsefsef\"}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(480, 43336, 'DetalleEvaluacion', 'detalle_evaluacion', '1', 'CREAR', NULL, '{\"id_unidad_corte\":1,\"id_tipo_evaluacion\":\"4\",\"id_tecnica_evaluacion\":\"5\",\"id_instrumento\":null,\"ponderacion_detalle_evaluacion\":\"25\",\"integrantes_detalle_evaluacion\":1,\"fecha_evaluacion_detalle_evaluacion\":\"2026-05-04\",\"forma_participacion_detalle_evaluacion\":\"1\",\"estatus\":\"2\",\"id_detalle_evaluacion\":1}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(481, 43336, 'DetalleBibliografia', 'detalle_bibliografia', '1', 'CREAR', NULL, '{\"id_unidad_corte\":1,\"id_bibliografia\":\"4\",\"estatus\":\"1\",\"id_detalle_bibliografia\":1}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(482, 43336, 'UnidadCorte', 'unidad_corte', '2', 'CREAR', NULL, '{\"id_planificacion\":1,\"numero_unidad_corte\":2,\"indicador_logro_unidad_corte\":\"sedrfgadfgfgsgaergerg\",\"estatus\":\"2\",\"id_unidad_corte\":2}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(483, 43336, 'DetalleContenido', 'detalle_contenido', '2', 'CREAR', NULL, '{\"id_unidad_corte\":2,\"id_contenido\":\"5\",\"estatus\":\"1\",\"id_detalle_contenido\":2}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(484, 43336, 'UnidadCorte', 'unidad_corte', '2', 'MODIFICAR', '{\"id_planificacion\":1,\"numero_unidad_corte\":2,\"indicador_logro_unidad_corte\":\"sedrfgadfgfgsgaergerg\",\"estatus\":\"2\",\"id_unidad_corte\":2}', '{\"id_tecnica_actividad\":\"8\",\"descripcion_actividad_unidad_corte\":\"serfeargaegaerfgaergaerg\"}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(485, 43336, 'DetalleEvaluacion', 'detalle_evaluacion', '2', 'CREAR', NULL, '{\"id_unidad_corte\":2,\"id_tipo_evaluacion\":\"3\",\"id_tecnica_evaluacion\":\"3\",\"id_instrumento\":null,\"ponderacion_detalle_evaluacion\":\"25\",\"integrantes_detalle_evaluacion\":1,\"fecha_evaluacion_detalle_evaluacion\":\"2026-05-06\",\"forma_participacion_detalle_evaluacion\":\"1\",\"estatus\":\"2\",\"id_detalle_evaluacion\":2}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(486, 43336, 'DetalleBibliografia', 'detalle_bibliografia', '2', 'CREAR', NULL, '{\"id_unidad_corte\":2,\"id_bibliografia\":\"9\",\"estatus\":\"1\",\"id_detalle_bibliografia\":2}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(487, 43336, 'UnidadCorte', 'unidad_corte', '3', 'CREAR', NULL, '{\"id_planificacion\":1,\"numero_unidad_corte\":3,\"indicador_logro_unidad_corte\":\"aedrsgaegargaegaerg\",\"estatus\":\"2\",\"id_unidad_corte\":3}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(488, 43336, 'DetalleContenido', 'detalle_contenido', '3', 'CREAR', NULL, '{\"id_unidad_corte\":3,\"id_contenido\":\"7\",\"estatus\":\"1\",\"id_detalle_contenido\":3}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(489, 43336, 'UnidadCorte', 'unidad_corte', '3', 'MODIFICAR', '{\"id_planificacion\":1,\"numero_unidad_corte\":3,\"indicador_logro_unidad_corte\":\"aedrsgaegargaegaerg\",\"estatus\":\"2\",\"id_unidad_corte\":3}', '{\"id_tecnica_actividad\":\"8\",\"descripcion_actividad_unidad_corte\":\"egraergsrfgsthfgrfg\"}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(490, 43336, 'DetalleEvaluacion', 'detalle_evaluacion', '3', 'CREAR', NULL, '{\"id_unidad_corte\":3,\"id_tipo_evaluacion\":\"5\",\"id_tecnica_evaluacion\":\"2\",\"id_instrumento\":null,\"ponderacion_detalle_evaluacion\":\"25\",\"integrantes_detalle_evaluacion\":1,\"fecha_evaluacion_detalle_evaluacion\":\"2026-05-13\",\"forma_participacion_detalle_evaluacion\":\"1\",\"estatus\":\"2\",\"id_detalle_evaluacion\":3}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(491, 43336, 'DetalleBibliografia', 'detalle_bibliografia', '3', 'CREAR', NULL, '{\"id_unidad_corte\":3,\"id_bibliografia\":\"5\",\"estatus\":\"1\",\"id_detalle_bibliografia\":3}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(492, 43336, 'UnidadCorte', 'unidad_corte', '4', 'CREAR', NULL, '{\"id_planificacion\":1,\"numero_unidad_corte\":4,\"indicador_logro_unidad_corte\":\"aergasdgsgasgaeg\",\"estatus\":\"2\",\"id_unidad_corte\":4}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(493, 43336, 'DetalleContenido', 'detalle_contenido', '4', 'CREAR', NULL, '{\"id_unidad_corte\":4,\"id_contenido\":\"9\",\"estatus\":\"1\",\"id_detalle_contenido\":4}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(494, 43336, 'UnidadCorte', 'unidad_corte', '4', 'MODIFICAR', '{\"id_planificacion\":1,\"numero_unidad_corte\":4,\"indicador_logro_unidad_corte\":\"aergasdgsgasgaeg\",\"estatus\":\"2\",\"id_unidad_corte\":4}', '{\"id_tecnica_actividad\":\"8\",\"descripcion_actividad_unidad_corte\":\"ergsdgsgsedrgaerg\"}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(495, 43336, 'DetalleEvaluacion', 'detalle_evaluacion', '4', 'CREAR', NULL, '{\"id_unidad_corte\":4,\"id_tipo_evaluacion\":\"3\",\"id_tecnica_evaluacion\":\"2\",\"id_instrumento\":null,\"ponderacion_detalle_evaluacion\":\"25\",\"integrantes_detalle_evaluacion\":1,\"fecha_evaluacion_detalle_evaluacion\":\"2026-05-06\",\"forma_participacion_detalle_evaluacion\":\"1\",\"estatus\":\"2\",\"id_detalle_evaluacion\":4}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(496, 43336, 'DetalleBibliografia', 'detalle_bibliografia', '4', 'CREAR', NULL, '{\"id_unidad_corte\":4,\"id_bibliografia\":\"4\",\"estatus\":\"1\",\"id_detalle_bibliografia\":4}', '127.0.0.1', '2026-05-04 00:31:41', '1'),
(497, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:34:05', '1'),
(498, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:34:10', '1'),
(499, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:34:18', '1'),
(500, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:34:31', '1'),
(501, 0, 'Seguridad', 'users', '43336', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-04 00:34:43', '1'),
(502, 0, 'Seguridad', 'users', '43337', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-04 00:35:26', '1'),
(503, 43337, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:35:42', '1'),
(504, 43337, 'UnidadCorte', 'unidad_corte', '1', 'MODIFICAR', '{\"id_unidad_corte\":1,\"id_planificacion\":1,\"numero_unidad_corte\":\"1\",\"indicador_logro_unidad_corte\":\"sefsfgsrgdrgegefefr\",\"descripcion_actividad_unidad_corte\":\"sefsefsefsefsefsef\",\"descripcion_motivo_rechazo_unidad_corte\":null,\"id_tecnica_actividad\":8,\"fecha_creacion\":\"2026-05-03 16:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:31:41\",\"estatus\":\"2\"}', '{\"estatus\":1}', '127.0.0.1', '2026-05-04 00:35:45', '1'),
(505, 43337, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:35:45', '1'),
(506, 43337, 'UnidadCorte', 'unidad_corte', '2', 'MODIFICAR', '{\"id_unidad_corte\":2,\"id_planificacion\":1,\"numero_unidad_corte\":\"2\",\"indicador_logro_unidad_corte\":\"sedrfgadfgfgsgaergerg\",\"descripcion_actividad_unidad_corte\":\"serfeargaegaerfgaergaerg\",\"descripcion_motivo_rechazo_unidad_corte\":null,\"id_tecnica_actividad\":8,\"fecha_creacion\":\"2026-05-03 16:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:31:41\",\"estatus\":\"2\"}', '{\"estatus\":1}', '127.0.0.1', '2026-05-04 00:35:50', '1'),
(507, 43337, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:35:50', '1'),
(508, 43337, 'UnidadCorte', 'unidad_corte', '3', 'MODIFICAR', '{\"id_unidad_corte\":3,\"id_planificacion\":1,\"numero_unidad_corte\":\"3\",\"indicador_logro_unidad_corte\":\"aedrsgaegargaegaerg\",\"descripcion_actividad_unidad_corte\":\"egraergsrfgsthfgrfg\",\"descripcion_motivo_rechazo_unidad_corte\":null,\"id_tecnica_actividad\":8,\"fecha_creacion\":\"2026-05-03 16:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:31:41\",\"estatus\":\"2\"}', '{\"estatus\":1}', '127.0.0.1', '2026-05-04 00:35:53', '1'),
(509, 43337, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:35:53', '1'),
(510, 43337, 'UnidadCorte', 'unidad_corte', '4', 'MODIFICAR', '{\"id_unidad_corte\":4,\"id_planificacion\":1,\"numero_unidad_corte\":\"4\",\"indicador_logro_unidad_corte\":\"aergasdgsgasgaeg\",\"descripcion_actividad_unidad_corte\":\"ergsdgsgsedrgaerg\",\"descripcion_motivo_rechazo_unidad_corte\":null,\"id_tecnica_actividad\":8,\"fecha_creacion\":\"2026-05-03 16:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:31:41\",\"estatus\":\"2\"}', '{\"estatus\":1}', '127.0.0.1', '2026-05-04 00:35:56', '1'),
(511, 43337, 'Planificacion', 'planificacion', '1', 'MODIFICAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":null,\"estatus\":\"2\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', '{\"estatus\":1}', '127.0.0.1', '2026-05-04 00:35:56', '1'),
(512, 43337, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:35:56\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:36:00', '1'),
(513, 43337, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:35:56\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:36:03', '1'),
(514, 0, 'Seguridad', 'users', '43337', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-04 00:36:18', '1'),
(515, 0, 'Seguridad', 'users', '43336', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-04 00:36:35', '1'),
(516, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:35:56\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":null}', NULL, '127.0.0.1', '2026-05-04 00:37:07', '1'),
(517, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:37:19\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":\"contratos\\/FHnYEzlcJYPg6lYVbqvYSeTqmUhWf2MM3i0zxy12.pdf\"}', NULL, '127.0.0.1', '2026-05-04 00:38:39', '1'),
(518, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:37:19\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":\"contratos\\/FHnYEzlcJYPg6lYVbqvYSeTqmUhWf2MM3i0zxy12.pdf\"}', NULL, '127.0.0.1', '2026-05-04 00:38:43', '1'),
(519, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:37:19\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":\"contratos\\/FHnYEzlcJYPg6lYVbqvYSeTqmUhWf2MM3i0zxy12.pdf\"}', NULL, '127.0.0.1', '2026-05-04 00:51:08', '1'),
(520, 43336, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:37:19\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":\"contratos\\/FHnYEzlcJYPg6lYVbqvYSeTqmUhWf2MM3i0zxy12.pdf\",\"notificado\":0}', NULL, '127.0.0.1', '2026-05-04 00:51:22', '1'),
(521, 31114131, 'Seguridad', 'users', '31114131', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 23:47:53', '1'),
(522, 1, 'Planificacion', 'planificacion', '1', 'MOSTRAR', '{\"id_planificacion\":1,\"id_profesor_asignado\":60998,\"aceptado_vocero\":null,\"aceptado_coordinador\":null,\"fecha_creacion\":\"2026-05-03 20:31:41\",\"fecha_actualizacion\":\"2026-05-03 16:51:33\",\"estatus\":\"1\",\"tipo_planificacion\":\"[\\\"Regular\\\",\\\"PER\\\",\\\"Repitencia\\\"]\",\"archivo_contrato\":\"contratos\\/FHnYEzlcJYPg6lYVbqvYSeTqmUhWf2MM3i0zxy12.pdf\",\"notificado\":1}', NULL, '127.0.0.1', '2026-05-10 23:53:03', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel_cache_f3b336454b2b26307280119bf5ed8645fb106ed0', 'i:1;', 1777840695),
('laravel_cache_f3b336454b2b26307280119bf5ed8645fb106ed0:timer', 'i:1777840695;', 1777840695);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendario_academico`
--

CREATE TABLE `calendario_academico` (
  `id_calendario_academico` int(11) NOT NULL,
  `semana_calendario_academico` int(11) DEFAULT NULL,
  `dia_inicio_calendario_academico` date DEFAULT NULL,
  `dia_fin_calendario_academico` date DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calendario_academico`
--

INSERT INTO `calendario_academico` (`id_calendario_academico`, `semana_calendario_academico`, `dia_inicio_calendario_academico`, `dia_fin_calendario_academico`, `fecha_creacion`, `estatus`) VALUES
(12, 9, '2026-04-01', '2026-05-31', '2026-04-19 20:55:42', '3'),
(13, 13, '2026-04-01', '2026-06-30', '2026-04-19 21:00:31', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id_contenido` int(11) NOT NULL,
  `titulo_contenido` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contenido`
--

INSERT INTO `contenido` (`id_contenido`, `titulo_contenido`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(3, 'Definiciones y Evolución', '2026-04-27 22:33:56', NULL, '1'),
(4, 'Modelos de Desarrollo de Software (Cascada, Espiral, Ágil)', '2026-04-27 22:33:56', NULL, '1'),
(5, 'Elicitación y Análisis de Requisitos', '2026-04-27 22:33:56', NULL, '1'),
(6, 'Especificación de Requisitos de Software (SRS)', '2026-04-27 22:33:56', NULL, '1'),
(7, 'Principios de Diseño y Arquitectura', '2026-04-27 22:33:56', NULL, '1'),
(8, 'UML y Patrones de Diseño', '2026-04-27 22:33:56', NULL, '1'),
(9, 'Aseguramiento de Calidad (SQA)', '2026-04-27 22:33:56', NULL, '1'),
(10, 'Pruebas Unitarias, de Integración y de Sistema', '2026-04-27 22:33:56', NULL, '1'),
(11, 'Scrum y Kanban', '2026-04-27 22:33:56', NULL, '1'),
(12, 'Estimación y Planificación de Sprints', '2026-04-27 22:33:56', NULL, '1'),
(13, 'Arquitectura de Microservicios', '2026-04-27 22:33:56', NULL, '1'),
(14, 'APIs RESTful y GraphQL', '2026-04-27 22:33:56', NULL, '1'),
(15, 'Integración y Entrega Continua (CI/CD)', '2026-04-27 22:33:56', NULL, '1'),
(16, 'Contenedores y Orquestación (Docker, Kubernetes)', '2026-04-27 22:33:56', NULL, '1'),
(17, 'Refactorización de Código', '2026-04-27 22:33:56', NULL, '1'),
(18, 'Gestión de la Configuración y Control de Versiones', '2026-04-27 22:33:56', NULL, '1'),
(19, 'Introducción al Ciclo de Vida del Software', '2026-05-10 20:13:42', NULL, '1'),
(20, 'Metodologías Ágiles (Scrum, Kanban)', '2026-05-10 20:13:42', NULL, '1'),
(21, 'Modelado con UML 2.0', '2026-05-10 20:13:42', NULL, '1'),
(22, 'Estrategias de Pruebas Unitarias e Integración', '2026-05-10 20:13:43', NULL, '1'),
(23, 'Gestión de Versiones con Git', '2026-05-10 20:13:43', NULL, '1'),
(24, 'Modelos de Proceso (Cascada, Espiral, Ágil)', '2026-05-10 20:22:12', NULL, '1'),
(25, 'Técnicas de Elicitación', '2026-05-10 20:22:12', NULL, '1'),
(26, 'Documentación con IEEE 830', '2026-05-10 20:22:12', NULL, '1'),
(27, 'Definiciones', '2026-05-10 20:32:04', NULL, '1'),
(28, 'Modelos de Proceso', '2026-05-10 20:32:04', NULL, '1'),
(29, 'Elicitación', '2026-05-10 20:32:04', NULL, '1'),
(30, 'IEEE 830', '2026-05-10 20:32:04', NULL, '1'),
(31, 'Diagramas de Clase', '2026-05-10 20:32:05', NULL, '1'),
(32, 'Patrones', '2026-05-10 20:32:05', NULL, '1'),
(33, 'Caja Blanca/Negra', '2026-05-10 20:32:05', NULL, '1'),
(34, 'SQA', '2026-05-10 20:32:05', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_bibliografia`
--

CREATE TABLE `detalle_bibliografia` (
  `id_detalle_bibliografia` int(11) NOT NULL,
  `id_unidad_corte` int(11) DEFAULT NULL,
  `id_bibliografia` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_bibliografia`
--

INSERT INTO `detalle_bibliografia` (`id_detalle_bibliografia`, `id_unidad_corte`, `id_bibliografia`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, 4, '2026-05-03 20:31:41', NULL, '1'),
(2, 2, 9, '2026-05-03 20:31:41', NULL, '1'),
(3, 3, 5, '2026-05-03 20:31:41', NULL, '1'),
(4, 4, 4, '2026-05-03 20:31:41', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_contenido`
--

CREATE TABLE `detalle_contenido` (
  `id_detalle_contenido` int(11) NOT NULL,
  `id_unidad_corte` int(11) DEFAULT NULL,
  `id_contenido` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_contenido`
--

INSERT INTO `detalle_contenido` (`id_detalle_contenido`, `id_unidad_corte`, `id_contenido`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, 3, '2026-05-03 20:31:41', NULL, '1'),
(2, 2, 5, '2026-05-03 20:31:41', NULL, '1'),
(3, 3, 7, '2026-05-03 20:31:41', NULL, '1'),
(4, 4, 9, '2026-05-03 20:31:41', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evaluacion`
--

CREATE TABLE `detalle_evaluacion` (
  `id_detalle_evaluacion` int(11) NOT NULL,
  `id_tipo_evaluacion` int(11) DEFAULT NULL,
  `id_tecnica_evaluacion` int(11) DEFAULT NULL,
  `id_instrumento` int(11) DEFAULT NULL,
  `ponderacion_detalle_evaluacion` float DEFAULT NULL,
  `integrantes_detalle_evaluacion` int(11) DEFAULT NULL,
  `id_unidad_corte` int(11) DEFAULT NULL,
  `fecha_evaluacion_detalle_evaluacion` date DEFAULT NULL,
  `forma_participacion_detalle_evaluacion` enum('1','2') DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3','4') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_evaluacion`
--

INSERT INTO `detalle_evaluacion` (`id_detalle_evaluacion`, `id_tipo_evaluacion`, `id_tecnica_evaluacion`, `id_instrumento`, `ponderacion_detalle_evaluacion`, `integrantes_detalle_evaluacion`, `id_unidad_corte`, `fecha_evaluacion_detalle_evaluacion`, `forma_participacion_detalle_evaluacion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 4, 5, NULL, 25, 1, 1, '2026-05-04', '1', '2026-05-03 20:31:41', NULL, '2'),
(2, 3, 3, NULL, 25, 1, 2, '2026-05-06', '1', '2026-05-03 20:31:41', NULL, '2'),
(3, 5, 2, NULL, 25, 1, 3, '2026-05-13', '1', '2026-05-03 20:31:41', NULL, '2'),
(4, 3, 2, NULL, 25, 1, 4, '2026-05-06', '1', '2026-05-03 20:31:41', NULL, '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_objetivo`
--

CREATE TABLE `detalle_objetivo` (
  `id_detalle_objetivo` int(11) NOT NULL,
  `id_contenido` int(11) DEFAULT NULL,
  `id_objetivo` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_objetivo`
--

INSERT INTO `detalle_objetivo` (`id_detalle_objetivo`, `id_contenido`, `id_objetivo`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(3, 3, 2, '2026-04-27 22:33:56', NULL, '1'),
(4, 4, 2, '2026-04-27 22:33:56', NULL, '1'),
(5, 5, 3, '2026-04-27 22:33:56', NULL, '1'),
(6, 6, 3, '2026-04-27 22:33:56', NULL, '1'),
(7, 7, 4, '2026-04-27 22:33:56', NULL, '1'),
(8, 8, 4, '2026-04-27 22:33:56', NULL, '1'),
(9, 9, 5, '2026-04-27 22:33:56', NULL, '1'),
(10, 10, 5, '2026-04-27 22:33:56', NULL, '1'),
(11, 11, 6, '2026-04-27 22:33:56', NULL, '1'),
(12, 12, 6, '2026-04-27 22:33:56', NULL, '1'),
(13, 13, 7, '2026-04-27 22:33:56', NULL, '1'),
(14, 14, 7, '2026-04-27 22:33:56', NULL, '1'),
(15, 15, 8, '2026-04-27 22:33:56', NULL, '1'),
(16, 16, 8, '2026-04-27 22:33:56', NULL, '1'),
(17, 17, 9, '2026-04-27 22:33:56', NULL, '1'),
(18, 18, 9, '2026-04-27 22:33:56', NULL, '1'),
(19, 3, 24, '2026-05-10 20:22:12', NULL, '1'),
(20, 24, 24, '2026-05-10 20:22:12', NULL, '1'),
(21, 25, 25, '2026-05-10 20:22:12', NULL, '1'),
(22, 26, 25, '2026-05-10 20:22:12', NULL, '1'),
(23, 27, 26, '2026-05-10 20:32:04', NULL, '1'),
(24, 28, 26, '2026-05-10 20:32:04', NULL, '1'),
(25, 29, 27, '2026-05-10 20:32:04', NULL, '1'),
(26, 30, 27, '2026-05-10 20:32:04', NULL, '1'),
(27, 31, 28, '2026-05-10 20:32:05', NULL, '1'),
(28, 32, 28, '2026-05-10 20:32:05', NULL, '1'),
(29, 33, 29, '2026-05-10 20:32:05', NULL, '1'),
(30, 34, 29, '2026-05-10 20:32:05', NULL, '1'),
(31, 27, 30, '2026-05-10 20:32:05', NULL, '1'),
(32, 28, 30, '2026-05-10 20:32:05', NULL, '1'),
(33, 29, 31, '2026-05-10 20:32:05', NULL, '1'),
(34, 30, 31, '2026-05-10 20:32:05', NULL, '1'),
(35, 31, 32, '2026-05-10 20:32:05', NULL, '1'),
(36, 32, 32, '2026-05-10 20:32:05', NULL, '1'),
(37, 33, 33, '2026-05-10 20:32:06', NULL, '1'),
(38, 34, 33, '2026-05-10 20:32:06', NULL, '1'),
(39, 27, 34, '2026-05-10 20:32:06', NULL, '1'),
(40, 28, 34, '2026-05-10 20:32:06', NULL, '1'),
(41, 29, 35, '2026-05-10 20:32:06', NULL, '1'),
(42, 30, 35, '2026-05-10 20:32:06', NULL, '1'),
(43, 31, 36, '2026-05-10 20:32:07', NULL, '1'),
(44, 32, 36, '2026-05-10 20:32:07', NULL, '1'),
(45, 33, 37, '2026-05-10 20:32:07', NULL, '1'),
(46, 34, 37, '2026-05-10 20:32:07', NULL, '1'),
(47, 27, 38, '2026-05-10 20:32:07', NULL, '1'),
(48, 28, 38, '2026-05-10 20:32:07', NULL, '1'),
(49, 29, 39, '2026-05-10 20:32:07', NULL, '1'),
(50, 30, 39, '2026-05-10 20:32:07', NULL, '1'),
(51, 31, 40, '2026-05-10 20:32:07', NULL, '1'),
(52, 32, 40, '2026-05-10 20:32:07', NULL, '1'),
(53, 33, 41, '2026-05-10 20:32:08', NULL, '1'),
(54, 34, 41, '2026-05-10 20:32:08', NULL, '1'),
(55, 27, 42, '2026-05-10 20:32:08', NULL, '1'),
(56, 28, 42, '2026-05-10 20:32:08', NULL, '1'),
(57, 29, 43, '2026-05-10 20:32:08', NULL, '1'),
(58, 30, 43, '2026-05-10 20:32:08', NULL, '1'),
(59, 31, 44, '2026-05-10 20:32:08', NULL, '1'),
(60, 32, 44, '2026-05-10 20:32:08', NULL, '1'),
(61, 33, 45, '2026-05-10 20:32:09', NULL, '1'),
(62, 34, 45, '2026-05-10 20:32:10', NULL, '1'),
(63, 27, 46, '2026-05-10 20:32:12', NULL, '1'),
(64, 28, 46, '2026-05-10 20:32:13', NULL, '1'),
(65, 29, 47, '2026-05-10 20:32:17', NULL, '1'),
(66, 30, 47, '2026-05-10 20:32:19', NULL, '1'),
(67, 31, 48, '2026-05-10 20:32:21', NULL, '1'),
(68, 32, 48, '2026-05-10 20:32:21', NULL, '1'),
(69, 33, 49, '2026-05-10 20:32:21', NULL, '1'),
(70, 34, 49, '2026-05-10 20:32:21', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_recurso`
--

CREATE TABLE `detalle_recurso` (
  `id_detalle_recurso` int(11) NOT NULL,
  `id_recurso` int(11) DEFAULT NULL,
  `id_unidad_corte` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_recurso`
--

INSERT INTO `detalle_recurso` (`id_detalle_recurso`, `id_recurso`, `id_unidad_corte`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 10, 1, '2026-05-03 20:31:41', NULL, '1'),
(2, 11, 2, '2026-05-03 20:31:41', NULL, '1'),
(3, 14, 3, '2026-05-03 20:31:41', NULL, '1'),
(4, 15, 4, '2026-05-03 20:31:41', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL,
  `id_calendario` int(11) DEFAULT NULL,
  `dia_inicio_evento` date DEFAULT NULL,
  `dia_fin_evento` date DEFAULT NULL,
  `semana_evento` int(11) DEFAULT NULL,
  `descripcion_evento` varchar(100) DEFAULT NULL,
  `tipo_evento` enum('1','2','3') DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`id_evento`, `id_calendario`, `dia_inicio_evento`, `dia_fin_evento`, `semana_evento`, `descripcion_evento`, `tipo_evento`, `fecha_creacion`, `estatus`) VALUES
(2, 13, '2026-04-01', '2026-04-09', NULL, 'pop', '', '2026-04-19 21:00:31', '1'),
(3, 13, '2026-05-15', '2026-05-15', NULL, 'ki', '', '2026-04-19 21:00:31', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instrumento`
--

CREATE TABLE `instrumento` (
  `id_instrumento` int(11) NOT NULL,
  `nombre_instrumento` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `instrumento`
--

INSERT INTO `instrumento` (`id_instrumento`, `nombre_instrumento`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Escala de Estimación', '2026-05-10 20:22:11', NULL, '1'),
(2, 'Lista de Cotejo', '2026-05-10 20:22:11', NULL, '1'),
(3, 'Rúbrica Holística', '2026-05-10 20:22:11', NULL, '1'),
(4, 'Guía de Observación', '2026-05-10 20:22:11', NULL, '1'),
(5, 'Prueba Objetiva', '2026-05-10 20:22:11', NULL, '1'),
(6, 'Registro Anecdótico', '2026-05-10 20:22:11', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivo`
--

CREATE TABLE `objetivo` (
  `id_objetivo` int(11) NOT NULL,
  `titulo_objetivo` varchar(255) DEFAULT NULL,
  `id_tema_unidad` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `objetivo`
--

INSERT INTO `objetivo` (`id_objetivo`, `titulo_objetivo`, `id_tema_unidad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'asdasidjiasjd', 1, '2026-04-18 00:07:30', NULL, '1'),
(2, 'Comprender los conceptos básicos y ciclos de vida del software', 2, '2026-04-27 22:33:56', NULL, '1'),
(3, 'Aprender a elicitar, analizar y documentar requisitos', 3, '2026-04-27 22:33:56', NULL, '1'),
(4, 'Aplicar patrones de diseño y arquitecturas', 4, '2026-04-27 22:33:56', NULL, '1'),
(5, 'Asegurar la calidad del producto de software mediante pruebas', 5, '2026-04-27 22:33:56', NULL, '1'),
(6, 'Gestionar proyectos de software usando metodologías ágiles', 6, '2026-04-27 22:33:56', NULL, '1'),
(7, 'Diseñar sistemas con arquitecturas modernas y escalables', 7, '2026-04-27 22:33:56', NULL, '1'),
(8, 'Integrar prácticas de CI/CD en el ciclo de vida', 8, '2026-04-27 22:33:56', NULL, '1'),
(9, 'Mantener y evolucionar sistemas legados', 9, '2026-04-27 22:33:56', NULL, '1'),
(10, 'Comprender los principios básicos de la ingeniería de software.', 10, '2026-05-10 20:13:43', NULL, '1'),
(11, 'Identificar los diferentes modelos de ciclo de vida.', 10, '2026-05-10 20:13:43', NULL, '1'),
(12, 'Comprender la evolución y conceptos básicos de la ingeniería de software.', 10, '2026-05-10 20:17:00', NULL, '1'),
(13, 'Identificar los diferentes modelos de ciclo de vida del software.', 10, '2026-05-10 20:17:00', NULL, '1'),
(14, 'Analizar la ética y responsabilidad profesional del ingeniero.', 10, '2026-05-10 20:17:00', NULL, '1'),
(15, 'Elicitar requisitos utilizando técnicas de entrevistas y observación.', 3, '2026-05-10 20:17:00', NULL, '1'),
(16, 'Documentar requisitos funcionales y no funcionales (IEEE 830).', 3, '2026-05-10 20:17:00', NULL, '1'),
(17, 'Validar requisitos mediante inspecciones y prototipado.', 3, '2026-05-10 20:17:00', NULL, '1'),
(18, 'Aplicar principios de diseño como cohesión y acoplamiento.', 4, '2026-05-10 20:17:00', NULL, '1'),
(19, 'Diseñar arquitecturas de software utilizando patrones estándar.', 4, '2026-05-10 20:17:00', NULL, '1'),
(20, 'Modelar el sistema utilizando diagramas de clases y secuencia UML.', 4, '2026-05-10 20:17:00', NULL, '1'),
(21, 'Aplicar técnicas de caja blanca y caja negra para pruebas de software.', 5, '2026-05-10 20:17:00', NULL, '1'),
(22, 'Asegurar la calidad del producto mediante métricas de software.', 5, '2026-05-10 20:17:00', NULL, '1'),
(23, 'Planificar el mantenimiento y evolución del sistema.', 5, '2026-05-10 20:17:00', NULL, '1'),
(24, 'Comprender los fundamentos y el ciclo de vida del software.', 14, '2026-05-10 20:22:12', NULL, '1'),
(25, 'Aplicar técnicas de elicitación y análisis de requisitos.', 3, '2026-05-10 20:22:12', NULL, '1'),
(26, 'Comprender los conceptos básicos y el ciclo de vida. - T15', 15, '2026-05-10 20:32:03', NULL, '1'),
(27, 'Identificar y documentar requisitos del sistema. - T16', 16, '2026-05-10 20:32:04', NULL, '1'),
(28, 'Aplicar patrones de diseño y modelado UML. - T17', 17, '2026-05-10 20:32:05', NULL, '1'),
(29, 'Asegurar la calidad mediante pruebas sistemáticas. - T18', 18, '2026-05-10 20:32:05', NULL, '1'),
(30, 'Comprender los conceptos básicos y el ciclo de vida. - T19', 19, '2026-05-10 20:32:05', NULL, '1'),
(31, 'Identificar y documentar requisitos del sistema. - T20', 20, '2026-05-10 20:32:05', NULL, '1'),
(32, 'Aplicar patrones de diseño y modelado UML. - T21', 21, '2026-05-10 20:32:05', NULL, '1'),
(33, 'Asegurar la calidad mediante pruebas sistemáticas. - T22', 22, '2026-05-10 20:32:06', NULL, '1'),
(34, 'Comprender los conceptos básicos y el ciclo de vida. - T23', 23, '2026-05-10 20:32:06', NULL, '1'),
(35, 'Identificar y documentar requisitos del sistema. - T24', 24, '2026-05-10 20:32:06', NULL, '1'),
(36, 'Aplicar patrones de diseño y modelado UML. - T25', 25, '2026-05-10 20:32:06', NULL, '1'),
(37, 'Asegurar la calidad mediante pruebas sistemáticas. - T26', 26, '2026-05-10 20:32:07', NULL, '1'),
(38, 'Comprender los conceptos básicos y el ciclo de vida. - T27', 27, '2026-05-10 20:32:07', NULL, '1'),
(39, 'Identificar y documentar requisitos del sistema. - T28', 28, '2026-05-10 20:32:07', NULL, '1'),
(40, 'Aplicar patrones de diseño y modelado UML. - T29', 29, '2026-05-10 20:32:07', NULL, '1'),
(41, 'Asegurar la calidad mediante pruebas sistemáticas. - T30', 30, '2026-05-10 20:32:08', NULL, '1'),
(42, 'Comprender los conceptos básicos y el ciclo de vida. - T31', 31, '2026-05-10 20:32:08', NULL, '1'),
(43, 'Identificar y documentar requisitos del sistema. - T32', 32, '2026-05-10 20:32:08', NULL, '1'),
(44, 'Aplicar patrones de diseño y modelado UML. - T33', 33, '2026-05-10 20:32:08', NULL, '1'),
(45, 'Asegurar la calidad mediante pruebas sistemáticas. - T34', 34, '2026-05-10 20:32:08', NULL, '1'),
(46, 'Comprender los conceptos básicos y el ciclo de vida. - T35', 35, '2026-05-10 20:32:10', NULL, '1'),
(47, 'Identificar y documentar requisitos del sistema. - T36', 36, '2026-05-10 20:32:17', NULL, '1'),
(48, 'Aplicar patrones de diseño y modelado UML. - T37', 37, '2026-05-10 20:32:20', NULL, '1'),
(49, 'Asegurar la calidad mediante pruebas sistemáticas. - T38', 38, '2026-05-10 20:32:21', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `nombre_permiso` tinytext DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre_permiso`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Index de Perfil', '2026-03-24 04:55:38', NULL, '1'),
(2, 'Index de Seleccionar Rol', '2026-03-24 04:55:38', NULL, '1'),
(3, 'Listar de Contenido', '2026-03-24 04:55:38', NULL, '1'),
(4, 'Crear de Contenido', '2026-03-24 04:55:38', NULL, '1'),
(5, 'Editar de Contenido', '2026-03-24 04:55:38', NULL, '1'),
(6, 'Ver Detalles de Contenido', '2026-03-24 04:55:38', NULL, '1'),
(7, 'Listar de Tema', '2026-03-24 04:55:38', NULL, '1'),
(8, 'Crear de Tema', '2026-03-24 04:55:38', NULL, '1'),
(9, 'Editar de Tema', '2026-03-24 04:55:38', NULL, '1'),
(10, 'Ver Detalles de Tema', '2026-03-24 04:55:38', NULL, '1'),
(11, 'Crear de Usuarios', '2026-03-24 04:55:38', NULL, '1'),
(12, 'Listar de Usuarios', '2026-03-24 04:55:38', NULL, '1'),
(13, 'Listar de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(14, 'Crear de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(15, 'Editar de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(16, 'Ver Detalles de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(17, 'Reporte General de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(18, 'Reporte Detallado de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(19, 'Reporte de Calendario', '2026-03-24 04:55:38', NULL, '1'),
(20, 'Listar de Indicador Logro', '2026-03-24 04:55:38', NULL, '1'),
(21, 'Crear de Indicador Logro', '2026-03-24 04:55:38', NULL, '1'),
(22, 'Editar de Indicador Logro', '2026-03-24 04:55:38', NULL, '1'),
(23, 'Ver Detalles de Indicador Logro', '2026-03-24 04:55:38', NULL, '1'),
(24, 'Listar de Bibliografia', '2026-03-24 04:55:38', NULL, '1'),
(25, 'Crear de Bibliografia', '2026-03-24 04:55:38', NULL, '1'),
(26, 'Editar de Bibliografia', '2026-03-24 04:55:38', NULL, '1'),
(27, 'Ver Detalles de Bibliografia', '2026-03-24 04:55:38', NULL, '1'),
(28, 'Listar de Recurso', '2026-03-24 04:55:38', NULL, '1'),
(29, 'Crear de Recurso', '2026-03-24 04:55:38', NULL, '1'),
(30, 'Editar de Recurso', '2026-03-24 04:55:38', NULL, '1'),
(31, 'Ver Detalles de Recurso', '2026-03-24 04:55:38', NULL, '1'),
(32, 'Listar de Estrategia', '2026-03-24 04:55:38', NULL, '1'),
(33, 'Crear de Estrategia', '2026-03-24 04:55:38', NULL, '1'),
(34, 'Editar de Estrategia', '2026-03-24 04:55:38', NULL, '1'),
(35, 'Ver Detalles de Estrategia', '2026-03-24 04:55:38', NULL, '1'),
(36, 'Listar de Tecnica Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(37, 'Crear de Tecnica Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(38, 'Editar de Tecnica Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(39, 'Ver Detalles de Tecnica Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(40, 'Listar de Tipo Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(41, 'Crear de Tipo Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(42, 'Editar de Tipo Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(43, 'Ver Detalles de Tipo Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(44, 'Listar de Evento', '2026-03-24 04:55:38', NULL, '1'),
(45, 'Crear de Evento', '2026-03-24 04:55:38', NULL, '1'),
(46, 'Editar de Evento', '2026-03-24 04:55:38', '2026-04-27 16:04:45', '1'),
(47, 'Ver Detalles de Evento', '2026-03-24 04:55:38', NULL, '1'),
(48, 'Listar de Calendario', '2026-03-24 04:55:38', NULL, '1'),
(49, 'Crear de Calendario', '2026-03-24 04:55:38', NULL, '1'),
(50, 'Editar de Calendario', '2026-03-24 04:55:38', '2026-04-25 23:57:10', '3'),
(51, 'Ver Detalles de Calendario', '2026-03-24 04:55:38', NULL, '1'),
(52, 'Listar de Rol', '2026-03-24 04:55:38', '2026-04-25 23:57:10', '3'),
(53, 'Editar de Rol', '2026-03-24 04:55:38', '2026-04-25 23:57:10', '3'),
(54, 'Listar de Bitacora', '2026-03-24 04:55:38', NULL, '1'),
(55, 'Ver Detalles de Bitacora', '2026-03-24 04:55:38', NULL, '1'),
(56, 'Cambiar Estatus de Perfil', '2026-03-24 04:55:38', NULL, '1'),
(57, 'Cambiar Estatus de Seleccionar Rol', '2026-03-24 04:55:38', NULL, '1'),
(58, 'Cambiar Estatus de Contenido', '2026-03-24 04:55:38', NULL, '1'),
(59, 'Cambiar Estatus de Tema', '2026-03-24 04:55:38', NULL, '1'),
(60, 'Cambiar Estatus de Usuarios', '2026-03-24 04:55:38', NULL, '1'),
(61, 'Cambiar Estatus de Planificacion', '2026-03-24 04:55:38', NULL, '1'),
(62, 'Cambiar Estatus de Calendario', '2026-03-24 04:55:38', NULL, '1'),
(63, 'Cambiar Estatus de Indicador Logro', '2026-03-24 04:55:38', NULL, '1'),
(64, 'Cambiar Estatus de Bibliografia', '2026-03-24 04:55:38', NULL, '1'),
(65, 'Cambiar Estatus de Recurso', '2026-03-24 04:55:38', NULL, '1'),
(66, 'Cambiar Estatus de Estrategia', '2026-03-24 04:55:38', NULL, '1'),
(67, 'Cambiar Estatus de Tecnica Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(68, 'Cambiar Estatus de Tipo Evaluacion', '2026-03-24 04:55:38', NULL, '1'),
(69, 'Cambiar Estatus de Evento', '2026-03-24 04:55:38', NULL, '1'),
(70, 'Cambiar Estatus de Rol', '2026-03-24 04:55:38', '2026-04-25 23:57:10', '3'),
(71, 'Cambiar Estatus de Bitacora', '2026-03-24 04:55:38', NULL, '1'),
(72, 'Listar de Permiso', '2026-04-15 22:18:35', '2026-04-22 21:53:29', '1'),
(73, 'Editar de Permiso', '2026-04-15 22:18:35', '2026-04-22 21:53:30', '1'),
(74, 'Cambiar Estatus de Permiso', '2026-04-15 22:18:35', '2026-04-22 21:53:30', '1'),
(75, 'Acceso al Dashboard', '2026-05-10 20:17:00', NULL, '1'),
(76, 'Gestionar Usuarios', '2026-05-10 20:17:00', NULL, '1'),
(77, 'Gestionar Roles y Permisos', '2026-05-10 20:17:00', NULL, '1'),
(78, 'Ver Reportes de Planificación', '2026-05-10 20:17:00', NULL, '1'),
(79, 'Aprobar Planificaciones (Vocero)', '2026-05-10 20:17:01', NULL, '1'),
(80, 'Validar Planificaciones (Coordinador)', '2026-05-10 20:17:01', NULL, '1'),
(81, 'Notificar Profesores', '2026-05-10 20:17:01', NULL, '1'),
(82, 'Descargar Contratos de Aprendizaje', '2026-05-10 20:17:01', NULL, '1'),
(83, 'Configurar Calendario Académico', '2026-05-10 20:17:01', NULL, '1'),
(84, 'Auditar Bitácora de Sistema', '2026-05-10 20:17:01', NULL, '1'),
(85, 'Aprobar Planificaciones', '2026-05-10 20:22:12', NULL, '1'),
(86, 'Gestionar Catalogos Maestros', '2026-05-10 20:22:12', NULL, '1'),
(87, 'Configurar Calendario', '2026-05-10 20:32:21', NULL, '1'),
(88, 'Ver Bitacora', '2026-05-10 20:32:21', NULL, '1'),
(89, 'Gestionar Catalogos', '2026-05-10 20:32:21', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion`
--

CREATE TABLE `planificacion` (
  `id_planificacion` int(11) NOT NULL,
  `id_profesor_asignado` int(11) DEFAULT NULL,
  `aceptado_vocero` int(11) DEFAULT NULL,
  `aceptado_coordinador` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3','4') DEFAULT '1',
  `tipo_planificacion` text DEFAULT NULL,
  `archivo_contrato` varchar(255) DEFAULT NULL,
  `notificado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `planificacion`
--

INSERT INTO `planificacion` (`id_planificacion`, `id_profesor_asignado`, `aceptado_vocero`, `aceptado_coordinador`, `fecha_creacion`, `fecha_actualizacion`, `estatus`, `tipo_planificacion`, `archivo_contrato`, `notificado`) VALUES
(1, 60998, NULL, NULL, '2026-05-04 00:31:41', '2026-05-03 20:51:33', '1', '[\"Regular\",\"PER\",\"Repitencia\"]', 'contratos/FHnYEzlcJYPg6lYVbqvYSeTqmUhWf2MM3i0zxy12.pdf', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL,
  `nombre_recurso` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recurso`
--

INSERT INTO `recurso` (`id_recurso`, `nombre_recurso`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(6, 'proyector', '2026-04-27 20:31:40', NULL, '1'),
(7, 'Pizarra', '2026-04-27 20:31:51', NULL, '1'),
(8, 'Maquetas', '2026-04-27 20:32:08', NULL, '1'),
(9, 'Simuladores Virtuales', '2026-04-27 20:32:20', NULL, '1'),
(10, 'Documentos PDF', '2026-04-27 20:32:47', NULL, '1'),
(11, 'Infografías', '2026-04-27 20:32:53', NULL, '1'),
(12, 'Google Meet', '2026-04-27 20:33:03', NULL, '1'),
(13, 'Video Beam / Proyector', '2026-04-27 20:47:15', NULL, '1'),
(14, 'Laboratorio de Computación', '2026-04-27 20:47:15', NULL, '1'),
(15, 'Plataforma Moodle / Aula Virtual', '2026-04-27 20:47:15', NULL, '1'),
(16, 'Material Impreso (Guías/Libros)', '2026-04-27 20:47:15', NULL, '1'),
(17, 'Pizarra Acrílica y Marcadores', '2026-04-27 20:47:15', NULL, '1'),
(18, 'Internet / Conexión Wi-Fi', '2026-04-27 20:47:15', NULL, '1'),
(19, 'Software Especializado (IDE/Simuladores)', '2026-04-27 20:47:15', NULL, '1'),
(20, 'Video Beam / Proyector Multimedia', '2026-05-10 20:13:43', NULL, '1'),
(21, 'Software Especializado (IDEs/Simuladores)', '2026-05-10 20:13:43', NULL, '1'),
(22, 'Guías de Estudio Digitales (PDF)', '2026-05-10 20:13:43', NULL, '1'),
(23, 'Laptops / Tablets', '2026-05-10 20:16:59', NULL, '1'),
(24, 'Infografías y Mapas Mentales', '2026-05-10 20:16:59', NULL, '1'),
(25, 'Videos Educativos / YouTube', '2026-05-10 20:16:59', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `id_rol_permiso` int(11) NOT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol_permiso`, `id_permiso`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(139, 44, 31, '2026-04-25 23:56:13', NULL, '1'),
(140, 45, 31, '2026-04-25 23:56:13', NULL, '1'),
(141, 46, 31, '2026-04-25 23:56:13', '2026-04-27 22:25:36', '1'),
(142, 47, 31, '2026-04-25 23:56:13', NULL, '1'),
(143, 48, 31, '2026-04-25 23:56:13', NULL, '1'),
(144, 49, 31, '2026-04-25 23:56:13', NULL, '1'),
(145, 50, 31, '2026-04-25 23:56:13', '2026-04-26 04:03:44', '3'),
(146, 51, 31, '2026-04-25 23:56:13', NULL, '1'),
(147, 52, 31, '2026-04-25 23:56:13', '2026-04-26 04:03:44', '3'),
(148, 53, 31, '2026-04-25 23:56:13', '2026-04-26 04:03:44', '3'),
(149, 62, 31, '2026-04-25 23:56:13', NULL, '1'),
(150, 69, 31, '2026-04-25 23:56:13', NULL, '1'),
(151, 70, 31, '2026-04-25 23:56:13', '2026-04-26 04:03:44', '3'),
(152, 72, 31, '2026-04-25 23:56:13', NULL, '1'),
(153, 73, 31, '2026-04-25 23:56:13', NULL, '1'),
(154, 74, 31, '2026-04-25 23:56:13', NULL, '1'),
(170, 3, 11, '2026-04-25 23:56:13', NULL, '1'),
(171, 4, 11, '2026-04-25 23:56:13', NULL, '1'),
(172, 5, 11, '2026-04-25 23:56:13', NULL, '1'),
(173, 6, 11, '2026-04-25 23:56:13', NULL, '1'),
(174, 7, 11, '2026-04-25 23:56:13', NULL, '1'),
(175, 8, 11, '2026-04-25 23:56:13', NULL, '1'),
(176, 9, 11, '2026-04-25 23:56:13', NULL, '1'),
(177, 10, 11, '2026-04-25 23:56:13', NULL, '1'),
(178, 13, 11, '2026-04-25 23:56:13', NULL, '1'),
(179, 16, 11, '2026-04-25 23:56:13', NULL, '1'),
(180, 17, 11, '2026-04-25 23:56:13', NULL, '1'),
(181, 18, 11, '2026-04-25 23:56:13', NULL, '1'),
(182, 20, 11, '2026-04-25 23:56:13', NULL, '1'),
(183, 21, 11, '2026-04-25 23:56:13', NULL, '1'),
(184, 22, 11, '2026-04-25 23:56:13', NULL, '1'),
(185, 23, 11, '2026-04-25 23:56:13', NULL, '1'),
(186, 58, 11, '2026-04-25 23:56:13', NULL, '1'),
(187, 59, 11, '2026-04-25 23:56:13', NULL, '1'),
(188, 61, 11, '2026-04-25 23:56:13', NULL, '1'),
(189, 63, 11, '2026-04-25 23:56:13', NULL, '1'),
(201, 3, 30, '2026-04-25 23:56:13', NULL, '1'),
(202, 4, 30, '2026-04-25 23:56:13', NULL, '1'),
(203, 5, 30, '2026-04-25 23:56:13', NULL, '1'),
(204, 6, 30, '2026-04-25 23:56:13', NULL, '1'),
(205, 7, 30, '2026-04-25 23:56:13', NULL, '1'),
(206, 8, 30, '2026-04-25 23:56:13', NULL, '1'),
(207, 9, 30, '2026-04-25 23:56:13', NULL, '1'),
(208, 10, 30, '2026-04-25 23:56:13', NULL, '1'),
(209, 13, 30, '2026-04-25 23:56:13', NULL, '1'),
(210, 16, 30, '2026-04-25 23:56:13', NULL, '1'),
(211, 17, 30, '2026-04-25 23:56:13', NULL, '1'),
(212, 18, 30, '2026-04-25 23:56:13', NULL, '1'),
(213, 20, 30, '2026-04-25 23:56:13', NULL, '1'),
(214, 21, 30, '2026-04-25 23:56:13', NULL, '1'),
(215, 22, 30, '2026-04-25 23:56:13', NULL, '1'),
(216, 23, 30, '2026-04-25 23:56:13', NULL, '1'),
(217, 58, 30, '2026-04-25 23:56:13', NULL, '1'),
(218, 59, 30, '2026-04-25 23:56:13', NULL, '1'),
(219, 61, 30, '2026-04-25 23:56:13', NULL, '1'),
(220, 63, 30, '2026-04-25 23:56:13', NULL, '1'),
(232, 13, 3, '2026-04-25 23:56:13', NULL, '1'),
(233, 14, 3, '2026-04-25 23:56:13', NULL, '1'),
(234, 15, 3, '2026-04-25 23:56:13', NULL, '1'),
(235, 16, 3, '2026-04-25 23:56:13', NULL, '1'),
(236, 17, 3, '2026-04-25 23:56:13', NULL, '1'),
(237, 18, 3, '2026-04-25 23:56:13', NULL, '1'),
(238, 24, 3, '2026-04-25 23:56:13', NULL, '1'),
(239, 25, 3, '2026-04-25 23:56:13', NULL, '1'),
(240, 26, 3, '2026-04-25 23:56:13', NULL, '1'),
(241, 27, 3, '2026-04-25 23:56:13', NULL, '1'),
(242, 28, 3, '2026-04-25 23:56:13', NULL, '1'),
(243, 29, 3, '2026-04-25 23:56:13', NULL, '1'),
(244, 30, 3, '2026-04-25 23:56:13', NULL, '1'),
(245, 31, 3, '2026-04-25 23:56:13', NULL, '1'),
(246, 32, 3, '2026-04-25 23:56:13', NULL, '1'),
(247, 33, 3, '2026-04-25 23:56:13', NULL, '1'),
(248, 34, 3, '2026-04-25 23:56:13', NULL, '1'),
(249, 35, 3, '2026-04-25 23:56:13', NULL, '1'),
(250, 36, 3, '2026-04-25 23:56:13', NULL, '1'),
(251, 37, 3, '2026-04-25 23:56:13', NULL, '1'),
(252, 38, 3, '2026-04-25 23:56:13', NULL, '1'),
(253, 39, 3, '2026-04-25 23:56:13', NULL, '1'),
(254, 40, 3, '2026-04-25 23:56:13', NULL, '1'),
(255, 41, 3, '2026-04-25 23:56:13', NULL, '1'),
(256, 42, 3, '2026-04-25 23:56:13', NULL, '1'),
(257, 43, 3, '2026-04-25 23:56:13', NULL, '1'),
(258, 61, 3, '2026-04-25 23:56:13', NULL, '1'),
(259, 64, 3, '2026-04-25 23:56:13', NULL, '1'),
(260, 65, 3, '2026-04-25 23:56:13', NULL, '1'),
(261, 66, 3, '2026-04-25 23:56:13', NULL, '1'),
(262, 67, 3, '2026-04-25 23:56:13', NULL, '1'),
(263, 68, 3, '2026-04-25 23:56:13', NULL, '1'),
(325, 13, 4, '2026-04-26 04:22:45', NULL, '1'),
(326, 16, 4, '2026-04-26 04:22:45', NULL, '1'),
(327, 60, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(328, 11, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(329, 12, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(330, 68, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(331, 41, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(332, 42, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(333, 40, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(334, 43, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(335, 59, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(336, 8, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(337, 9, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(338, 7, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(339, 10, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(340, 67, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(341, 37, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(342, 38, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(343, 36, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(344, 39, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(345, 57, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(346, 2, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(347, 65, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(348, 29, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(349, 30, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(350, 28, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(351, 31, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(352, 61, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(353, 14, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(354, 15, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(355, 18, 4, '2026-04-27 16:05:27', NULL, '1'),
(356, 17, 4, '2026-04-27 16:05:27', NULL, '1'),
(357, 74, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(358, 73, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(359, 72, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(360, 56, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(361, 1, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(362, 63, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(363, 21, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(364, 22, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(365, 20, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(366, 23, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(367, 64, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(368, 25, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(369, 26, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(370, 24, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(371, 27, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(372, 71, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(373, 54, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(374, 55, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(375, 62, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(376, 49, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(377, 48, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(378, 19, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(379, 51, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(380, 58, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(381, 4, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(382, 5, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(383, 3, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(384, 6, 4, '2026-04-27 16:05:27', '2026-04-27 21:35:12', '3'),
(385, 66, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(386, 33, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(387, 34, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(388, 32, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(389, 35, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(390, 69, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(391, 45, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(392, 46, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(393, 44, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(394, 47, 4, '2026-04-27 16:05:28', '2026-04-27 21:35:12', '3'),
(395, 61, 31, '2026-04-27 22:09:02', NULL, '1'),
(396, 16, 31, '2026-04-27 22:09:02', NULL, '1'),
(397, 17, 31, '2026-04-27 22:09:02', NULL, '1'),
(398, 13, 31, '2026-04-27 22:09:02', NULL, '1'),
(399, 71, 31, '2026-04-27 22:25:36', NULL, '1'),
(400, 54, 31, '2026-04-27 22:25:36', NULL, '1'),
(401, 55, 31, '2026-04-27 22:25:36', NULL, '1'),
(402, 64, 31, '2026-04-27 22:25:36', NULL, '1'),
(403, 25, 31, '2026-04-27 22:25:36', NULL, '1'),
(404, 26, 31, '2026-04-27 22:25:36', NULL, '1'),
(405, 24, 31, '2026-04-27 22:25:36', NULL, '1'),
(406, 27, 31, '2026-04-27 22:25:36', NULL, '1'),
(407, 19, 31, '2026-04-27 22:25:36', NULL, '1'),
(408, 58, 31, '2026-04-27 22:25:36', NULL, '1'),
(409, 4, 31, '2026-04-27 22:25:36', NULL, '1'),
(410, 5, 31, '2026-04-27 22:25:36', NULL, '1'),
(411, 3, 31, '2026-04-27 22:25:36', NULL, '1'),
(412, 6, 31, '2026-04-27 22:25:36', NULL, '1'),
(413, 66, 31, '2026-04-27 22:25:36', NULL, '1'),
(414, 33, 31, '2026-04-27 22:25:36', NULL, '1'),
(415, 34, 31, '2026-04-27 22:25:36', NULL, '1'),
(416, 32, 31, '2026-04-27 22:25:36', NULL, '1'),
(417, 35, 31, '2026-04-27 22:25:36', NULL, '1'),
(418, 63, 31, '2026-04-27 22:25:36', NULL, '1'),
(419, 21, 31, '2026-04-27 22:25:36', NULL, '1'),
(420, 22, 31, '2026-04-27 22:25:36', NULL, '1'),
(421, 20, 31, '2026-04-27 22:25:36', NULL, '1'),
(422, 23, 31, '2026-04-27 22:25:36', NULL, '1'),
(423, 56, 31, '2026-04-27 22:25:36', NULL, '1'),
(424, 1, 31, '2026-04-27 22:25:36', NULL, '1'),
(425, 14, 31, '2026-04-27 22:25:36', NULL, '1'),
(426, 15, 31, '2026-04-27 22:25:36', NULL, '1'),
(427, 18, 31, '2026-04-27 22:25:36', NULL, '1'),
(428, 65, 31, '2026-04-27 22:25:36', NULL, '1'),
(429, 29, 31, '2026-04-27 22:25:36', NULL, '1'),
(430, 30, 31, '2026-04-27 22:25:36', NULL, '1'),
(431, 28, 31, '2026-04-27 22:25:36', NULL, '1'),
(432, 31, 31, '2026-04-27 22:25:37', NULL, '1'),
(433, 57, 31, '2026-04-27 22:25:37', NULL, '1'),
(434, 2, 31, '2026-04-27 22:25:37', NULL, '1'),
(435, 67, 31, '2026-04-27 22:25:37', NULL, '1'),
(436, 37, 31, '2026-04-27 22:25:37', NULL, '1'),
(437, 38, 31, '2026-04-27 22:25:37', NULL, '1'),
(438, 36, 31, '2026-04-27 22:25:37', NULL, '1'),
(439, 39, 31, '2026-04-27 22:25:37', NULL, '1'),
(440, 59, 31, '2026-04-27 22:25:37', NULL, '1'),
(441, 8, 31, '2026-04-27 22:25:37', NULL, '1'),
(442, 9, 31, '2026-04-27 22:25:37', NULL, '1'),
(443, 7, 31, '2026-04-27 22:25:37', NULL, '1'),
(444, 10, 31, '2026-04-27 22:25:37', NULL, '1'),
(445, 68, 31, '2026-04-27 22:25:37', NULL, '1'),
(446, 41, 31, '2026-04-27 22:25:37', NULL, '1'),
(447, 42, 31, '2026-04-27 22:25:37', NULL, '1'),
(448, 40, 31, '2026-04-27 22:25:37', NULL, '1'),
(449, 43, 31, '2026-04-27 22:25:37', NULL, '1'),
(450, 60, 31, '2026-04-27 22:25:37', NULL, '1'),
(451, 11, 31, '2026-04-27 22:25:37', NULL, '1'),
(452, 12, 31, '2026-04-27 22:25:37', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso_backup`
--

CREATE TABLE `rol_permiso_backup` (
  `id_rol_permiso` int(11) NOT NULL DEFAULT 0,
  `id_permiso` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso_backup`
--

INSERT INTO `rol_permiso_backup` (`id_rol_permiso`, `id_permiso`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 69, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(2, 45, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(3, 46, 3, '2026-03-24 04:58:45', '2026-04-26 03:45:32', '3'),
(4, 44, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(5, 47, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(6, 61, 3, '2026-03-24 04:58:45', NULL, '1'),
(7, 14, 3, '2026-03-24 04:58:45', NULL, '1'),
(8, 15, 3, '2026-03-24 04:58:45', NULL, '1'),
(9, 13, 3, '2026-03-24 04:58:45', NULL, '1'),
(10, 18, 3, '2026-03-24 04:58:45', NULL, '1'),
(11, 17, 3, '2026-03-24 04:58:45', NULL, '1'),
(12, 16, 3, '2026-03-24 04:58:45', NULL, '1'),
(13, 62, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(14, 49, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(15, 50, 3, '2026-03-24 04:58:45', '2026-04-26 03:45:32', '3'),
(16, 48, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(17, 19, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(18, 51, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(19, 61, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(20, 14, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(21, 15, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(22, 13, 4, '2026-03-25 05:30:31', NULL, '1'),
(23, 18, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(24, 17, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(25, 16, 4, '2026-03-25 05:30:31', NULL, '1'),
(26, 62, 4, '2026-03-28 15:50:50', NULL, '1'),
(27, 49, 4, '2026-03-28 15:50:50', NULL, '1'),
(28, 50, 4, '2026-03-28 15:50:50', '2026-04-26 03:45:32', '3'),
(29, 48, 4, '2026-03-28 15:50:50', NULL, '1'),
(30, 19, 4, '2026-03-28 15:50:50', NULL, '1'),
(31, 51, 4, '2026-03-28 15:50:50', NULL, '1'),
(32, 66, 3, '2026-04-07 15:38:53', NULL, '1'),
(33, 33, 3, '2026-04-07 15:38:53', NULL, '1'),
(34, 34, 3, '2026-04-07 15:38:53', NULL, '1'),
(35, 32, 3, '2026-04-07 15:38:53', NULL, '1'),
(36, 35, 3, '2026-04-07 15:38:53', NULL, '1'),
(37, 29, 3, '2026-04-07 15:38:53', NULL, '1'),
(38, 30, 3, '2026-04-07 15:38:53', NULL, '1'),
(39, 28, 3, '2026-04-07 15:38:53', NULL, '1'),
(40, 65, 3, '2026-04-07 15:38:53', NULL, '1'),
(41, 31, 3, '2026-04-07 15:38:53', NULL, '1'),
(42, 67, 3, '2026-04-07 15:38:53', NULL, '1'),
(43, 37, 3, '2026-04-07 15:38:53', NULL, '1'),
(44, 38, 3, '2026-04-07 15:38:53', NULL, '1'),
(45, 36, 3, '2026-04-07 15:38:53', NULL, '1'),
(46, 39, 3, '2026-04-07 15:38:53', NULL, '1'),
(47, 68, 3, '2026-04-07 15:38:53', NULL, '1'),
(48, 41, 3, '2026-04-07 15:38:53', NULL, '1'),
(49, 42, 3, '2026-04-07 15:38:53', NULL, '1'),
(50, 40, 3, '2026-04-07 15:38:53', NULL, '1'),
(51, 43, 3, '2026-04-07 15:38:53', NULL, '1'),
(52, 16, 11, '2026-04-07 15:40:35', NULL, '1'),
(53, 13, 11, '2026-04-07 15:40:35', NULL, '1'),
(54, 59, 11, '2026-04-07 15:49:15', NULL, '1'),
(55, 8, 11, '2026-04-07 15:49:15', NULL, '1'),
(56, 9, 11, '2026-04-07 15:49:15', NULL, '1'),
(57, 7, 11, '2026-04-07 15:49:15', NULL, '1'),
(58, 10, 11, '2026-04-07 15:49:15', NULL, '1'),
(59, 62, 11, '2026-04-08 01:12:40', NULL, '1'),
(60, 49, 11, '2026-04-08 01:12:40', NULL, '1'),
(61, 50, 11, '2026-04-08 01:12:40', '2026-04-26 03:45:32', '3'),
(62, 48, 11, '2026-04-08 01:12:40', NULL, '1'),
(63, 19, 11, '2026-04-08 01:12:40', NULL, '1'),
(64, 51, 11, '2026-04-08 01:12:40', NULL, '1'),
(65, 58, 11, '2026-04-18 00:07:08', NULL, '1'),
(66, 4, 11, '2026-04-18 00:07:08', NULL, '1'),
(67, 5, 11, '2026-04-18 00:07:08', NULL, '1'),
(68, 3, 11, '2026-04-18 00:07:08', NULL, '1'),
(69, 6, 11, '2026-04-18 00:07:08', NULL, '1'),
(70, 69, 11, '2026-04-19 20:57:03', NULL, '1'),
(71, 45, 11, '2026-04-19 20:57:03', NULL, '1'),
(72, 46, 11, '2026-04-19 20:57:03', '2026-04-26 03:45:32', '3'),
(73, 44, 11, '2026-04-19 20:57:03', NULL, '1'),
(74, 47, 11, '2026-04-19 20:57:03', NULL, '1'),
(75, 57, 3, '2026-04-23 01:54:10', NULL, '1'),
(76, 2, 3, '2026-04-23 01:54:10', NULL, '1'),
(77, 59, 3, '2026-04-23 01:54:10', NULL, '1'),
(78, 8, 3, '2026-04-23 01:54:10', NULL, '1'),
(79, 9, 3, '2026-04-23 01:54:11', NULL, '1'),
(80, 7, 3, '2026-04-23 01:54:11', NULL, '1'),
(81, 10, 3, '2026-04-23 01:54:11', NULL, '1'),
(82, 74, 3, '2026-04-23 01:54:11', NULL, '1'),
(83, 73, 3, '2026-04-23 01:54:11', NULL, '1'),
(84, 72, 3, '2026-04-23 01:54:11', NULL, '1'),
(85, 56, 3, '2026-04-23 01:54:11', NULL, '1'),
(86, 1, 3, '2026-04-23 01:54:11', NULL, '1'),
(87, 63, 3, '2026-04-23 01:54:11', NULL, '1'),
(88, 21, 3, '2026-04-23 01:54:11', NULL, '1'),
(89, 22, 3, '2026-04-23 01:54:11', NULL, '1'),
(90, 20, 3, '2026-04-23 01:54:11', NULL, '1'),
(91, 23, 3, '2026-04-23 01:54:11', NULL, '1'),
(92, 58, 3, '2026-04-23 01:54:11', NULL, '1'),
(93, 4, 3, '2026-04-23 01:54:11', NULL, '1'),
(94, 5, 3, '2026-04-23 01:54:11', NULL, '1'),
(95, 3, 3, '2026-04-23 01:54:11', NULL, '1'),
(96, 6, 3, '2026-04-23 01:54:11', NULL, '1'),
(97, 71, 3, '2026-04-23 01:54:11', NULL, '1'),
(98, 54, 3, '2026-04-23 01:54:11', NULL, '1'),
(99, 55, 3, '2026-04-23 01:54:11', NULL, '1'),
(100, 64, 3, '2026-04-23 01:54:11', NULL, '1'),
(101, 25, 3, '2026-04-23 01:54:11', NULL, '1'),
(102, 26, 3, '2026-04-23 01:54:11', NULL, '1'),
(103, 24, 3, '2026-04-23 01:54:11', NULL, '1'),
(104, 27, 3, '2026-04-23 01:54:11', NULL, '1'),
(105, 60, 3, '2026-04-23 01:54:11', NULL, '1'),
(106, 11, 3, '2026-04-23 01:54:11', NULL, '1'),
(107, 12, 3, '2026-04-23 01:54:11', NULL, '1'),
(108, 44, 31, '2026-04-25 23:38:06', NULL, '1'),
(109, 45, 31, '2026-04-25 23:38:06', NULL, '1'),
(110, 46, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(111, 47, 31, '2026-04-25 23:38:06', NULL, '1'),
(112, 48, 31, '2026-04-25 23:38:06', NULL, '1'),
(113, 49, 31, '2026-04-25 23:38:06', NULL, '1'),
(114, 50, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(115, 51, 31, '2026-04-25 23:38:06', NULL, '1'),
(116, 52, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(117, 53, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(118, 62, 31, '2026-04-25 23:38:06', NULL, '1'),
(119, 69, 31, '2026-04-25 23:38:06', NULL, '1'),
(120, 70, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(121, 72, 31, '2026-04-25 23:38:06', NULL, '1'),
(122, 73, 31, '2026-04-25 23:38:06', NULL, '1'),
(123, 74, 31, '2026-04-25 23:38:06', NULL, '1'),
(1, 69, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(2, 45, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(3, 46, 3, '2026-03-24 04:58:45', '2026-04-26 03:45:32', '3'),
(4, 44, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(5, 47, 3, '2026-03-24 04:58:45', '2026-04-15 19:29:02', '1'),
(6, 61, 3, '2026-03-24 04:58:45', NULL, '1'),
(7, 14, 3, '2026-03-24 04:58:45', NULL, '1'),
(8, 15, 3, '2026-03-24 04:58:45', NULL, '1'),
(9, 13, 3, '2026-03-24 04:58:45', NULL, '1'),
(10, 18, 3, '2026-03-24 04:58:45', NULL, '1'),
(11, 17, 3, '2026-03-24 04:58:45', NULL, '1'),
(12, 16, 3, '2026-03-24 04:58:45', NULL, '1'),
(13, 62, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(14, 49, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(15, 50, 3, '2026-03-24 04:58:45', '2026-04-26 03:45:32', '3'),
(16, 48, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(17, 19, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(18, 51, 3, '2026-03-24 04:58:45', '2026-04-23 01:54:11', '1'),
(19, 61, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(20, 14, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(21, 15, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(22, 13, 4, '2026-03-25 05:30:31', NULL, '1'),
(23, 18, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(24, 17, 4, '2026-03-25 05:30:31', '2026-04-11 02:57:37', '1'),
(25, 16, 4, '2026-03-25 05:30:31', NULL, '1'),
(26, 62, 4, '2026-03-28 15:50:50', NULL, '1'),
(27, 49, 4, '2026-03-28 15:50:50', NULL, '1'),
(28, 50, 4, '2026-03-28 15:50:50', '2026-04-26 03:45:32', '3'),
(29, 48, 4, '2026-03-28 15:50:50', NULL, '1'),
(30, 19, 4, '2026-03-28 15:50:50', NULL, '1'),
(31, 51, 4, '2026-03-28 15:50:50', NULL, '1'),
(32, 66, 3, '2026-04-07 15:38:53', NULL, '1'),
(33, 33, 3, '2026-04-07 15:38:53', NULL, '1'),
(34, 34, 3, '2026-04-07 15:38:53', NULL, '1'),
(35, 32, 3, '2026-04-07 15:38:53', NULL, '1'),
(36, 35, 3, '2026-04-07 15:38:53', NULL, '1'),
(37, 29, 3, '2026-04-07 15:38:53', NULL, '1'),
(38, 30, 3, '2026-04-07 15:38:53', NULL, '1'),
(39, 28, 3, '2026-04-07 15:38:53', NULL, '1'),
(40, 65, 3, '2026-04-07 15:38:53', NULL, '1'),
(41, 31, 3, '2026-04-07 15:38:53', NULL, '1'),
(42, 67, 3, '2026-04-07 15:38:53', NULL, '1'),
(43, 37, 3, '2026-04-07 15:38:53', NULL, '1'),
(44, 38, 3, '2026-04-07 15:38:53', NULL, '1'),
(45, 36, 3, '2026-04-07 15:38:53', NULL, '1'),
(46, 39, 3, '2026-04-07 15:38:53', NULL, '1'),
(47, 68, 3, '2026-04-07 15:38:53', NULL, '1'),
(48, 41, 3, '2026-04-07 15:38:53', NULL, '1'),
(49, 42, 3, '2026-04-07 15:38:53', NULL, '1'),
(50, 40, 3, '2026-04-07 15:38:53', NULL, '1'),
(51, 43, 3, '2026-04-07 15:38:53', NULL, '1'),
(52, 16, 11, '2026-04-07 15:40:35', NULL, '1'),
(53, 13, 11, '2026-04-07 15:40:35', NULL, '1'),
(54, 59, 11, '2026-04-07 15:49:15', NULL, '1'),
(55, 8, 11, '2026-04-07 15:49:15', NULL, '1'),
(56, 9, 11, '2026-04-07 15:49:15', NULL, '1'),
(57, 7, 11, '2026-04-07 15:49:15', NULL, '1'),
(58, 10, 11, '2026-04-07 15:49:15', NULL, '1'),
(59, 62, 11, '2026-04-08 01:12:40', NULL, '1'),
(60, 49, 11, '2026-04-08 01:12:40', NULL, '1'),
(61, 50, 11, '2026-04-08 01:12:40', '2026-04-26 03:45:32', '3'),
(62, 48, 11, '2026-04-08 01:12:40', NULL, '1'),
(63, 19, 11, '2026-04-08 01:12:40', NULL, '1'),
(64, 51, 11, '2026-04-08 01:12:40', NULL, '1'),
(65, 58, 11, '2026-04-18 00:07:08', NULL, '1'),
(66, 4, 11, '2026-04-18 00:07:08', NULL, '1'),
(67, 5, 11, '2026-04-18 00:07:08', NULL, '1'),
(68, 3, 11, '2026-04-18 00:07:08', NULL, '1'),
(69, 6, 11, '2026-04-18 00:07:08', NULL, '1'),
(70, 69, 11, '2026-04-19 20:57:03', NULL, '1'),
(71, 45, 11, '2026-04-19 20:57:03', NULL, '1'),
(72, 46, 11, '2026-04-19 20:57:03', '2026-04-26 03:45:32', '3'),
(73, 44, 11, '2026-04-19 20:57:03', NULL, '1'),
(74, 47, 11, '2026-04-19 20:57:03', NULL, '1'),
(75, 57, 3, '2026-04-23 01:54:10', NULL, '1'),
(76, 2, 3, '2026-04-23 01:54:10', NULL, '1'),
(77, 59, 3, '2026-04-23 01:54:10', NULL, '1'),
(78, 8, 3, '2026-04-23 01:54:10', NULL, '1'),
(79, 9, 3, '2026-04-23 01:54:11', NULL, '1'),
(80, 7, 3, '2026-04-23 01:54:11', NULL, '1'),
(81, 10, 3, '2026-04-23 01:54:11', NULL, '1'),
(82, 74, 3, '2026-04-23 01:54:11', NULL, '1'),
(83, 73, 3, '2026-04-23 01:54:11', NULL, '1'),
(84, 72, 3, '2026-04-23 01:54:11', NULL, '1'),
(85, 56, 3, '2026-04-23 01:54:11', NULL, '1'),
(86, 1, 3, '2026-04-23 01:54:11', NULL, '1'),
(87, 63, 3, '2026-04-23 01:54:11', NULL, '1'),
(88, 21, 3, '2026-04-23 01:54:11', NULL, '1'),
(89, 22, 3, '2026-04-23 01:54:11', NULL, '1'),
(90, 20, 3, '2026-04-23 01:54:11', NULL, '1'),
(91, 23, 3, '2026-04-23 01:54:11', NULL, '1'),
(92, 58, 3, '2026-04-23 01:54:11', NULL, '1'),
(93, 4, 3, '2026-04-23 01:54:11', NULL, '1'),
(94, 5, 3, '2026-04-23 01:54:11', NULL, '1'),
(95, 3, 3, '2026-04-23 01:54:11', NULL, '1'),
(96, 6, 3, '2026-04-23 01:54:11', NULL, '1'),
(97, 71, 3, '2026-04-23 01:54:11', NULL, '1'),
(98, 54, 3, '2026-04-23 01:54:11', NULL, '1'),
(99, 55, 3, '2026-04-23 01:54:11', NULL, '1'),
(100, 64, 3, '2026-04-23 01:54:11', NULL, '1'),
(101, 25, 3, '2026-04-23 01:54:11', NULL, '1'),
(102, 26, 3, '2026-04-23 01:54:11', NULL, '1'),
(103, 24, 3, '2026-04-23 01:54:11', NULL, '1'),
(104, 27, 3, '2026-04-23 01:54:11', NULL, '1'),
(105, 60, 3, '2026-04-23 01:54:11', NULL, '1'),
(106, 11, 3, '2026-04-23 01:54:11', NULL, '1'),
(107, 12, 3, '2026-04-23 01:54:11', NULL, '1'),
(108, 44, 31, '2026-04-25 23:38:06', NULL, '1'),
(109, 45, 31, '2026-04-25 23:38:06', NULL, '1'),
(110, 46, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(111, 47, 31, '2026-04-25 23:38:06', NULL, '1'),
(112, 48, 31, '2026-04-25 23:38:06', NULL, '1'),
(113, 49, 31, '2026-04-25 23:38:06', NULL, '1'),
(114, 50, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(115, 51, 31, '2026-04-25 23:38:06', NULL, '1'),
(116, 52, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(117, 53, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(118, 62, 31, '2026-04-25 23:38:06', NULL, '1'),
(119, 69, 31, '2026-04-25 23:38:06', NULL, '1'),
(120, 70, 31, '2026-04-25 23:38:06', '2026-04-25 23:48:29', '1'),
(121, 72, 31, '2026-04-25 23:38:06', NULL, '1'),
(122, 73, 31, '2026-04-25 23:38:06', NULL, '1'),
(123, 74, 31, '2026-04-25 23:38:06', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('IkxUhxYh92HHEu7WqUGtmHO9z2oBDI69HCx7uHiP', 43332, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiREZvR0lvVFEzNVBrWUZGcElsSTA3RHdvbUdhUVRveE9iUWNvV3JEQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wbGFuaWZpY2FjaW9uL2NyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MTE6ImFjdGl2ZV9yb2xlIjtpOjMxO3M6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjQzMzMyO30=', 1778445316);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_actividad`
--

CREATE TABLE `tecnica_actividad` (
  `id_tecnica_actividad` int(11) NOT NULL,
  `nombre_tecnica_actividad` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnica_actividad`
--

INSERT INTO `tecnica_actividad` (`id_tecnica_actividad`, `nombre_tecnica_actividad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(5, 'Aprendizaje Basado en Proyectos (ABP)', '2026-04-27 20:47:16', NULL, '1'),
(6, 'Clase Magistral Participativa', '2026-04-27 20:47:16', NULL, '1'),
(7, 'Debate y Discusión Dirigida', '2026-04-27 20:47:16', NULL, '1'),
(8, 'Resolución de Problemas / Algoritmos', '2026-04-27 20:47:16', NULL, '1'),
(9, 'Estudio de Casos Reales', '2026-04-27 20:47:16', NULL, '1'),
(10, 'Mapas Conceptuales / Mentales', '2026-04-27 20:47:16', NULL, '1'),
(11, 'Prácticas de Laboratorio Guiadas', '2026-04-27 20:47:16', NULL, '1'),
(12, 'Gamificación Educativa', '2026-04-27 20:50:40', NULL, '1'),
(13, 'Aula Invertida (Flipped Classroom)', '2026-04-27 20:50:40', NULL, '1'),
(14, 'Seminario de Investigación', '2026-04-27 20:50:40', NULL, '1'),
(15, 'Simulación de Entornos Profesionales', '2026-04-27 20:50:40', NULL, '1'),
(16, 'Aprendizaje Cooperativo en Pares', '2026-04-27 20:50:40', NULL, '1'),
(17, 'Taller de Resolución de Problemas', '2026-05-10 20:13:43', NULL, '1'),
(18, 'Debate y Discusión Socializada', '2026-05-10 20:13:43', NULL, '1'),
(19, 'Prácticas Externas / Visitas Técnicas', '2026-05-10 20:13:43', NULL, '1'),
(20, 'Aprendizaje Cooperativo', '2026-05-10 20:16:59', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_evaluacion`
--

CREATE TABLE `tecnica_evaluacion` (
  `id_tecnica_evaluacion` int(11) NOT NULL,
  `nombre_tecnica_evaluacion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnica_evaluacion`
--

INSERT INTO `tecnica_evaluacion` (`id_tecnica_evaluacion`, `nombre_tecnica_evaluacion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Observación Directa', '2026-04-27 20:47:16', NULL, '1'),
(2, 'Análisis de Producción Escrita', '2026-04-27 20:47:16', NULL, '1'),
(3, 'Exposición Oral', '2026-04-27 20:47:16', NULL, '1'),
(4, 'Prueba Práctica en Computador', '2026-04-27 20:47:16', NULL, '1'),
(5, 'Portafolio de Evidencias', '2026-04-27 20:47:16', NULL, '1'),
(6, 'Cuestionario / Examen', '2026-04-27 20:47:16', NULL, '1'),
(7, 'Defensa de Proyecto', '2026-04-27 20:47:16', NULL, '1'),
(8, 'Rúbricas de Evaluación', '2026-04-27 20:50:40', NULL, '1'),
(9, 'Listas de Cotejo', '2026-04-27 20:50:40', NULL, '1'),
(10, 'Ensayos Críticos', '2026-04-27 20:50:40', NULL, '1'),
(11, 'Mapas de Algoritmos (Diagramas de Flujo)', '2026-04-27 20:50:40', NULL, '1'),
(12, 'Entrevistas Técnicas', '2026-04-27 20:50:40', NULL, '1'),
(13, 'Exposición Oral y Defensa', '2026-05-10 20:13:43', NULL, '1'),
(14, 'Prueba Escrita / Cuestionario', '2026-05-10 20:13:43', NULL, '1'),
(15, 'Proyecto Final de Desarrollo', '2026-05-10 20:13:43', NULL, '1'),
(16, 'Portafolio de Evidencias Digital', '2026-05-10 20:13:43', NULL, '1'),
(17, 'Mapa Mental / Conceptual', '2026-05-10 20:13:43', NULL, '1'),
(18, 'Diagramas de Flujo / Algoritmos', '2026-05-10 20:16:59', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema_unidad`
--

CREATE TABLE `tema_unidad` (
  `id_tema_unidad` int(11) NOT NULL,
  `id_unidad_curricular` varchar(7) DEFAULT NULL,
  `titulo_tema` text DEFAULT NULL,
  `unidad_tema` enum('1','2','3','4') DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tema_unidad`
--

INSERT INTO `tema_unidad` (`id_tema_unidad`, `id_unidad_curricular`, `titulo_tema`, `unidad_tema`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, '2', 'ahasdhais', '1', '2026-04-18 00:07:30', NULL, '1'),
(2, '6', 'Unidad 1: Fundamentos de Ingeniería de Software', '1', '2026-04-27 22:33:56', NULL, '1'),
(3, '6', 'Unidad 2: Ingeniería de Requisitos', '2', '2026-04-27 22:33:56', NULL, '1'),
(4, '6', 'Unidad 3: Diseño de Software', '3', '2026-04-27 22:33:56', NULL, '1'),
(5, '6', 'Unidad 4: Calidad y Pruebas', '4', '2026-04-27 22:33:56', NULL, '1'),
(6, '5', 'Unidad 1: Gestión de Proyectos Ágiles', '1', '2026-04-27 22:33:56', NULL, '1'),
(7, '5', 'Unidad 2: Arquitecturas Avanzadas', '2', '2026-04-27 22:33:56', NULL, '1'),
(8, '5', 'Unidad 3: DevOps y Despliegue Continuo', '3', '2026-04-27 22:33:56', NULL, '1'),
(9, '5', 'Unidad 4: Mantenimiento y Evolución', '4', '2026-04-27 22:33:56', NULL, '1'),
(10, '6', 'Unidad 1: Fundamentos y Procesos de Software', '1', '2026-05-10 20:13:42', NULL, '1'),
(11, '6', 'Unidad 2: Ingeniería de Requisitos y Análisis', '2', '2026-05-10 20:13:42', NULL, '1'),
(12, '6', 'Unidad 3: Diseño de Arquitectura y Componentes', '3', '2026-05-10 20:13:42', NULL, '1'),
(13, '6', 'Unidad 4: Gestión de Calidad, Pruebas y Mantenimiento', '4', '2026-05-10 20:13:42', NULL, '1'),
(14, '6', 'Unidad 1: Introducción a la Ingeniería de Software', '1', '2026-05-10 20:22:12', NULL, '1'),
(15, '1', 'Unidad 1: Fundamentos y Evolución (Mat: 1)', '1', '2026-05-10 20:32:03', NULL, '1'),
(16, '1', 'Unidad 2: Análisis y Requisitos (Mat: 1)', '2', '2026-05-10 20:32:04', NULL, '1'),
(17, '1', 'Unidad 3: Diseño y Arquitectura (Mat: 1)', '3', '2026-05-10 20:32:04', NULL, '1'),
(18, '1', 'Unidad 4: Calidad y Pruebas (Mat: 1)', '4', '2026-05-10 20:32:05', NULL, '1'),
(19, '2', 'Unidad 1: Fundamentos y Evolución (Mat: 2)', '1', '2026-05-10 20:32:05', NULL, '1'),
(20, '2', 'Unidad 2: Análisis y Requisitos (Mat: 2)', '2', '2026-05-10 20:32:05', NULL, '1'),
(21, '2', 'Unidad 3: Diseño y Arquitectura (Mat: 2)', '3', '2026-05-10 20:32:05', NULL, '1'),
(22, '2', 'Unidad 4: Calidad y Pruebas (Mat: 2)', '4', '2026-05-10 20:32:06', NULL, '1'),
(23, '3', 'Unidad 1: Fundamentos y Evolución (Mat: 3)', '1', '2026-05-10 20:32:06', NULL, '1'),
(24, '3', 'Unidad 2: Análisis y Requisitos (Mat: 3)', '2', '2026-05-10 20:32:06', NULL, '1'),
(25, '3', 'Unidad 3: Diseño y Arquitectura (Mat: 3)', '3', '2026-05-10 20:32:06', NULL, '1'),
(26, '3', 'Unidad 4: Calidad y Pruebas (Mat: 3)', '4', '2026-05-10 20:32:07', NULL, '1'),
(27, '4', 'Unidad 1: Fundamentos y Evolución (Mat: 4)', '1', '2026-05-10 20:32:07', NULL, '1'),
(28, '4', 'Unidad 2: Análisis y Requisitos (Mat: 4)', '2', '2026-05-10 20:32:07', NULL, '1'),
(29, '4', 'Unidad 3: Diseño y Arquitectura (Mat: 4)', '3', '2026-05-10 20:32:07', NULL, '1'),
(30, '4', 'Unidad 4: Calidad y Pruebas (Mat: 4)', '4', '2026-05-10 20:32:08', NULL, '1'),
(31, '5', 'Unidad 1: Fundamentos y Evolución (Mat: 5)', '1', '2026-05-10 20:32:08', NULL, '1'),
(32, '5', 'Unidad 2: Análisis y Requisitos (Mat: 5)', '2', '2026-05-10 20:32:08', NULL, '1'),
(33, '5', 'Unidad 3: Diseño y Arquitectura (Mat: 5)', '3', '2026-05-10 20:32:08', NULL, '1'),
(34, '5', 'Unidad 4: Calidad y Pruebas (Mat: 5)', '4', '2026-05-10 20:32:08', NULL, '1'),
(35, '6', 'Unidad 1: Fundamentos y Evolución (Mat: 6)', '1', '2026-05-10 20:32:10', NULL, '1'),
(36, '6', 'Unidad 2: Análisis y Requisitos (Mat: 6)', '2', '2026-05-10 20:32:15', NULL, '1'),
(37, '6', 'Unidad 3: Diseño y Arquitectura (Mat: 6)', '3', '2026-05-10 20:32:20', NULL, '1'),
(38, '6', 'Unidad 4: Calidad y Pruebas (Mat: 6)', '4', '2026-05-10 20:32:21', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_evaluacion`
--

CREATE TABLE `tipo_evaluacion` (
  `id_tipo_evaluacion` int(11) NOT NULL,
  `nombre_tipo_evaluacion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_evaluacion`
--

INSERT INTO `tipo_evaluacion` (`id_tipo_evaluacion`, `nombre_tipo_evaluacion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Evaluación Diagnóstica', '2026-04-27 20:47:16', NULL, '1'),
(2, 'Evaluación Formativa', '2026-04-27 20:47:16', NULL, '1'),
(3, 'Evaluación Sumativa', '2026-04-27 20:47:16', NULL, '1'),
(4, 'Autoevaluación', '2026-04-27 20:47:16', NULL, '1'),
(5, 'Cooevaluación', '2026-04-27 20:47:16', NULL, '1'),
(6, 'Heteroevaluación', '2026-04-27 20:47:16', NULL, '1'),
(7, 'Evaluación Continua', '2026-04-27 20:47:16', NULL, '1'),
(8, 'Evaluación por Competencias', '2026-04-27 20:50:40', NULL, '1'),
(9, 'Evaluación de Desempeño', '2026-04-27 20:50:40', NULL, '1'),
(10, 'Evaluación Basada en Hitos', '2026-04-27 20:50:40', NULL, '1'),
(11, 'Evaluación Cualitativa', '2026-04-27 20:50:40', NULL, '1'),
(12, 'Evaluación Cuantitativa', '2026-04-27 20:50:40', NULL, '1'),
(13, 'Coevaluación', '2026-05-10 20:13:43', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_corte`
--

CREATE TABLE `unidad_corte` (
  `id_unidad_corte` int(11) NOT NULL,
  `id_planificacion` int(11) DEFAULT NULL,
  `numero_unidad_corte` enum('1','2','3','4') DEFAULT NULL,
  `indicador_logro_unidad_corte` text DEFAULT NULL,
  `descripcion_actividad_unidad_corte` text DEFAULT NULL,
  `descripcion_motivo_rechazo_unidad_corte` text DEFAULT NULL,
  `id_tecnica_actividad` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3','4','5') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidad_corte`
--

INSERT INTO `unidad_corte` (`id_unidad_corte`, `id_planificacion`, `numero_unidad_corte`, `indicador_logro_unidad_corte`, `descripcion_actividad_unidad_corte`, `descripcion_motivo_rechazo_unidad_corte`, `id_tecnica_actividad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, '1', 'sefsfgsrgdrgegefefr', 'sefsefsefsefsefsef', NULL, 8, '2026-05-03 20:31:41', '2026-05-03 20:35:45', '1'),
(2, 1, '2', 'sedrfgadfgfgsgaergerg', 'serfeargaegaerfgaergaerg', NULL, 8, '2026-05-03 20:31:41', '2026-05-03 20:35:49', '1'),
(3, 1, '3', 'aedrsgaegargaegaerg', 'egraergsrfgsthfgrfg', NULL, 8, '2026-05-03 20:31:41', '2026-05-03 20:35:53', '1'),
(4, 1, '4', 'aergasdgsgasgaeg', 'ergsdgsgsedrgaerg', NULL, 8, '2026-05-03 20:31:41', '2026-05-03 20:35:56', '1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bibliografia`
--
ALTER TABLE `bibliografia`
  ADD PRIMARY KEY (`id_bibliografia`);

--
-- Indices de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`id_bitacora`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD PRIMARY KEY (`id_calendario_academico`);

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id_contenido`);

--
-- Indices de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD PRIMARY KEY (`id_detalle_bibliografia`),
  ADD KEY `fk_detbibliografia_unidadcorte` (`id_unidad_corte`),
  ADD KEY `fk_detbibliografia_bibliografia` (`id_bibliografia`);

--
-- Indices de la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  ADD PRIMARY KEY (`id_detalle_contenido`),
  ADD KEY `fk_detcontenido_unidadcorte` (`id_unidad_corte`),
  ADD KEY `fk_detcontenido_contenido` (`id_contenido`);

--
-- Indices de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD PRIMARY KEY (`id_detalle_evaluacion`),
  ADD KEY `fk_deteval_tipoeval` (`id_tipo_evaluacion`),
  ADD KEY `fk_deteval_tecnicaeval` (`id_tecnica_evaluacion`),
  ADD KEY `fk_deteval_instrumento` (`id_instrumento`),
  ADD KEY `fk_deteval_unidadcorte` (`id_unidad_corte`);

--
-- Indices de la tabla `detalle_objetivo`
--
ALTER TABLE `detalle_objetivo`
  ADD PRIMARY KEY (`id_detalle_objetivo`),
  ADD KEY `fk_detobjetivo_contenido` (`id_contenido`),
  ADD KEY `fk_detobjetivo_objetivo` (`id_objetivo`);

--
-- Indices de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  ADD PRIMARY KEY (`id_detalle_recurso`),
  ADD KEY `fk_detrecurso_recurso` (`id_recurso`),
  ADD KEY `fk_detrecurso_unidadcorte` (`id_unidad_corte`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `fk_evento_calendario` (`id_calendario`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `instrumento`
--
ALTER TABLE `instrumento`
  ADD PRIMARY KEY (`id_instrumento`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  ADD PRIMARY KEY (`id_objetivo`),
  ADD KEY `fk_objetivo_temaunidad` (`id_tema_unidad`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  ADD PRIMARY KEY (`id_planificacion`);

--
-- Indices de la tabla `recurso`
--
ALTER TABLE `recurso`
  ADD PRIMARY KEY (`id_recurso`);

--
-- Indices de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD PRIMARY KEY (`id_rol_permiso`),
  ADD KEY `fk_rolpermiso_permiso` (`id_permiso`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `tecnica_actividad`
--
ALTER TABLE `tecnica_actividad`
  ADD PRIMARY KEY (`id_tecnica_actividad`);

--
-- Indices de la tabla `tecnica_evaluacion`
--
ALTER TABLE `tecnica_evaluacion`
  ADD PRIMARY KEY (`id_tecnica_evaluacion`);

--
-- Indices de la tabla `tema_unidad`
--
ALTER TABLE `tema_unidad`
  ADD PRIMARY KEY (`id_tema_unidad`);

--
-- Indices de la tabla `tipo_evaluacion`
--
ALTER TABLE `tipo_evaluacion`
  ADD PRIMARY KEY (`id_tipo_evaluacion`);

--
-- Indices de la tabla `unidad_corte`
--
ALTER TABLE `unidad_corte`
  ADD PRIMARY KEY (`id_unidad_corte`),
  ADD KEY `fk_unidadcorte_planificacion` (`id_planificacion`),
  ADD KEY `fk_unidadcorte_tecnicaactividad` (`id_tecnica_actividad`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bibliografia`
--
ALTER TABLE `bibliografia`
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=523;

--
-- AUTO_INCREMENT de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  MODIFY `id_calendario_academico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id_contenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  MODIFY `id_detalle_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  MODIFY `id_detalle_contenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  MODIFY `id_detalle_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_objetivo`
--
ALTER TABLE `detalle_objetivo`
  MODIFY `id_detalle_objetivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  MODIFY `id_detalle_recurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `instrumento`
--
ALTER TABLE `instrumento`
  MODIFY `id_instrumento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  MODIFY `id_objetivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  MODIFY `id_planificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  MODIFY `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=453;

--
-- AUTO_INCREMENT de la tabla `tecnica_actividad`
--
ALTER TABLE `tecnica_actividad`
  MODIFY `id_tecnica_actividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `tecnica_evaluacion`
--
ALTER TABLE `tecnica_evaluacion`
  MODIFY `id_tecnica_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `tema_unidad`
--
ALTER TABLE `tema_unidad`
  MODIFY `id_tema_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `tipo_evaluacion`
--
ALTER TABLE `tipo_evaluacion`
  MODIFY `id_tipo_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `unidad_corte`
--
ALTER TABLE `unidad_corte`
  MODIFY `id_unidad_corte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD CONSTRAINT `fk_detbibliografia_bibliografia` FOREIGN KEY (`id_bibliografia`) REFERENCES `bibliografia` (`id_bibliografia`),
  ADD CONSTRAINT `fk_detbibliografia_unidadcorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  ADD CONSTRAINT `fk_detcontenido_contenido` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`),
  ADD CONSTRAINT `fk_detcontenido_unidadcorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD CONSTRAINT `fk_deteval_instrumento` FOREIGN KEY (`id_instrumento`) REFERENCES `instrumento` (`id_instrumento`),
  ADD CONSTRAINT `fk_deteval_tecnicaeval` FOREIGN KEY (`id_tecnica_evaluacion`) REFERENCES `tecnica_evaluacion` (`id_tecnica_evaluacion`),
  ADD CONSTRAINT `fk_deteval_tipoeval` FOREIGN KEY (`id_tipo_evaluacion`) REFERENCES `tipo_evaluacion` (`id_tipo_evaluacion`),
  ADD CONSTRAINT `fk_deteval_unidadcorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `detalle_objetivo`
--
ALTER TABLE `detalle_objetivo`
  ADD CONSTRAINT `fk_detobjetivo_contenido` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`),
  ADD CONSTRAINT `fk_detobjetivo_objetivo` FOREIGN KEY (`id_objetivo`) REFERENCES `objetivo` (`id_objetivo`);

--
-- Filtros para la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  ADD CONSTRAINT `fk_detrecurso_recurso` FOREIGN KEY (`id_recurso`) REFERENCES `recurso` (`id_recurso`),
  ADD CONSTRAINT `fk_detrecurso_unidadcorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
  ADD CONSTRAINT `fk_evento_calendario` FOREIGN KEY (`id_calendario`) REFERENCES `calendario_academico` (`id_calendario_academico`);

--
-- Filtros para la tabla `objetivo`
--
ALTER TABLE `objetivo`
  ADD CONSTRAINT `fk_objetivo_temaunidad` FOREIGN KEY (`id_tema_unidad`) REFERENCES `tema_unidad` (`id_tema_unidad`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `fk_rolpermiso_permiso` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`);

--
-- Filtros para la tabla `unidad_corte`
--
ALTER TABLE `unidad_corte`
  ADD CONSTRAINT `fk_unidadcorte_planificacion` FOREIGN KEY (`id_planificacion`) REFERENCES `planificacion` (`id_planificacion`),
  ADD CONSTRAINT `fk_unidadcorte_tecnicaactividad` FOREIGN KEY (`id_tecnica_actividad`) REFERENCES `tecnica_actividad` (`id_tecnica_actividad`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
