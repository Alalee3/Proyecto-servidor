-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-02-2026 a las 19:25:33
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
-- Base de datos: `bolloconcebolla`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliografia`
--

CREATE TABLE `bibliografia` (
  `id_bibliografia` int(11) NOT NULL,
  `nombre_bibliografia` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bibliografia`
--

INSERT INTO `bibliografia` (`id_bibliografia`, `nombre_bibliografia`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'referenciadamente', '2025-12-24 04:35:50', '2025-12-24 18:01:08', '1'),
(2, 'juliana', '2025-12-24 19:10:43', '2025-12-24 19:10:59', '1'),
(3, 'Clean Code', '2025-12-25 21:36:29', NULL, '1');

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
-- Estructura de tabla para la tabla `calendario_academico`
--

CREATE TABLE `calendario_academico` (
  `id_calendario_academico` int(11) NOT NULL,
  `id_lapso_academico` int(11) DEFAULT NULL,
  `semana` int(11) DEFAULT NULL,
  `dia_inicio` date DEFAULT NULL,
  `dia_fin` date DEFAULT NULL,
  `carga_corte` enum('1','2') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calendario_academico`
--

INSERT INTO `calendario_academico` (`id_calendario_academico`, `id_lapso_academico`, `semana`, `dia_inicio`, `dia_fin`, `carga_corte`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 220, '2026-01-09', '2026-01-30', '1', '2026-01-25 02:10:48', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id_contenido` int(11) NOT NULL,
  `titulo_contenido` text DEFAULT NULL,
  `descripcion_contenido` text DEFAULT NULL,
  `id_tema` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenido`
--

INSERT INTO `contenido` (`id_contenido`, `titulo_contenido`, `descripcion_contenido`, `id_tema`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'asjdsd ', '', 3, '2026-01-30 20:19:54', '2026-01-30 20:30:22', '1'),
(2, 'funcionamiento', 'funcionamiento', 4, '2026-01-30 21:10:44', NULL, '1'),
(3, 'dasdasdas', 'dasdasd', 4, '2026-01-30 21:19:32', NULL, '1'),
(4, 'acortamiento 1', '', 5, '2026-01-30 21:23:54', NULL, '1'),
(5, 'acortamiento 3', '', 6, '2026-01-30 21:24:02', NULL, '1'),
(6, 'acortamiento 4', '', 7, '2026-01-30 21:24:08', NULL, '1'),
(7, 'gratinadaa', 'aros de cebolla', 8, '2026-01-31 00:06:49', '2026-01-31 00:07:21', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_bibliografia`
--

CREATE TABLE `detalle_bibliografia` (
  `id_detalle_bibliografia` int(11) NOT NULL,
  `id_planificacion` int(11) DEFAULT NULL,
  `id_bibliografia` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_bibliografia`
--

INSERT INTO `detalle_bibliografia` (`id_detalle_bibliografia`, `id_planificacion`, `id_bibliografia`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 2, 3, '2025-12-25 22:39:50', NULL, '1'),
(2, 3, 1, '2026-01-29 04:10:07', NULL, '1'),
(3, 4, 3, '2026-01-29 06:17:24', NULL, '1'),
(4, 5, 1, '2026-01-29 16:37:22', NULL, '1'),
(5, 6, 2, '2026-01-30 21:33:09', NULL, '1'),
(6, 14, 1, '2026-01-30 23:49:20', NULL, '1'),
(7, 15, 1, '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_contenido`
--

CREATE TABLE `detalle_contenido` (
  `id_detalle_contenido` bigint(20) UNSIGNED NOT NULL,
  `id_contenido` int(11) NOT NULL,
  `id_unidad` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_contenido`
--

INSERT INTO `detalle_contenido` (`id_detalle_contenido`, `id_contenido`, `id_unidad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 4, 18, '2026-01-30 21:33:09', NULL, '1'),
(2, 2, 19, '2026-01-30 21:33:09', NULL, '1'),
(3, 5, 20, '2026-01-30 21:33:09', NULL, '1'),
(4, 6, 21, '2026-01-30 21:33:09', NULL, '1'),
(11, 4, 31, '2026-01-30 23:49:20', NULL, '1'),
(12, 2, 32, '2026-01-30 23:49:20', NULL, '1'),
(13, 5, 33, '2026-01-30 23:49:20', NULL, '1'),
(14, 6, 34, '2026-01-30 23:49:20', NULL, '1'),
(15, 4, 35, '2026-01-31 00:17:58', NULL, '1'),
(16, 3, 36, '2026-01-31 00:17:58', NULL, '1'),
(17, 5, 37, '2026-01-31 00:17:58', NULL, '1'),
(18, 6, 38, '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_estrategia_pedagogica`
--

CREATE TABLE `detalle_estrategia_pedagogica` (
  `id_detalle_estrategia_pedagogica` int(11) NOT NULL,
  `id_estrategia_pedagogica` int(11) DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_estrategia_pedagogica`
--

INSERT INTO `detalle_estrategia_pedagogica` (`id_detalle_estrategia_pedagogica`, `id_estrategia_pedagogica`, `id_unidad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(2, 2, 2, '2025-12-25 22:39:50', NULL, '1'),
(3, 2, 3, '2025-12-25 22:39:50', NULL, '1'),
(4, 2, 4, '2025-12-25 22:39:50', NULL, '1'),
(5, 2, 5, '2025-12-25 22:39:50', NULL, '1'),
(6, 1, 6, '2026-01-29 04:10:07', NULL, '1'),
(7, 1, 7, '2026-01-29 04:10:07', NULL, '1'),
(8, 1, 8, '2026-01-29 04:10:07', NULL, '1'),
(9, 2, 9, '2026-01-29 04:10:07', NULL, '1'),
(10, 1, 10, '2026-01-29 06:17:24', NULL, '1'),
(11, 1, 11, '2026-01-29 06:17:24', NULL, '1'),
(12, 1, 12, '2026-01-29 06:17:24', NULL, '1'),
(13, 1, 13, '2026-01-29 06:17:24', NULL, '1'),
(14, 1, 14, '2026-01-29 16:37:22', NULL, '2'),
(15, 1, 15, '2026-01-29 16:37:22', NULL, '1'),
(16, 1, 16, '2026-01-29 16:37:22', NULL, '1'),
(17, 1, 17, '2026-01-29 16:37:22', NULL, '1'),
(18, 2, 14, '2026-01-29 16:45:33', NULL, '1'),
(19, 1, 18, '2026-01-30 21:33:09', NULL, '1'),
(20, 2, 19, '2026-01-30 21:33:09', NULL, '1'),
(21, 1, 20, '2026-01-30 21:33:09', NULL, '1'),
(22, 1, 21, '2026-01-30 21:33:09', NULL, '1'),
(29, 2, 31, '2026-01-30 23:49:20', NULL, '1'),
(30, 1, 32, '2026-01-30 23:49:20', NULL, '1'),
(31, 1, 33, '2026-01-30 23:49:20', NULL, '1'),
(32, 1, 34, '2026-01-30 23:49:20', NULL, '1'),
(33, 1, 35, '2026-01-31 00:17:58', NULL, '1'),
(34, 2, 36, '2026-01-31 00:17:58', NULL, '1'),
(35, 2, 37, '2026-01-31 00:17:58', NULL, '1'),
(36, 1, 38, '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evaluacion`
--

CREATE TABLE `detalle_evaluacion` (
  `id_detalle_evaluacion` int(11) NOT NULL,
  `id_evaluacion` int(11) DEFAULT NULL,
  `id_tecnica` int(11) DEFAULT NULL,
  `ponderacion_detalle_evaluacion` float DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL,
  `fecha_evaluacion_detalle_evaluacion` date DEFAULT NULL,
  `forma_participacion_detalle_evaluacion` enum('1','2','3') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3','4') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_evaluacion`
--

INSERT INTO `detalle_evaluacion` (`id_detalle_evaluacion`, `id_evaluacion`, `id_tecnica`, `ponderacion_detalle_evaluacion`, `id_unidad`, `fecha_evaluacion_detalle_evaluacion`, `forma_participacion_detalle_evaluacion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 2, 2, 25, 2, '2025-12-25', '1', '2025-12-25 22:39:50', NULL, '1'),
(2, 2, 2, 25, 3, '2025-12-25', '1', '2025-12-25 22:39:50', NULL, '1'),
(3, 2, 2, 25, 4, '2025-12-25', '1', '2025-12-25 22:39:50', NULL, '1'),
(4, 2, 2, 25, 5, '2025-12-25', '1', '2025-12-25 22:39:50', NULL, '1'),
(5, 1, 1, 25, 6, '2025-01-08', '1', '2026-01-29 04:10:07', NULL, '1'),
(6, 1, 1, 25, 7, '2025-01-08', '1', '2026-01-29 04:10:07', NULL, '1'),
(7, 1, 2, 1, 8, '2025-02-28', '2', '2026-01-29 04:10:07', NULL, '1'),
(8, 1, 2, 1, 8, '2025-02-28', '2', '2026-01-29 04:10:07', NULL, '1'),
(9, 1, 1, 25, 9, '2025-02-28', '2', '2026-01-29 04:10:07', NULL, '1'),
(10, 1, 1, 25, 10, '2026-01-29', '1', '2026-01-29 06:17:24', NULL, '1'),
(11, 1, 1, 25, 11, '2026-01-29', '1', '2026-01-29 06:17:24', NULL, '1'),
(12, 1, 1, 25, 12, '2026-01-30', '1', '2026-01-29 06:17:24', NULL, '1'),
(13, 1, 1, 25, 13, '2026-01-31', '2', '2026-01-29 06:17:24', NULL, '1'),
(14, 1, 1, 25, 14, '2025-01-30', '1', '2026-01-29 16:37:22', NULL, '1'),
(15, 1, 2, 25, 15, '2025-02-12', '2', '2026-01-29 16:37:22', NULL, '1'),
(16, 1, 2, 25, 16, '2025-02-13', '2', '2026-01-29 16:37:22', NULL, '1'),
(17, 1, 1, 25, 17, '2025-02-14', '1', '2026-01-29 16:37:22', NULL, '1'),
(18, 2, 1, 25, 18, '2026-01-15', '3', '2026-01-30 21:33:09', NULL, '1'),
(19, 2, 2, 25, 19, '2026-01-24', '1', '2026-01-30 21:33:09', NULL, '1'),
(20, 2, 1, 25, 20, '2026-01-15', '2', '2026-01-30 21:33:09', NULL, '1'),
(21, 1, 1, 25, 21, '2026-01-23', '1', '2026-01-30 21:33:09', NULL, '1'),
(25, 1, 2, 25, 31, '2026-02-10', '3', '2026-01-30 23:49:20', NULL, '1'),
(26, 1, 2, 25, 32, '2026-03-04', '3', '2026-01-30 23:49:20', NULL, '1'),
(27, 1, 1, 25, 33, '2026-12-04', '1', '2026-01-30 23:49:20', NULL, '1'),
(28, 1, 1, 25, 34, '2026-02-10', '1', '2026-01-30 23:49:20', NULL, '1'),
(29, 1, 1, 25, 35, '2026-01-31', '2', '2026-01-31 00:17:58', NULL, '1'),
(30, 1, 1, 25, 36, '2026-01-31', '2', '2026-01-31 00:17:58', NULL, '1'),
(31, 2, 1, 25, 37, '2026-01-31', '1', '2026-01-31 00:17:58', NULL, '1'),
(32, 1, 2, 25, 38, '2026-01-31', '3', '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_indicador`
--

CREATE TABLE `detalle_indicador` (
  `id_detalle_indicador` bigint(20) UNSIGNED NOT NULL,
  `id_indicador_logro` int(11) NOT NULL,
  `id_detalle_contenido` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_indicador`
--

INSERT INTO `detalle_indicador` (`id_detalle_indicador`, `id_indicador_logro`, `id_detalle_contenido`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 3, 1, '2026-01-30 21:33:09', NULL, '1'),
(2, 3, 2, '2026-01-30 21:33:09', NULL, '1'),
(3, 3, 3, '2026-01-30 21:33:09', NULL, '1'),
(4, 4, 4, '2026-01-30 21:33:09', NULL, '1'),
(11, 6, 11, '2026-01-30 23:49:20', NULL, '1'),
(12, 5, 12, '2026-01-30 23:49:20', NULL, '1'),
(13, 4, 13, '2026-01-30 23:49:20', NULL, '1'),
(14, 3, 14, '2026-01-30 23:49:20', NULL, '1'),
(15, 4, 15, '2026-01-31 00:17:58', NULL, '1'),
(16, 3, 16, '2026-01-31 00:17:58', NULL, '1'),
(17, 3, 17, '2026-01-31 00:17:58', NULL, '1'),
(18, 3, 18, '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_profesor_asignado`
--

CREATE TABLE `detalle_profesor_asignado` (
  `id_detalle_profesor_asignado` int(11) NOT NULL,
  `id_unidad_curricular` int(11) DEFAULT NULL,
  `id_users` int(11) DEFAULT NULL,
  `id_seccion` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_profesor_asignado`
--

INSERT INTO `detalle_profesor_asignado` (`id_detalle_profesor_asignado`, `id_unidad_curricular`, `id_users`, `id_seccion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 3, 1, 1, '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_recurso`
--

CREATE TABLE `detalle_recurso` (
  `id_detalle_recurso` int(11) NOT NULL,
  `id_recurso` int(11) DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_recurso`
--

INSERT INTO `detalle_recurso` (`id_detalle_recurso`, `id_recurso`, `id_unidad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(2, 3, 2, '2025-12-25 22:39:50', NULL, '1'),
(3, 3, 3, '2025-12-25 22:39:50', NULL, '1'),
(4, 3, 4, '2025-12-25 22:39:50', NULL, '1'),
(5, 3, 5, '2025-12-25 22:39:50', NULL, '1'),
(6, 1, 6, '2026-01-29 04:10:07', NULL, '1'),
(7, 1, 7, '2026-01-29 04:10:07', NULL, '1'),
(8, 1, 8, '2026-01-29 04:10:07', NULL, '1'),
(9, 1, 9, '2026-01-29 04:10:07', NULL, '1'),
(10, 1, 10, '2026-01-29 06:17:24', NULL, '1'),
(11, 1, 11, '2026-01-29 06:17:24', NULL, '1'),
(12, 1, 12, '2026-01-29 06:17:24', NULL, '1'),
(13, 2, 13, '2026-01-29 06:17:24', NULL, '1'),
(14, 1, 14, '2026-01-29 16:37:22', NULL, '2'),
(15, 1, 15, '2026-01-29 16:37:22', NULL, '1'),
(16, 2, 16, '2026-01-29 16:37:22', NULL, '1'),
(17, 2, 17, '2026-01-29 16:37:22', NULL, '1'),
(18, 3, 14, '2026-01-29 16:54:17', NULL, '1'),
(19, 1, 18, '2026-01-30 21:33:09', NULL, '1'),
(20, 3, 19, '2026-01-30 21:33:09', NULL, '1'),
(21, 2, 20, '2026-01-30 21:33:09', NULL, '1'),
(22, 2, 21, '2026-01-30 21:33:09', NULL, '1'),
(29, 1, 31, '2026-01-30 23:49:20', NULL, '1'),
(30, 1, 32, '2026-01-30 23:49:20', NULL, '1'),
(31, 2, 33, '2026-01-30 23:49:20', NULL, '1'),
(32, 2, 34, '2026-01-30 23:49:20', NULL, '1'),
(33, 3, 35, '2026-01-31 00:17:58', NULL, '1'),
(34, 2, 36, '2026-01-31 00:17:58', NULL, '1'),
(35, 2, 37, '2026-01-31 00:17:58', NULL, '1'),
(36, 1, 38, '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_unidad_curricular`
--

CREATE TABLE `detalle_unidad_curricular` (
  `id_detalle_unidad_curricular` int(11) NOT NULL,
  `id_unidad_curricular` int(11) DEFAULT NULL,
  `id_estudiante_seccion` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrategia_pedagogica`
--

CREATE TABLE `estrategia_pedagogica` (
  `id_estrategia_pedagogica` int(11) NOT NULL,
  `nombre_estrategia_pedagogica` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estrategia_pedagogica`
--

INSERT INTO `estrategia_pedagogica` (`id_estrategia_pedagogica`, `nombre_estrategia_pedagogica`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'actualizar', '2025-12-24 20:23:15', '2025-12-24 20:23:15', '1'),
(2, 'Aprendizaje Basado en Proyectos', '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_seccion`
--

CREATE TABLE `estudiante_seccion` (
  `id_estudiante_seccion` int(11) NOT NULL,
  `id_users` int(11) DEFAULT NULL,
  `id_seccion` int(11) DEFAULT NULL,
  `es_principal` enum('1','2') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE `evaluacion` (
  `id_evaluacion` int(11) NOT NULL,
  `nombre_evaluacion` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluacion`
--

INSERT INTO `evaluacion` (`id_evaluacion`, `nombre_evaluacion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, '3213', '2025-12-24 20:35:00', '2025-12-24 20:35:13', '1'),
(2, 'Parcial 1', '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL,
  `id_calendario` int(11) DEFAULT NULL,
  `fecha_evento` date DEFAULT NULL,
  `descripcion_evento` varchar(100) DEFAULT NULL,
  `tipo_evento` enum('1','2','3') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`id_evento`, `id_calendario`, `fecha_evento`, `descripcion_evento`, `tipo_evento`, `fecha_creacion`, `estatus`) VALUES
(1, NULL, '2026-01-08', 'cambolla gu,balla', '2', '2026-01-24 20:54:29', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicador_logro`
--

CREATE TABLE `indicador_logro` (
  `id_indicador_logro` int(11) NOT NULL,
  `nombre_indicador_logro` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `indicador_logro`
--

INSERT INTO `indicador_logro` (`id_indicador_logro`, `nombre_indicador_logro`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, '2323', '2025-12-22 05:20:37', NULL, '1'),
(2, '233', '2025-12-22 05:24:15', '2025-12-22 05:26:36', '2'),
(3, 'Domina la sintaxis', '2025-12-25 21:36:29', NULL, '1'),
(4, 'indicador de logro general', '2025-12-26 01:47:14', NULL, '1'),
(5, 'indicador de logro x', '2025-12-26 01:47:21', NULL, '1'),
(6, 'indicador de logo sql', '2025-12-26 01:47:28', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lapso_academico`
--

CREATE TABLE `lapso_academico` (
  `id_lapso_academico` int(11) NOT NULL,
  `nombre_lapso_academico` varchar(20) DEFAULT NULL,
  `fecha_inicio_lapso_academico` date DEFAULT NULL,
  `fecha_fin_lapso_academico` date DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lapso_academico`
--

INSERT INTO `lapso_academico` (`id_lapso_academico`, `nombre_lapso_academico`, `fecha_inicio_lapso_academico`, `fecha_fin_lapso_academico`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Lapso 2025-I', '2025-01-01', '2025-06-30', '2025-12-25 21:36:28', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `malla_academica`
--

CREATE TABLE `malla_academica` (
  `id_malla_academica` int(11) NOT NULL,
  `id_pnf` int(11) DEFAULT NULL,
  `nombre_malla_academica` tinytext DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `malla_academica`
--

INSERT INTO `malla_academica` (`id_malla_academica`, `id_pnf`, `nombre_malla_academica`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 4, 'Malla 2025', '2025-12-25 21:36:28', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `malla_academica_detalle`
--

CREATE TABLE `malla_academica_detalle` (
  `id_malla_academica_detalle` int(11) NOT NULL,
  `id_malla_academica` int(11) DEFAULT NULL,
  `id_semestre` int(11) DEFAULT NULL,
  `id_unidad_curricular` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '2025_12_06_033652_create_password_reset_tokens_table', 1),
(2, '2025_12_06_033714_create_sessions_table', 1),
(3, '2025_12_06_033745_create_personal_access_tokens_table', 1),
(4, '2025_12_06_033754_create_notifications_table', 1),
(5, '0001_01_01_000001_create_cache_table', 2),
(7, '2026_01_30_111200_create_tema_and_contenido_tables', 3),
(8, '2026_01_30_130500_update_schema_substitutions', 4),
(9, '2026_01_30_134500_create_objetivo_table', 5),
(10, '2026_01_30_150000_rename_corte_to_unidad', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_rechazo`
--

CREATE TABLE `motivo_rechazo` (
  `id_motivo_rechazo` int(11) NOT NULL,
  `descripcion_motivo_rechazo` text DEFAULT NULL,
  `id_unidad` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `motivo_rechazo`
--

INSERT INTO `motivo_rechazo` (`id_motivo_rechazo`, `descripcion_motivo_rechazo`, `id_unidad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, '11111111111111111111111111111', 10, '2026-01-29 06:19:12', NULL, '1'),
(2, '11111111111111111111111111111111111111', 11, '2026-01-29 06:19:12', NULL, '1'),
(3, '11111111111111111111111111', 12, '2026-01-29 06:19:12', NULL, '1'),
(4, '111111111111111111111111111', 13, '2026-01-29 06:19:12', NULL, '1'),
(5, 'no me gusto como lo hiciste', 6, '2026-01-29 15:22:42', NULL, '2'),
(6, 'no me gusto como lo hiciste', 6, '2026-01-29 15:25:27', NULL, '2'),
(7, 'no me gustoaaaaaaa', 2, '2026-01-29 15:32:57', NULL, '2'),
(8, 'aaaaaaaaaaaaaaaaaaaaaaaaa', 2, '2026-01-29 15:37:36', NULL, '2'),
(9, 'llllllllllllllllllllllllllllllllllllllllllllll', 5, '2026-01-29 15:38:58', NULL, '2'),
(10, 'no me gusta la cuestión', 2, '2026-01-29 16:22:59', NULL, '2'),
(11, 'no me gusto como lo hiciste', 14, '2026-01-29 16:45:01', NULL, '2'),
(12, 'no me gusto la cuestion', 14, '2026-01-29 16:45:55', NULL, '2'),
(13, 'no me gusta la cuestui', 14, '2026-01-29 16:54:00', NULL, '2'),
(14, 'no me gusta esta cosa', 15, '2026-01-29 16:59:43', NULL, '2'),
(15, 'aaaaaaaaaaaaaaaaaaaaaaaaaa', 2, '2026-01-29 17:07:34', NULL, '2'),
(16, 'jjaskñdjaslhdasoiudaslkln', 18, '2026-01-30 21:34:23', NULL, '2'),
(17, 'yghgjhyjkgjhjvvhh', 18, '2026-01-30 21:34:52', NULL, '2'),
(18, 'ahsdlashlkd', 18, '2026-01-30 21:35:28', NULL, '2'),
(19, 'no me gusto esa vaina', 19, '2026-01-30 21:35:59', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivo`
--

CREATE TABLE `objetivo` (
  `id_objetivo` bigint(20) UNSIGNED NOT NULL,
  `id_unidad` int(11) NOT NULL,
  `nombre_objetivo` varchar(255) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `objetivo`
--

INSERT INTO `objetivo` (`id_objetivo`, `id_unidad`, `nombre_objetivo`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(7, 31, '1231311313131', '2026-01-30 23:49:20', NULL, '1'),
(8, 32, 'fsdfsfsffss', '2026-01-30 23:49:20', NULL, '1'),
(9, 33, 'asddssdasd', '2026-01-30 23:49:20', NULL, '1'),
(10, 34, 'cebolla', '2026-01-30 23:49:20', NULL, '1'),
(11, 35, '12345', '2026-01-31 00:17:58', NULL, '1'),
(12, 36, '12345', '2026-01-31 00:17:58', NULL, '1'),
(13, 37, '12345', '2026-01-31 00:17:58', NULL, '1'),
(14, 38, '12345', '2026-01-31 00:17:58', NULL, '1');

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
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `nombre_permiso` tinytext DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre_permiso`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Todos', '2025-06-27 02:08:59', '2025-06-27 02:08:59', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion`
--

CREATE TABLE `planificacion` (
  `id_planificacion` int(11) NOT NULL,
  `id_profesor_asignado` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `planificacion`
--

INSERT INTO `planificacion` (`id_planificacion`, `id_profesor_asignado`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(2, 1, '2025-12-25 22:39:50', NULL, '1'),
(3, 1, '2026-01-29 04:10:07', NULL, '1'),
(4, 1, '2026-01-29 06:17:24', NULL, '1'),
(5, 1, '2026-01-29 16:37:22', NULL, '1'),
(6, 1, '2026-01-30 21:33:09', NULL, '3'),
(14, 1, '2026-01-30 23:49:20', NULL, '2'),
(15, 1, '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pnf`
--

CREATE TABLE `pnf` (
  `id_pnf` int(11) NOT NULL,
  `nombre_pnf` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pnf`
--

INSERT INTO `pnf` (`id_pnf`, `nombre_pnf`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'informatica', '2025-12-20 16:08:50', NULL, '1'),
(2, 'aguja jjjjjjj', NULL, NULL, NULL),
(3, 'julian', NULL, NULL, NULL),
(4, 'PNF Prueba Ingeniería', '2025-12-25 21:36:28', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL,
  `nombre_recurso` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recurso`
--

INSERT INTO `recurso` (`id_recurso`, `nombre_recurso`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'aaaa pppp', '2025-12-24 04:52:26', '2025-12-24 19:42:23', '1'),
(2, 'actualiza', '2025-12-24 19:38:17', '2025-12-24 19:38:17', '1'),
(3, 'Video Beam', '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `acceso_rol` tinytext DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `acceso_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Coordinador', '2025-06-27 02:08:33', '2025-06-27 02:08:33', '1'),
(2, 'Docente', '2025-06-27 02:08:33', '2025-06-27 02:08:33', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `id_rol_permiso` int(11) NOT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol_permiso`, `id_permiso`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-27 02:08:59', '2025-06-27 02:08:59', '1'),
(2, 1, 2, '2025-06-27 02:08:59', '2025-06-27 02:08:59', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE `seccion` (
  `id_seccion` int(11) NOT NULL,
  `nombre_seccion` varchar(15) DEFAULT NULL,
  `id_lapso_academico` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`id_seccion`, `nombre_seccion`, `id_lapso_academico`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'A01', 1, '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `semestre`
--

CREATE TABLE `semestre` (
  `id_semestre` int(11) NOT NULL,
  `semestre` enum('0','1','2','3','4','5','6','7','8','9','10') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
('9DZdSU1VCSGZAfLkocrGDHYsGO3QaY6AreMQvi5i', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiMnhncWtHV3cyOURBZm9oUHMzeUE1ak90QjIzNUVadnNFbURCTElaSSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC90ZWNuaWNhL2NyZWF0ZSI7fXM6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1770587488),
('hwNP1VLDAX89yJ8A52FvXF4hluQKtaWbNCMMGNpn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSk5DQkY1RXl4enBidk9HWHFXRGM2RUZOT1ZHTHBHbWZhR0hVbllaMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1770918396);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica`
--

CREATE TABLE `tecnica` (
  `id_tecnica` int(11) NOT NULL,
  `nombre_tecnica` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnica`
--

INSERT INTO `tecnica` (`id_tecnica`, `nombre_tecnica`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'ppppp\'\'\'\'', '2025-12-24 20:28:26', '2025-12-24 20:28:45', '1'),
(2, 'Prueba Escrita', '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema`
--

CREATE TABLE `tema` (
  `id_tema` int(11) NOT NULL,
  `id_unidad_curricular` varchar(7) DEFAULT NULL,
  `titulo_tema` text DEFAULT NULL,
  `descripcion_tema` text DEFAULT NULL,
  `unidad_tema` enum('1','2','3','4') DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tema`
--

INSERT INTO `tema` (`id_tema`, `id_unidad_curricular`, `titulo_tema`, `descripcion_tema`, `unidad_tema`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, '3', 'probatoriamente', 'el pepe', '2', '2026-01-30 20:02:47', '2026-01-30 20:06:54', '1'),
(2, '1', 'la sallona', 'el pepe el', '2', '2026-01-30 20:07:37', NULL, '1'),
(3, '2', 'hola mundo 25', '', '1', '2026-01-30 20:19:07', '2026-01-30 20:19:37', '1'),
(4, '3', 'el pepepepepepe', 'el pepepepepepe', '2', '2026-01-30 21:10:30', NULL, '1'),
(5, '3', 'corte 1 porgramacion', '', '1', '2026-01-30 21:22:57', NULL, '1'),
(6, '3', 'corte 3 porgramacion', '', '3', '2026-01-30 21:23:11', NULL, '1'),
(7, '3', 'corte 4 programación', '', '4', '2026-01-30 21:23:26', NULL, '1'),
(8, '1', 'la cbola', 'una cebolla', '3', '2026-01-31 00:05:27', '2026-01-31 00:06:01', '1'),
(9, '1', '231651566516', '', '1', '2026-02-03 23:11:03', NULL, '1'),
(10, '3', '1561651656', '', '2', '2026-02-03 23:11:44', NULL, '1'),
(11, '3', 'aaawd322342', '', '1', '2026-02-03 23:12:39', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad`
--

CREATE TABLE `unidad` (
  `id_unidad` int(11) NOT NULL,
  `id_planificacion` int(11) DEFAULT NULL,
  `numero_unidad` enum('1','2','3','4') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidad`
--

INSERT INTO `unidad` (`id_unidad`, `id_planificacion`, `numero_unidad`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(2, 2, '1', '2025-12-25 22:39:50', NULL, '1'),
(3, 2, '2', '2025-12-25 22:39:50', NULL, '1'),
(4, 2, '3', '2025-12-25 22:39:50', NULL, '1'),
(5, 2, '4', '2025-12-25 22:39:50', NULL, '1'),
(6, 3, '1', '2026-01-29 04:10:07', NULL, '1'),
(7, 3, '2', '2026-01-29 04:10:07', NULL, '1'),
(8, 3, '3', '2026-01-29 04:10:07', NULL, '1'),
(9, 3, '4', '2026-01-29 04:10:07', NULL, '1'),
(10, 4, '1', '2026-01-29 06:17:24', NULL, '1'),
(11, 4, '2', '2026-01-29 06:17:24', NULL, '1'),
(12, 4, '3', '2026-01-29 06:17:24', NULL, '1'),
(13, 4, '4', '2026-01-29 06:17:24', NULL, '1'),
(14, 5, '1', '2026-01-29 16:37:22', NULL, '1'),
(15, 5, '2', '2026-01-29 16:37:22', NULL, '1'),
(16, 5, '3', '2026-01-29 16:37:22', NULL, '1'),
(17, 5, '4', '2026-01-29 16:37:22', NULL, '1'),
(18, 6, '1', '2026-01-30 21:33:09', NULL, '1'),
(19, 6, '2', '2026-01-30 21:33:09', NULL, '3'),
(20, 6, '3', '2026-01-30 21:33:09', NULL, '2'),
(21, 6, '4', '2026-01-30 21:33:09', NULL, '2'),
(31, 14, '1', '2026-01-30 23:49:20', NULL, '2'),
(32, 14, '2', '2026-01-30 23:49:20', NULL, '2'),
(33, 14, '3', '2026-01-30 23:49:20', NULL, '2'),
(34, 14, '4', '2026-01-30 23:49:20', NULL, '2'),
(35, 15, '1', '2026-01-31 00:17:58', NULL, '1'),
(36, 15, '2', '2026-01-31 00:17:58', NULL, '1'),
(37, 15, '3', '2026-01-31 00:17:58', NULL, '1'),
(38, 15, '4', '2026-01-31 00:17:58', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_curricular`
--

CREATE TABLE `unidad_curricular` (
  `id_unidad_curricular` int(11) NOT NULL,
  `nombre_unidad_curricular` text DEFAULT NULL,
  `id_malla_academica` int(11) DEFAULT NULL,
  `descripcion_unidad_curricular` text DEFAULT NULL,
  `trayecto_unidad_curricular` varchar(1) DEFAULT NULL,
  `duracion_unidad_curricular` int(11) DEFAULT NULL,
  `tipo_unidad_curricular` enum('1','2') DEFAULT NULL,
  `proposito_unidad_curricular` text DEFAULT NULL,
  `unidades_credito_unidad_curricular` varchar(2) DEFAULT NULL,
  `horas_semanales_unidad_curricular` varchar(2) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidad_curricular`
--

INSERT INTO `unidad_curricular` (`id_unidad_curricular`, `nombre_unidad_curricular`, `id_malla_academica`, `descripcion_unidad_curricular`, `trayecto_unidad_curricular`, `duracion_unidad_curricular`, `tipo_unidad_curricular`, `proposito_unidad_curricular`, `unidades_credito_unidad_curricular`, `horas_semanales_unidad_curricular`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Programación Web', 1, 'Desarrollo de aplicaciones utilizando frameworks modernos y bases de datos.', '1', 1, '1', NULL, '3', '4', '2025-12-22 00:51:10', NULL, '1'),
(2, 'Base de Datos I', 1, 'Principios de diseño relacional, normalización y lenguaje SQL.', '1', 1, '1', NULL, '4', '6', '2025-12-22 00:51:10', NULL, '1'),
(3, 'Programación Avanzada', 1, NULL, '1', 12, '1', 'Aprender técnicas avanzadas de desarrollo.', '3', '4', '2025-12-25 21:36:29', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `apellido` text DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `remember_token` text DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `email`, `cedula`, `telefono`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Nasser J.', 'Daboin R.', 'nasserdaboin@gmail.com', '31215545', '04127827954', '$2y$12$fJUskRZ71zD7gFvpWtBp3OlKEPi/b/NY980PeASGA4jkPVioV/J5C', 'gSSbrrtlMEGsrYxjRUXbzFlqVakKU68trBqHhNTw61VOHYKzQGjbJ1F9aufs', '2025-06-27 02:08:08', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_usuario_rol` int(11) NOT NULL,
  `id_users` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario_rol`, `id_users`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, 1, '2025-06-27 02:08:59', '2025-06-27 02:08:59', '1'),
(2, 1, 2, '2025-06-27 02:08:59', '2025-06-27 02:08:59', '1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bibliografia`
--
ALTER TABLE `bibliografia`
  ADD PRIMARY KEY (`id_bibliografia`);

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
  ADD PRIMARY KEY (`id_calendario_academico`),
  ADD KEY `id_lapso_academico` (`id_lapso_academico`);

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
  ADD KEY `id_planificacion` (`id_planificacion`),
  ADD KEY `id_bibliografia` (`id_bibliografia`);

--
-- Indices de la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  ADD PRIMARY KEY (`id_detalle_contenido`),
  ADD KEY `detalle_contenido_id_contenido_foreign` (`id_contenido`),
  ADD KEY `detalle_contenido_id_corte_foreign` (`id_unidad`);

--
-- Indices de la tabla `detalle_estrategia_pedagogica`
--
ALTER TABLE `detalle_estrategia_pedagogica`
  ADD PRIMARY KEY (`id_detalle_estrategia_pedagogica`),
  ADD KEY `id_estrategia_pedagogica` (`id_estrategia_pedagogica`),
  ADD KEY `id_corte` (`id_unidad`);

--
-- Indices de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD PRIMARY KEY (`id_detalle_evaluacion`),
  ADD KEY `id_evaluacion` (`id_evaluacion`),
  ADD KEY `id_tecnica` (`id_tecnica`),
  ADD KEY `id_corte` (`id_unidad`);

--
-- Indices de la tabla `detalle_indicador`
--
ALTER TABLE `detalle_indicador`
  ADD PRIMARY KEY (`id_detalle_indicador`),
  ADD KEY `detalle_indicador_id_indicador_logro_foreign` (`id_indicador_logro`),
  ADD KEY `detalle_indicador_id_detalle_contenido_foreign` (`id_detalle_contenido`);

--
-- Indices de la tabla `detalle_profesor_asignado`
--
ALTER TABLE `detalle_profesor_asignado`
  ADD PRIMARY KEY (`id_detalle_profesor_asignado`),
  ADD KEY `id_users` (`id_users`),
  ADD KEY `id_unidad_curricular` (`id_unidad_curricular`),
  ADD KEY `id_seccion` (`id_seccion`);

--
-- Indices de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  ADD PRIMARY KEY (`id_detalle_recurso`),
  ADD KEY `id_recurso` (`id_recurso`),
  ADD KEY `id_corte` (`id_unidad`);

--
-- Indices de la tabla `detalle_unidad_curricular`
--
ALTER TABLE `detalle_unidad_curricular`
  ADD PRIMARY KEY (`id_detalle_unidad_curricular`),
  ADD KEY `id_unidad_curricular` (`id_unidad_curricular`),
  ADD KEY `id_estudiante_seccion` (`id_estudiante_seccion`);

--
-- Indices de la tabla `estrategia_pedagogica`
--
ALTER TABLE `estrategia_pedagogica`
  ADD PRIMARY KEY (`id_estrategia_pedagogica`);

--
-- Indices de la tabla `estudiante_seccion`
--
ALTER TABLE `estudiante_seccion`
  ADD PRIMARY KEY (`id_estudiante_seccion`),
  ADD KEY `id_users` (`id_users`),
  ADD KEY `id_seccion` (`id_seccion`);

--
-- Indices de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`id_evaluacion`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id_evento`),
  ADD KEY `id_calendario` (`id_calendario`);

--
-- Indices de la tabla `indicador_logro`
--
ALTER TABLE `indicador_logro`
  ADD PRIMARY KEY (`id_indicador_logro`);

--
-- Indices de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  ADD PRIMARY KEY (`id_lapso_academico`);

--
-- Indices de la tabla `malla_academica`
--
ALTER TABLE `malla_academica`
  ADD PRIMARY KEY (`id_malla_academica`),
  ADD KEY `id_pnf` (`id_pnf`);

--
-- Indices de la tabla `malla_academica_detalle`
--
ALTER TABLE `malla_academica_detalle`
  ADD PRIMARY KEY (`id_malla_academica_detalle`),
  ADD KEY `id_malla_academica` (`id_malla_academica`),
  ADD KEY `id_unidad_curricular` (`id_unidad_curricular`),
  ADD KEY `id_semestre` (`id_semestre`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `motivo_rechazo`
--
ALTER TABLE `motivo_rechazo`
  ADD PRIMARY KEY (`id_motivo_rechazo`),
  ADD KEY `id_corte` (`id_unidad`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indices de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  ADD PRIMARY KEY (`id_objetivo`),
  ADD KEY `objetivo_id_corte_foreign` (`id_unidad`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  ADD PRIMARY KEY (`id_planificacion`),
  ADD KEY `id_profesor_asignado` (`id_profesor_asignado`);

--
-- Indices de la tabla `pnf`
--
ALTER TABLE `pnf`
  ADD PRIMARY KEY (`id_pnf`);

--
-- Indices de la tabla `recurso`
--
ALTER TABLE `recurso`
  ADD PRIMARY KEY (`id_recurso`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD PRIMARY KEY (`id_rol_permiso`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indices de la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD PRIMARY KEY (`id_seccion`),
  ADD KEY `id_lapso_academico` (`id_lapso_academico`);

--
-- Indices de la tabla `semestre`
--
ALTER TABLE `semestre`
  ADD PRIMARY KEY (`id_semestre`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `tecnica`
--
ALTER TABLE `tecnica`
  ADD PRIMARY KEY (`id_tecnica`);

--
-- Indices de la tabla `tema`
--
ALTER TABLE `tema`
  ADD PRIMARY KEY (`id_tema`);

--
-- Indices de la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD PRIMARY KEY (`id_unidad`),
  ADD KEY `id_planificacion` (`id_planificacion`);

--
-- Indices de la tabla `unidad_curricular`
--
ALTER TABLE `unidad_curricular`
  ADD PRIMARY KEY (`id_unidad_curricular`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id_usuario_rol`),
  ADD KEY `id_users` (`id_users`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bibliografia`
--
ALTER TABLE `bibliografia`
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  MODIFY `id_calendario_academico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id_contenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  MODIFY `id_detalle_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  MODIFY `id_detalle_contenido` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `detalle_estrategia_pedagogica`
--
ALTER TABLE `detalle_estrategia_pedagogica`
  MODIFY `id_detalle_estrategia_pedagogica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  MODIFY `id_detalle_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `detalle_indicador`
--
ALTER TABLE `detalle_indicador`
  MODIFY `id_detalle_indicador` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `detalle_profesor_asignado`
--
ALTER TABLE `detalle_profesor_asignado`
  MODIFY `id_detalle_profesor_asignado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  MODIFY `id_detalle_recurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `detalle_unidad_curricular`
--
ALTER TABLE `detalle_unidad_curricular`
  MODIFY `id_detalle_unidad_curricular` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estrategia_pedagogica`
--
ALTER TABLE `estrategia_pedagogica`
  MODIFY `id_estrategia_pedagogica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estudiante_seccion`
--
ALTER TABLE `estudiante_seccion`
  MODIFY `id_estudiante_seccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `indicador_logro`
--
ALTER TABLE `indicador_logro`
  MODIFY `id_indicador_logro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  MODIFY `id_lapso_academico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `malla_academica`
--
ALTER TABLE `malla_academica`
  MODIFY `id_malla_academica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `malla_academica_detalle`
--
ALTER TABLE `malla_academica_detalle`
  MODIFY `id_malla_academica_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `motivo_rechazo`
--
ALTER TABLE `motivo_rechazo`
  MODIFY `id_motivo_rechazo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  MODIFY `id_objetivo` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  MODIFY `id_planificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pnf`
--
ALTER TABLE `pnf`
  MODIFY `id_pnf` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  MODIFY `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `seccion`
--
ALTER TABLE `seccion`
  MODIFY `id_seccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `semestre`
--
ALTER TABLE `semestre`
  MODIFY `id_semestre` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tecnica`
--
ALTER TABLE `tecnica`
  MODIFY `id_tecnica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tema`
--
ALTER TABLE `tema`
  MODIFY `id_tema` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `unidad`
--
ALTER TABLE `unidad`
  MODIFY `id_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `unidad_curricular`
--
ALTER TABLE `unidad_curricular`
  MODIFY `id_unidad_curricular` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `id_usuario_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD CONSTRAINT `calendario_academico_ibfk_1` FOREIGN KEY (`id_lapso_academico`) REFERENCES `lapso_academico` (`id_lapso_academico`);

--
-- Filtros para la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD CONSTRAINT `detalle_bibliografia_ibfk_1` FOREIGN KEY (`id_planificacion`) REFERENCES `planificacion` (`id_planificacion`),
  ADD CONSTRAINT `detalle_bibliografia_ibfk_2` FOREIGN KEY (`id_bibliografia`) REFERENCES `bibliografia` (`id_bibliografia`);

--
-- Filtros para la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  ADD CONSTRAINT `detalle_contenido_id_contenido_foreign` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_contenido_id_corte_foreign` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_estrategia_pedagogica`
--
ALTER TABLE `detalle_estrategia_pedagogica`
  ADD CONSTRAINT `detalle_estrategia_pedagogica_ibfk_1` FOREIGN KEY (`id_estrategia_pedagogica`) REFERENCES `estrategia_pedagogica` (`id_estrategia_pedagogica`),
  ADD CONSTRAINT `detalle_estrategia_pedagogica_ibfk_2` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`);

--
-- Filtros para la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD CONSTRAINT `detalle_evaluacion_ibfk_1` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id_evaluacion`),
  ADD CONSTRAINT `detalle_evaluacion_ibfk_2` FOREIGN KEY (`id_tecnica`) REFERENCES `tecnica` (`id_tecnica`),
  ADD CONSTRAINT `detalle_evaluacion_ibfk_3` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`);

--
-- Filtros para la tabla `detalle_indicador`
--
ALTER TABLE `detalle_indicador`
  ADD CONSTRAINT `detalle_indicador_id_detalle_contenido_foreign` FOREIGN KEY (`id_detalle_contenido`) REFERENCES `detalle_contenido` (`id_detalle_contenido`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalle_indicador_id_indicador_logro_foreign` FOREIGN KEY (`id_indicador_logro`) REFERENCES `indicador_logro` (`id_indicador_logro`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalle_profesor_asignado`
--
ALTER TABLE `detalle_profesor_asignado`
  ADD CONSTRAINT `detalle_profesor_asignado_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `detalle_profesor_asignado_ibfk_2` FOREIGN KEY (`id_unidad_curricular`) REFERENCES `unidad_curricular` (`id_unidad_curricular`),
  ADD CONSTRAINT `detalle_profesor_asignado_ibfk_3` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id_seccion`);

--
-- Filtros para la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  ADD CONSTRAINT `detalle_recurso_ibfk_1` FOREIGN KEY (`id_recurso`) REFERENCES `recurso` (`id_recurso`),
  ADD CONSTRAINT `detalle_recurso_ibfk_2` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`);

--
-- Filtros para la tabla `detalle_unidad_curricular`
--
ALTER TABLE `detalle_unidad_curricular`
  ADD CONSTRAINT `detalle_unidad_curricular_ibfk_1` FOREIGN KEY (`id_unidad_curricular`) REFERENCES `unidad_curricular` (`id_unidad_curricular`),
  ADD CONSTRAINT `detalle_unidad_curricular_ibfk_2` FOREIGN KEY (`id_estudiante_seccion`) REFERENCES `estudiante_seccion` (`id_estudiante_seccion`);

--
-- Filtros para la tabla `estudiante_seccion`
--
ALTER TABLE `estudiante_seccion`
  ADD CONSTRAINT `estudiante_seccion_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `estudiante_seccion_ibfk_2` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id_seccion`);

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
  ADD CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`id_calendario`) REFERENCES `calendario_academico` (`id_calendario_academico`);

--
-- Filtros para la tabla `malla_academica`
--
ALTER TABLE `malla_academica`
  ADD CONSTRAINT `malla_academica_ibfk_1` FOREIGN KEY (`id_pnf`) REFERENCES `pnf` (`id_pnf`);

--
-- Filtros para la tabla `malla_academica_detalle`
--
ALTER TABLE `malla_academica_detalle`
  ADD CONSTRAINT `malla_academica_detalle_ibfk_1` FOREIGN KEY (`id_malla_academica`) REFERENCES `malla_academica` (`id_malla_academica`),
  ADD CONSTRAINT `malla_academica_detalle_ibfk_2` FOREIGN KEY (`id_unidad_curricular`) REFERENCES `unidad_curricular` (`id_unidad_curricular`),
  ADD CONSTRAINT `malla_academica_detalle_ibfk_3` FOREIGN KEY (`id_semestre`) REFERENCES `semestre` (`id_semestre`);

--
-- Filtros para la tabla `motivo_rechazo`
--
ALTER TABLE `motivo_rechazo`
  ADD CONSTRAINT `motivo_rechazo_ibfk_1` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`);

--
-- Filtros para la tabla `objetivo`
--
ALTER TABLE `objetivo`
  ADD CONSTRAINT `objetivo_id_corte_foreign` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`) ON DELETE CASCADE;

--
-- Filtros para la tabla `planificacion`
--
ALTER TABLE `planificacion`
  ADD CONSTRAINT `planificacion_ibfk_1` FOREIGN KEY (`id_profesor_asignado`) REFERENCES `detalle_profesor_asignado` (`id_detalle_profesor_asignado`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`),
  ADD CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`);

--
-- Filtros para la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD CONSTRAINT `seccion_ibfk_1` FOREIGN KEY (`id_lapso_academico`) REFERENCES `lapso_academico` (`id_lapso_academico`);

--
-- Filtros para la tabla `unidad`
--
ALTER TABLE `unidad`
  ADD CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`id_planificacion`) REFERENCES `planificacion` (`id_planificacion`);

--
-- Filtros para la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
