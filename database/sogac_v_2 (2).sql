-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-12-2025 a las 13:11:05
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
-- Base de datos: `sogac_v_2`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id_contenido` int(11) NOT NULL,
  `id_unidad_curricular` int(11) DEFAULT NULL,
  `titulo_contenido` text DEFAULT NULL,
  `descripcion_contenido` text DEFAULT NULL,
  `corte_contenido` enum('1','2','3','4') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `corte`
--

CREATE TABLE `corte` (
  `id_corte` int(11) NOT NULL,
  `id_planificacion` int(11) DEFAULT NULL,
  `numero_corte` enum('1','2','3','4') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_estrategia_pedagogica`
--

CREATE TABLE `detalle_estrategia_pedagogica` (
  `id_detalle_estrategia_pedagogica` int(11) NOT NULL,
  `id_estrategia_pedagogica` int(11) DEFAULT NULL,
  `id_corte` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evaluacion`
--

CREATE TABLE `detalle_evaluacion` (
  `id_detalle_evaluacion` int(11) NOT NULL,
  `id_evaluacion` int(11) DEFAULT NULL,
  `id_tecnica` int(11) DEFAULT NULL,
  `ponderacion_detalle_evaluacion` float DEFAULT NULL,
  `id_corte` int(11) DEFAULT NULL,
  `fecha_evaluacion_detalle_evaluacion` date DEFAULT NULL,
  `forma_participacion_detalle_evaluacion` enum('1','2','3') DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3','4') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_indicador`
--

CREATE TABLE `detalle_indicador` (
  `id_detalle_indicador` int(11) NOT NULL,
  `id_detalle_tema` int(11) DEFAULT NULL,
  `id_indicador_logro` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_recurso`
--

CREATE TABLE `detalle_recurso` (
  `id_detalle_recurso` int(11) NOT NULL,
  `id_recurso` int(11) DEFAULT NULL,
  `id_corte` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_tema`
--

CREATE TABLE `detalle_tema` (
  `id_detalle_tema` int(11) NOT NULL,
  `id_tema` int(11) DEFAULT NULL,
  `id_corte` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(4, '2025_12_06_033754_create_notifications_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_rechazo`
--

CREATE TABLE `motivo_rechazo` (
  `id_motivo_rechazo` int(11) NOT NULL,
  `descripcion_motivo_rechazo` text DEFAULT NULL,
  `id_corte` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(2, 'aguja ', NULL, NULL, NULL),
(3, 'julian', NULL, NULL, NULL);

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
('M09W5Thl9FP5VxTtbm7dPWBwUqfITJcN0MPZLnSL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRGhPSUg3Y0FzaEhiOGRQR05ETGozcUJjOWtzb0ZnVWhHOFhWN3cxTiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3Byb2ZpbGUiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyNzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766232569),
('x2bHtnmTRV8RLooeYLhu7bZzbi6qYwEeMGdrXvC3', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQlJrUElvaVpyM0FzWGZUNnpCQXZ6alVaZk93Mm5qbkFsNXlDS2hNZCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3BuZi9saXN0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1766232618);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema`
--

CREATE TABLE `tema` (
  `id_tema` int(11) NOT NULL,
  `titulo_tema` text DEFAULT NULL,
  `descripcion_tema` text DEFAULT NULL,
  `id_contenido` int(11) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'Nasser J.', 'Daboin R.', 'nasserdaboin@gmail.com', '31215545', '04127827954', '$2y$12$fJUskRZ71zD7gFvpWtBp3OlKEPi/b/NY980PeASGA4jkPVioV/J5C', 'Yw5taDlEsXFTLlvUkbTqA2S2T4thkL4s2ZFjle6aBc3KsqC6RtBtLmCHh1av', '2025-06-27 02:08:08', '1');

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
-- Indices de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD PRIMARY KEY (`id_calendario_academico`),
  ADD KEY `id_lapso_academico` (`id_lapso_academico`);

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id_contenido`),
  ADD KEY `id_unidad_curricular` (`id_unidad_curricular`);

--
-- Indices de la tabla `corte`
--
ALTER TABLE `corte`
  ADD PRIMARY KEY (`id_corte`),
  ADD KEY `id_planificacion` (`id_planificacion`);

--
-- Indices de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD PRIMARY KEY (`id_detalle_bibliografia`),
  ADD KEY `id_planificacion` (`id_planificacion`),
  ADD KEY `id_bibliografia` (`id_bibliografia`);

--
-- Indices de la tabla `detalle_estrategia_pedagogica`
--
ALTER TABLE `detalle_estrategia_pedagogica`
  ADD PRIMARY KEY (`id_detalle_estrategia_pedagogica`),
  ADD KEY `id_estrategia_pedagogica` (`id_estrategia_pedagogica`),
  ADD KEY `id_corte` (`id_corte`);

--
-- Indices de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD PRIMARY KEY (`id_detalle_evaluacion`),
  ADD KEY `id_evaluacion` (`id_evaluacion`),
  ADD KEY `id_tecnica` (`id_tecnica`),
  ADD KEY `id_corte` (`id_corte`);

--
-- Indices de la tabla `detalle_indicador`
--
ALTER TABLE `detalle_indicador`
  ADD PRIMARY KEY (`id_detalle_indicador`),
  ADD KEY `id_indicador_logro` (`id_indicador_logro`),
  ADD KEY `id_detalle_tema` (`id_detalle_tema`);

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
  ADD KEY `id_corte` (`id_corte`);

--
-- Indices de la tabla `detalle_tema`
--
ALTER TABLE `detalle_tema`
  ADD PRIMARY KEY (`id_detalle_tema`),
  ADD KEY `id_tema` (`id_tema`),
  ADD KEY `id_corte` (`id_corte`);

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
  ADD KEY `id_corte` (`id_corte`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

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
  ADD PRIMARY KEY (`id_tema`),
  ADD KEY `id_contenido` (`id_contenido`);

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
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  MODIFY `id_calendario_academico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contenido`
--
ALTER TABLE `contenido`
  MODIFY `id_contenido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `corte`
--
ALTER TABLE `corte`
  MODIFY `id_corte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  MODIFY `id_detalle_bibliografia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_estrategia_pedagogica`
--
ALTER TABLE `detalle_estrategia_pedagogica`
  MODIFY `id_detalle_estrategia_pedagogica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  MODIFY `id_detalle_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_indicador`
--
ALTER TABLE `detalle_indicador`
  MODIFY `id_detalle_indicador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_profesor_asignado`
--
ALTER TABLE `detalle_profesor_asignado`
  MODIFY `id_detalle_profesor_asignado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_recurso`
--
ALTER TABLE `detalle_recurso`
  MODIFY `id_detalle_recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_tema`
--
ALTER TABLE `detalle_tema`
  MODIFY `id_detalle_tema` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_unidad_curricular`
--
ALTER TABLE `detalle_unidad_curricular`
  MODIFY `id_detalle_unidad_curricular` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estrategia_pedagogica`
--
ALTER TABLE `estrategia_pedagogica`
  MODIFY `id_estrategia_pedagogica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiante_seccion`
--
ALTER TABLE `estudiante_seccion`
  MODIFY `id_estudiante_seccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicador_logro`
--
ALTER TABLE `indicador_logro`
  MODIFY `id_indicador_logro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  MODIFY `id_lapso_academico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `malla_academica`
--
ALTER TABLE `malla_academica`
  MODIFY `id_malla_academica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `malla_academica_detalle`
--
ALTER TABLE `malla_academica_detalle`
  MODIFY `id_malla_academica_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `motivo_rechazo`
--
ALTER TABLE `motivo_rechazo`
  MODIFY `id_motivo_rechazo` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_planificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pnf`
--
ALTER TABLE `pnf`
  MODIFY `id_pnf` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_seccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `semestre`
--
ALTER TABLE `semestre`
  MODIFY `id_semestre` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tecnica`
--
ALTER TABLE `tecnica`
  MODIFY `id_tecnica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tema`
--
ALTER TABLE `tema`
  MODIFY `id_tema` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unidad_curricular`
--
ALTER TABLE `unidad_curricular`
  MODIFY `id_unidad_curricular` int(11) NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD CONSTRAINT `contenido_ibfk_1` FOREIGN KEY (`id_unidad_curricular`) REFERENCES `unidad_curricular` (`id_unidad_curricular`);

--
-- Filtros para la tabla `corte`
--
ALTER TABLE `corte`
  ADD CONSTRAINT `corte_ibfk_1` FOREIGN KEY (`id_planificacion`) REFERENCES `planificacion` (`id_planificacion`);

--
-- Filtros para la tabla `detalle_bibliografia`
--
ALTER TABLE `detalle_bibliografia`
  ADD CONSTRAINT `detalle_bibliografia_ibfk_1` FOREIGN KEY (`id_planificacion`) REFERENCES `planificacion` (`id_planificacion`),
  ADD CONSTRAINT `detalle_bibliografia_ibfk_2` FOREIGN KEY (`id_bibliografia`) REFERENCES `bibliografia` (`id_bibliografia`);

--
-- Filtros para la tabla `detalle_estrategia_pedagogica`
--
ALTER TABLE `detalle_estrategia_pedagogica`
  ADD CONSTRAINT `detalle_estrategia_pedagogica_ibfk_1` FOREIGN KEY (`id_estrategia_pedagogica`) REFERENCES `estrategia_pedagogica` (`id_estrategia_pedagogica`),
  ADD CONSTRAINT `detalle_estrategia_pedagogica_ibfk_2` FOREIGN KEY (`id_corte`) REFERENCES `corte` (`id_corte`);

--
-- Filtros para la tabla `detalle_evaluacion`
--
ALTER TABLE `detalle_evaluacion`
  ADD CONSTRAINT `detalle_evaluacion_ibfk_1` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id_evaluacion`),
  ADD CONSTRAINT `detalle_evaluacion_ibfk_2` FOREIGN KEY (`id_tecnica`) REFERENCES `tecnica` (`id_tecnica`),
  ADD CONSTRAINT `detalle_evaluacion_ibfk_3` FOREIGN KEY (`id_corte`) REFERENCES `corte` (`id_corte`);

--
-- Filtros para la tabla `detalle_indicador`
--
ALTER TABLE `detalle_indicador`
  ADD CONSTRAINT `detalle_indicador_ibfk_1` FOREIGN KEY (`id_indicador_logro`) REFERENCES `indicador_logro` (`id_indicador_logro`),
  ADD CONSTRAINT `detalle_indicador_ibfk_2` FOREIGN KEY (`id_detalle_tema`) REFERENCES `detalle_tema` (`id_detalle_tema`);

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
  ADD CONSTRAINT `detalle_recurso_ibfk_2` FOREIGN KEY (`id_corte`) REFERENCES `corte` (`id_corte`);

--
-- Filtros para la tabla `detalle_tema`
--
ALTER TABLE `detalle_tema`
  ADD CONSTRAINT `detalle_tema_ibfk_1` FOREIGN KEY (`id_tema`) REFERENCES `tema` (`id_tema`),
  ADD CONSTRAINT `detalle_tema_ibfk_2` FOREIGN KEY (`id_corte`) REFERENCES `corte` (`id_corte`);

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
  ADD CONSTRAINT `motivo_rechazo_ibfk_1` FOREIGN KEY (`id_corte`) REFERENCES `corte` (`id_corte`);

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
-- Filtros para la tabla `tema`
--
ALTER TABLE `tema`
  ADD CONSTRAINT `tema_ibfk_1` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`);

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
