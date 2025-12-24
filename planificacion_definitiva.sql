-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2025 a las 02:57:09
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `planificacion_definitiva`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliografias`
--

CREATE TABLE `bibliografias` (
  `bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `bibliografia` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `bibliografias`
--

INSERT INTO `bibliografias` (`bibliografia_id`, `bibliografia`, `fecha_creacion`, `estatus`) VALUES
(1, 'una bibliografía completa', '2025-06-25 01:19:03', '1'),
(2, 'otra bibliografía completa', '2025-06-25 01:19:09', '1'),
(3, 'nueva', '2025-06-25 02:17:13', '1'),
(4, 'nueva bibliografia', '2025-06-25 02:17:26', '1'),
(5, 'bibliografías de base de datos 1', '2025-06-25 14:29:38', '1'),
(6, 'bibliografia extensa de base de datos', '2025-06-25 14:29:47', '1'),
(7, 'bibliografia específica', '2025-06-25 14:29:58', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenidos`
--

CREATE TABLE `contenidos` (
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidad_codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenidos`
--

INSERT INTO `contenidos` (`contenido_id`, `titulo`, `descripcion`, `unidad_codigo`, `fecha_creacion`, `estatus`) VALUES
(1, '¿Que es una red?', 'Este contenido engloba el que es una red, porque existen y los medios por los que se puede transmitir', 'RCT226', '2025-06-24 14:06:39', '1'),
(2, 'Protocolos de Internet', 'Este contenido es para detallar los protocolos de internet', 'RCT226', '2025-06-24 14:06:39', '1'),
(3, 'Modelo E/R', 'Descripción del modelo E/R', 'BDD736', '2025-06-24 15:01:17', '1'),
(4, 'Lenguaje SQL', 'Descripción del lenguaje SQL', 'BDD736', '2025-06-24 15:01:17', '1'),
(5, 'Modelo OSI', 'Descripción del modelo OSI', 'RCT226', '2025-06-24 17:48:46', '1'),
(6, 'VLAN', 'Descripción de la VLAN', 'RCT226', '2025-06-24 17:48:46', '1'),
(7, 'Consultas en base de datos', 'Las consultas en base de datos son importantes', 'BDD736', '2025-06-25 14:14:50', '1'),
(8, 'Normalización', 'Las Formas normales', 'BDD736', '2025-06-25 14:14:50', '1'),
(9, 'Historia de las bases de datos', 'descripción de la historia de las bases de datos', 'BDD736', '2025-06-25 14:14:50', '1'),
(10, 'Sistemas gestores de base de datos', 'explicación de los sistemas gestores de base de datos', 'BDD736', '2025-06-25 14:14:50', '1'),
(11, 'Tipos de datos en SQL', 'explicación de los tipos de datos', 'BDD736', '2025-06-25 14:14:50', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_indicadores`
--

CREATE TABLE `contenido_indicadores` (
  `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL,
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `indicador_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenido_indicadores`
--

INSERT INTO `contenido_indicadores` (`contenido_indicador_id`, `contenido_id`, `indicador_id`, `fecha_creacion`, `estatus`) VALUES
(5, 1, 2, '2025-06-25 02:26:39', '2'),
(6, 5, 1, '2025-06-25 02:26:40', '2'),
(7, 2, 3, '2025-06-25 02:26:40', '2'),
(8, 6, 4, '2025-06-25 02:26:40', '2'),
(9, 1, 2, '2025-06-25 11:29:22', '2'),
(10, 5, 1, '2025-06-25 11:29:23', '2'),
(11, 2, 3, '2025-06-25 11:29:23', '2'),
(12, 6, 4, '2025-06-25 11:29:24', '2'),
(13, 1, 2, '2025-06-25 11:40:18', '2'),
(14, 5, 1, '2025-06-25 11:40:18', '2'),
(15, 2, 3, '2025-06-25 11:40:19', '2'),
(16, 6, 4, '2025-06-25 11:40:19', '2'),
(17, 1, 2, '2025-06-25 11:43:48', '2'),
(18, 5, 1, '2025-06-25 11:43:49', '2'),
(19, 2, 3, '2025-06-25 11:43:49', '2'),
(20, 6, 4, '2025-06-25 11:43:50', '2'),
(21, 3, 5, '2025-06-25 14:34:11', '2'),
(22, 3, 6, '2025-06-25 14:34:12', '2'),
(23, 7, 7, '2025-06-25 14:34:12', '2'),
(24, 8, 3, '2025-06-25 14:34:12', '2'),
(25, 8, 1, '2025-06-25 14:34:12', '2'),
(26, 11, 4, '2025-06-25 14:34:12', '2'),
(27, 7, 7, '2025-06-25 14:42:15', '2'),
(28, 7, 2, '2025-06-25 14:42:15', '2'),
(29, 9, 1, '2025-06-25 14:42:15', '2'),
(30, 3, 5, '2025-06-25 14:42:16', '2'),
(31, 11, 4, '2025-06-25 14:42:16', '2'),
(32, 8, 6, '2025-06-25 14:42:16', '2'),
(33, 10, 3, '2025-06-25 14:42:16', '2'),
(34, 8, 6, '2025-06-25 20:18:21', '2'),
(35, 4, 4, '2025-06-25 20:18:21', '2'),
(36, 7, 5, '2025-06-25 20:18:22', '2'),
(37, 11, 3, '2025-06-25 20:18:22', '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_actividad`
--

CREATE TABLE `detalle_actividad` (
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `corte` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_actividad`
--

INSERT INTO `detalle_actividad` (`detalle_id`, `corte`, `fecha_creacion`, `estatus`) VALUES
(9, '1', '2025-06-25 02:26:39', '1'),
(10, '2', '2025-06-25 02:26:40', '1'),
(11, '3', '2025-06-25 02:26:40', '1'),
(12, '4', '2025-06-25 02:26:40', '1'),
(13, '1', '2025-06-25 11:29:22', '1'),
(14, '2', '2025-06-25 11:29:23', '1'),
(15, '3', '2025-06-25 11:29:23', '1'),
(16, '4', '2025-06-25 11:29:23', '1'),
(17, '1', '2025-06-25 11:40:18', '1'),
(18, '2', '2025-06-25 11:40:18', '1'),
(19, '3', '2025-06-25 11:40:18', '1'),
(20, '4', '2025-06-25 11:40:19', '1'),
(21, '1', '2025-06-26 00:45:53', '1'),
(22, '2', '2025-06-25 11:43:48', '1'),
(23, '3', '2025-06-25 11:43:49', '1'),
(24, '4', '2025-06-25 11:43:49', '1'),
(25, '1', '2025-06-26 00:38:30', '1'),
(26, '2', '2025-06-26 00:38:30', '1'),
(27, '3', '2025-06-25 14:34:12', '1'),
(28, '4', '2025-06-26 00:38:30', '1'),
(29, '1', '2025-06-25 23:56:43', '1'),
(30, '2', '2025-06-25 14:42:15', '1'),
(31, '3', '2025-06-25 14:42:16', '1'),
(32, '4', '2025-06-25 14:42:16', '1'),
(33, '1', '2025-06-25 20:18:21', '1'),
(34, '2', '2025-06-25 20:18:21', '1'),
(35, '3', '2025-06-25 20:18:21', '1'),
(36, '4', '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_bibliografia`
--

CREATE TABLE `detalle_bibliografia` (
  `detalle_bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_bibliografia`
--

INSERT INTO `detalle_bibliografia` (`detalle_bibliografia_id`, `planificacion_id`, `bibliografia_id`, `fecha_creacion`, `estatus`) VALUES
(1, 10, 2, '2025-06-25 02:26:40', '1'),
(2, 10, 1, '2025-06-25 02:26:40', '1'),
(3, 10, 3, '2025-06-25 02:26:40', '1'),
(4, 10, 4, '2025-06-25 02:26:40', '1'),
(5, 10, 2, '2025-06-25 02:26:40', '1'),
(6, 10, 1, '2025-06-25 02:26:40', '1'),
(7, 10, 3, '2025-06-25 02:26:40', '1'),
(8, 10, 4, '2025-06-25 02:26:40', '1'),
(9, 10, 2, '2025-06-25 02:26:40', '1'),
(10, 10, 1, '2025-06-25 02:26:40', '1'),
(11, 10, 3, '2025-06-25 02:26:40', '1'),
(12, 10, 4, '2025-06-25 02:26:40', '1'),
(13, 10, 2, '2025-06-25 02:26:40', '1'),
(14, 10, 1, '2025-06-25 02:26:41', '1'),
(15, 10, 3, '2025-06-25 02:26:41', '1'),
(16, 10, 4, '2025-06-25 02:26:41', '1'),
(17, 11, 3, '2025-06-25 11:29:24', '1'),
(18, 11, 1, '2025-06-25 11:29:24', '1'),
(19, 11, 2, '2025-06-25 11:29:24', '1'),
(20, 12, 3, '2025-06-25 11:40:19', '1'),
(21, 12, 4, '2025-06-25 11:40:19', '1'),
(22, 12, 2, '2025-06-25 11:40:19', '1'),
(23, 13, 2, '2025-06-25 11:43:50', '1'),
(24, 13, 1, '2025-06-25 11:43:50', '1'),
(25, 14, 7, '2025-06-25 14:34:12', '1'),
(26, 14, 5, '2025-06-25 14:34:12', '1'),
(27, 14, 6, '2025-06-25 14:34:12', '1'),
(28, 15, 2, '2025-06-25 14:42:16', '1'),
(29, 15, 6, '2025-06-25 14:42:16', '1'),
(30, 15, 3, '2025-06-25 14:42:16', '1'),
(31, 16, 7, '2025-06-25 20:18:22', '1'),
(32, 16, 5, '2025-06-25 20:18:22', '1'),
(33, 16, 6, '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_contenidos`
--

CREATE TABLE `detalle_contenidos` (
  `detalle_contenido_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_contenidos`
--

INSERT INTO `detalle_contenidos` (`detalle_contenido_id`, `detalle_id`, `contenido_id`, `fecha_creacion`, `estatus`) VALUES
(8, 9, 1, '2025-06-25 02:26:39', '1'),
(9, 10, 5, '2025-06-25 02:26:40', '1'),
(10, 11, 2, '2025-06-25 02:26:40', '1'),
(11, 12, 6, '2025-06-25 02:26:40', '1'),
(12, 13, 1, '2025-06-25 11:29:22', '1'),
(13, 14, 5, '2025-06-25 11:29:23', '1'),
(14, 15, 2, '2025-06-25 11:29:23', '1'),
(15, 16, 6, '2025-06-25 11:29:24', '1'),
(16, 17, 1, '2025-06-25 11:40:18', '1'),
(17, 18, 5, '2025-06-25 11:40:18', '1'),
(18, 19, 2, '2025-06-25 11:40:19', '1'),
(19, 20, 6, '2025-06-25 11:40:19', '1'),
(20, 21, 1, '2025-06-25 11:43:48', '1'),
(21, 22, 5, '2025-06-25 11:43:49', '1'),
(22, 23, 2, '2025-06-25 11:43:49', '1'),
(23, 24, 6, '2025-06-25 11:43:49', '1'),
(24, 25, 3, '2025-06-25 14:34:11', '1'),
(25, 26, 7, '2025-06-25 14:34:12', '1'),
(26, 27, 8, '2025-06-25 14:34:12', '1'),
(27, 28, 11, '2025-06-25 14:34:12', '1'),
(28, 29, 7, '2025-06-25 14:42:15', '1'),
(29, 29, 9, '2025-06-25 14:42:15', '1'),
(30, 30, 3, '2025-06-25 14:42:15', '1'),
(31, 30, 11, '2025-06-25 14:42:16', '1'),
(32, 31, 8, '2025-06-25 14:42:16', '1'),
(33, 32, 10, '2025-06-25 14:42:16', '1'),
(34, 33, 8, '2025-06-25 20:18:21', '1'),
(35, 34, 4, '2025-06-25 20:18:21', '1'),
(36, 35, 7, '2025-06-25 20:18:22', '1'),
(37, 36, 11, '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_estrategias`
--

CREATE TABLE `detalle_estrategias` (
  `detalle_estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_estrategias`
--

INSERT INTO `detalle_estrategias` (`detalle_estrategia_id`, `detalle_id`, `estrategia_id`, `fecha_creacion`, `estatus`) VALUES
(8, 9, 2, '2025-06-25 02:26:39', '1'),
(9, 10, 1, '2025-06-25 02:26:40', '1'),
(10, 10, 3, '2025-06-25 02:26:40', '1'),
(11, 11, 3, '2025-06-25 02:26:40', '1'),
(12, 11, 1, '2025-06-25 02:26:40', '1'),
(13, 11, 2, '2025-06-25 02:26:40', '1'),
(14, 12, 2, '2025-06-25 02:26:40', '1'),
(15, 12, 3, '2025-06-25 02:26:40', '1'),
(16, 13, 3, '2025-06-25 11:29:22', '1'),
(17, 14, 1, '2025-06-25 11:29:23', '1'),
(18, 15, 3, '2025-06-25 11:29:23', '1'),
(19, 16, 2, '2025-06-25 11:29:24', '1'),
(20, 17, 3, '2025-06-25 11:40:18', '1'),
(21, 18, 3, '2025-06-25 11:40:18', '1'),
(22, 19, 3, '2025-06-25 11:40:18', '1'),
(23, 20, 2, '2025-06-25 11:40:19', '1'),
(24, 21, 3, '2025-06-25 11:43:48', '1'),
(25, 22, 1, '2025-06-25 11:43:49', '1'),
(26, 23, 2, '2025-06-25 11:43:49', '1'),
(27, 24, 1, '2025-06-25 11:43:49', '1'),
(28, 25, 4, '2025-06-25 14:34:11', '1'),
(29, 26, 5, '2025-06-25 14:34:12', '1'),
(30, 27, 3, '2025-06-25 14:34:12', '1'),
(31, 28, 3, '2025-06-25 14:34:12', '1'),
(32, 29, 1, '2025-06-25 14:42:15', '1'),
(33, 30, 4, '2025-06-25 14:42:15', '1'),
(34, 31, 4, '2025-06-25 14:42:16', '1'),
(35, 32, 1, '2025-06-25 14:42:16', '1'),
(36, 33, 5, '2025-06-25 20:18:21', '1'),
(37, 34, 1, '2025-06-25 20:18:21', '1'),
(38, 35, 5, '2025-06-25 20:18:22', '1'),
(39, 36, 1, '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evaluacion`
--

CREATE TABLE `detalle_evaluacion` (
  `detalle_evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica_id` bigint(20) UNSIGNED NOT NULL,
  `ponderacion` double NOT NULL,
  `fecha_evaluacion` date NOT NULL,
  `forma_participacion` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_evaluacion`
--

INSERT INTO `detalle_evaluacion` (`detalle_evaluacion_id`, `evaluacion_id`, `detalle_id`, `tecnica_id`, `ponderacion`, `fecha_evaluacion`, `forma_participacion`, `fecha_creacion`, `estatus`) VALUES
(2, 1, 9, 1, 25, '2025-08-12', '1', '2025-06-25 02:26:40', '1'),
(3, 2, 10, 1, 25, '2025-09-12', '2', '2025-06-25 02:26:40', '1'),
(4, 3, 11, 3, 10, '2025-10-26', '2', '2025-06-25 02:26:40', '1'),
(5, 2, 11, 2, 15, '2025-10-10', '3', '2025-06-25 02:26:40', '1'),
(6, 1, 12, 1, 25, '2025-11-11', '1', '2025-06-25 02:26:40', '1'),
(7, 1, 13, 1, 25, '2025-10-10', '2', '2025-06-25 11:29:22', '1'),
(8, 2, 14, 2, 25, '2025-10-26', '3', '2025-06-25 11:29:23', '1'),
(9, 1, 15, 1, 25, '2025-11-04', '1', '2025-06-25 11:29:23', '1'),
(10, 3, 16, 3, 25, '2025-11-15', '2', '2025-06-25 11:29:24', '1'),
(11, 3, 17, 3, 25, '2025-11-10', '1', '2025-06-25 11:40:18', '1'),
(12, 2, 18, 2, 25, '2025-11-10', '3', '2025-06-25 11:40:18', '1'),
(13, 1, 19, 1, 25, '2025-11-30', '1', '2025-06-25 11:40:19', '1'),
(14, 2, 20, 2, 25, '2025-12-10', '3', '2025-06-25 11:40:19', '1'),
(15, 1, 21, 2, 25, '2025-10-11', '2', '2025-06-25 11:43:48', '1'),
(16, 2, 22, 2, 25, '2025-10-20', '3', '2025-06-25 11:43:49', '1'),
(17, 3, 23, 1, 25, '2025-11-10', '2', '2025-06-25 11:43:49', '1'),
(18, 3, 24, 3, 25, '2025-11-20', '2', '2025-06-25 11:43:50', '1'),
(19, 4, 25, 4, 25, '2025-10-10', '3', '2025-06-25 14:34:12', '1'),
(20, 5, 26, 5, 10, '2025-10-25', '2', '2025-06-25 14:34:12', '1'),
(21, 5, 26, 6, 15, '2025-11-02', '1', '2025-06-25 14:34:12', '1'),
(22, 3, 27, 3, 25, '2025-11-11', '2', '2025-06-25 14:34:12', '1'),
(23, 6, 28, 6, 25, '2025-11-30', '2', '2025-06-25 14:34:12', '1'),
(24, 3, 29, 1, 25, '2025-10-10', '2', '2025-06-25 14:42:15', '1'),
(25, 5, 30, 1, 25, '2025-10-15', '1', '2025-06-25 14:42:16', '1'),
(26, 3, 31, 3, 25, '2025-11-02', '2', '2025-06-25 14:42:16', '1'),
(27, 4, 32, 1, 25, '2025-11-20', '2', '2025-06-25 14:42:16', '1'),
(28, 3, 33, 3, 25, '2025-09-10', '2', '2025-06-25 20:18:21', '1'),
(29, 2, 34, 2, 25, '2025-09-20', '3', '2025-06-25 20:18:21', '1'),
(30, 4, 35, 4, 25, '2025-09-27', '3', '2025-06-25 20:18:22', '1'),
(31, 3, 36, 3, 15, '2025-11-10', '2', '2025-06-25 20:18:22', '1'),
(32, 2, 36, 2, 10, '2025-11-15', '3', '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_planificacion`
--

CREATE TABLE `detalle_planificacion` (
  `detalle_planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_planificacion`
--

INSERT INTO `detalle_planificacion` (`detalle_planificacion_id`, `planificacion_id`, `detalle_id`, `fecha_creacion`, `estatus`) VALUES
(9, 10, 9, '2025-06-25 02:26:39', '1'),
(10, 10, 10, '2025-06-25 02:26:40', '1'),
(11, 10, 11, '2025-06-25 02:26:40', '1'),
(12, 10, 12, '2025-06-25 02:26:40', '1'),
(13, 11, 13, '2025-06-25 11:29:22', '1'),
(14, 11, 14, '2025-06-25 11:29:23', '1'),
(15, 11, 15, '2025-06-25 11:29:23', '1'),
(16, 11, 16, '2025-06-25 11:29:24', '1'),
(17, 12, 17, '2025-06-25 11:40:18', '1'),
(18, 12, 18, '2025-06-25 11:40:18', '1'),
(19, 12, 19, '2025-06-25 11:40:18', '1'),
(20, 12, 20, '2025-06-25 11:40:19', '1'),
(21, 13, 21, '2025-06-25 11:43:48', '1'),
(22, 13, 22, '2025-06-25 11:43:48', '1'),
(23, 13, 23, '2025-06-25 11:43:49', '1'),
(24, 13, 24, '2025-06-25 11:43:49', '1'),
(25, 14, 25, '2025-06-25 14:34:11', '1'),
(26, 14, 26, '2025-06-25 14:34:12', '1'),
(27, 14, 27, '2025-06-25 14:34:12', '1'),
(28, 14, 28, '2025-06-25 14:34:12', '1'),
(29, 15, 29, '2025-06-25 14:42:15', '1'),
(30, 15, 30, '2025-06-25 14:42:15', '1'),
(31, 15, 31, '2025-06-25 14:42:16', '1'),
(32, 15, 32, '2025-06-25 14:42:16', '1'),
(33, 16, 33, '2025-06-25 20:18:21', '1'),
(34, 16, 34, '2025-06-25 20:18:21', '1'),
(35, 16, 35, '2025-06-25 20:18:21', '1'),
(36, 16, 36, '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_recursos`
--

CREATE TABLE `detalle_recursos` (
  `detalle_recurso_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_recursos`
--

INSERT INTO `detalle_recursos` (`detalle_recurso_id`, `detalle_id`, `recurso_id`, `fecha_creacion`, `estatus`) VALUES
(22, 9, 5, '2025-06-25 02:26:39', '1'),
(23, 9, 4, '2025-06-25 02:26:39', '1'),
(24, 9, 6, '2025-06-25 02:26:39', '1'),
(25, 10, 6, '2025-06-25 02:26:40', '1'),
(26, 10, 4, '2025-06-25 02:26:40', '1'),
(27, 10, 3, '2025-06-25 02:26:40', '1'),
(28, 11, 4, '2025-06-25 02:26:40', '1'),
(29, 11, 2, '2025-06-25 02:26:40', '1'),
(30, 11, 1, '2025-06-25 02:26:40', '1'),
(31, 12, 6, '2025-06-25 02:26:40', '1'),
(32, 12, 1, '2025-06-25 02:26:40', '1'),
(33, 12, 3, '2025-06-25 02:26:40', '1'),
(34, 13, 3, '2025-06-25 11:29:22', '1'),
(35, 14, 1, '2025-06-25 11:29:23', '1'),
(36, 14, 2, '2025-06-25 11:29:23', '1'),
(37, 15, 1, '2025-06-25 11:29:23', '1'),
(38, 16, 3, '2025-06-25 11:29:24', '1'),
(39, 16, 1, '2025-06-25 11:29:24', '1'),
(40, 17, 5, '2025-06-25 11:40:18', '1'),
(41, 18, 2, '2025-06-25 11:40:18', '1'),
(42, 19, 3, '2025-06-25 11:40:18', '1'),
(43, 20, 6, '2025-06-25 11:40:19', '1'),
(44, 21, 3, '2025-06-25 11:43:48', '1'),
(45, 22, 5, '2025-06-25 11:43:49', '1'),
(46, 23, 3, '2025-06-25 11:43:49', '1'),
(47, 24, 2, '2025-06-25 11:43:49', '1'),
(48, 25, 8, '2025-06-25 14:34:11', '1'),
(49, 25, 7, '2025-06-25 14:34:11', '1'),
(50, 25, 1, '2025-06-25 14:34:11', '1'),
(51, 25, 3, '2025-06-25 14:34:11', '1'),
(52, 26, 8, '2025-06-25 14:34:12', '1'),
(53, 27, 5, '2025-06-25 14:34:12', '1'),
(54, 27, 3, '2025-06-25 14:34:12', '1'),
(55, 27, 1, '2025-06-25 14:34:12', '1'),
(56, 28, 8, '2025-06-25 14:34:12', '1'),
(57, 28, 2, '2025-06-25 14:34:12', '1'),
(58, 28, 7, '2025-06-25 14:34:12', '1'),
(59, 28, 3, '2025-06-25 14:34:12', '1'),
(60, 29, 8, '2025-06-25 14:42:15', '1'),
(61, 30, 3, '2025-06-25 14:42:15', '1'),
(62, 31, 7, '2025-06-25 14:42:16', '1'),
(63, 32, 5, '2025-06-25 14:42:16', '1'),
(64, 33, 6, '2025-06-25 20:18:21', '1'),
(65, 33, 2, '2025-06-25 20:18:21', '1'),
(66, 33, 7, '2025-06-25 20:18:21', '1'),
(67, 34, 8, '2025-06-25 20:18:21', '1'),
(68, 34, 9, '2025-06-25 20:18:21', '1'),
(69, 35, 6, '2025-06-25 20:18:22', '1'),
(70, 36, 6, '2025-06-25 20:18:22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrategias_pedagogicas`
--

CREATE TABLE `estrategias_pedagogicas` (
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `estrategia` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `estrategias_pedagogicas`
--

INSERT INTO `estrategias_pedagogicas` (`estrategia_id`, `estrategia`, `fecha_creacion`, `estatus`) VALUES
(1, 'Debate', '2025-06-24 15:26:39', '1'),
(2, 'Lluvia de ideas', '2025-06-24 16:57:20', '1'),
(3, 'a estrategia con a', '2025-06-25 02:13:07', '1'),
(4, 'Ayudar a los estudiantes a manejar las relaciones fomentando la lógica relacional', '2025-06-25 14:18:18', '1'),
(5, 'En base a sus modelos de base de datos anteriormente creados ellos aplicarán la lógica de las consultas', '2025-06-25 14:22:36', '1'),
(6, 'nueva estrategia de pruebas', '2025-06-25 17:54:44', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `evaluaciones`
--

INSERT INTO `evaluaciones` (`evaluacion_id`, `evaluacion`, `fecha_creacion`, `estatus`) VALUES
(1, 'Examen escrito', '2025-06-24 15:23:59', '1'),
(2, 'Exposición', '2025-06-24 15:25:47', '1'),
(3, 'taller escrito', '2025-06-25 02:15:14', '1'),
(4, 'Modelar una base de datos', '2025-06-25 14:18:50', '1'),
(5, 'Crear, editar, buscar y eliminar dentro de la base de datos', '2025-06-25 14:23:26', '1'),
(6, 'examen Práctico con el sistema gestor de base de datos', '2025-06-25 14:26:50', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicadores_logros`
--

CREATE TABLE `indicadores_logros` (
  `indicador_id` bigint(20) UNSIGNED NOT NULL,
  `indicador` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `indicadores_logros`
--

INSERT INTO `indicadores_logros` (`indicador_id`, `indicador`, `fecha_creacion`, `estatus`) VALUES
(1, 'el estudiante logra...', '2025-06-24 16:37:37', '1'),
(2, 'el estudiante es capaz...', '2025-06-24 16:56:57', '1'),
(3, 'los estudiantes', '2025-06-24 17:10:39', '1'),
(4, 'nuevo indicadore', '2025-06-25 02:14:35', '1'),
(5, 'El estudiantes es capaz de hacer un modelo entidad relación lógico que no tenga muchos bucles en relaciones', '2025-06-25 14:15:56', '1'),
(6, 'Modelar correctamente el esquema de la base de datos de su proyecto', '2025-06-25 14:16:57', '1'),
(7, 'El estudiante logra hacer consultas en base de datos correcta insertando, actualizando, buscando y eliminando', '2025-06-25 14:21:49', '1'),
(8, 'actualizaci', '2025-06-25 17:05:48', '1'),
(9, 'actualizacion para otro nuevo indicador', '2025-06-25 17:09:18', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lapso_academico`
--

CREATE TABLE `lapso_academico` (
  `lapso_id` bigint(20) UNSIGNED NOT NULL,
  `lapso` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lapso_academico`
--

INSERT INTO `lapso_academico` (`lapso_id`, `lapso`, `fecha_inicio`, `fecha_fin`, `fecha_creacion`, `estatus`) VALUES
(1, '2025-II', '2025-08-24 00:00:00', '2025-12-24 00:00:00', '2025-06-24 14:10:12', '1'),
(2, '2025-INTENSIVO', '2025-06-30 00:00:00', '2025-08-18 00:00:00', '2025-06-24 14:11:08', '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_10_145839_create_pnfs_table', 1),
(5, '2025_05_10_150114_create_unidades_curriculares_table', 1),
(6, '2025_05_10_172931_create_lapso_academico_table', 1),
(7, '2025_05_10_173733_create_planificacion_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivos_rechazo`
--

CREATE TABLE `motivos_rechazo` (
  `motivo_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `motivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `motivos_rechazo`
--

INSERT INTO `motivos_rechazo` (`motivo_id`, `detalle_id`, `motivo`, `fecha_creacion`, `estatus`) VALUES
(1, 29, 'no me gustó', '2025-06-25 23:56:43', '2'),
(2, 25, 'otro motivo para rechazarla', '2025-06-26 00:38:30', '2'),
(3, 25, 'otro motivo para rechazarla', '2025-06-26 00:38:30', '2'),
(4, 26, 'motivo para ver si se pueden rechazar más de uno', '2025-06-26 00:38:30', '2'),
(5, 28, 'y otro más', '2025-06-26 00:38:30', '2'),
(6, 25, 'motivo sobreescrito', '2025-06-26 00:38:30', '2'),
(7, 26, 'motivo para ver si se pueden rechazar más de uno', '2025-06-26 00:38:30', '2'),
(8, 28, 'y otro más', '2025-06-26 00:38:30', '2'),
(9, 26, 'motivo para ver si se pueden rechazar más de uno', '2025-06-26 00:38:30', '2'),
(10, 28, 'y otro más', '2025-06-26 00:38:30', '2'),
(11, 21, 'no me gustó', '2025-06-26 00:45:53', '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion`
--

CREATE TABLE `planificacion` (
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `docente_id` bigint(20) UNSIGNED NOT NULL,
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `unidad_codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planificacion`
--

INSERT INTO `planificacion` (`planificacion_id`, `docente_id`, `seccion_id`, `unidad_codigo`, `fecha_creacion`, `estatus`) VALUES
(10, 1, 1, 'RCT226', '2025-06-25 02:26:39', '2'),
(11, 2, 2, 'RCT226', '2025-06-25 11:29:22', '2'),
(12, 2, 3, 'RCT226', '2025-06-25 11:40:18', '2'),
(13, 2, 4, 'RCT226', '2025-06-25 11:43:48', '1'),
(14, 1, 1, 'BDD736', '2025-06-25 14:34:11', '1'),
(15, 2, 25, 'BDD736', '2025-06-25 14:42:15', '1'),
(16, 2, 4, 'BDD736', '2025-06-25 20:18:21', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pnfs`
--

CREATE TABLE `pnfs` (
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pnfs`
--

INSERT INTO `pnfs` (`pnf_id`, `nombre`, `fecha_creacion`, `estatus`) VALUES
(1, 'Informática', '2025-06-24 13:59:53', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `recurso` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recursos`
--

INSERT INTO `recursos` (`recurso_id`, `recurso`, `fecha_creacion`, `estatus`) VALUES
(1, 'Pizarrón', '2025-06-24 15:26:30', '1'),
(2, 'VIDEO BEAM', '2025-06-24 15:35:27', '1'),
(3, 'Marcadores', '2025-06-24 15:36:54', '1'),
(4, 'Algo para duplicar', '2025-06-24 15:37:02', '1'),
(5, 'Nuevo recurso', '2025-06-24 15:37:28', '1'),
(6, 'recurso de prueba', '2025-06-24 17:18:55', '1'),
(7, 'Lapices', '2025-06-25 14:17:16', '1'),
(8, 'MySQL Workbench', '2025-06-25 14:17:26', '1'),
(9, 'recurso de pre', '2025-06-25 17:57:48', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `acceso` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `acceso`, `fecha_creacion`, `estatus`) VALUES
(1, 'Coordinador', '2025-06-24 13:47:10', '1'),
(2, 'Profesor', '2025-06-24 13:47:10', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `seccion` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lapso_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`seccion_id`, `seccion`, `lapso_id`, `fecha_creacion`, `estatus`) VALUES
(1, '331', 1, '2025-06-24 14:16:05', '1'),
(2, '336', 1, '2025-06-24 14:16:05', '1'),
(3, '431', 1, '2025-06-24 14:16:05', '1'),
(4, '436', 1, '2025-06-24 14:16:05', '1'),
(5, '031', 1, '2025-06-24 14:16:05', '1'),
(6, '036', 1, '2025-06-24 14:16:05', '1'),
(7, '131', 1, '2025-06-24 14:16:05', '1'),
(8, '136', 1, '2025-06-24 14:17:52', '1'),
(9, '231', 1, '2025-06-24 14:17:52', '1'),
(10, '236', 1, '2025-06-24 14:17:52', '1'),
(11, '531', 1, '2025-06-24 14:17:52', '1'),
(12, '536', 1, '2025-06-24 14:17:52', '1'),
(13, '631', 1, '2025-06-24 14:17:52', '1'),
(14, '636', 1, '2025-06-24 14:17:52', '1'),
(15, '731', 1, '2025-06-24 14:17:52', '1'),
(16, '736', 1, '2025-06-24 14:17:52', '1'),
(17, '831', 1, '2025-06-24 14:17:52', '1'),
(18, '836', 1, '2025-06-24 14:17:52', '1'),
(19, '031-INT', 2, '2025-06-24 14:20:55', '1'),
(20, '036-INT', 2, '2025-06-24 14:20:55', '1'),
(21, '131-INT', 2, '2025-06-24 14:20:55', '1'),
(22, '136-INT', 2, '2025-06-24 14:20:55', '1'),
(23, '231-INT', 2, '2025-06-24 14:20:55', '1'),
(24, '236-INT', 2, '2025-06-24 14:20:55', '1'),
(25, '331-INT', 2, '2025-06-24 14:20:55', '1'),
(26, '336-INT', 2, '2025-06-24 14:20:55', '1'),
(27, '431-INT', 2, '2025-06-24 14:20:55', '1'),
(28, '436-INT', 2, '2025-06-24 14:20:55', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Cadg4n6e8OKAINCKiB1nv6IMbto13sNrQz57lX68', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiS25pdlY3REVuazE5dnFNR1hEdzE4UHc4MEZOcXpxNEQ4Qm5xd3owbyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvcGxhbmlmaWNhY2lvbi9saXN0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1750895805),
('G5vgY2GEDf5RD9xJqYx7FdYxeZftDfp35lpFpatV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQm91NURiUEt6U1FvRUlqYmc2dFB1WjVDWDRRczFNc0JQWUVROG41WiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1750899346);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicas`
--

CREATE TABLE `tecnicas` (
  `tecnica_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tecnicas`
--

INSERT INTO `tecnicas` (`tecnica_id`, `tecnica`, `fecha_creacion`, `estatus`) VALUES
(1, 'un examen dividido en teoría y práctica', '2025-06-24 15:27:08', '1'),
(2, 'exposición grupal didáctica con video beam', '2025-06-24 16:59:18', '1'),
(3, 'taller escrito en parejas', '2025-06-25 02:15:43', '1'),
(4, 'En conjunto con todos sus compañeros deberán modelar sus base de dao', '2025-06-25 14:19:42', '1'),
(5, 'examen escrito sobre las consultas SQL', '2025-06-25 14:24:06', '1'),
(6, 'examen Práctico con el sistema gestor de base de datos', '2025-06-25 14:27:13', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades_curriculares`
--

CREATE TABLE `unidades_curriculares` (
  `codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `trayecto` enum('0','1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL,
  `proposito` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidades_credito` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `horas_semanales` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidades_curriculares`
--

INSERT INTO `unidades_curriculares` (`codigo`, `nombre`, `pnf_id`, `descripcion`, `trayecto`, `tipo`, `proposito`, `unidades_credito`, `horas_semanales`, `fecha_creacion`, `estatus`) VALUES
('BDD736', 'Base de datos', 1, 'Base de datos descripción indica la descripción', '2', '1', 'Indica el propósito de las bases de datos', '3', '3', '2025-06-24 15:01:17', '1'),
('RCT226', 'Redes del Computador', 1, 'Redes del computador es una unidad curricular muy extensa que es fundamental para la informática', '2', '2', 'El propósito de esta unidad curricular es...', '3', '3', '2025-06-24 14:06:39', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `cedula`, `email`, `telefono`, `theme`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Admin', 'Admin', '99999999', 'admin@example.com', '0410220020', NULL, '$2y$12$nr7A4RY67zXV2aaTD0413Oa3Ez8fCw9V85eNJrC4LyTsCpgxZYwy2', NULL, '2025-06-24 13:50:13', '1'),
(2, 'Nasser', 'Daboin', '31215545', 'nasserdaboin@gmail.com', '04127827954', NULL, '$2y$12$Dq9y6wna6KiXyM6z5t8jOeYydFInhx0GbBnOw.dngKRFdvxfzxn3m', NULL, '2025-06-25 11:21:34', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_roles`
--

CREATE TABLE `usuario_roles` (
  `usuario_rol_id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario_roles`
--

INSERT INTO `usuario_roles` (`usuario_rol_id`, `usuario_id`, `rol_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-24 13:50:38', '1'),
(2, 1, 2, '2025-06-24 13:50:38', '1'),
(3, 2, 2, '2025-06-25 11:21:34', '1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bibliografias`
--
ALTER TABLE `bibliografias`
  ADD PRIMARY KEY (`bibliografia_id`);

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
-- Indices de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD PRIMARY KEY (`contenido_id`),
  ADD KEY `contenidos_unidad_codigo_foreign` (`unidad_codigo`);

--
-- Indices de la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  ADD PRIMARY KEY (`contenido_indicador_id`),
  ADD KEY `contenido_indicadores_contenido_id_foreign` (`contenido_id`),
  ADD KEY `contenido_indicadores_indicador_id_foreign` (`indicador_id`);

--
-- Indices de la tabla `detalle_actividad`
--
ALTER TABLE `detalle_actividad`
  ADD PRIMARY KEY (`detalle_id`);

--
-- Indices de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD PRIMARY KEY (`detalle_bibliografia_id`),
  ADD KEY `detalle_bibliografia_planificacion_id_foreign` (`planificacion_id`),
  ADD KEY `detalle_bibliografia_bibliografia_id_foreign` (`bibliografia_id`);

--
-- Indices de la tabla `detalle_contenidos`
--
ALTER TABLE `detalle_contenidos`
  ADD PRIMARY KEY (`detalle_contenido_id`),
  ADD KEY `detalle_contenidos_detalle_id_foreign` (`detalle_id`),
  ADD KEY `detalle_contenidos_contenido_id_foreign` (`contenido_id`);

--
-- Indices de la tabla `detalle_estrategias`
--
ALTER TABLE `detalle_estrategias`
  ADD PRIMARY KEY (`detalle_estrategia_id`),
  ADD KEY `detalle_estrategias_detalle_id_foreign` (`detalle_id`),
  ADD KEY `detalle_estrategias_estrategia_id_foreign` (`estrategia_id`);

--
-- Indices de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD PRIMARY KEY (`detalle_evaluacion_id`),
  ADD KEY `detalle_evaluacion_evaluacion_id_foreign` (`evaluacion_id`),
  ADD KEY `detalle_evaluacion_detalle_id_foreign` (`detalle_id`),
  ADD KEY `detalle_evaluacion_tecnica_id_foreign` (`tecnica_id`);

--
-- Indices de la tabla `detalle_planificacion`
--
ALTER TABLE `detalle_planificacion`
  ADD PRIMARY KEY (`detalle_planificacion_id`),
  ADD KEY `detalle_planificacion_planificacion_id_foreign` (`planificacion_id`),
  ADD KEY `detalle_planificacion_detalle_id_foreign` (`detalle_id`);

--
-- Indices de la tabla `detalle_recursos`
--
ALTER TABLE `detalle_recursos`
  ADD PRIMARY KEY (`detalle_recurso_id`),
  ADD KEY `detalle_recursos_detalle_id_foreign` (`detalle_id`),
  ADD KEY `detalle_recursos_recurso_id_foreign` (`recurso_id`);

--
-- Indices de la tabla `estrategias_pedagogicas`
--
ALTER TABLE `estrategias_pedagogicas`
  ADD PRIMARY KEY (`estrategia_id`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`evaluacion_id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `indicadores_logros`
--
ALTER TABLE `indicadores_logros`
  ADD PRIMARY KEY (`indicador_id`);

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
-- Indices de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  ADD PRIMARY KEY (`lapso_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `motivos_rechazo`
--
ALTER TABLE `motivos_rechazo`
  ADD PRIMARY KEY (`motivo_id`),
  ADD KEY `motivos_rechazo_detalle_id_foreign` (`detalle_id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  ADD PRIMARY KEY (`planificacion_id`),
  ADD KEY `planificacion_docente_id_foreign` (`docente_id`),
  ADD KEY `planificacion_seccion_id_foreign` (`seccion_id`),
  ADD KEY `planificacion_unidad_codigo_foreign` (`unidad_codigo`);

--
-- Indices de la tabla `pnfs`
--
ALTER TABLE `pnfs`
  ADD PRIMARY KEY (`pnf_id`);

--
-- Indices de la tabla `recursos`
--
ALTER TABLE `recursos`
  ADD PRIMARY KEY (`recurso_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD PRIMARY KEY (`seccion_id`),
  ADD KEY `secciones_lapso_id_foreign` (`lapso_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `tecnicas`
--
ALTER TABLE `tecnicas`
  ADD PRIMARY KEY (`tecnica_id`);

--
-- Indices de la tabla `unidades_curriculares`
--
ALTER TABLE `unidades_curriculares`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `unidades_curriculares_pnf_id_foreign` (`pnf_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_cedula_unique` (`cedula`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_telefono_unique` (`telefono`);

--
-- Indices de la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  ADD PRIMARY KEY (`usuario_rol_id`),
  ADD KEY `usuario_roles_usuario_id_foreign` (`usuario_id`),
  ADD KEY `usuario_roles_rol_id_foreign` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bibliografias`
--
ALTER TABLE `bibliografias`
  MODIFY `bibliografia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  MODIFY `contenido_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  MODIFY `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `detalle_actividad`
--
ALTER TABLE `detalle_actividad`
  MODIFY `detalle_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  MODIFY `detalle_bibliografia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `detalle_contenidos`
--
ALTER TABLE `detalle_contenidos`
  MODIFY `detalle_contenido_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `detalle_estrategias`
--
ALTER TABLE `detalle_estrategias`
  MODIFY `detalle_estrategia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  MODIFY `detalle_evaluacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `detalle_planificacion`
--
ALTER TABLE `detalle_planificacion`
  MODIFY `detalle_planificacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `detalle_recursos`
--
ALTER TABLE `detalle_recursos`
  MODIFY `detalle_recurso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `estrategias_pedagogicas`
--
ALTER TABLE `estrategias_pedagogicas`
  MODIFY `estrategia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `evaluacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicadores_logros`
--
ALTER TABLE `indicadores_logros`
  MODIFY `indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  MODIFY `lapso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `motivos_rechazo`
--
ALTER TABLE `motivos_rechazo`
  MODIFY `motivo_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  MODIFY `planificacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `pnfs`
--
ALTER TABLE `pnfs`
  MODIFY `pnf_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `recursos`
--
ALTER TABLE `recursos`
  MODIFY `recurso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `seccion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `tecnicas`
--
ALTER TABLE `tecnicas`
  MODIFY `tecnica_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  MODIFY `usuario_rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD CONSTRAINT `contenidos_unidad_codigo_foreign` FOREIGN KEY (`unidad_codigo`) REFERENCES `unidades_curriculares` (`codigo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  ADD CONSTRAINT `contenido_indicadores_contenido_id_foreign` FOREIGN KEY (`contenido_id`) REFERENCES `detalle_contenidos` (`contenido_id`),
  ADD CONSTRAINT `contenido_indicadores_indicador_id_foreign` FOREIGN KEY (`indicador_id`) REFERENCES `indicadores_logros` (`indicador_id`);

--
-- Filtros para la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD CONSTRAINT `detalle_bibliografia_bibliografia_id_foreign` FOREIGN KEY (`bibliografia_id`) REFERENCES `bibliografias` (`bibliografia_id`),
  ADD CONSTRAINT `detalle_bibliografia_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificacion` (`planificacion_id`);

--
-- Filtros para la tabla `detalle_contenidos`
--
ALTER TABLE `detalle_contenidos`
  ADD CONSTRAINT `detalle_contenidos_contenido_id_foreign` FOREIGN KEY (`contenido_id`) REFERENCES `contenidos` (`contenido_id`),
  ADD CONSTRAINT `detalle_contenidos_detalle_id_foreign` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_actividad` (`detalle_id`);

--
-- Filtros para la tabla `detalle_estrategias`
--
ALTER TABLE `detalle_estrategias`
  ADD CONSTRAINT `detalle_estrategias_detalle_id_foreign` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_actividad` (`detalle_id`),
  ADD CONSTRAINT `detalle_estrategias_estrategia_id_foreign` FOREIGN KEY (`estrategia_id`) REFERENCES `estrategias_pedagogicas` (`estrategia_id`);

--
-- Filtros para la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD CONSTRAINT `detalle_evaluacion_detalle_id_foreign` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_actividad` (`detalle_id`),
  ADD CONSTRAINT `detalle_evaluacion_evaluacion_id_foreign` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`evaluacion_id`),
  ADD CONSTRAINT `detalle_evaluacion_tecnica_id_foreign` FOREIGN KEY (`tecnica_id`) REFERENCES `tecnicas` (`tecnica_id`);

--
-- Filtros para la tabla `detalle_planificacion`
--
ALTER TABLE `detalle_planificacion`
  ADD CONSTRAINT `detalle_planificacion_detalle_id_foreign` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_actividad` (`detalle_id`),
  ADD CONSTRAINT `detalle_planificacion_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificacion` (`planificacion_id`);

--
-- Filtros para la tabla `detalle_recursos`
--
ALTER TABLE `detalle_recursos`
  ADD CONSTRAINT `detalle_recursos_detalle_id_foreign` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_actividad` (`detalle_id`),
  ADD CONSTRAINT `detalle_recursos_recurso_id_foreign` FOREIGN KEY (`recurso_id`) REFERENCES `recursos` (`recurso_id`);

--
-- Filtros para la tabla `motivos_rechazo`
--
ALTER TABLE `motivos_rechazo`
  ADD CONSTRAINT `motivos_rechazo_detalle_id_foreign` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_actividad` (`detalle_id`);

--
-- Filtros para la tabla `planificacion`
--
ALTER TABLE `planificacion`
  ADD CONSTRAINT `planificacion_docente_id_foreign` FOREIGN KEY (`docente_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `planificacion_seccion_id_foreign` FOREIGN KEY (`seccion_id`) REFERENCES `secciones` (`seccion_id`),
  ADD CONSTRAINT `planificacion_unidad_codigo_foreign` FOREIGN KEY (`unidad_codigo`) REFERENCES `unidades_curriculares` (`codigo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD CONSTRAINT `secciones_lapso_id_foreign` FOREIGN KEY (`lapso_id`) REFERENCES `lapso_academico` (`lapso_id`);

--
-- Filtros para la tabla `unidades_curriculares`
--
ALTER TABLE `unidades_curriculares`
  ADD CONSTRAINT `unidades_curriculares_pnf_id_foreign` FOREIGN KEY (`pnf_id`) REFERENCES `pnfs` (`pnf_id`);

--
-- Filtros para la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  ADD CONSTRAINT `usuario_roles_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`),
  ADD CONSTRAINT `usuario_roles_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
