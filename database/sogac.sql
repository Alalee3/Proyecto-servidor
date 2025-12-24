-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-12-2025 a las 10:57:23
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
-- Base de datos: `sogac`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliografias`
--

CREATE TABLE `bibliografias` (
  `bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `bibliografia` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `bibliografias`
--

INSERT INTO `bibliografias` (`bibliografia_id`, `bibliografia`, `fecha_creacion`, `estatus`) VALUES
(1, 'BOLÍVAR, Simón. \"Cartas y Discursos\".', '2025-06-26 22:44:56', '1'),
(2, 'LOVERA, Jorge. \"Simón Rodríguez y su impacto en el pensamiento bolivariano\".', '2025-06-26 22:45:02', '1'),
(3, 'FRANCO, Eduardo. \"Bolívar: de la Infancia a la Revolución\".', '2025-06-26 22:45:09', '1'),
(4, 'Eduardo Blanco - Venezuela Heroica, John Lynch - Simón Bolívar.', '2025-06-26 22:45:16', '1'),
(5, 'Cartas y discursos de Bolívar, Constitución de Angostura, Congreso de Panamá.', '2025-06-26 22:45:21', '1'),
(6, 'Antonio José de Sucre - Biografía, Historia de la Gran Colombia.', '2025-06-26 22:45:29', '1'),
(7, 'Libros sobre la independencia de América, Artículos de Historia Política de América Latina.', '2025-06-26 22:45:34', '1'),
(8, 'base para los estudiantes', '2025-06-27 01:14:51', '1'),
(9, 'estudiantes conociendo sobre seguridad', '2025-06-27 11:56:14', '1'),
(10, 'el estudiante conoce las redes informaticas', '2025-06-27 12:47:35', '1'),
(11, 'el estudiante aprende a como gestiona', '2025-06-27 12:47:47', '1'),
(12, 'mandraca el magus', '2025-12-20 00:39:13', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Estructura de tabla para la tabla `contenidos`
--

CREATE TABLE `contenidos` (
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` text NOT NULL,
  `descripcion` text NOT NULL,
  `unidad_codigo` varchar(7) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenidos`
--

INSERT INTO `contenidos` (`contenido_id`, `titulo`, `descripcion`, `unidad_codigo`, `fecha_creacion`, `estatus`) VALUES
(1, 'Bolívar de la Cuna al Monte “Humano”', 'Biografía del Libertador Simón Bolívar desde su nacimiento hasta juramento histórico en el monte Sacro', 'IBO011', '2025-06-26 22:16:41', '1'),
(2, 'Del Monte Sacro a Libertador “Militar y político”', 'Principales batallas en el proceso independentista, Influencia de Francisco de Miranda', 'IBO011', '2025-06-26 22:16:41', '1'),
(3, 'Su trascendencia “Bolívar legislador y estadista”', 'Bolívar Libertador de Venezuela y su trascendencia en Nuestra América', 'IBO011', '2025-06-26 22:16:41', '1'),
(4, 'Colombia la Grande y la creación de un eje de Poder Nuestro Americano,', 'importancia de Antonio José de Sucre', 'IBO011', '2025-06-26 22:16:41', '1'),
(5, 'MySQL', 'base de datos', 'BDC213', '2025-06-27 01:10:27', '1'),
(6, 'workbench', 'workbench y su gestión de datos', 'BDC213', '2025-06-27 01:10:27', '1'),
(7, 'estructura de datos', 'estructural de base de datos', 'BDC213', '2025-06-27 01:10:27', '1'),
(8, 'modelo de identidad de relacion', 'conexiones de tablas', 'BDC213', '2025-06-27 01:10:27', '1'),
(9, 'seguridad sistematica', 'sobre la seguridad', 'SEI2120', '2025-06-27 11:47:10', '1'),
(10, 'seguridad foránea', 'formacion de la seguridad', 'SEI2120', '2025-06-27 11:47:10', '1'),
(11, 'destruccion de seguridad', 'destruye de seguridad de tu sistema', 'SEI2120', '2025-06-27 11:47:10', '1'),
(12, 'reparacion de sistemas', 'repara la seguridad y añade seguro', 'SEI2120', '2025-06-27 11:47:10', '1'),
(13, '¿Que es una red?', 'una red es un conjunto de medios por los cuales se emiten mensajes', 'RTC233', '2025-06-27 12:26:25', '1'),
(14, 'Tipos de medios', 'Los tipos de medio por los que se comunican las redes de computadoras', 'RTC233', '2025-06-27 12:26:25', '1'),
(15, 'WLAN o LAN', 'explicación de las redes de área local inalámbricas y alámbricas', 'RTC233', '2025-06-27 12:26:25', '1'),
(16, 'Importancia de las redes', 'Aquí se habla sobre la importancia de las redes', 'RTC233', '2025-06-27 12:26:25', '1'),
(17, 'Subneteo', 'Ejemplos de subneteo, entre otros', 'RTC233', '2025-06-27 12:26:25', '1'),
(18, 'Servidores', 'Aqui se explican los servidores', 'RTC233', '2025-06-27 12:26:25', '1'),
(19, 'VLAN', 'aqui se explican las VLAN', 'RTC233', '2025-06-27 12:26:25', '1'),
(20, 'Como funciona un ROUTER', 'aqui se explica tanto el metodo de conexión como las direcciones IP', 'RTC233', '2025-06-27 12:26:25', '1'),
(21, 'Direcciones IP', 'explicaciones de las IP', 'RTC233', '2025-06-27 12:26:25', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_indicadores`
--

CREATE TABLE `contenido_indicadores` (
  `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_contenido_id` bigint(20) UNSIGNED NOT NULL,
  `indicador_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenido_indicadores`
--

INSERT INTO `contenido_indicadores` (`contenido_indicador_id`, `detalle_contenido_id`, `indicador_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:46:23', '3'),
(2, 2, 2, '2025-06-26 22:46:23', '3'),
(3, 3, 3, '2025-06-26 22:46:23', '3'),
(4, 4, 4, '2025-06-26 22:46:23', '1'),
(5, 5, 1, '2025-06-27 01:15:40', '1'),
(6, 6, 2, '2025-06-27 01:15:40', '1'),
(7, 7, 3, '2025-06-27 01:15:40', '1'),
(8, 8, 5, '2025-06-27 01:15:40', '1'),
(9, 9, 1, '2025-06-27 01:31:05', '1'),
(10, 9, 2, '2025-06-27 01:31:05', '1'),
(11, 10, 3, '2025-06-27 01:31:05', '1'),
(12, 11, 4, '2025-06-27 01:31:05', '1'),
(13, 12, 5, '2025-06-27 01:31:05', '1'),
(15, 4, 3, '2025-06-27 02:03:11', '3'),
(16, 13, 4, '2025-06-27 02:03:11', '1'),
(17, 3, 5, '2025-06-27 02:03:11', '3'),
(18, 2, 4, '2025-06-27 02:18:46', '3'),
(19, 14, 1, '2025-06-27 03:36:43', '3'),
(20, 14, 2, '2025-06-27 03:36:43', '3'),
(21, 14, 3, '2025-06-27 03:36:43', '3'),
(22, 15, 4, '2025-06-27 03:36:44', '3'),
(23, 15, 7, '2025-06-27 03:36:44', '3'),
(24, 15, 6, '2025-06-27 03:36:44', '3'),
(25, 16, 8, '2025-06-27 03:36:44', '3'),
(26, 17, 9, '2025-06-27 03:36:44', '1'),
(27, 18, 9, '2025-06-27 11:57:41', '3'),
(28, 19, 8, '2025-06-27 11:57:41', '3'),
(29, 19, 7, '2025-06-27 11:57:41', '3'),
(30, 20, 5, '2025-06-27 11:57:41', '1'),
(31, 21, 6, '2025-06-27 11:57:41', '3'),
(32, 4, 7, '2025-06-27 12:12:55', '1'),
(33, 4, 6, '2025-06-27 12:12:55', '1'),
(34, 2, 8, '2025-06-27 12:12:55', '1'),
(35, 3, 9, '2025-06-27 12:12:55', '1'),
(36, 22, 10, '2025-06-27 12:48:54', '1'),
(37, 23, 11, '2025-06-27 12:48:54', '1'),
(38, 24, 12, '2025-06-27 12:48:54', '1'),
(39, 24, 13, '2025-06-27 12:48:54', '1'),
(40, 25, 15, '2025-06-27 12:48:54', '1'),
(41, 25, 14, '2025-06-27 12:48:54', '1'),
(42, 26, 17, '2025-06-27 12:48:54', '1'),
(43, 27, 16, '2025-06-27 12:48:54', '1'),
(44, 28, 18, '2025-06-27 12:48:54', '1'),
(45, 21, 12, '2025-06-27 14:00:46', '1'),
(46, 21, 13, '2025-06-27 14:00:46', '1'),
(47, 16, 15, '2025-06-27 14:00:46', '1'),
(48, 16, 14, '2025-06-27 14:00:46', '1'),
(49, 19, 17, '2025-06-27 14:00:46', '1'),
(50, 15, 16, '2025-06-27 14:00:46', '1'),
(51, 18, 18, '2025-06-27 14:00:46', '1'),
(52, 29, 8, '2025-06-27 14:13:30', '1'),
(53, 14, 8, '2025-06-27 14:19:33', '1'),
(54, 14, 7, '2025-06-27 14:19:33', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_actividad`
--

CREATE TABLE `detalle_actividad` (
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `corte` varchar(1) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_actividad`
--

INSERT INTO `detalle_actividad` (`detalle_id`, `corte`, `fecha_creacion`, `estatus`) VALUES
(1, '1', '2025-06-27 05:45:54', '1'),
(2, '2', '2025-06-27 01:19:48', '1'),
(3, '3', '2025-06-27 01:19:48', '1'),
(4, '4', '2025-06-27 01:19:48', '1'),
(5, '1', '2025-06-27 01:24:43', '1'),
(6, '2', '2025-06-27 01:17:35', '1'),
(7, '3', '2025-06-27 01:17:35', '1'),
(8, '4', '2025-06-27 01:17:35', '1'),
(9, '1', '2025-06-27 03:23:33', '1'),
(10, '2', '2025-06-27 03:23:33', '1'),
(11, '3', '2025-06-27 03:23:33', '1'),
(12, '4', '2025-06-27 03:23:33', '1'),
(13, '1', '2025-06-27 12:13:23', '1'),
(14, '2', '2025-06-27 12:13:23', '1'),
(15, '3', '2025-06-27 12:13:23', '1'),
(16, '4', '2025-06-27 12:13:23', '1'),
(17, '1', '2025-06-27 11:58:21', '1'),
(18, '2', '2025-06-27 11:58:21', '1'),
(19, '3', '2025-06-27 11:58:21', '1'),
(20, '4', '2025-06-27 11:58:21', '1'),
(21, '1', '2025-09-18 02:16:38', '1'),
(22, '2', '2025-09-18 02:16:38', '1'),
(23, '3', '2025-09-18 02:16:38', '1'),
(24, '4', '2025-09-18 02:16:38', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_bibliografia`
--

CREATE TABLE `detalle_bibliografia` (
  `detalle_bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_bibliografia`
--

INSERT INTO `detalle_bibliografia` (`detalle_bibliografia_id`, `planificacion_id`, `bibliografia_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:46:23', '1'),
(2, 1, 2, '2025-06-26 22:46:23', '1'),
(3, 1, 3, '2025-06-26 22:46:23', '1'),
(4, 1, 4, '2025-06-26 22:46:23', '1'),
(5, 1, 5, '2025-06-26 22:46:23', '1'),
(6, 1, 6, '2025-06-27 01:02:32', '1'),
(7, 1, 7, '2025-06-27 01:02:32', '1'),
(8, 2, 8, '2025-06-27 01:15:40', '1'),
(20, 3, 7, '2025-06-27 01:31:05', '1'),
(21, 3, 8, '2025-06-27 01:31:05', '1'),
(22, 3, 3, '2025-06-27 02:03:11', '3'),
(23, 4, 2, '2025-06-27 03:36:44', '1'),
(24, 4, 7, '2025-06-27 03:36:44', '1'),
(25, 4, 8, '2025-06-27 03:36:44', '1'),
(26, 4, 4, '2025-06-27 03:36:44', '1'),
(27, 5, 8, '2025-06-27 11:57:41', '1'),
(28, 5, 9, '2025-06-27 11:57:41', '1'),
(29, 4, 6, '2025-06-27 12:12:55', '1'),
(30, 4, 9, '2025-06-27 12:12:55', '1'),
(31, 4, 3, '2025-06-27 12:12:55', '1'),
(32, 6, 11, '2025-06-27 12:48:54', '1'),
(33, 6, 10, '2025-06-27 12:48:54', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_contenidos`
--

CREATE TABLE `detalle_contenidos` (
  `detalle_contenido_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_contenidos`
--

INSERT INTO `detalle_contenidos` (`detalle_contenido_id`, `detalle_id`, `contenido_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:46:23', '3'),
(2, 2, 2, '2025-06-26 22:46:23', '1'),
(3, 3, 3, '2025-06-26 22:46:23', '1'),
(4, 4, 4, '2025-06-26 22:46:23', '1'),
(5, 5, 7, '2025-06-27 01:15:40', '1'),
(6, 6, 8, '2025-06-27 01:15:40', '1'),
(7, 7, 5, '2025-06-27 01:15:40', '1'),
(8, 8, 6, '2025-06-27 01:15:40', '1'),
(9, 9, 1, '2025-06-27 01:31:05', '1'),
(10, 10, 4, '2025-06-27 01:31:05', '1'),
(11, 11, 2, '2025-06-27 01:31:05', '1'),
(12, 12, 3, '2025-06-27 01:31:05', '1'),
(13, 11, 1, '2025-06-27 02:03:11', '1'),
(14, 13, 1, '2025-06-27 03:36:43', '3'),
(15, 14, 4, '2025-06-27 03:36:44', '1'),
(16, 15, 2, '2025-06-27 03:36:44', '1'),
(17, 16, 3, '2025-06-27 03:36:44', '1'),
(18, 17, 9, '2025-06-27 11:57:41', '1'),
(19, 18, 12, '2025-06-27 11:57:41', '1'),
(20, 19, 10, '2025-06-27 11:57:41', '1'),
(21, 20, 11, '2025-06-27 11:57:41', '1'),
(22, 21, 13, '2025-06-27 12:48:54', '1'),
(23, 21, 20, '2025-06-27 12:48:54', '1'),
(24, 22, 21, '2025-06-27 12:48:54', '1'),
(25, 22, 16, '2025-06-27 12:48:54', '3'),
(26, 23, 19, '2025-06-27 12:48:54', '1'),
(27, 23, 15, '2025-06-27 12:48:54', '1'),
(28, 24, 18, '2025-06-27 12:48:54', '1'),
(29, 22, 14, '2025-06-27 14:13:30', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_estrategias`
--

CREATE TABLE `detalle_estrategias` (
  `detalle_estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_estrategias`
--

INSERT INTO `detalle_estrategias` (`detalle_estrategia_id`, `detalle_id`, `estrategia_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:46:23', '1'),
(2, 2, 2, '2025-06-26 22:46:23', '1'),
(3, 3, 3, '2025-06-26 22:46:23', '1'),
(4, 4, 4, '2025-06-26 22:46:23', '1'),
(5, 5, 2, '2025-06-27 01:15:40', '1'),
(6, 6, 3, '2025-06-27 01:15:40', '1'),
(7, 7, 2, '2025-06-27 01:15:40', '1'),
(8, 8, 2, '2025-06-27 01:15:40', '1'),
(9, 9, 2, '2025-06-27 01:31:05', '1'),
(10, 10, 1, '2025-06-27 01:31:05', '1'),
(11, 11, 2, '2025-06-27 01:31:05', '1'),
(12, 12, 3, '2025-06-27 01:31:05', '1'),
(13, 13, 3, '2025-06-27 03:36:43', '1'),
(14, 14, 3, '2025-06-27 03:36:44', '1'),
(15, 14, 5, '2025-06-27 03:36:44', '1'),
(16, 14, 1, '2025-06-27 03:36:44', '1'),
(17, 15, 4, '2025-06-27 03:36:44', '1'),
(18, 16, 4, '2025-06-27 03:36:44', '1'),
(19, 16, 3, '2025-06-27 03:36:44', '1'),
(20, 16, 5, '2025-06-27 03:36:44', '1'),
(21, 17, 6, '2025-06-27 11:57:41', '1'),
(22, 17, 7, '2025-06-27 11:57:41', '1'),
(23, 18, 1, '2025-06-27 11:57:41', '1'),
(24, 19, 2, '2025-06-27 11:57:41', '1'),
(25, 20, 9, '2025-06-27 11:57:41', '1'),
(26, 20, 8, '2025-06-27 11:57:41', '1'),
(27, 21, 10, '2025-06-27 12:48:54', '1'),
(28, 21, 11, '2025-06-27 12:48:54', '1'),
(29, 21, 12, '2025-06-27 12:48:54', '1'),
(30, 22, 10, '2025-06-27 12:48:54', '1'),
(31, 23, 14, '2025-06-27 12:48:54', '1'),
(32, 23, 13, '2025-06-27 14:12:29', '3'),
(33, 24, 15, '2025-06-27 12:48:54', '1'),
(34, 24, 16, '2025-06-27 14:12:30', '3'),
(35, 22, 16, '2025-06-27 14:12:29', '3'),
(36, 22, 14, '2025-06-27 14:12:29', '3');

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
  `forma_participacion` enum('1','2','3') NOT NULL DEFAULT '1',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_evaluacion`
--

INSERT INTO `detalle_evaluacion` (`detalle_evaluacion_id`, `evaluacion_id`, `detalle_id`, `tecnica_id`, `ponderacion`, `fecha_evaluacion`, `forma_participacion`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, 1, 5, '2025-08-26', '3', '2025-06-26 22:46:23', '1'),
(2, 2, 1, 1, 20, '2025-09-01', '3', '2025-06-26 22:46:23', '1'),
(3, 3, 2, 2, 25, '2025-09-25', '3', '2025-06-26 22:46:23', '1'),
(4, 4, 3, 3, 25, '2025-09-12', '3', '2025-06-26 22:46:23', '1'),
(5, 5, 4, 4, 25, '2025-09-30', '3', '2025-06-26 22:46:23', '1'),
(6, 2, 5, 3, 25, '2025-08-30', '1', '2025-06-27 01:15:40', '1'),
(7, 2, 6, 1, 15, '2025-09-22', '1', '2025-06-27 01:15:40', '1'),
(8, 3, 6, 2, 10, '2025-10-28', '2', '2025-06-27 01:15:40', '1'),
(9, 3, 7, 4, 25, '2025-10-22', '1', '2025-06-27 01:15:40', '1'),
(10, 3, 8, 2, 5, '2025-11-22', '1', '2025-06-27 01:15:40', '1'),
(11, 3, 8, 1, 20, '2025-11-25', '2', '2025-06-27 01:15:40', '1'),
(12, 2, 9, 3, 25, '2025-08-26', '1', '2025-06-27 01:31:05', '1'),
(13, 3, 10, 4, 10, '2025-08-30', '2', '2025-06-27 01:31:05', '1'),
(14, 2, 10, 4, 15, '2025-10-04', '3', '2025-06-27 01:31:05', '1'),
(15, 4, 11, 4, 25, '2025-09-11', '3', '2025-06-27 01:31:05', '1'),
(16, 5, 12, 3, 25, '2025-11-11', '3', '2025-06-27 01:31:05', '1'),
(17, 1, 13, 2, 10, '2025-07-22', '1', '2025-06-27 03:36:43', '1'),
(18, 3, 13, 4, 15, '2025-07-30', '2', '2025-06-27 03:36:44', '1'),
(19, 3, 14, 3, 25, '2025-07-15', '2', '2025-06-27 03:36:44', '1'),
(20, 5, 15, 3, 25, '2025-07-21', '2', '2025-06-27 03:36:44', '1'),
(21, 2, 16, 2, 25, '2025-08-01', '3', '2025-06-27 03:36:44', '1'),
(22, 2, 17, 5, 15, '2025-09-22', '1', '2025-06-27 11:57:41', '1'),
(23, 6, 17, 4, 10, '2025-08-30', '1', '2025-06-27 11:57:41', '1'),
(24, 2, 18, 2, 25, '2025-09-25', '2', '2025-06-27 11:57:41', '1'),
(25, 3, 19, 3, 25, '2025-10-22', '2', '2025-06-27 11:57:41', '1'),
(26, 2, 20, 6, 25, '2025-11-01', '1', '2025-06-27 11:57:41', '1'),
(27, 2, 21, 7, 10, '2025-08-28', '2', '2025-06-27 12:48:54', '1'),
(28, 3, 21, 8, 15, '2025-08-26', '3', '2025-06-27 12:48:54', '1'),
(29, 6, 22, 9, 10, '2025-08-26', '2', '2025-06-27 12:48:54', '1'),
(30, 2, 22, 12, 15, '2025-09-20', '2', '2025-06-27 12:48:54', '1'),
(31, 6, 23, 12, 25, '2025-09-01', '1', '2025-06-27 12:48:54', '1'),
(32, 6, 24, 12, 15, '2025-09-20', '1', '2025-06-27 12:48:54', '1'),
(33, 2, 24, 12, 10, '2025-09-30', '2', '2025-06-27 12:48:54', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_planificacion`
--

CREATE TABLE `detalle_planificacion` (
  `detalle_planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_planificacion`
--

INSERT INTO `detalle_planificacion` (`detalle_planificacion_id`, `planificacion_id`, `detalle_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:46:23', '1'),
(2, 1, 2, '2025-06-26 22:46:23', '1'),
(3, 1, 3, '2025-06-26 22:46:23', '1'),
(4, 1, 4, '2025-06-26 22:46:23', '1'),
(5, 2, 5, '2025-06-27 01:15:40', '1'),
(6, 2, 6, '2025-06-27 01:15:40', '1'),
(7, 2, 7, '2025-06-27 01:15:40', '1'),
(8, 2, 8, '2025-06-27 01:15:40', '1'),
(9, 3, 9, '2025-06-27 01:31:05', '1'),
(10, 3, 10, '2025-06-27 01:31:05', '1'),
(11, 3, 11, '2025-06-27 01:31:05', '1'),
(12, 3, 12, '2025-06-27 01:31:05', '1'),
(13, 4, 13, '2025-06-27 03:36:43', '1'),
(14, 4, 14, '2025-06-27 03:36:44', '1'),
(15, 4, 15, '2025-06-27 03:36:44', '1'),
(16, 4, 16, '2025-06-27 03:36:44', '1'),
(17, 5, 17, '2025-06-27 11:57:41', '1'),
(18, 5, 18, '2025-06-27 11:57:41', '1'),
(19, 5, 19, '2025-06-27 11:57:41', '1'),
(20, 5, 20, '2025-06-27 11:57:41', '1'),
(21, 6, 21, '2025-06-27 12:48:54', '1'),
(22, 6, 22, '2025-06-27 12:48:54', '1'),
(23, 6, 23, '2025-06-27 12:48:54', '1'),
(24, 6, 24, '2025-06-27 12:48:54', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_recursos`
--

CREATE TABLE `detalle_recursos` (
  `detalle_recurso_id` bigint(20) UNSIGNED NOT NULL,
  `detalle_id` bigint(20) UNSIGNED NOT NULL,
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_recursos`
--

INSERT INTO `detalle_recursos` (`detalle_recurso_id`, `detalle_id`, `recurso_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:46:23', '1'),
(2, 1, 2, '2025-06-26 22:46:23', '1'),
(3, 2, 3, '2025-06-26 22:46:23', '1'),
(4, 3, 4, '2025-06-26 22:46:23', '1'),
(5, 4, 5, '2025-06-26 22:46:23', '1'),
(6, 5, 1, '2025-06-27 01:15:40', '1'),
(7, 6, 1, '2025-06-27 01:15:40', '1'),
(8, 7, 1, '2025-06-27 01:15:40', '1'),
(9, 8, 1, '2025-06-27 01:15:40', '1'),
(10, 9, 2, '2025-06-27 01:31:05', '1'),
(11, 10, 2, '2025-06-27 01:31:05', '1'),
(12, 11, 3, '2025-06-27 01:31:05', '1'),
(13, 12, 4, '2025-06-27 01:31:05', '1'),
(14, 13, 1, '2025-06-27 03:36:43', '1'),
(15, 13, 2, '2025-06-27 03:36:43', '1'),
(16, 13, 4, '2025-06-27 03:36:43', '1'),
(17, 14, 3, '2025-06-27 03:36:44', '1'),
(18, 14, 2, '2025-06-27 03:36:44', '1'),
(19, 14, 4, '2025-06-27 03:36:44', '1'),
(20, 15, 3, '2025-06-27 03:36:44', '1'),
(21, 16, 2, '2025-06-27 03:36:44', '1'),
(22, 16, 4, '2025-06-27 03:36:44', '1'),
(23, 16, 5, '2025-06-27 03:36:44', '1'),
(24, 17, 6, '2025-06-27 11:57:41', '1'),
(25, 17, 7, '2025-06-27 11:57:41', '1'),
(26, 18, 5, '2025-06-27 11:57:41', '1'),
(27, 19, 2, '2025-06-27 11:57:41', '1'),
(28, 20, 6, '2025-06-27 11:57:41', '1'),
(29, 21, 7, '2025-06-27 12:48:54', '1'),
(30, 21, 6, '2025-06-27 12:48:54', '1'),
(31, 21, 8, '2025-06-27 12:48:54', '1'),
(32, 21, 9, '2025-06-27 12:48:54', '1'),
(33, 22, 7, '2025-06-27 12:48:54', '1'),
(34, 22, 8, '2025-06-27 13:57:42', '1'),
(35, 22, 9, '2025-06-27 13:57:42', '1'),
(36, 23, 7, '2025-06-27 12:48:54', '1'),
(37, 24, 6, '2025-06-27 12:48:54', '1'),
(38, 22, 2, '2025-06-27 13:57:42', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrategias_pedagogicas`
--

CREATE TABLE `estrategias_pedagogicas` (
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `estrategia` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `estrategias_pedagogicas`
--

INSERT INTO `estrategias_pedagogicas` (`estrategia_id`, `estrategia`, `fecha_creacion`, `estatus`) VALUES
(1, 'Creación de un cuento en donde relatan la vida del libertador y la influencia e importancia de Simón Rodríguez en relación al juramento histórico en el monte sacro. Taller grupal en clases.', '2025-06-26 22:32:02', '1'),
(2, 'Exposición crítica.', '2025-06-26 22:36:54', '1'),
(3, 'Foro académico organizado por los estudiantes.', '2025-06-26 22:40:40', '1'),
(4, 'Periódico mural: Elaboración de un mural histórico sobre la Gran Colombia.', '2025-06-26 22:43:58', '1'),
(5, 'estrategia de prueba', '2025-06-27 03:29:15', '1'),
(6, 'USB', '2025-06-27 11:50:35', '1'),
(7, 'formacion', '2025-06-27 11:51:14', '1'),
(8, 'trabajos seguridad', '2025-06-27 11:56:46', '1'),
(9, 'como ingresar seguridad', '2025-06-27 11:57:03', '1'),
(10, 'Trabajos escritos', '2025-06-27 12:30:31', '1'),
(11, 'discuciones socializadas por medio de software de gestión de aprendizaje', '2025-06-27 12:31:41', '1'),
(12, 'taller práctico empleando simuladores', '2025-06-27 12:31:54', '1'),
(13, 'Practica en el laboratorio', '2025-06-27 12:42:08', '1'),
(14, 'redes VLAN', '2025-06-27 12:42:25', '1'),
(15, 'servidores son fundament', '2025-06-27 12:44:34', '1'),
(16, 'servidores junto al subneteo', '2025-06-27 12:45:01', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `evaluaciones`
--

INSERT INTO `evaluaciones` (`evaluacion_id`, `evaluacion`, `fecha_creacion`, `estatus`) VALUES
(1, 'Creación de un cuento', '2025-06-26 22:34:25', '1'),
(2, 'Taller', '2025-06-26 22:35:31', '1'),
(3, 'Exposición oral', '2025-06-26 22:38:36', '1'),
(4, 'Realizar un foro académico', '2025-06-26 22:43:06', '1'),
(5, 'crear un mural', '2025-06-26 22:44:43', '1'),
(6, 'trabajo comunitario', '2025-06-27 11:52:18', '1');

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
-- Estructura de tabla para la tabla `indicadores_logros`
--

CREATE TABLE `indicadores_logros` (
  `indicador_id` bigint(20) UNSIGNED NOT NULL,
  `indicador` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `indicadores_logros`
--

INSERT INTO `indicadores_logros` (`indicador_id`, `indicador`, `fecha_creacion`, `estatus`) VALUES
(1, 'El estudiante es capaz de reconocer los acontecimientos más relevantes en la vida de Simón Bolívar, comprendiendo su contexto y relevancia histórica. Además, analiza la formación del pensamiento político y filosófico de Bolívar.', '2025-06-26 22:30:59', '1'),
(2, 'Analizan las principales batallas del proceso independentista y su impacto.', '2025-06-26 22:36:31', '1'),
(3, 'Organizan de manera autónoma el foro, estableciendo roles y normas claras.', '2025-06-26 22:41:17', '1'),
(4, 'Explican la importancia de Colombia la Grande en la historia de América.', '2025-06-26 22:43:24', '1'),
(5, 'importancia sobre el codigo', '2025-06-27 01:15:32', '1'),
(6, 'un nuevo indicador de logros', '2025-06-27 03:26:35', '1'),
(7, 'indicador de prueba', '2025-06-27 03:32:01', '1'),
(8, 'nuevo indicador', '2025-06-27 03:34:30', '1'),
(9, 'hola mundo', '2025-06-27 03:36:33', '1'),
(10, 'el estudiante logra entender el concepto básico de una red', '2025-06-27 12:27:10', '1'),
(11, 'Lograr identificar las IP y conexiones de un router', '2025-06-27 12:28:50', '1'),
(12, 'Reconocer las direcciones IP y porque son tan importantes', '2025-06-27 12:35:04', '1'),
(13, 'las direcciones ip son importantes', '2025-06-27 12:35:16', '1'),
(14, 'reconocer la importancia de las redes del computador', '2025-06-27 12:35:49', '1'),
(15, 'indicador de logros para la importancia de las redes', '2025-06-27 12:36:28', '1'),
(16, 'La VLAN son fundamentales', '2025-06-27 12:40:54', '1'),
(17, 'La VLAN forman............', '2025-06-27 12:41:17', '1'),
(18, 'como desarrollamos los servidores hoy en dia??', '2025-06-27 12:44:11', '1');

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
-- Estructura de tabla para la tabla `lapso_academico`
--

CREATE TABLE `lapso_academico` (
  `lapso_id` bigint(20) UNSIGNED NOT NULL,
  `lapso` varchar(20) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lapso_academico`
--

INSERT INTO `lapso_academico` (`lapso_id`, `lapso`, `fecha_inicio`, `fecha_fin`, `fecha_creacion`, `estatus`) VALUES
(1, '2025-INTENSIVO', '2025-09-19 00:00:00', '2025-11-27 00:00:00', '2025-06-26 22:17:51', '1'),
(2, '2025-I', '2025-01-01 00:00:00', '2025-08-04 00:00:00', '2025-06-26 22:18:23', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
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
  `motivo` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `motivos_rechazo`
--

INSERT INTO `motivos_rechazo` (`motivo_id`, `detalle_id`, `motivo`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 'no me gustó el corte', '2025-06-26 23:33:45', '2'),
(2, 1, 'revisar mejor los recursos', '2025-06-26 23:38:17', '2'),
(3, 2, 'no me gusta este contenido', '2025-06-26 23:38:42', '2'),
(4, 3, 'prueba para ver si rechaza más de uno', '2025-06-27 01:19:48', '2'),
(5, 4, 'y ver que ocurre', '2025-06-27 01:19:48', '2'),
(7, 5, 'porq no siento que este bien', '2025-06-27 01:17:35', '2'),
(10, 5, 'no me gustó', '2025-06-27 01:24:43', '2'),
(11, 1, 'no me gustó', '2025-06-27 01:24:36', '2'),
(12, 1, 'no me gusta como lo estructuraste', '2025-06-27 05:45:54', '2'),
(13, 9, 'rechazo estecorte porque no me gusta', '2025-06-27 03:23:33', '2'),
(14, 9, 'rechazo estecorte porque no me gusta', '2025-06-27 03:23:33', '2'),
(15, 10, 'tampoco me gusta', '2025-06-27 03:23:33', '2'),
(16, 9, 'rechazo estecorte porque no me gusta', '2025-06-27 03:23:33', '2'),
(17, 10, 'tampoco me gusta', '2025-06-27 03:23:33', '2'),
(18, 9, 'rechazo estecorte porque no me gusta', '2025-06-27 03:23:33', '2'),
(19, 10, 'tampoco me gusta', '2025-06-27 03:23:33', '2'),
(20, 11, 'no me gustó tiene mucho texto', '2025-06-27 03:23:33', '2'),
(21, 13, 'rechazo este corte porque no me gusta', '2025-06-27 12:13:23', '2'),
(22, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(23, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(24, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(25, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(26, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(27, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(28, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(29, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(30, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(31, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(32, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(33, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(34, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(35, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(36, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(37, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2'),
(38, 21, 'no me gusta el corte, cambialo', '2025-09-18 02:16:38', '2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
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
  `unidad_codigo` varchar(7) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planificacion`
--

INSERT INTO `planificacion` (`planificacion_id`, `docente_id`, `seccion_id`, `unidad_codigo`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, 'IBO011', '2025-06-26 22:46:23', '1'),
(2, 1, 7, 'BDC213', '2025-06-27 01:15:40', '1'),
(3, 1, 2, 'IBO011', '2025-06-27 01:31:05', '1'),
(4, 1, 10, 'IBO011', '2025-06-27 03:36:43', '1'),
(5, 1, 14, 'SEI2120', '2025-06-27 11:57:41', '1'),
(6, 1, 7, 'RTC233', '2025-06-27 12:48:54', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pnfs`
--

CREATE TABLE `pnfs` (
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` tinytext NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pnfs`
--

INSERT INTO `pnfs` (`pnf_id`, `nombre`, `fecha_creacion`, `estatus`) VALUES
(1, 'Informática voladora', '2025-06-26 22:09:40', '1'),
(2, 'prod', '2025-09-19 21:06:43', '2'),
(3, 'julian', '2025-11-15 12:18:31', '1'),
(4, 'dasdsad', '2025-11-15 12:19:44', '1'),
(5, 'juan', '2025-11-15 12:20:11', '1'),
(6, 'actualiza', '2025-11-15 12:20:53', '1'),
(7, 'asdasd', '2025-11-15 12:21:01', '1'),
(8, 'dsads', '2025-11-15 12:25:21', '1'),
(9, 'dsdsd', '2025-11-15 12:25:48', '1'),
(10, 'dasdd', '2025-11-15 12:30:28', '1'),
(11, 'dsd', '2025-11-15 12:35:05', '1'),
(12, 'asas', '2025-11-15 12:43:13', '1'),
(13, 'asd', '2025-11-15 12:43:34', '1'),
(14, 'dsad', '2025-11-15 12:44:43', '1'),
(15, 'creacinaiento', '2025-11-15 13:19:09', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `recurso` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recursos`
--

INSERT INTO `recursos` (`recurso_id`, `recurso`, `fecha_creacion`, `estatus`) VALUES
(1, 'Documentos históricos y biografías.', '2025-06-26 22:31:22', '1'),
(2, 'Guia de estudios.', '2025-06-26 22:31:38', '1'),
(3, 'Documentos históricos, imágenes, línea de tiempo.', '2025-06-26 22:36:43', '1'),
(4, 'Normas del foro, plataforma de discusión, reglamento de participación.', '2025-06-26 22:41:03', '1'),
(5, 'Carteles, papel, colores, imágenes, recortes.', '2025-06-26 22:43:37', '1'),
(6, 'computadoras', '2025-06-27 11:49:05', '1'),
(7, 'pizzara', '2025-06-27 11:50:58', '1'),
(8, 'marcadores', '2025-06-27 12:29:56', '1'),
(9, 'Video BEAM', '2025-06-27 12:30:10', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `acceso` tinytext NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `acceso`, `fecha_creacion`, `estatus`) VALUES
(1, 'Coordinador', '2025-06-26 22:08:33', '1'),
(2, 'Docente', '2025-06-26 22:08:33', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `seccion` varchar(15) NOT NULL,
  `lapso_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`seccion_id`, `seccion`, `lapso_id`, `fecha_creacion`, `estatus`) VALUES
(1, '031', 1, '2025-06-26 22:20:19', '1'),
(2, '036', 1, '2025-06-26 22:20:19', '1'),
(3, '131', 1, '2025-06-26 22:20:19', '1'),
(4, '136', 1, '2025-06-26 22:20:19', '1'),
(5, '231', 1, '2025-06-26 22:20:19', '1'),
(6, '236', 1, '2025-06-26 22:20:19', '1'),
(7, '331', 1, '2025-06-26 22:20:19', '1'),
(8, '336', 1, '2025-06-26 22:20:19', '1'),
(9, '431', 1, '2025-06-26 22:20:19', '1'),
(10, '031-INT', 2, '2025-06-27 00:45:52', '1'),
(11, '036-INT', 2, '2025-06-27 00:45:52', '1'),
(12, '131-INT', 2, '2025-06-27 00:45:52', '1'),
(13, '136-INT', 2, '2025-06-27 00:45:52', '1'),
(14, '531', 1, '2025-06-27 11:47:48', '1');

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
('VFOpQbUyrkttxw6IQPRXaPT2TJGmxt4QFyPSL9SO', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidnRadVZhWVlFR1oyb2ZUVm5XZUdZVThBb0xNbE9vNnpLMlpRMlZRYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wbGFuaWZpY2FjaW9uL2NyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1766191457);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnicas`
--

CREATE TABLE `tecnicas` (
  `tecnica_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tecnicas`
--

INSERT INTO `tecnicas` (`tecnica_id`, `tecnica`, `fecha_creacion`, `estatus`) VALUES
(1, 'Estudio de documentos históricos y biografías.', '2025-06-26 22:32:34', '1'),
(2, 'Rúbrica de exposición oral, lista de cotejo.', '2025-06-26 22:38:03', '1'),
(3, 'Observación directa, rúbrica de evaluación, lista de cotejo (evaluación formativa y sumativa).', '2025-06-26 22:42:11', '1'),
(4, 'Evaluación visual del mural, rúbrica de coherencia.', '2025-06-26 22:44:16', '1'),
(5, 'estudio sobre seguridad', '2025-06-27 11:51:44', '1'),
(6, 'evaluacion didactica', '2025-06-27 11:55:42', '1'),
(7, 'tecnica para evaluar redes', '2025-06-27 12:33:54', '1'),
(8, 'exposiciones teóricas sobre las redes', '2025-06-27 12:34:32', '1'),
(9, 'trabajos en empresas', '2025-06-27 12:37:27', '1'),
(10, 'manua', '2025-06-27 12:38:48', '1'),
(12, 'informe', '2025-06-27 12:39:01', '1'),
(13, 'potaforio academico', '2025-06-27 12:47:03', '1'),
(14, 'pepapig', '2025-12-20 00:38:48', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades_curriculares`
--

CREATE TABLE `unidades_curriculares` (
  `codigo` varchar(7) NOT NULL,
  `nombre` tinytext NOT NULL,
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `descripcion` text NOT NULL,
  `trayecto` enum('0','1','2','3','4') NOT NULL,
  `tipo` enum('1','2') NOT NULL,
  `proposito` text NOT NULL,
  `unidades_credito` varchar(2) NOT NULL,
  `horas_semanales` varchar(2) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidades_curriculares`
--

INSERT INTO `unidades_curriculares` (`codigo`, `nombre`, `pnf_id`, `descripcion`, `trayecto`, `tipo`, `proposito`, `unidades_credito`, `horas_semanales`, `fecha_creacion`, `estatus`) VALUES
('BDC213', 'base de datos', 1, 'descripcion de base de datos', '2', '1', 'estudiantes de base de datos', '4', '5', '2025-06-27 01:10:27', '1'),
('IBO011', 'Ideario Bolivariano', 1, 'descripción de ideario bolivariano', '0', '1', 'Desarrollar la identidad nacionalista y concienciación política desde los ideales Bolivarianos y la transcendencia en sus proyectos ideológicos de emancipación desde en Modelo Ideológico, autóctono, histórico del ser nacional', '9', '3', '2025-06-26 22:16:40', '1'),
('RTC233', 'Redes del Computador', 1, 'Redes es una unidad curricular importante', '2', '2', 'El proposito de redes es para...', '5', '3', '2025-06-27 12:26:25', '1'),
('SEI2120', 'seguridad en informatica', 1, 'trabajando con la seguridad informatica', '3', '2', 'para estudiantes sobre seguridad en informatica', '4', '5', '2025-06-27 11:47:10', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` tinytext NOT NULL,
  `apellido` tinytext NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `theme` varchar(10) DEFAULT NULL,
  `password` text NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `cedula`, `email`, `telefono`, `theme`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Nasser J.', 'Daboin R.', '31215545', 'nasserdaboin@gmail.com', '04127827954', NULL, '$2y$12$fJUskRZ71zD7gFvpWtBp3OlKEPi/b/NY980PeASGA4jkPVioV/J5C', 'Yw5taDlEsXFTLlvUkbTqA2S2T4thkL4s2ZFjle6aBc3KsqC6RtBtLmCHh1av', '2025-06-26 22:08:08', '1'),
(2, 'Fernando A.', 'Leon L.', '31306741', 'fernandolanderleon15@gmail.com', '04245738833', NULL, '$2y$12$vpswJTV.fPeaxUiGMgXIlOmIWekAtgmHxX9DTk/mHkP8v.l52u0B2', NULL, '2025-06-26 22:25:08', '2'),
(3, 'SAUPA 2020', 'SAUPA 123', 'VN31009367', 'elnegro@xn--ida.p', 'no tengo', NULL, '$2y$12$JHqEhHGDKFB3be40bGbguuNoPePUxY9C4OKU.IyiCOK/./zKrxx4C', NULL, '2025-09-18 01:57:09', '1'),
(4, 'Fernando A.', 'Leon L.', 'Docente', '1@1.1', 'se me perdio', NULL, '$2y$12$QV7vw2nhpOGQJWFLwfkeNuus2/XpQUCbGrMSImZvprFzZmVvVDSCe', NULL, '2025-09-18 02:00:12', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_roles`
--

CREATE TABLE `usuario_roles` (
  `usuario_rol_id` bigint(20) UNSIGNED NOT NULL,
  `usuario_id` bigint(20) UNSIGNED NOT NULL,
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario_roles`
--

INSERT INTO `usuario_roles` (`usuario_rol_id`, `usuario_id`, `rol_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-26 22:08:59', '1'),
(2, 1, 2, '2025-06-26 22:08:59', '1'),
(3, 2, 2, '2025-06-26 22:25:08', '1'),
(4, 3, 1, '2025-09-18 01:57:09', '1'),
(5, 4, 1, '2025-09-18 02:00:12', '1');

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
  ADD KEY `contenido_indicadores_detalle_contenido_id_foreign` (`detalle_contenido_id`),
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
  MODIFY `bibliografia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  MODIFY `contenido_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  MODIFY `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `detalle_actividad`
--
ALTER TABLE `detalle_actividad`
  MODIFY `detalle_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  MODIFY `detalle_bibliografia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `detalle_contenidos`
--
ALTER TABLE `detalle_contenidos`
  MODIFY `detalle_contenido_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `detalle_estrategias`
--
ALTER TABLE `detalle_estrategias`
  MODIFY `detalle_estrategia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  MODIFY `detalle_evaluacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `detalle_planificacion`
--
ALTER TABLE `detalle_planificacion`
  MODIFY `detalle_planificacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `detalle_recursos`
--
ALTER TABLE `detalle_recursos`
  MODIFY `detalle_recurso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `estrategias_pedagogicas`
--
ALTER TABLE `estrategias_pedagogicas`
  MODIFY `estrategia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
  MODIFY `motivo_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  MODIFY `planificacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pnfs`
--
ALTER TABLE `pnfs`
  MODIFY `pnf_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
  MODIFY `seccion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tecnicas`
--
ALTER TABLE `tecnicas`
  MODIFY `tecnica_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  MODIFY `usuario_rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  ADD CONSTRAINT `contenido_indicadores_detalle_contenido_id_foreign` FOREIGN KEY (`detalle_contenido_id`) REFERENCES `detalle_contenidos` (`detalle_contenido_id`),
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
