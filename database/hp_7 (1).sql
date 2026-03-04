-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-03-2026 a las 22:42:30
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
-- Base de datos: `hp_7`
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
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bitacora`
--

INSERT INTO `bitacora` (`id_bitacora`, `id_users`, `modulo_afectado_bitacora`, `tabla_afectada_bitacora`, `id_registro_afectado_bitacora`, `accion_bitacora`, `valores_anteriores_bitacora`, `valores_nuevos_bitacora`, `ip_origen_bitacora`, `fecha_creacion`, `estatus`) VALUES
(1, 1, 'Seguridad', 'users', '1', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-03 22:25:45', '1'),
(2, 1, 'Permiso', 'permiso', '2', 'CREAR', NULL, '{\"nombre_permiso\":\"Confirm Password User\",\"fecha_creacion\":\"2026-03-03T19:09:49.268598Z\",\"estatus\":\"1\",\"id_permiso\":2}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(3, 1, 'Permiso', 'permiso', '3', 'CREAR', NULL, '{\"nombre_permiso\":\"Confirmed Password Status User\",\"fecha_creacion\":\"2026-03-03T19:09:49.284139Z\",\"estatus\":\"1\",\"id_permiso\":3}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(4, 1, 'Permiso', 'permiso', '4', 'CREAR', NULL, '{\"nombre_permiso\":\"Two Factor Qr Code User\",\"fecha_creacion\":\"2026-03-03T19:09:49.292619Z\",\"estatus\":\"1\",\"id_permiso\":4}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(5, 1, 'Permiso', 'permiso', '5', 'CREAR', NULL, '{\"nombre_permiso\":\"Two Factor Secret Key User\",\"fecha_creacion\":\"2026-03-03T19:09:49.301398Z\",\"estatus\":\"1\",\"id_permiso\":5}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(6, 1, 'Permiso', 'permiso', '6', 'CREAR', NULL, '{\"nombre_permiso\":\"Two Factor Recovery Codes User\",\"fecha_creacion\":\"2026-03-03T19:09:49.308890Z\",\"estatus\":\"1\",\"id_permiso\":6}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(7, 1, 'Permiso', 'permiso', '7', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Contenido\",\"fecha_creacion\":\"2026-03-03T19:09:49.317187Z\",\"estatus\":\"1\",\"id_permiso\":7}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(8, 1, 'Permiso', 'permiso', '8', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Contenido\",\"fecha_creacion\":\"2026-03-03T19:09:49.324640Z\",\"estatus\":\"1\",\"id_permiso\":8}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(9, 1, 'Permiso', 'permiso', '9', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Contenido\",\"fecha_creacion\":\"2026-03-03T19:09:49.332734Z\",\"estatus\":\"1\",\"id_permiso\":9}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(10, 1, 'Permiso', 'permiso', '10', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Contenido\",\"fecha_creacion\":\"2026-03-03T19:09:49.340226Z\",\"estatus\":\"1\",\"id_permiso\":10}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(11, 1, 'Permiso', 'permiso', '11', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Tema\",\"fecha_creacion\":\"2026-03-03T19:09:49.359293Z\",\"estatus\":\"1\",\"id_permiso\":11}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(12, 1, 'Permiso', 'permiso', '12', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Tema\",\"fecha_creacion\":\"2026-03-03T19:09:49.377209Z\",\"estatus\":\"1\",\"id_permiso\":12}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(13, 1, 'Permiso', 'permiso', '13', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Tema\",\"fecha_creacion\":\"2026-03-03T19:09:49.389699Z\",\"estatus\":\"1\",\"id_permiso\":13}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(14, 1, 'Permiso', 'permiso', '14', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Tema\",\"fecha_creacion\":\"2026-03-03T19:09:49.399297Z\",\"estatus\":\"1\",\"id_permiso\":14}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(15, 1, 'Permiso', 'permiso', '15', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Planificacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.409761Z\",\"estatus\":\"1\",\"id_permiso\":15}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(16, 1, 'Permiso', 'permiso', '16', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Indicador Logro\",\"fecha_creacion\":\"2026-03-03T19:09:49.426677Z\",\"estatus\":\"1\",\"id_permiso\":16}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(17, 1, 'Permiso', 'permiso', '17', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Indicador Logro\",\"fecha_creacion\":\"2026-03-03T19:09:49.438295Z\",\"estatus\":\"1\",\"id_permiso\":17}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(18, 1, 'Permiso', 'permiso', '18', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Indicador Logro\",\"fecha_creacion\":\"2026-03-03T19:09:49.449437Z\",\"estatus\":\"1\",\"id_permiso\":18}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(19, 1, 'Permiso', 'permiso', '19', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Indicador Logro\",\"fecha_creacion\":\"2026-03-03T19:09:49.458367Z\",\"estatus\":\"1\",\"id_permiso\":19}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(20, 1, 'Permiso', 'permiso', '20', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Bibliografia\",\"fecha_creacion\":\"2026-03-03T19:09:49.467241Z\",\"estatus\":\"1\",\"id_permiso\":20}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(21, 1, 'Permiso', 'permiso', '21', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Bibliografia\",\"fecha_creacion\":\"2026-03-03T19:09:49.475772Z\",\"estatus\":\"1\",\"id_permiso\":21}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(22, 1, 'Permiso', 'permiso', '22', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Bibliografia\",\"fecha_creacion\":\"2026-03-03T19:09:49.484910Z\",\"estatus\":\"1\",\"id_permiso\":22}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(23, 1, 'Permiso', 'permiso', '23', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Bibliografia\",\"fecha_creacion\":\"2026-03-03T19:09:49.490775Z\",\"estatus\":\"1\",\"id_permiso\":23}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(24, 1, 'Permiso', 'permiso', '24', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Recurso\",\"fecha_creacion\":\"2026-03-03T19:09:49.496654Z\",\"estatus\":\"1\",\"id_permiso\":24}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(25, 1, 'Permiso', 'permiso', '25', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Recurso\",\"fecha_creacion\":\"2026-03-03T19:09:49.507437Z\",\"estatus\":\"1\",\"id_permiso\":25}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(26, 1, 'Permiso', 'permiso', '26', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Recurso\",\"fecha_creacion\":\"2026-03-03T19:09:49.524453Z\",\"estatus\":\"1\",\"id_permiso\":26}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(27, 1, 'Permiso', 'permiso', '27', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Recurso\",\"fecha_creacion\":\"2026-03-03T19:09:49.534419Z\",\"estatus\":\"1\",\"id_permiso\":27}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(28, 1, 'Permiso', 'permiso', '28', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Estrategia\",\"fecha_creacion\":\"2026-03-03T19:09:49.542421Z\",\"estatus\":\"1\",\"id_permiso\":28}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(29, 1, 'Permiso', 'permiso', '29', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Estrategia\",\"fecha_creacion\":\"2026-03-03T19:09:49.550513Z\",\"estatus\":\"1\",\"id_permiso\":29}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(30, 1, 'Permiso', 'permiso', '30', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Estrategia\",\"fecha_creacion\":\"2026-03-03T19:09:49.558734Z\",\"estatus\":\"1\",\"id_permiso\":30}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(31, 1, 'Permiso', 'permiso', '31', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Estrategia\",\"fecha_creacion\":\"2026-03-03T19:09:49.567127Z\",\"estatus\":\"1\",\"id_permiso\":31}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(32, 1, 'Permiso', 'permiso', '32', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Tecnica\",\"fecha_creacion\":\"2026-03-03T19:09:49.576804Z\",\"estatus\":\"1\",\"id_permiso\":32}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(33, 1, 'Permiso', 'permiso', '33', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Tecnica\",\"fecha_creacion\":\"2026-03-03T19:09:49.591063Z\",\"estatus\":\"1\",\"id_permiso\":33}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(34, 1, 'Permiso', 'permiso', '34', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Tecnica\",\"fecha_creacion\":\"2026-03-03T19:09:49.604451Z\",\"estatus\":\"1\",\"id_permiso\":34}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(35, 1, 'Permiso', 'permiso', '35', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Tecnica\",\"fecha_creacion\":\"2026-03-03T19:09:49.612429Z\",\"estatus\":\"1\",\"id_permiso\":35}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(36, 1, 'Permiso', 'permiso', '36', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Evaluacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.621306Z\",\"estatus\":\"1\",\"id_permiso\":36}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(37, 1, 'Permiso', 'permiso', '37', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Evaluacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.630763Z\",\"estatus\":\"1\",\"id_permiso\":37}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(38, 1, 'Permiso', 'permiso', '38', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Evaluacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.638938Z\",\"estatus\":\"1\",\"id_permiso\":38}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(39, 1, 'Permiso', 'permiso', '39', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Evaluacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.646574Z\",\"estatus\":\"1\",\"id_permiso\":39}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(40, 1, 'Permiso', 'permiso', '40', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Evento\",\"fecha_creacion\":\"2026-03-03T19:09:49.653715Z\",\"estatus\":\"1\",\"id_permiso\":40}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(41, 1, 'Permiso', 'permiso', '41', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Evento\",\"fecha_creacion\":\"2026-03-03T19:09:49.660332Z\",\"estatus\":\"1\",\"id_permiso\":41}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(42, 1, 'Permiso', 'permiso', '42', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Evento\",\"fecha_creacion\":\"2026-03-03T19:09:49.667487Z\",\"estatus\":\"1\",\"id_permiso\":42}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(43, 1, 'Permiso', 'permiso', '43', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Evento\",\"fecha_creacion\":\"2026-03-03T19:09:49.674144Z\",\"estatus\":\"1\",\"id_permiso\":43}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(44, 1, 'Permiso', 'permiso', '44', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Permiso\",\"fecha_creacion\":\"2026-03-03T19:09:49.681542Z\",\"estatus\":\"1\",\"id_permiso\":44}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(45, 1, 'Permiso', 'permiso', '45', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Permiso\",\"fecha_creacion\":\"2026-03-03T19:09:49.688285Z\",\"estatus\":\"1\",\"id_permiso\":45}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(46, 1, 'Permiso', 'permiso', '46', 'CREAR', NULL, '{\"nombre_permiso\":\"Listar Bitacora\",\"fecha_creacion\":\"2026-03-03T19:09:49.695160Z\",\"estatus\":\"1\",\"id_permiso\":46}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(47, 1, 'Permiso', 'permiso', '47', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Bitacora\",\"fecha_creacion\":\"2026-03-03T19:09:49.701928Z\",\"estatus\":\"1\",\"id_permiso\":47}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(48, 1, 'Permiso', 'permiso', '48', 'CREAR', NULL, '{\"nombre_permiso\":\"Crear Planificacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.708933Z\",\"estatus\":\"1\",\"id_permiso\":48}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(49, 1, 'Permiso', 'permiso', '49', 'CREAR', NULL, '{\"nombre_permiso\":\"Editar Planificacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.719236Z\",\"estatus\":\"1\",\"id_permiso\":49}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(50, 1, 'Permiso', 'permiso', '50', 'CREAR', NULL, '{\"nombre_permiso\":\"Ver Detalles de Planificacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.737247Z\",\"estatus\":\"1\",\"id_permiso\":50}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(51, 1, 'Permiso', 'permiso', '51', 'CREAR', NULL, '{\"nombre_permiso\":\"Reporte General de Planificacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.752683Z\",\"estatus\":\"1\",\"id_permiso\":51}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(52, 1, 'Permiso', 'permiso', '52', 'CREAR', NULL, '{\"nombre_permiso\":\"Reporte Detallado de Planificacion\",\"fecha_creacion\":\"2026-03-03T19:09:49.764179Z\",\"estatus\":\"1\",\"id_permiso\":52}', '127.0.0.1', '2026-03-03 23:09:49', '1'),
(53, 1, 'Seguridad', 'users', '1', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-03-04 01:33:18', '1'),
(54, 1, 'Seguridad', 'users', '1', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-03-04 01:33:34', '1');

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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `fecha_actualizacion?` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evaluacion`
--

CREATE TABLE `detalle_evaluacion` (
  `id_detalle_evaluacion` int(11) NOT NULL,
  `id_evaluacion` int(11) DEFAULT NULL,
  `id_tecnica` int(11) DEFAULT NULL,
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre_permiso`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(55, 'Confirm Password User', '2026-03-04 01:08:56', NULL, '1'),
(56, 'Confirmed Password Status User', '2026-03-04 01:08:56', NULL, '1'),
(57, 'Two Factor Qr Code User', '2026-03-04 01:08:56', NULL, '1'),
(58, 'Two Factor Secret Key User', '2026-03-04 01:08:56', NULL, '1'),
(59, 'Two Factor Recovery Codes User', '2026-03-04 01:08:56', NULL, '1'),
(60, 'Listar Contenido', '2026-03-04 01:08:56', NULL, '1'),
(61, 'Crear Contenido', '2026-03-04 01:08:56', NULL, '1'),
(62, 'Editar Contenido', '2026-03-04 01:08:56', NULL, '1'),
(63, 'Ver Detalles de Contenido', '2026-03-04 01:08:56', NULL, '1'),
(64, 'Listar Tema', '2026-03-04 01:08:56', NULL, '1'),
(65, 'Crear Tema', '2026-03-04 01:08:56', NULL, '1'),
(66, 'Editar Tema', '2026-03-04 01:08:56', NULL, '1'),
(67, 'Ver Detalles de Tema', '2026-03-04 01:08:56', NULL, '1'),
(68, 'Listar Planificacion', '2026-03-04 01:08:56', NULL, '1'),
(69, 'Listar Indicador Logro', '2026-03-04 01:08:56', NULL, '1'),
(70, 'Crear Indicador Logro', '2026-03-04 01:08:56', NULL, '1'),
(71, 'Editar Indicador Logro', '2026-03-04 01:08:56', NULL, '1'),
(72, 'Ver Detalles de Indicador Logro', '2026-03-04 01:08:56', NULL, '1'),
(73, 'Listar Bibliografia', '2026-03-04 01:08:56', NULL, '1'),
(74, 'Crear Bibliografia', '2026-03-04 01:08:56', NULL, '1'),
(75, 'Editar Bibliografia', '2026-03-04 01:08:56', NULL, '1'),
(76, 'Ver Detalles de Bibliografia', '2026-03-04 01:08:56', NULL, '1'),
(77, 'Listar Recurso', '2026-03-04 01:08:56', NULL, '1'),
(78, 'Crear Recurso', '2026-03-04 01:08:56', NULL, '1'),
(79, 'Editar Recurso', '2026-03-04 01:08:56', NULL, '1'),
(80, 'Ver Detalles de Recurso', '2026-03-04 01:08:56', NULL, '1'),
(81, 'Listar Estrategia', '2026-03-04 01:08:56', NULL, '1'),
(82, 'Crear Estrategia', '2026-03-04 01:08:56', NULL, '1'),
(83, 'Editar Estrategia', '2026-03-04 01:08:56', NULL, '1'),
(84, 'Ver Detalles de Estrategia', '2026-03-04 01:08:56', NULL, '1'),
(85, 'Listar Tecnica', '2026-03-04 01:08:56', NULL, '1'),
(86, 'Crear Tecnica', '2026-03-04 01:08:56', NULL, '1'),
(87, 'Editar Tecnica', '2026-03-04 01:08:56', NULL, '1'),
(88, 'Ver Detalles de Tecnica', '2026-03-04 01:08:56', NULL, '1'),
(89, 'Listar Evaluacion', '2026-03-04 01:08:56', NULL, '1'),
(90, 'Crear Evaluacion', '2026-03-04 01:08:56', NULL, '1'),
(91, 'Editar Evaluacion', '2026-03-04 01:08:56', NULL, '1'),
(92, 'Ver Detalles de Evaluacion', '2026-03-04 01:08:56', NULL, '1'),
(93, 'Listar Evento', '2026-03-04 01:08:56', NULL, '1'),
(94, 'Crear Evento', '2026-03-04 01:08:56', NULL, '1'),
(95, 'Editar Evento', '2026-03-04 01:08:56', NULL, '1'),
(96, 'Ver Detalles de Evento', '2026-03-04 01:08:56', NULL, '1'),
(97, 'Listar Rol', '2026-03-04 01:08:56', NULL, '1'),
(98, 'Editar Rol', '2026-03-04 01:08:56', NULL, '1'),
(99, 'Listar Bitacora', '2026-03-04 01:08:56', NULL, '1'),
(100, 'Ver Detalles de Bitacora', '2026-03-04 01:08:56', NULL, '1'),
(101, 'Crear Planificacion', '2026-03-04 01:08:56', NULL, '1'),
(102, 'Editar Planificacion', '2026-03-04 01:08:56', NULL, '1'),
(103, 'Ver Detalles de Planificacion', '2026-03-04 01:08:56', NULL, '1'),
(104, 'Reporte General de Planificacion', '2026-03-04 01:08:56', NULL, '1'),
(105, 'Reporte Detallado de Planificacion', '2026-03-04 01:08:56', NULL, '1');

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
  `estatus` enum('1','2','3','4') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol_permiso`, `id_permiso`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(5, 97, 46, '2026-03-04 01:34:00', NULL, '1'),
(6, 98, 46, '2026-03-04 01:34:00', NULL, '1'),
(7, 93, 4, '2026-03-04 01:41:16', '2026-03-04 01:42:12', '1'),
(8, 98, 4, '2026-03-04 01:42:12', NULL, '1'),
(9, 97, 4, '2026-03-04 01:42:12', NULL, '1');

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
('oQDlx2cb2dvQjM1b2d4oFD6cTO9BvWUSViNMACri', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieEpVUk1CQnlWaFBHbVEwTnBmVjBmTDVzYkh2UnFHaVRzVWJITXpFViI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yb2wvbGlzdCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1772574134);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_evaluacion`
--

CREATE TABLE `tecnica_evaluacion` (
  `id_tecnica` int(11) NOT NULL,
  `nombre_tecnica_evaluacion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `estatus?` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3','4','5') DEFAULT '1'
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
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `apellido`, `email`, `cedula`, `telefono`, `password`, `remember_token`, `fecha_creacion`, `estatus`) VALUES
(1, 'Nasser J.', 'Daboin R.', 'nasserdaboin@gmail.com', '31215545', NULL, '$2y$12$rS9/5YQoeAG9lF597ZPOq.wPix4C/vWLo7LWekPhEWYt2fwlZkXeO', NULL, '2026-03-02 20:54:33', '1'),
(2, 'Enmanuel Salas', 'Salas', 'enmanuelsalas0911@gmail.com', '31114131', NULL, '$2y$12$AX2LT7s.7FH2TOv.5KUVrOptXZbn9I9jYkye9WFiYEabcXwCn.vJG', NULL, '2026-03-02 20:54:33', '1');

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
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario_rol`, `id_users`, `id_rol`, `fecha_creacion`, `fecha_actualizacion`, `estatus`) VALUES
(1, 1, 4, '2026-03-04 01:33:34', NULL, '1');

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
  ADD KEY `fk_deval_eval` (`id_evaluacion`),
  ADD KEY `fk_deval_tecnica` (`id_tecnica`),
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
  ADD PRIMARY KEY (`id_tecnica`);

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
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

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
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

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
  MODIFY `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tecnica_actividad`
--
ALTER TABLE `tecnica_actividad`
  MODIFY `id_tecnica_actividad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tecnica_evaluacion`
--
ALTER TABLE `tecnica_evaluacion`
  MODIFY `id_tecnica` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `fk_deval_eval` FOREIGN KEY (`id_evaluacion`) REFERENCES `tipo_evaluacion` (`id_tipo_evaluacion`),
  ADD CONSTRAINT `fk_deval_inst` FOREIGN KEY (`id_instrumento`) REFERENCES `instrumento` (`id_instrumento`),
  ADD CONSTRAINT `fk_deval_tecnica` FOREIGN KEY (`id_tecnica`) REFERENCES `tecnica_evaluacion` (`id_tecnica`),
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
  ADD CONSTRAINT `fk_rperm_permiso` FOREIGN KEY (`id_permiso`) REFERENCES `permiso` (`id_permiso`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `fk_urol_users` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
