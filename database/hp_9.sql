-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-03-2026 a las 20:20:14
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
-- Base de datos: `hp_9`
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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `id_bitacora` int(11) NOT NULL,
  `id_users` int(11) NOT NULL,
  `modulo_afectado_bitacora` varchar(255) DEFAULT NULL,
  `tabla_afectada_bitacora` text DEFAULT NULL,
  `id_registro_afectado_bitacora` text DEFAULT NULL,
  `accion_bitacora` enum('CREAR','MODIFICAR','MOSTRAR','ELIMINAR','LOGIN','LOGOUT','REPORTE') DEFAULT NULL,
  `valores_anteriores_bitacora` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_anteriores_bitacora`)),
  `valores_nuevos_bitacora` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`valores_nuevos_bitacora`)),
  `ip_origen_bitacora` varchar(45) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bitacora`
--

INSERT INTO `bitacora` (`id_bitacora`, `id_users`, `modulo_afectado_bitacora`, `tabla_afectada_bitacora`, `id_registro_afectado_bitacora`, `accion_bitacora`, `valores_anteriores_bitacora`, `valores_nuevos_bitacora`, `ip_origen_bitacora`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 'Seguridad', 'users', '1', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-05 23:15:51', '1'),
(2, 1, 'Evaluacion', 'tecnica_evaluacion', '1', 'CREAR', NULL, '{\"nombre_tecnica_evaluacion\":\"yuiyui\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-05T19:18:24.852632Z\",\"fecha_actualizacion\":\"2026-03-05T19:18:24.852641Z\",\"id_tecnica_evaluacion\":1}', '127.0.0.1', '2026-03-05 23:18:24', '1'),
(3, 1, 'Tecnica', 'tecnica_evaluacion', '2', 'CREAR', NULL, '{\"nombre_tecnica_evaluacion\":\"yukuyk\",\"estatus\":\"1\",\"fecha_creacion\":\"2026-03-05T19:18:33.153194Z\",\"fecha_actualizacion\":\"2026-03-05T19:18:33.153210Z\",\"id_tecnica_evaluacion\":2}', '127.0.0.1', '2026-03-05 23:18:33', '1'),
(4, 1, 'Evaluacion', 'tecnica_evaluacion', '2', 'MODIFICAR', '{\"id_tecnica_evaluacion\":2,\"nombre_tecnica_evaluacion\":\"yukuyk\",\"fecha_creacion\":\"2026-03-05 19:18:33\",\"fecha_actualizacion\":\"2026-03-05 19:18:33\",\"estatus\":\"1\"}', '{\"nombre_tecnica_evaluacion\":\"evaluacion del modulo evaluacion\",\"fecha_actualizacion\":\"2026-03-05T19:19:09.495177Z\"}', '127.0.0.1', '2026-03-05 23:19:09', '1'),
(5, 1, 'Tecnica', 'tecnica_evaluacion', '1', 'MODIFICAR', '{\"id_tecnica_evaluacion\":1,\"nombre_tecnica_evaluacion\":\"yuiyui\",\"fecha_creacion\":\"2026-03-05 19:18:24\",\"fecha_actualizacion\":\"2026-03-05 19:18:24\",\"estatus\":\"1\"}', '{\"nombre_tecnica_evaluacion\":\"tecnica del modulo tecnica\",\"fecha_actualizacion\":\"2026-03-05T19:19:30.118765Z\"}', '127.0.0.1', '2026-03-05 23:19:30', '1');

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
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id_contenido` int(11) NOT NULL,
  `titulo_contenido` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3','4') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL,
  `id_lapso` int(11) DEFAULT NULL COMMENT 'Clave foránea de sogac:',
  `dia_inicio_evento` date DEFAULT NULL,
  `dia_fin_evento` date DEFAULT NULL,
  `descripcion_evento` varchar(100) DEFAULT NULL,
  `tipo_evento` enum('1','2','3') DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 2),
(3, '2026_02_12_181809_create_sessions_table', 3);

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
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `nombre_permiso` tinytext DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre_permiso`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'Todos', '2026-03-05 19:14:33', '2026-03-05 19:15:54', ''),
(2, 'Listar Pnf', '2026-03-05 23:15:54', NULL, '1'),
(3, 'Crear Pnf', '2026-03-05 23:15:54', NULL, '1'),
(4, 'Editar Pnf', '2026-03-05 23:15:54', NULL, '1'),
(5, 'Ver Detalles de Pnf', '2026-03-05 23:15:54', NULL, '1'),
(6, 'Listar Contenido', '2026-03-05 23:15:54', NULL, '1'),
(7, 'Crear Contenido', '2026-03-05 23:15:54', NULL, '1'),
(8, 'Editar Contenido', '2026-03-05 23:15:54', NULL, '1'),
(9, 'Ver Detalles de Contenido', '2026-03-05 23:15:54', NULL, '1'),
(10, 'Listar Tema', '2026-03-05 23:15:54', NULL, '1'),
(11, 'Crear Tema', '2026-03-05 23:15:54', NULL, '1'),
(12, 'Editar Tema', '2026-03-05 23:15:54', NULL, '1'),
(13, 'Ver Detalles de Tema', '2026-03-05 23:15:54', NULL, '1'),
(14, 'Crear Usuarios', '2026-03-05 23:15:54', NULL, '1'),
(15, 'Listar Usuarios', '2026-03-05 23:15:54', NULL, '1'),
(16, 'Listar Planificacion', '2026-03-05 23:15:54', NULL, '1'),
(17, 'Crear Planificacion', '2026-03-05 23:15:54', NULL, '1'),
(18, 'Editar Planificacion', '2026-03-05 23:15:54', NULL, '1'),
(19, 'Ver Detalles de Planificacion', '2026-03-05 23:15:54', NULL, '1'),
(20, 'Reporte General de Planificacion', '2026-03-05 23:15:54', NULL, '1'),
(21, 'Reporte Detallado de Planificacion', '2026-03-05 23:15:54', NULL, '1'),
(22, 'Listar Indicador Logro', '2026-03-05 23:15:54', NULL, '1'),
(23, 'Crear Indicador Logro', '2026-03-05 23:15:54', NULL, '1'),
(24, 'Editar Indicador Logro', '2026-03-05 23:15:54', NULL, '1'),
(25, 'Ver Detalles de Indicador Logro', '2026-03-05 23:15:54', NULL, '1'),
(26, 'Listar Bibliografia', '2026-03-05 23:15:54', NULL, '1'),
(27, 'Crear Bibliografia', '2026-03-05 23:15:54', NULL, '1'),
(28, 'Editar Bibliografia', '2026-03-05 23:15:54', NULL, '1'),
(29, 'Ver Detalles de Bibliografia', '2026-03-05 23:15:54', NULL, '1'),
(30, 'Listar Recurso', '2026-03-05 23:15:54', NULL, '1'),
(31, 'Crear Recurso', '2026-03-05 23:15:54', NULL, '1'),
(32, 'Editar Recurso', '2026-03-05 23:15:54', NULL, '1'),
(33, 'Ver Detalles de Recurso', '2026-03-05 23:15:54', NULL, '1'),
(34, 'Listar Estrategia', '2026-03-05 23:15:54', NULL, '1'),
(35, 'Crear Estrategia', '2026-03-05 23:15:54', NULL, '1'),
(36, 'Editar Estrategia', '2026-03-05 23:15:54', NULL, '1'),
(37, 'Ver Detalles de Estrategia', '2026-03-05 23:15:54', NULL, '1'),
(38, 'Listar Tecnica', '2026-03-05 23:15:54', NULL, '1'),
(39, 'Crear Tecnica', '2026-03-05 23:15:54', NULL, '1'),
(40, 'Editar Tecnica', '2026-03-05 23:15:54', NULL, '1'),
(41, 'Ver Detalles de Tecnica', '2026-03-05 23:15:54', NULL, '1'),
(42, 'Listar Evaluacion', '2026-03-05 23:15:54', NULL, '1'),
(43, 'Crear Evaluacion', '2026-03-05 23:15:54', NULL, '1'),
(44, 'Editar Evaluacion', '2026-03-05 23:15:54', NULL, '1'),
(45, 'Ver Detalles de Evaluacion', '2026-03-05 23:15:54', NULL, '1'),
(46, 'Listar Evento', '2026-03-05 23:15:54', NULL, '1'),
(47, 'Crear Evento', '2026-03-05 23:15:54', NULL, '1'),
(48, 'Editar Evento', '2026-03-05 23:15:54', NULL, '1'),
(49, 'Ver Detalles de Evento', '2026-03-05 23:15:54', NULL, '1'),
(50, 'Listar Rol', '2026-03-05 23:15:54', NULL, '1'),
(51, 'Editar Rol', '2026-03-05 23:15:54', NULL, '1'),
(52, 'Listar Bitacora', '2026-03-05 23:15:54', NULL, '1'),
(53, 'Ver Detalles de Bitacora', '2026-03-05 23:15:54', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion`
--

CREATE TABLE `planificacion` (
  `id_planificacion` int(11) NOT NULL,
  `id_profesor_asignado` int(11) DEFAULT NULL COMMENT 'Clave foránea de sogac:',
  `aceptado_vocero` int(11) DEFAULT NULL,
  `aceptado_coordinador` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3','4') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL,
  `nombre_recurso` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `id_rol_permiso` int(11) NOT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL COMMENT 'Clave foránea de sogac:',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol_permiso`, `id_permiso`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 39, 4, '2026-03-05 23:17:34', NULL, '1'),
(2, 40, 4, '2026-03-05 23:17:34', NULL, '1'),
(3, 38, 4, '2026-03-05 23:17:34', NULL, '1'),
(4, 41, 4, '2026-03-05 23:17:34', NULL, '1'),
(5, 43, 4, '2026-03-05 23:17:34', NULL, '1'),
(6, 44, 4, '2026-03-05 23:17:34', NULL, '1'),
(7, 42, 4, '2026-03-05 23:17:34', NULL, '1'),
(8, 45, 4, '2026-03-05 23:17:34', NULL, '1');

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
('ozq9FKLef1uOWWHh4GAqOXYjzEVzbyXXnaw88XUQ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNmZDMHkxZmdBQzRyUXhPa2ZnNE43OVE4a29lNHZjRjNnYU83RzdEOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9ldmFsdWFjaW9uL2xpc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1772738381);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_actividad`
--

CREATE TABLE `tecnica_actividad` (
  `id_tecnica_actividad` int(11) NOT NULL,
  `nombre_tecnica_actividad` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_evaluacion`
--

CREATE TABLE `tecnica_evaluacion` (
  `id_tecnica_evaluacion` int(11) NOT NULL,
  `nombre_tecnica_evaluacion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnica_evaluacion`
--

INSERT INTO `tecnica_evaluacion` (`id_tecnica_evaluacion`, `nombre_tecnica_evaluacion`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 'tecnica del modulo tecnica', '2026-03-05 23:18:24', '2026-03-05 23:19:30', '1'),
(2, 'evaluacion del modulo evaluacion', '2026-03-05 23:18:33', '2026-03-05 23:19:09', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema_unidad`
--

CREATE TABLE `tema_unidad` (
  `id_tema_unidad` int(11) NOT NULL,
  `id_unidad_curricular` varchar(7) DEFAULT NULL COMMENT 'Clave foránea de sogac:',
  `titulo_tema` text DEFAULT NULL,
  `unidad_tema` enum('1','2','3','4') DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_evaluacion`
--

CREATE TABLE `tipo_evaluacion` (
  `id_tipo_evaluacion` int(11) NOT NULL,
  `nombre_tipo_evaluacion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3','4','5') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `email`, `cedula`, `telefono`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Nasser J.', 'Daboin R.', 'nasserdaboin@gmail.com', '31215545', NULL, '$2y$12$rS9/5YQoeAG9lF597ZPOq.wPix4C/vWLo7LWekPhEWYt2fwlZkXeO', NULL, '2026-03-05 19:14:33', '1'),
(2, 'Enmanuel Salas', 'Salas', 'enmanuelsalas0911@gmail.com', '31114131', NULL, '$2y$12$AX2LT7s.7FH2TOv.5KUVrOptXZbn9I9jYkye9WFiYEabcXwCn.vJG', NULL, '2026-03-05 19:14:33', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_usuario_rol` int(11) NOT NULL,
  `id_users` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL COMMENT 'Clave foránea de sogac:',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario_rol`, `id_users`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, 4, '2026-03-05 23:15:51', NULL, '1');

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
  ADD PRIMARY KEY (`id_bitacora`),
  ADD KEY `fk_bit_users` (`id_users`);

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
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id_contenido`);

--
-- Indices de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD PRIMARY KEY (`id_detalle_bibliografia`),
  ADD KEY `fk_dbib_biblio` (`id_bibliografia`),
  ADD KEY `fk_dbib_ucorte` (`id_unidad_corte`);

--
-- Indices de la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  ADD PRIMARY KEY (`id_detalle_contenido`),
  ADD KEY `fk_dcont_ucorte` (`id_unidad_corte`),
  ADD KEY `fk_dcont_cont` (`id_contenido`);

--
-- Indices de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD PRIMARY KEY (`id_detalle_evaluacion`),
  ADD KEY `fk_deval_tipo` (`id_tipo_evaluacion`),
  ADD KEY `fk_deval_tecnica` (`id_tecnica_evaluacion`),
  ADD KEY `fk_deval_inst` (`id_instrumento`),
  ADD KEY `fk_deval_ucorte` (`id_unidad_corte`);

--
-- Indices de la tabla `detalle_objetivo`
--
ALTER TABLE `detalle_objetivo`
  ADD PRIMARY KEY (`id_detalle_objetivo`),
  ADD KEY `fk_dobj_cont` (`id_contenido`),
  ADD KEY `fk_dobj_obj` (`id_objetivo`);

--
-- Indices de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  ADD PRIMARY KEY (`id_detalle_recurso`),
  ADD KEY `fk_drec_recurso` (`id_recurso`),
  ADD KEY `fk_drec_ucorte` (`id_unidad_corte`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id_evento`);

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
  ADD KEY `fk_obj_tema` (`id_tema_unidad`);

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
  ADD KEY `fk_rperm_permiso` (`id_permiso`);

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
  ADD KEY `fk_ucorte_plan` (`id_planificacion`),
  ADD KEY `fk_ucorte_tecnica` (`id_tecnica_actividad`);

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
  ADD KEY `fk_urol_users` (`id_users`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bibliografia`
--
ALTER TABLE `bibliografia`
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id_contenido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  MODIFY `id_detalle_bibliografia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  MODIFY `id_detalle_contenido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  MODIFY `id_detalle_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_objetivo`
--
ALTER TABLE `detalle_objetivo`
  MODIFY `id_detalle_objetivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  MODIFY `id_detalle_recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `instrumento`
--
ALTER TABLE `instrumento`
  MODIFY `id_instrumento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  MODIFY `id_objetivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  MODIFY `id_planificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  MODIFY `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tecnica_actividad`
--
ALTER TABLE `tecnica_actividad`
  MODIFY `id_tecnica_actividad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tecnica_evaluacion`
--
ALTER TABLE `tecnica_evaluacion`
  MODIFY `id_tecnica_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tema_unidad`
--
ALTER TABLE `tema_unidad`
  MODIFY `id_tema_unidad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_evaluacion`
--
ALTER TABLE `tipo_evaluacion`
  MODIFY `id_tipo_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unidad_corte`
--
ALTER TABLE `unidad_corte`
  MODIFY `id_unidad_corte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `id_usuario_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD CONSTRAINT `fk_bit_users` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD CONSTRAINT `fk_dbib_biblio` FOREIGN KEY (`id_bibliografia`) REFERENCES `bibliografia` (`id_bibliografia`),
  ADD CONSTRAINT `fk_dbib_ucorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `detalle_contenido`
--
ALTER TABLE `detalle_contenido`
  ADD CONSTRAINT `fk_dcont_cont` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`),
  ADD CONSTRAINT `fk_dcont_ucorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD CONSTRAINT `fk_deval_inst` FOREIGN KEY (`id_instrumento`) REFERENCES `instrumento` (`id_instrumento`),
  ADD CONSTRAINT `fk_deval_tecnica` FOREIGN KEY (`id_tecnica_evaluacion`) REFERENCES `tecnica_evaluacion` (`id_tecnica_evaluacion`),
  ADD CONSTRAINT `fk_deval_tipo` FOREIGN KEY (`id_tipo_evaluacion`) REFERENCES `tipo_evaluacion` (`id_tipo_evaluacion`),
  ADD CONSTRAINT `fk_deval_ucorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `detalle_objetivo`
--
ALTER TABLE `detalle_objetivo`
  ADD CONSTRAINT `fk_dobj_cont` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`),
  ADD CONSTRAINT `fk_dobj_obj` FOREIGN KEY (`id_objetivo`) REFERENCES `objetivo` (`id_objetivo`);

--
-- Filtros para la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  ADD CONSTRAINT `fk_drec_recurso` FOREIGN KEY (`id_recurso`) REFERENCES `recurso` (`id_recurso`),
  ADD CONSTRAINT `fk_drec_ucorte` FOREIGN KEY (`id_unidad_corte`) REFERENCES `unidad_corte` (`id_unidad_corte`);

--
-- Filtros para la tabla `objetivo`
--
ALTER TABLE `objetivo`
  ADD CONSTRAINT `fk_obj_tema` FOREIGN KEY (`id_tema_unidad`) REFERENCES `tema_unidad` (`id_tema_unidad`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `fk_rperm_permiso` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`);

--
-- Filtros para la tabla `unidad_corte`
--
ALTER TABLE `unidad_corte`
  ADD CONSTRAINT `fk_ucorte_plan` FOREIGN KEY (`id_planificacion`) REFERENCES `planificacion` (`id_planificacion`),
  ADD CONSTRAINT `fk_ucorte_tecnica` FOREIGN KEY (`id_tecnica_actividad`) REFERENCES `tecnica_actividad` (`id_tecnica_actividad`);

--
-- Filtros para la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD CONSTRAINT `fk_urol_users` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
