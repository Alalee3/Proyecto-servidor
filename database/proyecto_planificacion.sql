-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2025 a las 05:01:04
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
-- Base de datos: `proyecto_planificacion`
--

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
  `unidad_codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenidos`
--

INSERT INTO `contenidos` (`contenido_id`, `unidad_codigo`, `titulo`, `descripcion`, `fecha_creacion`, `estatus`) VALUES
(1, 'PTO312', 'CSS', 'una introducción básica a CSS', '2025-05-28 21:55:06', '1'),
(2, 'PTO312', 'HTML', 'introducción Básica a HTML', '2025-05-28 21:55:06', '1'),
(3, 'poo643', 'khffwwsr', 'khfgdseaseses', '2025-05-29 00:31:19', '1'),
(4, 'K841KC', 'askdhasudgyasd', 'asdjkahsdtasydasd', '2025-05-29 00:44:37', '1'),
(5, 'K841KC', 'iasduiasudasd', 'asdakhsdjhasud', '2025-05-29 00:44:37', '1'),
(6, 'K841KC', 'asdkashdjhasasd', 'askdhajsdhasdjhasd', '2025-05-29 00:44:37', '1'),
(7, '7777i4', 'asdkahsdjkaskdasd', 'asdasdhjasdasd', '2025-05-29 00:45:49', '1'),
(8, '77Ka33', 'Modelo E/R', 'descripcion del modelo E/R', '2025-05-29 01:16:16', '1'),
(9, '77Ka33', 'Base de datos avanzada', 'descripcion....', '2025-05-29 01:16:16', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_indicadores`
--

CREATE TABLE `contenido_indicadores` (
  `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL,
  `contenido_id` bigint(20) UNSIGNED NOT NULL,
  `indicador_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contenido_indicadores`
--

INSERT INTO `contenido_indicadores` (`contenido_indicador_id`, `contenido_id`, `indicador_id`) VALUES
(1, 3, 1),
(2, 4, 2),
(3, 5, 3),
(4, 7, 4),
(5, 7, 5),
(6, 7, 6),
(7, 8, 7),
(8, 8, 2),
(9, 9, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrategias_pedagogicas`
--

CREATE TABLE `estrategias_pedagogicas` (
  `estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `tecnica` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_evaluacion` datetime NOT NULL
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
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `indicadores_logros`
--

INSERT INTO `indicadores_logros` (`indicador_id`, `indicador`, `fecha_creacion`) VALUES
(1, 'gdsdfhbjknkjhvjon', '2025-05-29 00:31:19'),
(2, 'indicador', '2025-05-29 00:44:37'),
(3, 'kiajsdiaisjda', '2025-05-29 00:44:37'),
(4, 'asfasasdasd', '2025-05-29 00:45:49'),
(5, 'asdasdasdasd', '2025-05-29 00:45:49'),
(6, 'asdasdasd', '2025-05-29 00:45:49'),
(7, 'el estudiante logra hacer....', '2025-05-29 01:16:16'),
(8, 'el estudiante logra....', '2025-05-29 01:16:16');

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
  `nombre` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lapso_academico`
--

INSERT INTO `lapso_academico` (`lapso_id`, `nombre`, `fecha_inicio`, `fecha_fin`, `fecha_creacion`, `estatus`) VALUES
(1, '2025-2', '2025-05-29 00:00:00', '2025-09-25 00:00:00', '2025-05-29 02:02:10', '1');

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
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificaciones_recursos`
--

CREATE TABLE `planificaciones_recursos` (
  `planificacion_recurso_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `recurso_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion_estrategias`
--

CREATE TABLE `planificacion_estrategias` (
  `planificacion_estrategia_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `estrategia_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion_evaluaciones`
--

CREATE TABLE `planificacion_evaluaciones` (
  `planificacion_evaluacion_id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL,
  `evaluacion_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pnfs`
--

CREATE TABLE `pnfs` (
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pnfs`
--

INSERT INTO `pnfs` (`pnf_id`, `nombre`, `fecha_creacion`, `estatus`) VALUES
(1, 'Earum cupiditate sed aut et.', '2025-05-11 15:33:20', '1'),
(2, 'Voluptatem aut quam ut consequatur quos perspiciatis praesentium voluptas.', '2025-05-11 15:33:20', '1'),
(3, 'Distinctio non eaque sit accusantium a dolor recusandae.', '2025-05-11 15:33:21', '1'),
(4, 'Tempore at doloremque deserunt suscipit adipisci voluptatum aut.', '2025-05-11 15:33:21', '1'),
(5, 'Culpa expedita voluptate corrupti et dolorem officiis laudantium qui.', '2025-05-11 15:33:21', '1'),
(6, 'Quis molestiae nesciunt facilis maiores voluptas vel.', '2025-05-11 15:33:21', '1'),
(7, 'Repellendus nemo et reiciendis ea.', '2025-05-11 15:33:21', '1'),
(8, 'Qui officia soluta dolorem nam et doloremque.', '2025-05-11 15:33:21', '1'),
(9, 'Deleniti blanditiis enim aut porro necessitatibus maxime.', '2025-05-11 15:33:21', '1'),
(10, 'Molestiae blanditiis minus ut.', '2025-05-11 15:33:21', '1'),
(11, 'Omnis magnam ea occaecati.', '2025-05-11 15:33:21', '1'),
(12, 'Quo et ut et beatae.', '2025-05-11 15:33:21', '1'),
(13, 'Temporibus alias inventore eaque nostrum aperiam ipsam.', '2025-05-11 15:33:21', '1'),
(14, 'Qui eum explicabo nisi ut dolores voluptate.', '2025-05-11 15:33:21', '1'),
(15, 'Amet possimus voluptatem dolores ut voluptatibus qui.', '2025-05-11 15:33:21', '1'),
(16, 'Eligendi sequi atque explicabo et dolorum nam.', '2025-05-11 15:33:22', '1'),
(17, 'Labore omnis vel dolores saepe dolorum.', '2025-05-11 15:33:22', '1'),
(18, 'Nobis dolorum quas ea harum.', '2025-05-11 15:33:22', '1'),
(19, 'Minima ea voluptatem cumque quos est et.', '2025-05-11 15:33:22', '1'),
(20, 'Ex ad earum corporis corrupti et expedita.', '2025-05-11 15:33:22', '1'),
(21, 'Impedit officia expedita soluta eos ut at ut.', '2025-05-11 15:33:22', '1'),
(22, 'Et ipsum pariatur consequatur eum neque voluptatem.', '2025-05-11 15:33:22', '1'),
(23, 'Commodi laborum fugiat et exercitationem quam.', '2025-05-11 15:33:22', '1'),
(24, 'Qui totam repellat quia dolore quo et in nemo.', '2025-05-11 15:33:22', '1'),
(25, 'Hic voluptatem eos omnis culpa quo debitis vel enim.', '2025-05-11 15:33:22', '1'),
(26, 'Rerum iure odio aliquid.', '2025-05-11 15:33:22', '1'),
(27, 'Tenetur vitae repellendus occaecati qui debitis placeat.', '2025-05-11 15:33:22', '1'),
(28, 'Sit qui aliquid nemo odio.', '2025-05-11 15:33:23', '1'),
(29, 'Optio consectetur et qui hic molestiae adipisci eum.', '2025-05-11 15:33:23', '1'),
(30, 'Iste velit at ut explicabo.', '2025-05-11 15:33:23', '1'),
(31, 'Ducimus hic qui est sed mollitia sint.', '2025-05-11 15:33:23', '1'),
(32, 'Consequuntur et ullam autem eius non.', '2025-05-11 15:33:23', '1'),
(33, 'Nostrum hic repellendus itaque deleniti quisquam eveniet culpa.', '2025-05-11 15:33:23', '1'),
(34, 'Quo esse natus quas quam aliquam dolores.', '2025-05-11 15:33:23', '1'),
(35, 'Voluptates facere et consequatur quam voluptatibus repellat.', '2025-05-11 15:33:23', '1'),
(36, 'Tempora nihil velit architecto voluptatem consequatur.', '2025-05-11 15:33:23', '1'),
(37, 'Libero illum sit quasi cupiditate minima veniam saepe.', '2025-05-11 15:33:23', '1'),
(38, 'Velit occaecati esse placeat provident dolor.', '2025-05-11 15:33:24', '1'),
(39, 'Ut autem et fuga nulla perspiciatis et.', '2025-05-11 15:33:24', '1'),
(40, 'Illum minima maxime ut doloremque sequi.', '2025-05-11 15:33:24', '1'),
(41, 'Dolore ipsum dolore quisquam voluptas id delectus quisquam.', '2025-05-11 15:33:24', '1'),
(42, 'Eum quo et ipsam fugit esse odit voluptatem optio.', '2025-05-11 15:33:24', '1'),
(43, 'Natus voluptates sint perferendis nisi.', '2025-05-11 15:33:24', '1'),
(44, 'Tenetur libero labore iusto molestias deserunt.', '2025-05-11 15:33:24', '1'),
(45, 'Ut asperiores ex aperiam.', '2025-05-11 15:33:24', '1'),
(46, 'Sed aliquam aut sed nobis.', '2025-05-11 15:33:24', '1'),
(47, 'Quos consectetur minima ut deleniti voluptatem.', '2025-05-11 15:33:24', '1'),
(48, 'Itaque necessitatibus vitae voluptas accusantium dolore eum officia.', '2025-05-11 15:33:24', '1'),
(49, 'Laboriosam culpa dolores voluptates adipisci ut alias deserunt suscipit.', '2025-05-11 15:33:24', '1'),
(50, 'Quo omnis qui temporibus qui.', '2025-05-11 15:33:24', '1'),
(51, 'Nasser Jose', '2025-05-14 22:41:50', '1'),
(52, 'informatica', '2025-05-14 22:52:16', '1'),
(53, 'mantenimiento', '2025-05-14 22:58:57', '1'),
(54, 'hola mundo', '2025-05-15 00:09:39', '1'),
(55, 'as3', '2025-05-19 16:56:12', '1'),
(56, 'mecanica', '2025-05-22 23:48:21', '1'),
(57, 'veterinaria', '2025-05-22 23:48:57', '1'),
(58, 'gerencia', '2025-05-22 23:51:09', '1'),
(59, 'pnf', '2025-05-25 22:47:03', '1'),
(60, 'hola', '2025-05-25 22:57:57', '1'),
(61, 'pnf de prueba 2', '2025-05-25 23:03:20', '1'),
(62, 'Nasser Jose', '2025-05-25 23:04:35', '1'),
(63, 'Nasser Jose', '2025-05-25 23:05:11', '1'),
(64, 'datos sin nada', '2025-05-25 23:06:00', '1'),
(65, 'algo', '2025-05-25 23:07:39', '1'),
(66, '123', '2025-05-25 23:19:25', '1'),
(67, 'batman', '2025-05-25 23:19:48', '1'),
(68, 'jelllo', '2025-05-25 23:20:17', '1'),
(69, 'hola mundo dos', '2025-05-25 23:23:08', '1'),
(70, 'Harvard', '2025-05-25 23:23:57', '1'),
(71, 'Español', '2025-05-25 23:31:00', '1'),
(72, 'hola mundo tres', '2025-05-25 23:31:07', '1'),
(73, 'kekkai orai', '2025-05-25 23:37:20', '1'),
(74, 'algo más', '2025-05-25 23:56:43', '1'),
(75, 'hola do', '2025-05-25 23:58:46', '1'),
(76, 'informatical', '2025-05-26 00:52:48', '1'),
(77, 'Pnf Creado para prueba', '2025-05-26 02:18:27', '1'),
(78, 'hola mundoooooo', '2025-05-26 02:18:49', '1'),
(79, 'hola otra vez áéíóúÑ', '2025-05-27 01:57:19', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas_seguridad`
--

CREATE TABLE `preguntas_seguridad` (
  `pregunta_id` bigint(20) UNSIGNED NOT NULL,
  `pregunta` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `recurso_id` bigint(20) UNSIGNED NOT NULL,
  `nombre` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `nivel_de_acceso` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `seccion_id` bigint(20) UNSIGNED NOT NULL,
  `seccion` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lapso_id` bigint(20) UNSIGNED NOT NULL,
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL
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
('PaiBvC7Iz2rJQb0PhsLysAn8cAvTKSGZnQDR9H6A', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTkRIaUN3RzZVMmVrSkFyMVJmNFlhZnNjR09qNmFTRHNWcDYyazhIZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC91bmlkYWRfY3VycmljdWxhci9jcmVhdGUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1748487571);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades_curriculares`
--

CREATE TABLE `unidades_curriculares` (
  `codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pnf_id` bigint(20) UNSIGNED NOT NULL,
  `semestre` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `proposito` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidades_credito` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `unidades_curriculares`
--

INSERT INTO `unidades_curriculares` (`codigo`, `pnf_id`, `semestre`, `nombre`, `descripcion`, `proposito`, `unidades_credito`, `fecha_creacion`, `estatus`) VALUES
('39ESP9', 71, '8', 'Gramatica', 'una descripcion', 'un proposito', '4', '2025-05-27 21:39:15', '1'),
('39ESP95', 70, '2', 'informatica', 'asdasdasd', 'asdasdasd', '4', '2025-05-27 21:42:01', '1'),
('4B3491', 76, '5', 'hola mundo', 'aksdasdjaksd', 'asdkajsdkajskdasd', '3', '2025-05-28 16:00:38', '1'),
('774B12', 71, '3', 'adios mundo', 'aasdkasd', 'asdkajsdkjads', '5', '2025-05-28 15:56:59', '1'),
('7777i4', 5, '5', 'hola mundo 3', 'asdkhasdjaksd', 'asdkasdkajksda', '3', '2025-05-29 00:45:49', '1'),
('77Ka33', 52, '4', 'Base de datos', 'una base de datos es importante', 'las bases de datos son el principio de un sistema', '3', '2025-05-29 01:16:16', '1'),
('AAD802', 47, '1', 'Quisquam voluptate eaque quibusdam.', 'Qui enim et qui dolorem facere placeat aut. Illo dolorem exercitationem officia ad est similique molestiae voluptas.', 'Porro distinctio rerum dolore.', '4', '2025-05-22 17:27:33', '1'),
('AIC136', 11, '8', 'Qui tempora voluptatem.', 'Occaecati excepturi temporibus ab sint pariatur praesentium porro. Quae vero architecto repudiandae molestias. Perferendis enim sit consequatur in quibusdam ut laboriosam.', 'Sed debitis quia laborum voluptatibus voluptatum.', '6', '2025-05-22 17:27:32', '1'),
('AOD347', 29, '5', 'Minus dolor est porro.', 'Ea quia iure mollitia animi. Saepe qui voluptatem totam. Ullam esse et eius.', 'Modi sit eius ut deleniti quas.', '5', '2025-05-22 17:27:33', '1'),
('BFR947', 45, '7', 'Ut et et.', 'Ea est voluptates aut qui nostrum nam maiores numquam. Ex asperiores doloremque totam minima nihil voluptatem minima. Officia ducimus suscipit blanditiis nihil a.', 'Aperiam molestiae fugiat soluta.', '3', '2025-05-22 17:27:31', '1'),
('CFV565', 23, '6', 'Neque numquam tenetur.', 'Magni illum qui quas consequatur qui dolorem deleniti expedita. Ut minima repudiandae est facilis quos.', 'Consequatur omnis id vero sunt et amet ab.', '2', '2025-05-22 17:27:32', '1'),
('CFZ967', 10, '5', 'Aliquam rerum voluptas.', 'Et sunt nulla officia et voluptas molestias quos. Atque laboriosam ut nemo omnis consequuntur veniam. Debitis in dolorum sequi voluptas omnis explicabo.', 'Quo quam aut et itaque.', '4', '2025-05-22 17:27:34', '1'),
('ETG848', 53, '1', 'Voluptatem commodi ipsam incidunt.', 'Qui dignissimos a in autem voluptas vel soluta. Ea ut est et sapiente eligendi dolorem.', 'Placeat et quidem quisquam et quos.', '6', '2025-05-22 17:27:34', '1'),
('FNA261', 20, '1', 'Minima laudantium repellendus velit.', 'Qui sunt incidunt est a omnis molestiae autem. Nostrum molestiae in distinctio consectetur.', 'Quo adipisci porro aliquam nihil dolorem sit.', '6', '2025-05-22 17:27:31', '1'),
('FQV516', 51, '1', 'Non modi sed.', 'Nulla rerum quasi reprehenderit soluta ut aut non. Repellendus nemo modi dolores in voluptas quis dolorem.', 'Facere esse est non enim.', '3', '2025-05-22 17:27:33', '1'),
('FUL777', 50, '6', 'Aut id a recusandae.', 'Illo accusantium minus sed. Corrupti optio voluptatibus quasi eligendi nam harum ut.', 'Exercitationem consectetur corporis quasi porro.', '4', '2025-05-22 17:27:32', '1'),
('FVZ007', 32, '1', 'Et deleniti quisquam vel.', 'Modi consequatur quo ducimus rerum ut distinctio. Quas optio sit ut nobis eum esse quos.', 'Nihil et occaecati officiis qui.', '6', '2025-05-22 17:27:34', '1'),
('ICP059', 36, '5', 'Fuga non.', 'Et magni libero et sed. Minus corrupti molestiae sit sit pariatur temporibus recusandae. Et dolores minima harum qui aut error quasi quaerat.', 'Numquam ipsum nemo repellendus dolorem magnam.', '6', '2025-05-22 17:27:33', '1'),
('IGU769', 41, '2', 'Laborum id alias.', 'Modi aliquid provident quia sequi qui. Quo animi odit velit facere possimus cumque. Consequuntur facere ratione quod sit.', 'Quis accusamus nemo aut unde corporis dolorem assumenda.', '4', '2025-05-22 17:27:31', '1'),
('JFC967', 18, '8', 'Aut voluptatem ratione.', 'Repellat blanditiis mollitia eum est. Modi expedita aut qui minima aut esse.', 'Et ut ut alias.', '4', '2025-05-22 17:27:32', '1'),
('JLD035', 48, '5', 'Itaque ut dolor dolorem.', 'Voluptatem deserunt ad dolor ab. Nesciunt sed omnis id quibusdam doloribus tempore eos voluptatum.', 'Recusandae unde veniam itaque autem.', '6', '2025-05-22 17:27:32', '1'),
('JML043', 33, '4', 'Autem accusamus officia saepe.', 'Neque sunt eum voluptates iusto error ab dolores. Odit quam ut sed asperiores esse quia rerum. Quia enim ipsam numquam impedit expedita ducimus sunt et.', 'Laudantium quia culpa rerum occaecati ad dignissimos expedita sed.', '4', '2025-05-22 17:27:31', '1'),
('K841KC', 52, '5', 'Formacion Critica', 'kasduiashidawd', 'asjkdhasudhasd', '5', '2025-05-29 00:44:37', '1'),
('KWK618', 15, '4', 'Numquam ut culpa.', 'Est omnis ratione odio sed exercitationem temporibus ipsa. Omnis possimus atque rerum magni unde ducimus.', 'Ea hic molestiae vitae.', '6', '2025-05-22 17:27:31', '1'),
('KYE898', 47, '1', 'Illo sapiente ducimus.', 'Ea ab veritatis consequatur eum. Culpa quisquam ut sunt nemo quis eaque.', 'Accusamus eveniet nihil sunt esse autem at officiis.', '3', '2025-05-22 17:27:34', '1'),
('LDG303', 24, '6', 'Et veniam earum nesciunt.', 'Ea voluptatem molestiae vero nihil velit aspernatur voluptatibus. Iste ipsa placeat itaque quo.', 'Perferendis eveniet nihil quia nihil est officiis.', '5', '2025-05-22 17:27:31', '1'),
('LPY247', 13, '7', 'Dolorem odio deleniti.', 'Aut quidem ut enim unde rerum debitis a. Ut rerum exercitationem iusto cumque officiis animi tenetur.', 'Iste molestiae inventore et ut non dolorem.', '6', '2025-05-22 17:27:31', '1'),
('MRP221', 5, '7', 'Pariatur magni odit adipisci.', 'Quia ut laborum natus quia dolor voluptatibus dolore non. Possimus dolorem eaque delectus voluptates ratione accusantium officiis. Nesciunt accusantium dignissimos non accusamus repudiandae et enim soluta.', 'Aut et expedita unde itaque laudantium alias.', '6', '2025-05-22 17:27:32', '1'),
('MWL371', 5, '6', 'Sed et minima dolor.', 'Reiciendis sint blanditiis minus pariatur cum error. Voluptas tempora assumenda similique nesciunt animi vero nihil sequi. Harum sint qui excepturi ab.', 'Quos et accusantium quo illo qui dolorum ratione ea.', '6', '2025-05-22 17:27:32', '1'),
('NFK451', 15, '6', 'Est alias et.', 'Officia sunt nihil magni. Molestias perferendis enim nisi ipsa ullam et.', 'Dicta minima quasi ipsa sequi molestiae deserunt doloribus.', '5', '2025-05-22 17:27:32', '1'),
('NSV244', 24, '1', 'Ipsa facere qui.', 'Possimus et praesentium mollitia ipsam dolor cumque quisquam voluptatem. Rerum eius quos similique aliquid. Nihil autem labore perspiciatis eum totam pariatur.', 'Est incidunt enim dicta hic unde fugit.', '6', '2025-05-22 17:27:32', '1'),
('ONW563', 3, '3', 'Tempora sunt accusantium.', 'Amet voluptatibus blanditiis minima non quisquam ab dolore. Aut eveniet et rerum quia ratione.', 'Voluptas maxime blanditiis ratione soluta ut asperiores.', '2', '2025-05-22 17:27:33', '1'),
('OTV724', 10, '5', 'Exercitationem aspernatur quaerat commodi.', 'Et quo ut consequuntur dolores. Aperiam veritatis alias reprehenderit accusamus ex quasi et.', 'Ipsam et quia quia explicabo sequi alias.', '2', '2025-05-22 17:27:34', '1'),
('OXJ199', 42, '6', 'Reiciendis quas voluptatem.', 'Voluptatem voluptatem dignissimos voluptatum ex. Tenetur aspernatur et aut.', 'Est harum cupiditate architecto vel qui nemo omnis.', '6', '2025-05-22 17:27:31', '1'),
('PKT530', 30, '6', 'Reprehenderit neque quia dolor.', 'Magni aliquam a vel id expedita minima molestiae. Natus animi fugiat illo quae et accusamus. Autem facere et accusantium sit deleniti corrupti.', 'Non repellendus voluptatem ratione temporibus.', '2', '2025-05-22 17:27:31', '1'),
('PMM479', 51, '3', 'Beatae perspiciatis.', 'Aut a at debitis sunt inventore molestiae deserunt. Laborum porro officiis neque officia harum autem ut.', 'Corrupti reprehenderit ab saepe distinctio cumque.', '4', '2025-05-22 17:27:33', '1'),
('PNW072', 10, '8', 'Occaecati voluptatum qui et.', 'Velit totam vel quas architecto velit doloremque laborum nulla. Omnis suscipit dolor earum eos.', 'Minima ullam ducimus asperiores saepe.', '5', '2025-05-22 17:27:32', '1'),
('poo643', 52, '7', 'algoritmica', 'bgdhfgdd', 'mkjkjhjhh', '6', '2025-05-29 00:31:19', '1'),
('PTO312', 52, '8', 'Programacion', 'asjkdhajkshd', 'asdajsdhjhasd', '3', '2025-05-28 21:55:06', '1'),
('PTO349', 70, '3', 'Programacion II', 'es una programacion', 'incentivar a la programacion', '2', '2025-05-27 21:24:09', '2'),
('PXT843', 48, '8', 'Quia ex totam aut.', 'Nihil cumque dolor praesentium voluptas sunt dolorum eos qui. Totam et repellat odio sed nostrum fuga. Quia rerum iusto iusto.', 'Quas sunt omnis perspiciatis dolor.', '2', '2025-05-22 17:27:33', '1'),
('QTM711', 26, '5', 'Voluptatem magnam maiores iure eos.', 'Est molestiae laboriosam veniam beatae. Fugiat facilis eveniet ullam porro dolorem eaque. Nam eum qui qui et ab veniam aspernatur est.', 'Similique eaque temporibus inventore qui est at id.', '6', '2025-05-22 17:27:32', '1'),
('QZT672', 48, '1', 'Tempore facilis minima.', 'Rem in aut et. Soluta ad voluptas nostrum velit earum magni non dolor. Architecto est reiciendis eveniet sed.', 'Ut eligendi molestias incidunt.', '3', '2025-05-22 17:27:34', '1'),
('RDD163', 48, '1', 'Odit omnis non ratione.', 'Eaque non non consequuntur laudantium aut. Voluptatem omnis veniam ipsam earum consequatur.', 'Sunt et dicta consequatur consequatur sed dignissimos.', '6', '2025-05-22 17:27:31', '1'),
('RWU322', 1, '6', 'Voluptatum minus vitae quis.', 'Quidem nulla non voluptatum id. Perspiciatis adipisci optio et.', 'Fugiat reprehenderit dolores quae dolorem.', '3', '2025-05-22 17:27:33', '1'),
('SES904', 3, '7', 'Consequuntur impedit aliquam aut.', 'Ut ea non fuga debitis ea eaque et. Sint temporibus architecto perspiciatis laboriosam a cumque aliquam rerum. Doloribus molestiae commodi laboriosam dignissimos at.', 'Amet nemo distinctio eos possimus.', '2', '2025-05-22 17:27:32', '1'),
('SWO031', 31, '6', 'Corporis et iure vero.', 'Ea enim unde debitis eaque repudiandae. Omnis temporibus corporis in earum quas neque. Sit itaque ea mollitia vitae voluptas voluptatibus.', 'Amet aut aut ut et.', '6', '2025-05-22 17:27:33', '1'),
('TQT714', 17, '7', 'Dolores distinctio.', 'Est quis dolores placeat. Est nihil voluptates sint ut aut facere molestiae accusamus.', 'Aut eum laudantium consequuntur minima odio distinctio.', '5', '2025-05-22 17:27:33', '1'),
('UDL549', 18, '5', 'Numquam mollitia ea.', 'Beatae sed consectetur ex asperiores cum. Ea voluptates reprehenderit sed vel natus.', 'Veniam ab maxime eligendi et quia voluptas.', '5', '2025-05-22 17:27:33', '1'),
('UGT175', 38, '7', 'Omnis assumenda quidem.', 'Nam rerum enim rerum hic in dolor explicabo. Blanditiis ratione voluptatem quo est. Vitae vero dignissimos molestias enim nisi veritatis veniam quo.', 'Optio qui omnis eius praesentium omnis.', '2', '2025-05-22 17:27:32', '1'),
('UGX736', 52, '4', 'Assumenda eum sequi dolorem iusto.', 'Sunt et et et sed voluptas. Culpa sunt est laudantium accusantium voluptas. Similique veniam vero odio dolorem nobis rerum aut.', 'Itaque dolorem dignissimos eum voluptatem nihil.', '5', '2025-05-22 17:27:31', '2'),
('USA851', 32, '2', 'Pariatur consectetur fugit aperiam.', 'Expedita tenetur nostrum molestiae rerum ullam. Fuga cum ullam tenetur voluptates similique autem.', 'Quidem quia voluptatem minima voluptas sed et rerum suscipit.', '6', '2025-05-22 17:27:34', '1'),
('UWN092', 32, '3', 'Nemo quibusdam deserunt.', 'Similique et omnis temporibus mollitia id. Repellat maxime esse qui sequi eum.', 'Cumque ut dolor cum et ut nisi.', '5', '2025-05-22 17:27:31', '1'),
('VUT510', 40, '1', 'Dolorem voluptatem deserunt cupiditate.', 'Velit dolorem dolores inventore voluptas architecto. Minus beatae dolore quos adipisci odit at qui.', 'Et accusamus omnis autem rem accusantium nihil.', '6', '2025-05-22 17:27:33', '1'),
('WWG037', 7, '5', 'Reprehenderit explicabo esse voluptatibus.', 'Sint eaque expedita eos. Sit quidem cum sed et.', 'Eligendi officiis quo iste assumenda quo velit.', '6', '2025-05-22 17:27:33', '1'),
('WXO260', 32, '5', 'Atque quo voluptatum sint.', 'Eius nihil dolores facilis qui id nesciunt. Unde autem consequuntur rerum sed.', 'Quia nisi corrupti ex aliquam excepturi quo.', '4', '2025-05-22 17:27:32', '1'),
('XML758', 28, '5', 'Minima exercitationem ipsa autem veritatis.', 'Eos iusto reiciendis aut corrupti non. Est veritatis ut aut. Sunt excepturi voluptatum illum voluptatibus et aliquam.', 'Fuga consequatur sapiente omnis magni sunt.', '3', '2025-05-22 17:27:32', '1'),
('XOK776', 35, '2', 'Ab fugiat libero maxime.', 'Quo alias corrupti est excepturi ut in ut. Molestiae aspernatur reprehenderit tempore iste quod maiores non recusandae.', 'Eum voluptas soluta recusandae asperiores.', '5', '2025-05-22 17:27:30', '1'),
('XPR769', 1, '5', 'Fugit sapiente officia.', 'Distinctio molestiae quisquam culpa repudiandae est modi. Similique et ipsum magni temporibus sunt quis amet.', 'Ex voluptate eveniet libero optio laudantium dolores.', '5', '2025-05-22 17:27:34', '1'),
('ZBQ389', 17, '5', 'Dolorum a quasi.', 'Provident qui quos tempora ullam. Laborum vel ut perspiciatis ipsam doloremque veniam.', 'Et voluptate et laudantium quidem maiores nisi.', '6', '2025-05-22 17:27:31', '1');

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
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `cedula`, `email`, `telefono`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Nasser', 'Daboin', '31215545', 'nasserdaboin@gmail.com', NULL, '$2y$12$B5h0APBdl3CSeX9IWZR0dOF0xBZCmLqefnN1cu0koifa5yYAzeSUq', NULL, '2025-05-11 03:06:06', '1'),
(2, 'Chanchito', 'Feliz', '10143592', 'chanchitofeliz@example.com', NULL, '$2y$12$Lahma9An.b.63OXBKmkJQ.taHmdvVN.Hb1sLluPf35SgPqGY8BJc.', NULL, '2025-05-14 23:04:32', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_planificaciones`
--

CREATE TABLE `usuarios_planificaciones` (
  `usuario_planificacion` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `planificacion_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_preguntas`
--

CREATE TABLE `usuario_preguntas` (
  `usuario_pregunta_id` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `pregunta_id` bigint(20) UNSIGNED NOT NULL,
  `respuesta` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_roles`
--

CREATE TABLE `usuario_roles` (
  `usuario_rol_id` bigint(20) UNSIGNED NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `rol_id` bigint(20) UNSIGNED NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estatus` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

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
  ADD PRIMARY KEY (`planificacion_id`),
  ADD KEY `planificaciones_seccion_id_foreign` (`seccion_id`);

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
-- Indices de la tabla `preguntas_seguridad`
--
ALTER TABLE `preguntas_seguridad`
  ADD PRIMARY KEY (`pregunta_id`);

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
-- Indices de la tabla `usuario_preguntas`
--
ALTER TABLE `usuario_preguntas`
  ADD PRIMARY KEY (`usuario_pregunta_id`),
  ADD KEY `usuario_preguntas_id_foreign` (`id`),
  ADD KEY `usuario_preguntas_pregunta_id_foreign` (`pregunta_id`);

--
-- Indices de la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  ADD PRIMARY KEY (`usuario_rol_id`),
  ADD KEY `usuario_roles_id_foreign` (`id`),
  ADD KEY `usuario_roles_rol_id_foreign` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `contenidos`
--
ALTER TABLE `contenidos`
  MODIFY `contenido_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  MODIFY `contenido_indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `indicador_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  MODIFY `lapso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `pnf_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT de la tabla `preguntas_seguridad`
--
ALTER TABLE `preguntas_seguridad`
  MODIFY `pregunta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recursos`
--
ALTER TABLE `recursos`
  MODIFY `recurso_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `seccion_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios_planificaciones`
--
ALTER TABLE `usuarios_planificaciones`
  MODIFY `usuario_planificacion` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_preguntas`
--
ALTER TABLE `usuario_preguntas`
  MODIFY `usuario_pregunta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  MODIFY `usuario_rol_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `contenidos`
--
ALTER TABLE `contenidos`
  ADD CONSTRAINT `contenidos_unidad_codigo_foreign` FOREIGN KEY (`unidad_codigo`) REFERENCES `unidades_curriculares` (`codigo`);

--
-- Filtros para la tabla `contenido_indicadores`
--
ALTER TABLE `contenido_indicadores`
  ADD CONSTRAINT `contenido_indicadores_contenido_id_foreign` FOREIGN KEY (`contenido_id`) REFERENCES `contenidos` (`contenido_id`),
  ADD CONSTRAINT `contenido_indicadores_indicador_id_foreign` FOREIGN KEY (`indicador_id`) REFERENCES `indicadores_logros` (`indicador_id`);

--
-- Filtros para la tabla `planificaciones`
--
ALTER TABLE `planificaciones`
  ADD CONSTRAINT `planificaciones_seccion_id_foreign` FOREIGN KEY (`seccion_id`) REFERENCES `secciones` (`seccion_id`);

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
-- Filtros para la tabla `usuario_preguntas`
--
ALTER TABLE `usuario_preguntas`
  ADD CONSTRAINT `usuario_preguntas_id_foreign` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuario_preguntas_pregunta_id_foreign` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas_seguridad` (`pregunta_id`);

--
-- Filtros para la tabla `usuario_roles`
--
ALTER TABLE `usuario_roles`
  ADD CONSTRAINT `usuario_roles_id_foreign` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuario_roles_rol_id_foreign` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
