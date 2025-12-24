-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-06-2025 a las 01:05:33
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
-- Base de datos: `proyecto_planificacion_nueva`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliografias`
--

CREATE TABLE `bibliografias` (
  `bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `libro` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_publicacion` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Estructura de tabla para la tabla `calendario_academico`
--

CREATE TABLE `calendario_academico` (
  `corte_id` bigint(20) UNSIGNED NOT NULL,
  `corte` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenidos`
--

CREATE TABLE `contenidos` (
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `unidad_codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenidos`
--

INSERT INTO `contenidos` (`contenido_id`, `unidad_codigo`, `titulo`, `descripcion`, `fecha_creacion`, `estatus`) VALUES
(1, 'POT2312', 'CRUD', 'En este contenido se debe explorar las funciones de CRUD, (Create, Read, Update, Delete), (Crear, Leer, Actualizar, Eliminar) mediante PHP y MySQL', '2025-05-29 20:50:30', '1'),
(2, 'POT2312', 'Maestros', 'Con los conocimientos adquiridos de los anteriores contenidos el estudiante deberá empezar a juntarlos, HTML, CSS, JavaScript, y PHP, deberá hacer un CRUD con diseño, y funciones en tiempo real.', '2025-05-29 20:50:31', '1'),
(3, 'RCT226', 'Sub Redes', 'Las sub redes son parte indispensable para la distribución de una red.', '2025-05-29 21:12:11', '1'),
(4, 'RCT226', 'VLAN', 'Las VLAN permiten crear redes de longitud variable.', '2025-05-29 21:12:11', '3'),
(5, 'FSC233', 'ni idea', 'no me acuerdo de los contenidos', '2025-05-29 23:52:54', '1'),
(6, 'FSC233', 'otro contenido', 'no me acuerdo x2', '2025-05-29 23:52:54', '1'),
(7, 'POT2312', 'otro contenido de programación...', 'otra descripción de programación...', '2025-05-30 22:30:53', '1'),
(8, 'PTO5473', 'Primera fase...', 'Descripción de primera fase....', '2025-05-30 23:20:41', '1'),
(9, 'BDD736', 'Modelo E/R', 'Descripción del modelo E/R...', '2025-05-30 23:42:15', '1'),
(10, 'PTO5473', 'Fase 2', 'Fase 2....', '2025-05-30 23:56:57', '1'),
(11, 'PTO5473', 'Fase 3', 'fase 3...', '2025-05-31 14:48:56', '1'),
(12, 'MTC341', 'Matrices', 'Matrices descripción', '2025-05-31 15:00:55', '1'),
(13, 'MTC341', 'Matrices escalonadas', 'Matrices escalonadas descripción...', '2025-05-31 15:00:56', '1'),
(14, 'MTC341', 'Funciones', 'funciones...', '2025-05-31 15:02:39', '1'),
(15, 'ALP312', 'Listas en PYTHON', 'Listas en PYTHON descripción...', '2025-05-31 15:28:25', '1'),
(16, 'RCT226', 'VLAN', 'vlan....', '2025-05-31 19:51:51', '1'),
(17, 'IDB335', 'Bolívar y el juramento en el monte sacro', 'Bolívar...', '2025-06-01 14:35:04', '1'),
(18, 'RBO412', 'Revolución titulo...', 'Revolución descripción...', '2025-06-01 14:37:53', '1'),
(19, 'RCT226', 'VLAN', 'hola vlan...', '2025-06-01 15:10:16', '3'),
(20, 'IDS321', 'Verbo To Be', 'Verbo To Be descripción...', '2025-06-02 18:48:10', '1'),
(21, 'IDS321', 'Pronombres Personales', 'Pronombres Personales Descripción...', '2025-06-02 18:48:10', '1'),
(22, 'IDS321', 'otro contenido de prueba', 'otro contenido de prueba', '2025-06-02 18:49:39', '1'),
(23, 'SDI6233', 'Seguridad...', 'Seguridad...', '2025-06-05 14:18:59', '1'),
(24, 'SDI6233', 'Cifrado', 'Cifrado...', '2025-06-05 14:18:59', '1'),
(25, 'SDI6233', 'Formas de ocultar información...', 'formas de ocultar información....', '2025-06-05 14:18:59', '1'),
(26, 'RBO412', 'nuevo contenido revolución bolivariana', 'nuevo contenido revolución bolivariana', '2025-06-05 14:34:22', '1'),
(27, 'SDI6233', 'seguridad contenido...', 'seguridad contenido...', '2025-06-05 14:37:44', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_bibliografias`
--

CREATE TABLE `contenido_bibliografias` (
  `contenido_bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `bibliografia_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_indicadores`
--

CREATE TABLE `contenido_indicadores` (
  `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL,
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `indicador_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenido_indicadores`
--

INSERT INTO `contenido_indicadores` (`contenido_indicador_id`, `contenido_id`, `indicador_id`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 1, '2025-05-29 20:50:31', '1'),
(2, 1, 2, '2025-05-29 20:50:31', '1'),
(3, 2, 3, '2025-05-29 20:50:31', '1'),
(4, 5, 4, '2025-05-29 23:52:54', '1'),
(5, 5, 1, '2025-05-29 23:52:54', '3'),
(6, 5, 5, '2025-05-29 23:52:54', '3'),
(7, 6, 6, '2025-05-29 23:52:54', '3'),
(8, 6, 2, '2025-05-29 23:52:55', '1'),
(9, 6, 3, '2025-05-29 23:52:55', '1'),
(10, 1, 6, '2025-05-30 23:06:16', '1'),
(11, 3, 7, '2025-05-30 23:10:06', '1'),
(12, 8, 8, '2025-05-30 23:20:41', '1'),
(13, 8, 9, '2025-05-30 23:20:41', '1'),
(14, 9, 10, '2025-05-30 23:42:15', '1'),
(15, 9, 6, '2025-05-30 23:42:15', '1'),
(16, 9, 4, '2025-05-30 23:42:16', '1'),
(17, 10, 11, '2025-05-30 23:56:57', '1'),
(18, 10, 12, '2025-05-31 14:46:16', '1'),
(19, 12, 4, '2025-05-31 15:00:55', '1'),
(20, 12, 13, '2025-05-31 15:00:56', '1'),
(21, 13, 14, '2025-05-31 15:00:56', '1'),
(22, 11, 15, '2025-05-31 15:02:00', '1'),
(23, 14, 16, '2025-05-31 15:02:39', '1'),
(24, 15, 17, '2025-05-31 15:28:25', '1'),
(25, 15, 6, '2025-05-31 15:28:25', '1'),
(26, 15, 4, '2025-05-31 15:28:25', '1'),
(27, 15, 18, '2025-05-31 15:28:25', '1'),
(28, 3, 11, '2025-05-31 15:50:00', '1'),
(29, 16, 5, '2025-05-31 19:51:51', '2'),
(30, 16, 11, '2025-05-31 19:51:51', '2'),
(31, 17, 19, '2025-06-01 14:35:04', '1'),
(32, 17, 4, '2025-06-01 14:35:04', '1'),
(33, 17, 10, '2025-06-01 14:35:04', '1'),
(34, 18, 20, '2025-06-01 14:37:53', '3'),
(35, 20, 7, '2025-06-02 18:48:10', '1'),
(36, 20, 21, '2025-06-02 18:48:10', '1'),
(37, 21, 15, '2025-06-02 18:48:10', '1'),
(38, 21, 22, '2025-06-02 18:48:10', '1'),
(39, 22, 6, '2025-06-02 18:49:39', '1'),
(40, 23, 23, '2025-06-05 14:18:59', '1'),
(41, 23, 4, '2025-06-05 14:18:59', '1'),
(42, 24, 24, '2025-06-05 14:18:59', '1'),
(43, 24, 6, '2025-06-05 14:18:59', '1'),
(44, 25, 25, '2025-06-05 14:18:59', '1'),
(45, 25, 5, '2025-06-05 14:18:59', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrategias_pedagogicas`
--

CREATE TABLE `estrategias_pedagogicas` (
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_evaluacion` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'El estudiante logró hacer todas las consultas y aprendió a hacer lo más básico de la programación', '2025-05-29 20:50:31', '1'),
(2, 'El estudiante definió el proceso de las consultas SQL y logró hacer un proyecto sencillo', '2025-05-29 20:50:31', '1'),
(3, 'El estudiante logró crear un modulo CRUD que cumplió con la expectativa de validación, y tiempo real.', '2025-05-29 20:50:31', '1'),
(4, 'prueba de indicadores, cambié las funciones así que quiero saber si funciona correctamente', '2025-05-29 23:52:54', '1'),
(5, 'parece ser que si', '2025-05-29 23:52:54', '2'),
(6, 'indicador nuevo', '2025-05-29 23:52:54', '1'),
(7, 'El estudiante logra definir una subred', '2025-05-30 23:10:06', '1'),
(8, 'El estudiante logra definir una subred', '2025-05-30 23:20:41', '1'),
(9, 'indicador nuevo', '2025-05-30 23:20:41', '1'),
(10, 'El estudiante logra hacer un modelo de base de datos Entidad Relación hasta la 3ra forma normal', '2025-05-30 23:42:15', '1'),
(11, 'fase 2 indicador de logros', '2025-05-30 23:56:57', '2'),
(12, 'fase 2 indicador específico actualizado', '2025-05-31 14:46:16', '1'),
(13, 'matemáticas indicador...', '2025-05-31 15:00:56', '1'),
(14, 'matrices escalonadas...', '2025-05-31 15:00:56', '1'),
(15, 'fase 3 indicador', '2025-05-31 15:02:00', '1'),
(16, 'funciones indicador...', '2025-05-31 15:02:39', '1'),
(17, 'listas indicador python...', '2025-05-31 15:28:25', '1'),
(18, 'listas indicadores...', '2025-05-31 15:28:25', '1'),
(19, 'Ideario Indicador...', '2025-06-01 14:35:04', '1'),
(20, 'indicador revolución...', '2025-06-01 14:37:53', '1'),
(21, 'Verbo to be indicador...', '2025-06-02 18:48:10', '1'),
(22, 'Pronombres Indicador...', '2025-06-02 18:48:10', '1'),
(23, 'Indicador seguridad...', '2025-06-05 14:18:59', '1'),
(24, 'Cifrado indicador...', '2025-06-05 14:18:59', '1'),
(25, 'formas indicador...', '2025-06-05 14:18:59', '1');

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
  `nombre` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lapso_academico`
--

INSERT INTO `lapso_academico` (`lapso_id`, `nombre`, `fecha_inicio`, `fecha_fin`, `fecha_creacion`, `estatus`) VALUES
(1, '2025-1', '2025-05-29 00:00:00', '2025-07-31 00:00:00', '2025-05-29 21:49:11', '1'),
(2, '2025-2', '2025-10-29 00:00:00', '2025-11-28 00:00:00', '2025-05-29 21:50:09', '2'),
(3, '2026-1', '2026-02-12 00:00:00', '2026-06-27 00:00:00', '2025-05-29 21:55:33', '2'),
(4, '2027-1', '2027-01-29 00:00:00', '2027-06-29 00:00:00', '2025-05-29 22:13:36', '1'),
(5, '2026-II', '2026-07-29 00:00:00', '2026-08-29 00:00:00', '2025-05-30 00:06:58', '2'),
(6, '2025-II', '2025-05-30 00:00:00', '2025-05-31 00:00:00', '2025-05-30 00:08:51', '1'),
(7, '2025-I', '2025-05-30 00:00:00', '2025-05-31 00:00:00', '2025-05-30 00:11:27', '1'),
(8, '2028-1', '2028-01-01 00:00:00', '2028-06-02 00:00:00', '2025-05-30 00:18:59', '2'),
(9, '2029-I', '2029-01-01 00:00:00', '2029-10-04 00:00:00', '2025-06-01 15:25:07', '1'),
(15, '2029-II', '2029-11-02 00:00:00', '2029-11-03 00:00:00', '2025-06-02 01:39:37', '2'),
(16, '2030-I', '2030-01-03 00:00:00', '2030-06-06 00:00:00', '2025-06-02 01:42:51', '1');

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
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificaciones`
--

CREATE TABLE `planificaciones` (
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificaciones_recursos`
--

CREATE TABLE `planificaciones_recursos` (
  `planificacion_recurso_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion_estrategias`
--

CREATE TABLE `planificacion_estrategias` (
  `planificacion_estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion_evaluaciones`
--

CREATE TABLE `planificacion_evaluaciones` (
  `planificacion_evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Informática', '2025-05-29 20:25:29', '1'),
(2, 'Mantenimiento', '2025-05-30 16:42:36', '1'),
(3, 'Veterinaria', '2025-05-30 17:54:33', '1'),
(4, 'Administracion', '2025-06-02 20:17:05', '1'),
(5, 'Mecánica', '2025-06-02 20:17:19', '1'),
(6, 'Arte', '2025-06-02 20:18:51', '1'),
(7, 'Agroalimentaria', '2025-06-06 22:52:56', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Coordinador', '2025-06-06 14:19:36', '1'),
(2, 'Profesor', '2025-06-06 14:19:36', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `seccion` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lapso_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`seccion_id`, `seccion`, `lapso_id`, `fecha_creacion`, `estatus`) VALUES
(1, '31', 1, '2025-06-05 00:50:07', '1'),
(2, '32', 1, '2025-06-05 13:57:47', '1'),
(3, '33', 1, '2025-06-05 13:57:47', '1'),
(4, '34', 1, '2025-06-05 13:57:47', '1'),
(5, '35', 1, '2025-06-05 13:57:47', '1'),
(6, '31', 2, '2025-06-05 14:02:47', '1'),
(7, '32', 2, '2025-06-05 14:02:47', '1'),
(8, '33', 2, '2025-06-05 14:02:47', '1'),
(9, '34', 2, '2025-06-05 14:02:47', '1'),
(10, '35', 2, '2025-06-05 14:02:47', '1'),
(11, '31', 16, '2025-06-06 22:54:16', '1'),
(12, '32', 16, '2025-06-06 22:54:16', '1'),
(13, '33', 16, '2025-06-06 22:54:16', '1'),
(14, '34', 16, '2025-06-06 22:54:16', '1'),
(15, '36', 16, '2025-06-07 00:11:10', '1'),
(16, '31', 4, '2025-06-08 17:23:44', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion_planificaciones`
--

CREATE TABLE `seccion_planificaciones` (
  `seccion_planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
('RE6QcLtp6H0x6nHjx7sudcvGl9X8iMjHoOo6OH9K', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTjU1RHNhbXZBVkJ3Ulo1YU9iRng5dHZVN3hFN3ZXc0lXTUl0eDJLQiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC91c3Vhcmlvcy9jcmVhdGUiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1749596440);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades_curriculares`
--

CREATE TABLE `unidades_curriculares` (
  `codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `semestre` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `proposito` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidades_credito` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `horas_semanales` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidades_curriculares`
--

INSERT INTO `unidades_curriculares` (`codigo`, `nombre`, `pnf_id`, `semestre`, `descripcion`, `proposito`, `unidades_credito`, `horas_semanales`, `fecha_creacion`, `estatus`) VALUES
('ALP312', 'Algorítmica y programación', 1, '1', 'Algorítmica y programación descripción...', 'Algorítmica y programación propósito...', '3', '5', '2025-05-31 15:28:25', '1'),
('BDD736', 'Base de datos', 1, '3', 'Base de datos...', 'Base de datos...', '4', '3', '2025-05-30 23:42:15', '1'),
('FSC233', 'Formación Crítica', 1, '4', 'Descripción de formación crítica...', 'Propósito de formación crítica...', '3', '2', '2025-05-29 23:52:54', '1'),
('IDB335', 'Ideario Bolivariano', 1, '0', 'Descripción de ideario bolivariano...', 'Propósito de ideario bolivariano...', '3', '3', '2025-06-01 14:35:04', '1'),
('IDS321', 'Idiomas dos', 1, '3', 'Descripción de idiomas...', 'Propósito de idiomas...', '5', '6', '2025-06-02 18:48:09', '1'),
('MTC341', 'Matemáticas', 1, '4', 'Descripción de matemáticas...', 'Propósito de matemáticas...', '3', '2', '2025-05-31 15:00:55', '1'),
('POT2312', 'Programación II', 1, '4', 'Descripción de programación...', 'Propósito de programación.....', '5', '4', '2025-05-29 20:50:30', '1'),
('PTO5473', 'Proyecto II', 1, '4', 'Proyecto 2...', 'Proyecto 2...', '4', '5', '2025-05-30 23:20:40', '1'),
('RBO412', 'Revolución Bolivariana', 1, '0', 'Revolución descripción...', 'Revolución Propósito...', '4', '2', '2025-06-01 14:37:53', '1'),
('RCT226', 'Redes del Computador', 1, '4', 'Descripción de redes del computador...', 'Propósito de redes del computador...', '4', '4', '2025-05-29 21:12:10', '1'),
('SDI6233', 'Seguridad Informática', 1, '7', 'Seguridad Descripción...', 'Seguridad Propósito...', '5', '4', '2025-06-05 14:18:59', '1');

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
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `cedula`, `email`, `telefono`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Nasser', 'Daboin', '31215545', 'nasserdaboin@gmail.com', NULL, '$2y$12$PX/8ITFqgpHYffM7q/Ezw./3YC54tJrtITigwutQQGhxw17ssXqK2', NULL, '2025-05-29 20:24:36', '1'),
(4, 'Admin', 'Admin', '99999999', 'admin@example.com', '', '$2y$12$yUsbMhB/u7bKQBqrUymzZObVycHAZyfQcJcz8kT.c0btftsZJ7LnC', NULL, '2025-06-06 22:35:32', '1'),
(5, 'Chanchito', 'Feliz', '00000000', 'chanchitofeliz@example.com', '04327823978', '$2y$12$Yz4fhjA6NsEC8DtF7nNzQ.H1CAei5jc5/wkpdhg3KdRXJUE49/oJu', NULL, '2025-06-06 22:39:33', '1'),
(6, 'jhoel', 'lugo', '31466621', 'jhoel@example.com', '3948193124', '$2y$12$qqZU0ArHcdfyKC1ZmHINJekvrVKHgoBu37CEwnxP38t5JydXaoZn6', NULL, '2025-06-10 23:00:18', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_planificaciones`
--

CREATE TABLE `usuarios_planificaciones` (
  `usuario_planificacion` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, 1, '2025-06-06 14:20:18', '1'),
(2, 1, 2, '2025-06-06 14:22:41', '1'),
(3, 4, 1, '2025-06-06 22:35:32', '1'),
(4, 5, 1, '2025-06-06 22:39:33', '1'),
(5, 5, 2, '2025-06-06 22:39:33', '1'),
(6, 6, 1, '2025-06-10 23:00:18', '1'),
(7, 6, 2, '2025-06-10 23:00:18', '1');

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
-- Indices de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD PRIMARY KEY (`corte_id`);

--
-- Indices de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD PRIMARY KEY (`contenido_id`),
  ADD KEY `contenidos_unidad_codigo_foreign` (`unidad_codigo`);

--
-- Indices de la tabla `contenido_bibliografias`
--
ALTER TABLE `contenido_bibliografias`
  ADD PRIMARY KEY (`contenido_bibliografia_id`),
  ADD KEY `contenido_bibliografias_contenido_id_foreign` (`contenido_id`),
  ADD KEY `contenido_bibliografias_bibliografia_id_foreign` (`bibliografia_id`);

--
-- Indices de la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  ADD PRIMARY KEY (`contenido_indicador_id`),
  ADD KEY `contenido_indicadores_contenido_id_foreign` (`contenido_id`),
  ADD KEY `contenido_indicadores_indicador_id_foreign` (`indicador_id`);

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
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `planificaciones`
--
ALTER TABLE `planificaciones`
  ADD PRIMARY KEY (`planificacion_id`);

--
-- Indices de la tabla `planificaciones_recursos`
--
ALTER TABLE `planificaciones_recursos`
  ADD PRIMARY KEY (`planificacion_recurso_id`),
  ADD KEY `planificaciones_recursos_planificacion_id_foreign` (`planificacion_id`),
  ADD KEY `planificaciones_recursos_recurso_id_foreign` (`recurso_id`);

--
-- Indices de la tabla `planificacion_estrategias`
--
ALTER TABLE `planificacion_estrategias`
  ADD PRIMARY KEY (`planificacion_estrategia_id`),
  ADD KEY `planificacion_estrategias_planificacion_id_foreign` (`planificacion_id`),
  ADD KEY `planificacion_estrategias_estrategia_id_foreign` (`estrategia_id`);

--
-- Indices de la tabla `planificacion_evaluaciones`
--
ALTER TABLE `planificacion_evaluaciones`
  ADD PRIMARY KEY (`planificacion_evaluacion_id`),
  ADD KEY `planificacion_evaluaciones_planificacion_id_foreign` (`planificacion_id`),
  ADD KEY `planificacion_evaluaciones_evaluacion_id_foreign` (`evaluacion_id`);

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
-- Indices de la tabla `seccion_planificaciones`
--
ALTER TABLE `seccion_planificaciones`
  ADD PRIMARY KEY (`seccion_planificacion_id`),
  ADD KEY `seccion_planificaciones_seccion_id_foreign` (`seccion_id`),
  ADD KEY `seccion_planificaciones_planificacion_id_foreign` (`planificacion_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

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
-- Indices de la tabla `usuarios_planificaciones`
--
ALTER TABLE `usuarios_planificaciones`
  ADD PRIMARY KEY (`usuario_planificacion`),
  ADD KEY `usuarios_planificaciones_id_foreign` (`id`),
  ADD KEY `usuarios_planificaciones_planificacion_id_foreign` (`planificacion_id`);

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
  MODIFY `bibliografia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  MODIFY `corte_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  MODIFY `contenido_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `contenido_bibliografias`
--
ALTER TABLE `contenido_bibliografias`
  MODIFY `contenido_bibliografia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  MODIFY `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `estrategias_pedagogicas`
--
ALTER TABLE `estrategias_pedagogicas`
  MODIFY `estrategia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `evaluacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicadores_logros`
--
ALTER TABLE `indicadores_logros`
  MODIFY `indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  MODIFY `lapso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `planificaciones`
--
ALTER TABLE `planificaciones`
  MODIFY `planificacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planificaciones_recursos`
--
ALTER TABLE `planificaciones_recursos`
  MODIFY `planificacion_recurso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planificacion_estrategias`
--
ALTER TABLE `planificacion_estrategias`
  MODIFY `planificacion_estrategia_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planificacion_evaluaciones`
--
ALTER TABLE `planificacion_evaluaciones`
  MODIFY `planificacion_evaluacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pnfs`
--
ALTER TABLE `pnfs`
  MODIFY `pnf_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `recursos`
--
ALTER TABLE `recursos`
  MODIFY `recurso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `seccion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `seccion_planificaciones`
--
ALTER TABLE `seccion_planificaciones`
  MODIFY `seccion_planificacion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios_planificaciones`
--
ALTER TABLE `usuarios_planificaciones`
  MODIFY `usuario_planificacion` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  MODIFY `usuario_rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD CONSTRAINT `contenidos_unidad_codigo_foreign` FOREIGN KEY (`unidad_codigo`) REFERENCES `unidades_curriculares` (`codigo`);

--
-- Filtros para la tabla `contenido_bibliografias`
--
ALTER TABLE `contenido_bibliografias`
  ADD CONSTRAINT `contenido_bibliografias_bibliografia_id_foreign` FOREIGN KEY (`bibliografia_id`) REFERENCES `bibliografias` (`bibliografia_id`),
  ADD CONSTRAINT `contenido_bibliografias_contenido_id_foreign` FOREIGN KEY (`contenido_id`) REFERENCES `contenidos` (`contenido_id`);

--
-- Filtros para la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  ADD CONSTRAINT `contenido_indicadores_contenido_id_foreign` FOREIGN KEY (`contenido_id`) REFERENCES `contenidos` (`contenido_id`),
  ADD CONSTRAINT `contenido_indicadores_indicador_id_foreign` FOREIGN KEY (`indicador_id`) REFERENCES `indicadores_logros` (`indicador_id`);

--
-- Filtros para la tabla `planificaciones_recursos`
--
ALTER TABLE `planificaciones_recursos`
  ADD CONSTRAINT `planificaciones_recursos_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificaciones` (`planificacion_id`),
  ADD CONSTRAINT `planificaciones_recursos_recurso_id_foreign` FOREIGN KEY (`recurso_id`) REFERENCES `recursos` (`recurso_id`);

--
-- Filtros para la tabla `planificacion_estrategias`
--
ALTER TABLE `planificacion_estrategias`
  ADD CONSTRAINT `planificacion_estrategias_estrategia_id_foreign` FOREIGN KEY (`estrategia_id`) REFERENCES `estrategias_pedagogicas` (`estrategia_id`),
  ADD CONSTRAINT `planificacion_estrategias_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificaciones` (`planificacion_id`);

--
-- Filtros para la tabla `planificacion_evaluaciones`
--
ALTER TABLE `planificacion_evaluaciones`
  ADD CONSTRAINT `planificacion_evaluaciones_evaluacion_id_foreign` FOREIGN KEY (`evaluacion_id`) REFERENCES `evaluaciones` (`evaluacion_id`),
  ADD CONSTRAINT `planificacion_evaluaciones_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificaciones` (`planificacion_id`);

--
-- Filtros para la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD CONSTRAINT `secciones_lapso_id_foreign` FOREIGN KEY (`lapso_id`) REFERENCES `lapso_academico` (`lapso_id`);

--
-- Filtros para la tabla `seccion_planificaciones`
--
ALTER TABLE `seccion_planificaciones`
  ADD CONSTRAINT `seccion_planificaciones_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificaciones` (`planificacion_id`),
  ADD CONSTRAINT `seccion_planificaciones_seccion_id_foreign` FOREIGN KEY (`seccion_id`) REFERENCES `secciones` (`seccion_id`);

--
-- Filtros para la tabla `unidades_curriculares`
--
ALTER TABLE `unidades_curriculares`
  ADD CONSTRAINT `unidades_curriculares_pnf_id_foreign` FOREIGN KEY (`pnf_id`) REFERENCES `pnfs` (`pnf_id`);

--
-- Filtros para la tabla `usuarios_planificaciones`
--
ALTER TABLE `usuarios_planificaciones`
  ADD CONSTRAINT `usuarios_planificaciones_id_foreign` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuarios_planificaciones_planificacion_id_foreign` FOREIGN KEY (`planificacion_id`) REFERENCES `planificaciones` (`planificacion_id`);

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
