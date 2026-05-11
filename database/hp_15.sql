-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2026 a las 23:14:48
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
-- Base de datos: `hp_12`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bibliografia`
--

CREATE TABLE `bibliografia` (
  `id_bibliografia` int(11) NOT NULL,
  `nombre_bibliografia` text DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bibliografia`
--

INSERT INTO `bibliografia` (`id_bibliografia`, `nombre_bibliografia`, `estatus`) VALUES
(1, 'llll', '1');

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
(5, 1, 'CalendarioAcademico', 'calendario_academico', '5', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\",\"id_calendario_academico\":5}', '127.0.0.1', '2026-04-23 04:53:10', '1'),
(6, 1, 'Evento', 'evento', '1', 'CREAR', NULL, '{\"leyenda_evento\":\"Actividad Administrativa\",\"tipo_evento\":\"2\",\"estatus\":\"1\",\"id_evento\":1}', '127.0.0.1', '2026-04-23 04:53:11', '1'),
(7, 1, 'DetalleEvento', 'detalle_evento', '1', 'CREAR', NULL, '{\"id_evento\":1,\"id_calendario_academico\":5,\"dia_inicio_detalle_evento\":\"2026-04-01\",\"dia_fin_detalle_evento\":\"2026-04-02\",\"semana_detalle_evento\":null,\"estatus\":\"1\",\"id_detalle_evento\":1}', '127.0.0.1', '2026-04-23 04:53:11', '1'),
(8, 0, 'Seguridad', 'users', '39195', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 04:53:17', '1'),
(9, 39195, 'Roles (Permisos)', 'rol_permiso', '1', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"62\",\"estatus\":\"1\",\"id_rol_permiso\":1}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(10, 39195, 'Roles (Permisos)', 'rol_permiso', '2', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"25\",\"estatus\":\"1\",\"id_rol_permiso\":2}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(11, 39195, 'Roles (Permisos)', 'rol_permiso', '3', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"26\",\"estatus\":\"1\",\"id_rol_permiso\":3}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(12, 39195, 'Roles (Permisos)', 'rol_permiso', '4', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"24\",\"estatus\":\"1\",\"id_rol_permiso\":4}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(13, 39195, 'Roles (Permisos)', 'rol_permiso', '5', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"27\",\"estatus\":\"1\",\"id_rol_permiso\":5}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(14, 39195, 'Roles (Permisos)', 'rol_permiso', '6', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"69\",\"estatus\":\"1\",\"id_rol_permiso\":6}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(15, 39195, 'Roles (Permisos)', 'rol_permiso', '7', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"52\",\"estatus\":\"1\",\"id_rol_permiso\":7}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(16, 39195, 'Roles (Permisos)', 'rol_permiso', '8', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"53\",\"estatus\":\"1\",\"id_rol_permiso\":8}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(17, 39195, 'Roles (Permisos)', 'rol_permiso', '9', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"60\",\"estatus\":\"1\",\"id_rol_permiso\":9}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(18, 39195, 'Roles (Permisos)', 'rol_permiso', '10', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"48\",\"estatus\":\"1\",\"id_rol_permiso\":10}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(19, 39195, 'Roles (Permisos)', 'rol_permiso', '11', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"47\",\"estatus\":\"1\",\"id_rol_permiso\":11}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(20, 39195, 'Roles (Permisos)', 'rol_permiso', '12', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"id_rol_permiso\":12}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(21, 39195, 'Roles (Permisos)', 'rol_permiso', '13', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"49\",\"estatus\":\"1\",\"id_rol_permiso\":13}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(22, 39195, 'Roles (Permisos)', 'rol_permiso', '14', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"56\",\"estatus\":\"1\",\"id_rol_permiso\":14}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(23, 39195, 'Roles (Permisos)', 'rol_permiso', '15', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"4\",\"estatus\":\"1\",\"id_rol_permiso\":15}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(24, 39195, 'Roles (Permisos)', 'rol_permiso', '16', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"5\",\"estatus\":\"1\",\"id_rol_permiso\":16}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(25, 39195, 'Roles (Permisos)', 'rol_permiso', '17', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"3\",\"estatus\":\"1\",\"id_rol_permiso\":17}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(26, 39195, 'Roles (Permisos)', 'rol_permiso', '18', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"6\",\"estatus\":\"1\",\"id_rol_permiso\":18}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(27, 39195, 'Roles (Permisos)', 'rol_permiso', '19', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"64\",\"estatus\":\"1\",\"id_rol_permiso\":19}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(28, 39195, 'Roles (Permisos)', 'rol_permiso', '20', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"33\",\"estatus\":\"1\",\"id_rol_permiso\":20}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(29, 39195, 'Roles (Permisos)', 'rol_permiso', '21', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"34\",\"estatus\":\"1\",\"id_rol_permiso\":21}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(30, 39195, 'Roles (Permisos)', 'rol_permiso', '22', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"32\",\"estatus\":\"1\",\"id_rol_permiso\":22}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(31, 39195, 'Roles (Permisos)', 'rol_permiso', '23', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"35\",\"estatus\":\"1\",\"id_rol_permiso\":23}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(32, 39195, 'Roles (Permisos)', 'rol_permiso', '24', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"67\",\"estatus\":\"1\",\"id_rol_permiso\":24}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(33, 39195, 'Roles (Permisos)', 'rol_permiso', '25', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"45\",\"estatus\":\"1\",\"id_rol_permiso\":25}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(34, 39195, 'Roles (Permisos)', 'rol_permiso', '26', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"44\",\"estatus\":\"1\",\"id_rol_permiso\":26}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(35, 39195, 'Roles (Permisos)', 'rol_permiso', '27', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"46\",\"estatus\":\"1\",\"id_rol_permiso\":27}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(36, 39195, 'Roles (Permisos)', 'rol_permiso', '28', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"61\",\"estatus\":\"1\",\"id_rol_permiso\":28}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(37, 39195, 'Roles (Permisos)', 'rol_permiso', '29', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"21\",\"estatus\":\"1\",\"id_rol_permiso\":29}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(38, 39195, 'Roles (Permisos)', 'rol_permiso', '30', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"22\",\"estatus\":\"1\",\"id_rol_permiso\":30}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(39, 39195, 'Roles (Permisos)', 'rol_permiso', '31', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"20\",\"estatus\":\"1\",\"id_rol_permiso\":31}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(40, 39195, 'Roles (Permisos)', 'rol_permiso', '32', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"23\",\"estatus\":\"1\",\"id_rol_permiso\":32}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(41, 39195, 'Roles (Permisos)', 'rol_permiso', '33', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"54\",\"estatus\":\"1\",\"id_rol_permiso\":33}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(42, 39195, 'Roles (Permisos)', 'rol_permiso', '34', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"1\",\"estatus\":\"1\",\"id_rol_permiso\":34}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(43, 39195, 'Roles (Permisos)', 'rol_permiso', '35', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"68\",\"estatus\":\"1\",\"id_rol_permiso\":35}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(44, 39195, 'Roles (Permisos)', 'rol_permiso', '36', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"51\",\"estatus\":\"1\",\"id_rol_permiso\":36}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(45, 39195, 'Roles (Permisos)', 'rol_permiso', '37', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"50\",\"estatus\":\"1\",\"id_rol_permiso\":37}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(46, 39195, 'Roles (Permisos)', 'rol_permiso', '38', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"18\",\"estatus\":\"1\",\"id_rol_permiso\":38}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(47, 39195, 'Roles (Permisos)', 'rol_permiso', '39', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"59\",\"estatus\":\"1\",\"id_rol_permiso\":39}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(48, 39195, 'Roles (Permisos)', 'rol_permiso', '40', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"14\",\"estatus\":\"1\",\"id_rol_permiso\":40}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(49, 39195, 'Roles (Permisos)', 'rol_permiso', '41', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"15\",\"estatus\":\"1\",\"id_rol_permiso\":41}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(50, 39195, 'Roles (Permisos)', 'rol_permiso', '42', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"13\",\"estatus\":\"1\",\"id_rol_permiso\":42}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(51, 39195, 'Roles (Permisos)', 'rol_permiso', '43', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"17\",\"estatus\":\"1\",\"id_rol_permiso\":43}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(52, 39195, 'Roles (Permisos)', 'rol_permiso', '44', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"16\",\"estatus\":\"1\",\"id_rol_permiso\":44}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(53, 39195, 'Roles (Permisos)', 'rol_permiso', '45', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"63\",\"estatus\":\"1\",\"id_rol_permiso\":45}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(54, 39195, 'Roles (Permisos)', 'rol_permiso', '46', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"29\",\"estatus\":\"1\",\"id_rol_permiso\":46}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(55, 39195, 'Roles (Permisos)', 'rol_permiso', '47', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"30\",\"estatus\":\"1\",\"id_rol_permiso\":47}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(56, 39195, 'Roles (Permisos)', 'rol_permiso', '48', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"28\",\"estatus\":\"1\",\"id_rol_permiso\":48}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(57, 39195, 'Roles (Permisos)', 'rol_permiso', '49', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"31\",\"estatus\":\"1\",\"id_rol_permiso\":49}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(58, 39195, 'Roles (Permisos)', 'rol_permiso', '50', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"55\",\"estatus\":\"1\",\"id_rol_permiso\":50}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(59, 39195, 'Roles (Permisos)', 'rol_permiso', '51', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"2\",\"estatus\":\"1\",\"id_rol_permiso\":51}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(60, 39195, 'Roles (Permisos)', 'rol_permiso', '52', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"65\",\"estatus\":\"1\",\"id_rol_permiso\":52}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(61, 39195, 'Roles (Permisos)', 'rol_permiso', '53', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"37\",\"estatus\":\"1\",\"id_rol_permiso\":53}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(62, 39195, 'Roles (Permisos)', 'rol_permiso', '54', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"38\",\"estatus\":\"1\",\"id_rol_permiso\":54}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(63, 39195, 'Roles (Permisos)', 'rol_permiso', '55', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"36\",\"estatus\":\"1\",\"id_rol_permiso\":55}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(64, 39195, 'Roles (Permisos)', 'rol_permiso', '56', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"39\",\"estatus\":\"1\",\"id_rol_permiso\":56}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(65, 39195, 'Roles (Permisos)', 'rol_permiso', '57', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"57\",\"estatus\":\"1\",\"id_rol_permiso\":57}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(66, 39195, 'Roles (Permisos)', 'rol_permiso', '58', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"8\",\"estatus\":\"1\",\"id_rol_permiso\":58}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(67, 39195, 'Roles (Permisos)', 'rol_permiso', '59', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"9\",\"estatus\":\"1\",\"id_rol_permiso\":59}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(68, 39195, 'Roles (Permisos)', 'rol_permiso', '60', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"7\",\"estatus\":\"1\",\"id_rol_permiso\":60}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(69, 39195, 'Roles (Permisos)', 'rol_permiso', '61', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"10\",\"estatus\":\"1\",\"id_rol_permiso\":61}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(70, 39195, 'Roles (Permisos)', 'rol_permiso', '62', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"66\",\"estatus\":\"1\",\"id_rol_permiso\":62}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(71, 39195, 'Roles (Permisos)', 'rol_permiso', '63', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"41\",\"estatus\":\"1\",\"id_rol_permiso\":63}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(72, 39195, 'Roles (Permisos)', 'rol_permiso', '64', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"42\",\"estatus\":\"1\",\"id_rol_permiso\":64}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(73, 39195, 'Roles (Permisos)', 'rol_permiso', '65', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"40\",\"estatus\":\"1\",\"id_rol_permiso\":65}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(74, 39195, 'Roles (Permisos)', 'rol_permiso', '66', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"43\",\"estatus\":\"1\",\"id_rol_permiso\":66}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(75, 39195, 'Roles (Permisos)', 'rol_permiso', '67', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"58\",\"estatus\":\"1\",\"id_rol_permiso\":67}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(76, 39195, 'Roles (Permisos)', 'rol_permiso', '68', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"11\",\"estatus\":\"1\",\"id_rol_permiso\":68}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(77, 39195, 'Roles (Permisos)', 'rol_permiso', '69', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"12\",\"estatus\":\"1\",\"id_rol_permiso\":69}', '127.0.0.1', '2026-04-23 04:54:16', '1'),
(78, 39195, 'CalendarioAcademico', 'calendario_academico', '5', 'MOSTRAR', '{\"id_calendario_academico\":5,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 04:54:50', '1'),
(79, 39195, 'CalendarioAcademico', 'calendario_academico', '5', 'MOSTRAR', '{\"id_calendario_academico\":5,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 04:54:55', '1'),
(80, 39195, 'CalendarioAcademico', 'calendario_academico', '5', 'MOSTRAR', '{\"id_calendario_academico\":5,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 04:58:27', '1'),
(81, 39195, 'Evento', 'evento', '1', 'MOSTRAR', '{\"id_evento\":1,\"id_color\":null,\"leyenda_evento\":\"Actividad Administrativa\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 05:01:57', '1'),
(82, 39195, 'Evento', 'evento', '2', 'CREAR', NULL, '{\"leyenda_evento\":\"dsd\",\"tipo_evento\":null,\"estatus\":\"1\",\"id_evento\":2}', '127.0.0.1', '2026-04-23 05:02:52', '1'),
(83, 39195, 'DetalleEvento', 'detalle_evento', '2', 'CREAR', NULL, '{\"id_evento\":2,\"id_calendario_academico\":5,\"dia_inicio_detalle_evento\":\"2026-04-01\",\"dia_fin_detalle_evento\":\"2026-04-16\",\"semana_detalle_evento\":null,\"estatus\":\"1\",\"id_detalle_evento\":2}', '127.0.0.1', '2026-04-23 05:02:52', '1'),
(84, 39195, 'Evento', 'evento', '1', 'MOSTRAR', '{\"id_evento\":1,\"id_color\":null,\"leyenda_evento\":\"Actividad Administrativa\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 05:03:07', '1'),
(85, 39195, 'Evento', 'evento', '2', 'MOSTRAR', '{\"id_evento\":2,\"id_color\":null,\"leyenda_evento\":\"dsd\",\"tipo_evento\":null,\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 05:03:10', '1'),
(86, 39195, 'Evento', 'evento', '2', 'MOSTRAR', '{\"id_evento\":2,\"id_color\":null,\"nombre_evento\":\"dsd\",\"tipo_evento\":null,\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 05:25:22', '1'),
(87, 39195, 'Evento', 'evento', '3', 'CREAR', NULL, '{\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"id_color\":1,\"estatus\":\"1\",\"id_evento\":3}', '127.0.0.1', '2026-04-23 06:00:19', '1'),
(88, 39195, 'DetalleEvento', 'detalle_evento', '3', 'CREAR', NULL, '{\"id_evento\":3,\"id_calendario_academico\":5,\"dia_inicio_detalle_evento\":\"2026-04-01\",\"dia_fin_detalle_evento\":\"2026-04-01\",\"semana_detalle_evento\":null,\"estatus\":\"1\",\"id_detalle_evento\":3}', '127.0.0.1', '2026-04-23 06:00:19', '1'),
(89, 39195, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":1,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:00:32', '1'),
(90, 39195, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":1,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:01:16', '1'),
(91, 39195, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":1,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:01:17', '1'),
(92, 39195, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":1,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:03:33', '1'),
(93, 39195, 'Roles (Permisos)', 'rol_permiso', '70', 'CREAR', NULL, '{\"id_rol\":\"11\",\"id_permiso\":\"70\",\"estatus\":\"1\",\"id_rol_permiso\":70}', '127.0.0.1', '2026-04-23 06:19:20', '1'),
(94, 39195, 'Evento', 'evento', '2', 'MOSTRAR', '{\"id_evento\":2,\"id_color\":null,\"nombre_evento\":\"dsd\",\"tipo_evento\":null,\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:19:35', '1'),
(95, 39195, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":1,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:19:40', '1'),
(96, 39195, 'Evento', 'evento', '3', 'MODIFICAR', '{\"id_evento\":3,\"id_color\":1,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":3}', '127.0.0.1', '2026-04-23 06:20:05', '1'),
(97, 39195, 'DetalleEvento', 'detalle_evento', '3', 'MODIFICAR', '{\"id_detalle_evento\":3,\"id_evento\":3,\"id_calendario_academico\":5,\"dia_inicio_detalle_evento\":\"2026-04-01\",\"dia_fin_detalle_evento\":\"2026-04-01\",\"semana_detalle_evento\":null,\"estatus\":\"1\"}', '{\"dia_fin_detalle_evento\":\"2026-04-02\"}', '127.0.0.1', '2026-04-23 06:20:05', '1'),
(98, 39195, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":3,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 06:20:09', '1'),
(99, 39195, 'Evento', 'evento', '4', 'CREAR', NULL, '{\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"id_color\":5,\"estatus\":\"1\",\"id_evento\":4}', '127.0.0.1', '2026-04-23 06:26:37', '1'),
(100, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 20:17:11', '1'),
(101, 43325, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":3,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 20:17:27', '1'),
(102, 43325, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":3,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 20:17:30', '1'),
(103, 43325, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":3,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 20:18:03', '1'),
(104, 43325, 'Evento', 'evento', '3', 'MOSTRAR', '{\"id_evento\":3,\"id_color\":3,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 20:18:11', '1'),
(105, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 20:29:11', '1'),
(106, 43325, 'TecnicaEvaluacion', 'tecnica_evaluacion', '1', 'CREAR', NULL, '{\"nombre_tecnica_evaluacion\":\"\\u00f1\\u00f1\\u00f1\\u00f1\",\"estatus\":\"1\",\"id_tecnica_evaluacion\":1}', '127.0.0.1', '2026-04-23 20:29:54', '1'),
(107, 43325, 'TecnicaEvaluacion', 'tecnica_evaluacion', '1', 'MOSTRAR', '{\"id_tecnica_evaluacion\":1,\"nombre_tecnica_evaluacion\":\"\\u00f1\\u00f1\\u00f1\\u00f1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 20:42:34', '1'),
(108, 1, 'CalendarioAcademico', 'calendario_academico', '5', 'MODIFICAR', '{\"id_calendario_academico\":5,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-23 20:44:07', '1'),
(109, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-23 20:44:25', '1'),
(110, 1, 'CalendarioAcademico', 'calendario_academico', '6', 'CREAR', NULL, '{\"semana_calendario_academico\":18,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-07-30\",\"estatus\":\"1\",\"id_calendario_academico\":6}', '127.0.0.1', '2026-04-23 21:00:48', '1'),
(111, 1, 'Evento', 'evento', '5', 'CREAR', NULL, '{\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"id_color\":null,\"estatus\":\"1\",\"id_evento\":5}', '127.0.0.1', '2026-04-23 21:00:48', '1'),
(112, 1, 'Evento', 'evento', '6', 'CREAR', NULL, '{\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"id_color\":null,\"estatus\":\"1\",\"id_evento\":6}', '127.0.0.1', '2026-04-23 21:00:48', '1'),
(113, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 21:00:51', '1'),
(114, 1, 'CalendarioAcademico', 'calendario_academico', '6', 'MODIFICAR', '{\"id_calendario_academico\":6,\"semana_calendario_academico\":18,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-07-30\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-23 21:44:42', '1'),
(115, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-23 21:44:48', '1'),
(116, 1, 'CalendarioAcademico', 'calendario_academico', '7', 'CREAR', NULL, '{\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\",\"id_calendario_academico\":7}', '127.0.0.1', '2026-04-23 21:45:17', '1'),
(117, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 21:45:18', '1'),
(118, 43325, 'Estrategia', 'tecnica_actividad', '1', 'CREAR', NULL, '{\"nombre_tecnica_actividad\":\"pppppppppp\",\"estatus\":\"1\",\"id_tecnica_actividad\":1}', '127.0.0.1', '2026-04-23 21:48:55', '1'),
(119, 43325, 'Bibliografia', 'bibliografia', '1', 'CREAR', NULL, '{\"nombre_bibliografia\":\"llll\",\"estatus\":\"1\",\"id_bibliografia\":1}', '127.0.0.1', '2026-04-23 21:51:42', '1'),
(120, 43325, 'TipoEvaluacion', 'tipo_evaluacion', '1', 'CREAR', NULL, '{\"nombre_tipo_evaluacion\":\"dasdsa\",\"estatus\":\"1\",\"id_tipo_evaluacion\":1}', '127.0.0.1', '2026-04-23 21:51:59', '1'),
(121, 43325, 'Recurso', 'recurso', '1', 'CREAR', NULL, '{\"nombre_recurso\":\"23,\",\"estatus\":\"1\",\"id_recurso\":1}', '127.0.0.1', '2026-04-23 21:54:27', '1'),
(122, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-23 21:55:14', '1'),
(123, 1, 'CalendarioAcademico', 'calendario_academico', '7', 'MODIFICAR', '{\"id_calendario_academico\":7,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-23 21:55:47', '1'),
(124, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-23 21:56:46', '1'),
(125, 1, 'CalendarioAcademico', 'calendario_academico', '8', 'CREAR', NULL, '{\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\",\"id_calendario_academico\":8}', '127.0.0.1', '2026-04-23 22:09:28', '1'),
(126, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 22:09:29', '1'),
(127, 1, 'CalendarioAcademico', 'calendario_academico', '8', 'MODIFICAR', '{\"id_calendario_academico\":8,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-23 22:11:53', '1'),
(128, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-23 22:12:00', '1'),
(129, 1, 'CalendarioAcademico', 'calendario_academico', '9', 'CREAR', NULL, '{\"semana_calendario_academico\":22,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-08-31\",\"estatus\":\"1\",\"id_calendario_academico\":9}', '127.0.0.1', '2026-04-23 22:12:44', '1'),
(130, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-23 22:12:46', '1'),
(131, 1, 'CalendarioAcademico', 'calendario_academico', '9', 'MODIFICAR', '{\"id_calendario_academico\":9,\"semana_calendario_academico\":22,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-08-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-25 20:49:33', '1'),
(132, 1, 'CalendarioAcademico', 'calendario_academico', '10', 'CREAR', NULL, '{\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\",\"id_calendario_academico\":10}', '127.0.0.1', '2026-04-25 20:50:33', '1'),
(133, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-25 20:50:35', '1'),
(134, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-26 22:16:02', '1'),
(135, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-26 22:42:52', '1'),
(136, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-27 19:57:15', '1'),
(137, 1, 'CalendarioAcademico', 'calendario_academico', '10', 'MODIFICAR', '{\"id_calendario_academico\":10,\"semana_calendario_academico\":5,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-04-30\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-27 20:05:12', '1'),
(138, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-27 20:05:18', '1'),
(139, 1, 'CalendarioAcademico', 'calendario_academico', '11', 'CREAR', NULL, '{\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\",\"id_calendario_academico\":11}', '127.0.0.1', '2026-04-27 20:06:05', '1'),
(140, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-27 20:06:07', '1'),
(141, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-27 20:07:10', '1'),
(142, 1, 'CalendarioAcademico', 'calendario_academico', '11', 'MODIFICAR', '{\"id_calendario_academico\":11,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-04-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-27 20:07:15', '1'),
(143, 1, 'CalendarioAcademico', 'calendario_academico', '12', 'CREAR', NULL, '{\"semana_calendario_academico\":6,\"dia_inicio_calendario_academico\":\"2026-04-10\",\"dia_fin_calendario_academico\":\"2026-05-21\",\"estatus\":\"1\",\"id_calendario_academico\":12}', '127.0.0.1', '2026-04-27 22:24:04', '1'),
(144, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-27 22:24:42', '1'),
(145, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:24:51', '1'),
(146, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:26:04', '1'),
(147, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:28:46', '1'),
(148, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:28:53', '1'),
(149, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:28:56', '1'),
(150, 43325, 'Evento', 'evento', '6', 'MOSTRAR', '{\"id_evento\":6,\"id_color\":null,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:29:23', '1'),
(151, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:29:27', '1'),
(152, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:32:26', '1'),
(153, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:32:27', '1'),
(154, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:33:04', '1'),
(155, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:33:56', '1'),
(156, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:33:57', '1'),
(157, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:34:05', '1'),
(158, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:34:05', '1'),
(159, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:34:07', '1'),
(160, 43325, 'Evento', 'evento', '4', 'MOSTRAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:34:07', '1'),
(161, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:36:24', '1'),
(162, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:36:28', '1'),
(163, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:36:42', '1'),
(164, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-27 22:36:44', '1'),
(165, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 00:31:54', '1'),
(166, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 00:31:57', '1'),
(167, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:04:43', '1'),
(168, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:04:45', '1'),
(169, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:08:42', '1'),
(170, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:08:45', '1'),
(171, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:11:31', '1'),
(172, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:15:32', '1'),
(173, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:15:34', '1'),
(174, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:15:36', '1'),
(175, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:15:37', '1'),
(176, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:16:40', '1'),
(177, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:16:54', '1'),
(178, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:20:34', '1'),
(179, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:21:10', '1'),
(180, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:21:13', '1'),
(181, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:21:14', '1'),
(182, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:21:16', '1'),
(183, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:21:17', '1'),
(184, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:21:23', '1'),
(185, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:23:07', '1'),
(186, 43325, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-04-28 01:23:14', '1'),
(187, 1, 'CalendarioAcademico', 'calendario_academico', '12', 'MODIFICAR', '{\"id_calendario_academico\":12,\"semana_calendario_academico\":6,\"dia_inicio_calendario_academico\":\"2026-04-10\",\"dia_fin_calendario_academico\":\"2026-05-21\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-28 03:08:29', '1'),
(188, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-28 03:08:37', '1'),
(189, 1, 'CalendarioAcademico', 'calendario_academico', '13', 'CREAR', NULL, '{\"semana_calendario_academico\":257,\"dia_inicio_calendario_academico\":\"2025-01-01\",\"dia_fin_calendario_academico\":\"2029-12-01\",\"estatus\":\"1\",\"id_calendario_academico\":13}', '127.0.0.1', '2026-04-29 01:06:06', '1'),
(190, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-04-29 01:06:08', '1'),
(191, 1, 'CalendarioAcademico', 'calendario_academico', '13', 'MODIFICAR', '{\"id_calendario_academico\":13,\"semana_calendario_academico\":257,\"dia_inicio_calendario_academico\":\"2025-01-01\",\"dia_fin_calendario_academico\":\"2029-12-01\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-29 01:39:41', '1'),
(192, 0, 'Seguridad', 'users', '43325', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-04-29 01:39:49', '1'),
(193, 1, 'CalendarioAcademico', 'calendario_academico', '14', 'CREAR', NULL, '{\"semana_calendario_academico\":58,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2027-02-10\",\"estatus\":\"1\",\"id_calendario_academico\":14}', '127.0.0.1', '2026-04-29 02:46:40', '1'),
(194, 1, 'CalendarioAcademico', 'calendario_academico', '14', 'MODIFICAR', '{\"id_calendario_academico\":14,\"semana_calendario_academico\":58,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2027-02-10\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-04-29 02:46:53', '1'),
(195, 1, 'CalendarioAcademico', 'calendario_academico', '15', 'CREAR', NULL, '{\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-05-02\",\"dia_fin_calendario_academico\":\"2026-06-30\",\"estatus\":\"1\",\"id_calendario_academico\":15}', '127.0.0.1', '2026-05-02 20:16:33', '1'),
(196, 0, 'Seguridad', 'users', '43325', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-02 20:16:38', '1'),
(197, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-03 00:28:00', '1'),
(198, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-03 00:29:45', '1'),
(199, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-03 00:29:56', '1'),
(200, 31009367, 'Recurso', 'recurso', '1', 'MOSTRAR', '{\"id_recurso\":1,\"nombre_recurso\":\"23,\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-03 00:30:18', '1'),
(201, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-03 00:40:38', '1'),
(202, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-03 00:41:17', '1'),
(203, 1, 'CalendarioAcademico', 'calendario_academico', '15', 'MODIFICAR', '{\"id_calendario_academico\":15,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-05-02\",\"dia_fin_calendario_academico\":\"2026-06-30\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 06:58:57', '1'),
(204, 1, 'CalendarioAcademico', 'calendario_academico', '16', 'CREAR', NULL, '{\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-06-30\",\"estatus\":\"1\",\"id_calendario_academico\":16}', '127.0.0.1', '2026-05-06 07:03:31', '1'),
(205, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 07:03:33', '1'),
(206, 31009367, 'Roles (Permisos)', 'rol_permiso', '71', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"67\",\"estatus\":\"1\",\"id_rol_permiso\":71}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(207, 31009367, 'Roles (Permisos)', 'rol_permiso', '72', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"45\",\"estatus\":\"1\",\"id_rol_permiso\":72}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(208, 31009367, 'Roles (Permisos)', 'rol_permiso', '73', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"70\",\"estatus\":\"1\",\"id_rol_permiso\":73}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(209, 31009367, 'Roles (Permisos)', 'rol_permiso', '74', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"44\",\"estatus\":\"1\",\"id_rol_permiso\":74}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(210, 31009367, 'Roles (Permisos)', 'rol_permiso', '75', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"46\",\"estatus\":\"1\",\"id_rol_permiso\":75}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(211, 31009367, 'Roles (Permisos)', 'rol_permiso', '76', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"69\",\"estatus\":\"1\",\"id_rol_permiso\":76}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(212, 31009367, 'Roles (Permisos)', 'rol_permiso', '77', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"52\",\"estatus\":\"1\",\"id_rol_permiso\":77}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(213, 31009367, 'Roles (Permisos)', 'rol_permiso', '78', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"53\",\"estatus\":\"1\",\"id_rol_permiso\":78}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(214, 31009367, 'Roles (Permisos)', 'rol_permiso', '79', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"60\",\"estatus\":\"1\",\"id_rol_permiso\":79}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(215, 31009367, 'Roles (Permisos)', 'rol_permiso', '80', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"48\",\"estatus\":\"1\",\"id_rol_permiso\":80}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(216, 31009367, 'Roles (Permisos)', 'rol_permiso', '81', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"47\",\"estatus\":\"1\",\"id_rol_permiso\":81}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(217, 31009367, 'Roles (Permisos)', 'rol_permiso', '82', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"19\",\"estatus\":\"1\",\"id_rol_permiso\":82}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(218, 31009367, 'Roles (Permisos)', 'rol_permiso', '83', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"49\",\"estatus\":\"1\",\"id_rol_permiso\":83}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(219, 31009367, 'Roles (Permisos)', 'rol_permiso', '84', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"68\",\"estatus\":\"1\",\"id_rol_permiso\":84}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(220, 31009367, 'Roles (Permisos)', 'rol_permiso', '85', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"51\",\"estatus\":\"1\",\"id_rol_permiso\":85}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(221, 31009367, 'Roles (Permisos)', 'rol_permiso', '86', 'CREAR', NULL, '{\"id_rol\":\"31\",\"id_permiso\":\"50\",\"estatus\":\"1\",\"id_rol_permiso\":86}', '127.0.0.1', '2026-05-06 07:37:09', '1'),
(222, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:43:54', '1'),
(223, 31009367, 'Evento', 'evento', '17', 'MODIFICAR', '{\"id_evento\":17,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":2}', '127.0.0.1', '2026-05-06 07:44:02', '1'),
(224, 31009367, 'Evento', 'evento', '2', 'MODIFICAR', '{\"id_evento\":2,\"id_color\":null,\"nombre_evento\":\"dsd\",\"tipo_evento\":null,\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:44:10', '1'),
(225, 31009367, 'Evento', 'evento', '1', 'MODIFICAR', '{\"id_evento\":1,\"id_color\":null,\"nombre_evento\":\"Actividad Administrativa\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:44:12', '1'),
(226, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:44:14', '1'),
(227, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:44:23', '1'),
(228, 31009367, 'Evento', 'evento', '16', 'MODIFICAR', '{\"id_evento\":16,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":1}', '127.0.0.1', '2026-05-06 07:44:28', '1'),
(229, 31009367, 'Evento', 'evento', '15', 'MOSTRAR', '{\"id_evento\":15,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:44:31', '1'),
(230, 31009367, 'Evento', 'evento', '15', 'MODIFICAR', '{\"id_evento\":15,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":3}', '127.0.0.1', '2026-05-06 07:44:36', '1'),
(231, 31009367, 'Evento', 'evento', '14', 'MOSTRAR', '{\"id_evento\":14,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:44:39', '1'),
(232, 31009367, 'Evento', 'evento', '14', 'MODIFICAR', '{\"id_evento\":14,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":4}', '127.0.0.1', '2026-05-06 07:44:46', '1'),
(233, 31009367, 'Evento', 'evento', '13', 'MOSTRAR', '{\"id_evento\":13,\"id_color\":null,\"nombre_evento\":\"DECLARACION DE LA INDEPENDENCIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:44:50', '1'),
(234, 31009367, 'Evento', 'evento', '13', 'MODIFICAR', '{\"id_evento\":13,\"id_color\":null,\"nombre_evento\":\"DECLARACION DE LA INDEPENDENCIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":5}', '127.0.0.1', '2026-05-06 07:44:55', '1'),
(235, 31009367, 'Evento', 'evento', '12', 'MOSTRAR', '{\"id_evento\":12,\"id_color\":null,\"nombre_evento\":\"JUEVES y VIERNES SANTO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:45:56', '1'),
(236, 31009367, 'Evento', 'evento', '12', 'MODIFICAR', '{\"id_evento\":12,\"id_color\":null,\"nombre_evento\":\"JUEVES y VIERNES SANTO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":6}', '127.0.0.1', '2026-05-06 07:46:02', '1'),
(237, 31009367, 'Evento', 'evento', '11', 'MOSTRAR', '{\"id_evento\":11,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR UNIVERSITARIO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:46:08', '1'),
(238, 31009367, 'Evento', 'evento', '11', 'MODIFICAR', '{\"id_evento\":11,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR UNIVERSITARIO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":7}', '127.0.0.1', '2026-05-06 07:46:14', '1'),
(239, 31009367, 'Evento', 'evento', '10', 'MOSTRAR', '{\"id_evento\":10,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:46:19', '1'),
(240, 31009367, 'Evento', 'evento', '10', 'MODIFICAR', '{\"id_evento\":10,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":8}', '127.0.0.1', '2026-05-06 07:46:24', '1'),
(241, 31009367, 'Evento', 'evento', '9', 'MOSTRAR', '{\"id_evento\":9,\"id_color\":null,\"nombre_evento\":\"CARNAVAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:46:29', '1'),
(242, 31009367, 'Evento', 'evento', '9', 'MODIFICAR', '{\"id_evento\":9,\"id_color\":null,\"nombre_evento\":\"CARNAVAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":9}', '127.0.0.1', '2026-05-06 07:46:35', '1'),
(243, 31009367, 'Evento', 'evento', '8', 'MOSTRAR', '{\"id_evento\":8,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE LA DEMOCRACIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:46:40', '1'),
(244, 31009367, 'Evento', 'evento', '8', 'MODIFICAR', '{\"id_evento\":8,\"id_color\":null,\"nombre_evento\":\"D\\u00cdA DE LA DEMOCRACIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":10}', '127.0.0.1', '2026-05-06 07:46:46', '1'),
(245, 31009367, 'Evento', 'evento', '3', 'MODIFICAR', '{\"id_evento\":3,\"id_color\":3,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:47:07', '1'),
(246, 31009367, 'Evento', 'evento', '4', 'MODIFICAR', '{\"id_evento\":4,\"id_color\":5,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:47:10', '1'),
(247, 31009367, 'Evento', 'evento', '5', 'MODIFICAR', '{\"id_evento\":5,\"id_color\":null,\"nombre_evento\":\"dsdp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:47:13', '1'),
(248, 31009367, 'Evento', 'evento', '6', 'MODIFICAR', '{\"id_evento\":6,\"id_color\":null,\"nombre_evento\":\"dsdpp\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:47:14', '1'),
(249, 31009367, 'Evento', 'evento', '7', 'MOSTRAR', '{\"id_evento\":7,\"id_color\":null,\"nombre_evento\":\"A\\u00d1O NUEVO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:47:22', '1'),
(250, 31009367, 'Evento', 'evento', '7', 'MODIFICAR', '{\"id_evento\":7,\"id_color\":null,\"nombre_evento\":\"A\\u00d1O NUEVO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"id_color\":11}', '127.0.0.1', '2026-05-06 07:47:27', '1');
INSERT INTO `bitacora` (`id_bitacora`, `id_usuario`, `modulo_afectado_bitacora`, `tabla_afectada_bitacora`, `id_registro_afectado_bitacora`, `accion_bitacora`, `valores_anteriores_bitacora`, `valores_nuevos_bitacora`, `ip_origen_bitacora`, `fecha_creacion`, `estatus`) VALUES
(251, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:47:34', '1'),
(252, 31009367, 'Evento', 'evento', '17', 'MODIFICAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:47:40', '1'),
(253, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:47:46', '1'),
(254, 31009367, 'Evento', 'evento', '16', 'MODIFICAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:47:51', '1'),
(255, 31009367, 'Evento', 'evento', '15', 'MOSTRAR', '{\"id_evento\":15,\"id_color\":3,\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:47:57', '1'),
(256, 31009367, 'Evento', 'evento', '15', 'MODIFICAR', '{\"id_evento\":15,\"id_color\":3,\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:48:01', '1'),
(257, 31009367, 'Evento', 'evento', '14', 'MOSTRAR', '{\"id_evento\":14,\"id_color\":4,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:05', '1'),
(258, 31009367, 'Evento', 'evento', '14', 'MODIFICAR', '{\"id_evento\":14,\"id_color\":4,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:48:09', '1'),
(259, 31009367, 'Evento', 'evento', '15', 'MOSTRAR', '{\"id_evento\":15,\"id_color\":3,\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:12', '1'),
(260, 31009367, 'Evento', 'evento', '14', 'MOSTRAR', '{\"id_evento\":14,\"id_color\":4,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:19', '1'),
(261, 31009367, 'Evento', 'evento', '13', 'MOSTRAR', '{\"id_evento\":13,\"id_color\":5,\"nombre_evento\":\"DECLARACION DE LA INDEPENDENCIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:25', '1'),
(262, 31009367, 'Evento', 'evento', '13', 'MODIFICAR', '{\"id_evento\":13,\"id_color\":5,\"nombre_evento\":\"DECLARACION DE LA INDEPENDENCIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:48:30', '1'),
(263, 31009367, 'Evento', 'evento', '12', 'MOSTRAR', '{\"id_evento\":12,\"id_color\":6,\"nombre_evento\":\"JUEVES y VIERNES SANTO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:35', '1'),
(264, 31009367, 'Evento', 'evento', '12', 'MODIFICAR', '{\"id_evento\":12,\"id_color\":6,\"nombre_evento\":\"JUEVES y VIERNES SANTO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:48:39', '1'),
(265, 31009367, 'Evento', 'evento', '11', 'MOSTRAR', '{\"id_evento\":11,\"id_color\":7,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR UNIVERSITARIO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:43', '1'),
(266, 31009367, 'Evento', 'evento', '11', 'MODIFICAR', '{\"id_evento\":11,\"id_color\":7,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR UNIVERSITARIO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:48:47', '1'),
(267, 31009367, 'Evento', 'evento', '10', 'MOSTRAR', '{\"id_evento\":10,\"id_color\":8,\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:48:51', '1'),
(268, 31009367, 'Evento', 'evento', '10', 'MODIFICAR', '{\"id_evento\":10,\"id_color\":8,\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:48:56', '1'),
(269, 31009367, 'Evento', 'evento', '9', 'MOSTRAR', '{\"id_evento\":9,\"id_color\":9,\"nombre_evento\":\"CARNAVAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:04', '1'),
(270, 31009367, 'Evento', 'evento', '9', 'MODIFICAR', '{\"id_evento\":9,\"id_color\":9,\"nombre_evento\":\"CARNAVAL\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:49:08', '1'),
(271, 31009367, 'Evento', 'evento', '8', 'MOSTRAR', '{\"id_evento\":8,\"id_color\":10,\"nombre_evento\":\"D\\u00cdA DE LA DEMOCRACIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:13', '1'),
(272, 31009367, 'Evento', 'evento', '8', 'MODIFICAR', '{\"id_evento\":8,\"id_color\":10,\"nombre_evento\":\"D\\u00cdA DE LA DEMOCRACIA\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:49:17', '1'),
(273, 31009367, 'Evento', 'evento', '8', 'MOSTRAR', '{\"id_evento\":8,\"id_color\":10,\"nombre_evento\":\"D\\u00cdA DE LA DEMOCRACIA\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:21', '1'),
(274, 31009367, 'Evento', 'evento', '9', 'MOSTRAR', '{\"id_evento\":9,\"id_color\":9,\"nombre_evento\":\"CARNAVAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:25', '1'),
(275, 31009367, 'Evento', 'evento', '10', 'MOSTRAR', '{\"id_evento\":10,\"id_color\":8,\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:30', '1'),
(276, 31009367, 'Evento', 'evento', '11', 'MOSTRAR', '{\"id_evento\":11,\"id_color\":7,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR UNIVERSITARIO\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:35', '1'),
(277, 31009367, 'Evento', 'evento', '12', 'MOSTRAR', '{\"id_evento\":12,\"id_color\":6,\"nombre_evento\":\"JUEVES y VIERNES SANTO\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:49:40', '1'),
(278, 31009367, 'Evento', 'evento', '7', 'MOSTRAR', '{\"id_evento\":7,\"id_color\":11,\"nombre_evento\":\"A\\u00d1O NUEVO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 07:50:06', '1'),
(279, 31009367, 'Evento', 'evento', '7', 'MODIFICAR', '{\"id_evento\":7,\"id_color\":11,\"nombre_evento\":\"A\\u00d1O NUEVO\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"tipo_evento\":\"1\"}', '127.0.0.1', '2026-05-06 07:50:10', '1'),
(280, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 07:50:24', '1'),
(281, 1, 'CalendarioAcademico', 'calendario_academico', '16', 'MODIFICAR', '{\"id_calendario_academico\":16,\"semana_calendario_academico\":9,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-06-30\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 07:51:18', '1'),
(282, 1, 'CalendarioAcademico', 'calendario_academico', '17', 'CREAR', NULL, '{\"semana_calendario_academico\":18,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-08-31\",\"estatus\":\"1\",\"id_calendario_academico\":17}', '127.0.0.1', '2026-05-06 07:56:21', '1'),
(283, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 07:56:23', '1'),
(284, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 07:56:35', '1'),
(285, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 08:00:48', '1'),
(286, 1, 'CalendarioAcademico', 'calendario_academico', '17', 'MODIFICAR', '{\"id_calendario_academico\":17,\"semana_calendario_academico\":18,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-08-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:00:52', '1'),
(287, 1, 'CalendarioAcademico', 'calendario_academico', '18', 'CREAR', NULL, '{\"semana_calendario_academico\":14,\"dia_inicio_calendario_academico\":\"2026-04-30\",\"dia_fin_calendario_academico\":\"2026-07-31\",\"estatus\":\"1\",\"id_calendario_academico\":18}', '127.0.0.1', '2026-05-06 08:05:47', '1'),
(288, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 08:05:50', '1'),
(289, 31009367, 'Evento', 'evento', '16', 'MODIFICAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:06:25', '1'),
(290, 31009367, 'Evento', 'evento', '10', 'MODIFICAR', '{\"id_evento\":10,\"id_color\":8,\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:06:39', '1'),
(291, 31009367, 'Evento', 'evento', '15', 'MODIFICAR', '{\"id_evento\":15,\"id_color\":3,\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:06:49', '1'),
(292, 31009367, 'Evento', 'evento', '17', 'MODIFICAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:06:58', '1'),
(293, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 08:07:09', '1'),
(294, 1, 'CalendarioAcademico', 'calendario_academico', '18', 'MODIFICAR', '{\"id_calendario_academico\":18,\"semana_calendario_academico\":14,\"dia_inicio_calendario_academico\":\"2026-04-30\",\"dia_fin_calendario_academico\":\"2026-07-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:07:13', '1'),
(295, 1, 'CalendarioAcademico', 'calendario_academico', '19', 'CREAR', NULL, '{\"semana_calendario_academico\":14,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-07-31\",\"estatus\":\"1\",\"id_calendario_academico\":19}', '127.0.0.1', '2026-05-06 08:08:26', '1'),
(296, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 08:08:31', '1'),
(297, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 08:09:02', '1'),
(298, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 08:09:42', '1'),
(299, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 08:09:48', '1'),
(300, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 08:10:14', '1'),
(301, 1, 'CalendarioAcademico', 'calendario_academico', '19', 'MODIFICAR', '{\"id_calendario_academico\":19,\"semana_calendario_academico\":14,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-07-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 08:10:57', '1'),
(302, 1, 'CalendarioAcademico', 'calendario_academico', '20', 'CREAR', NULL, '{\"semana_calendario_academico\":29,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2026-07-17\",\"estatus\":\"1\",\"id_calendario_academico\":20}', '127.0.0.1', '2026-05-06 08:16:16', '1'),
(303, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 08:16:21', '1'),
(304, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 08:16:36', '1'),
(305, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 08:19:13', '1'),
(306, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-06 08:20:00', '1'),
(307, 31009367, 'Evento', 'evento', '14', 'MOSTRAR', '{\"id_evento\":14,\"id_color\":4,\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-06 08:20:08', '1'),
(308, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-06 08:20:24', '1'),
(309, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 08:20:50', '1'),
(310, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 14:34:08', '1'),
(311, 1, 'CalendarioAcademico', 'calendario_academico', '20', 'MODIFICAR', '{\"id_calendario_academico\":20,\"semana_calendario_academico\":29,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2026-07-17\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 14:35:29', '1'),
(312, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 14:35:32', '1'),
(313, 1, 'CalendarioAcademico', 'calendario_academico', '21', 'CREAR', NULL, '{\"semana_calendario_academico\":18,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-08-31\",\"estatus\":\"1\",\"id_calendario_academico\":21}', '127.0.0.1', '2026-05-06 15:54:37', '1'),
(314, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 15:54:46', '1'),
(315, 1, 'CalendarioAcademico', 'calendario_academico', '21', 'MODIFICAR', '{\"id_calendario_academico\":21,\"semana_calendario_academico\":18,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-08-31\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-06 16:01:28', '1'),
(316, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 16:01:31', '1'),
(317, 1, 'CalendarioAcademico', 'calendario_academico', '22', 'CREAR', NULL, '{\"semana_calendario_academico\":59,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2027-02-12\",\"estatus\":\"1\",\"id_calendario_academico\":22}', '127.0.0.1', '2026-05-06 19:30:57', '1'),
(318, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 19:31:04', '1'),
(319, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-06 19:39:37', '1'),
(320, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-06 19:42:15', '1'),
(321, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-07 05:30:27', '1'),
(322, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-07 18:24:18', '1'),
(323, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-07 18:27:28', '1'),
(324, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-07 18:40:33', '1'),
(325, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-07 22:58:40', '1'),
(326, 31009367, 'CalendarioAcademico', 'calendario_academico', '23', 'CREAR', NULL, '{\"semana_calendario_academico\":4,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2026-05-28\",\"estatus\":\"1\",\"id_calendario_academico\":23}', '127.0.0.1', '2026-05-07 23:21:50', '1'),
(327, 31009367, 'CalendarioAcademico', 'calendario_academico', '24', 'CREAR', NULL, '{\"semana_calendario_academico\":75,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2027-10-07\",\"estatus\":\"1\",\"id_calendario_academico\":24}', '127.0.0.1', '2026-05-07 23:37:27', '1'),
(328, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-07 23:37:33', '1'),
(329, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-08 04:07:52', '1'),
(330, 31009367, 'CalendarioAcademico', 'calendario_academico', '25', 'CREAR', NULL, '{\"semana_calendario_academico\":22,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2026-05-31\",\"estatus\":\"1\",\"id_calendario_academico\":25}', '127.0.0.1', '2026-05-08 04:45:57', '1'),
(331, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-08 04:46:23', '1'),
(332, 31009367, 'CalendarioAcademico', 'calendario_academico', '26', 'CREAR', NULL, '{\"semana_calendario_academico\":59,\"dia_inicio_calendario_academico\":\"2026-01-01\",\"dia_fin_calendario_academico\":\"2027-02-11\",\"estatus\":\"1\",\"id_calendario_academico\":26}', '127.0.0.1', '2026-05-08 04:48:36', '1'),
(333, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-08 04:49:13', '1'),
(334, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 02:59:02', '1'),
(335, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-10 02:59:13', '1'),
(336, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 03:10:12', '1'),
(337, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-10 03:11:12', '1'),
(338, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 03:17:04', '1'),
(339, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-10 03:20:57', '1'),
(340, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 03:21:10', '1'),
(341, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-10 03:24:15', '1'),
(342, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 03:25:02', '1'),
(343, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 15:16:17', '1'),
(344, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:32:23', '1'),
(345, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:33:25', '1'),
(346, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:38:54', '1'),
(347, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:39:03', '1'),
(348, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:39:04', '1'),
(349, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:41:38', '1'),
(350, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:41:47', '1'),
(351, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:41:49', '1'),
(352, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:43:42', '1'),
(353, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:46:08', '1'),
(354, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:46:16', '1'),
(355, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:48:22', '1'),
(356, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:52:31', '1'),
(357, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:53:37', '1'),
(358, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:55:39', '1'),
(359, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:57:46', '1'),
(360, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 15:57:50', '1'),
(361, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:00:04', '1'),
(362, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:02:20', '1'),
(363, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:02:22', '1'),
(364, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:06:05', '1'),
(365, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:06:16', '1'),
(366, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:06:19', '1'),
(367, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:08:23', '1'),
(368, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:14:34', '1'),
(369, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:15:57', '1'),
(370, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:18:15', '1'),
(371, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:21:32', '1'),
(372, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:22:37', '1'),
(373, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:23:42', '1'),
(374, 31009367, 'CalendarioAcademico', 'calendario_academico', '27', 'CREAR', NULL, '{\"semana_calendario_academico\":41,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2027-02-10\",\"estatus\":\"1\",\"id_calendario_academico\":27}', '127.0.0.1', '2026-05-10 16:25:15', '1'),
(375, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:25:20', '1'),
(376, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:27:55', '1'),
(377, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:28:26', '1'),
(378, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:28:55', '1'),
(379, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:30:19', '1'),
(380, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:30:48', '1'),
(381, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:32:24', '1'),
(382, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:32:39', '1'),
(383, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:34:47', '1'),
(384, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:35:18', '1'),
(385, 31009367, 'CalendarioAcademico', 'calendario_academico', '28', 'CREAR', NULL, '{\"semana_calendario_academico\":41,\"dia_inicio_calendario_academico\":\"2026-05-01\",\"dia_fin_calendario_academico\":\"2027-02-10\",\"estatus\":\"1\",\"id_calendario_academico\":28}', '127.0.0.1', '2026-05-10 16:36:45', '1'),
(386, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:36:58', '1'),
(387, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:37:24', '1'),
(388, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:44:35', '1'),
(389, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:45:58', '1'),
(390, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:47:21', '1'),
(391, 31009367, 'Evento', 'evento', '17', 'MOSTRAR', '{\"id_evento\":17,\"id_color\":2,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', NULL, '127.0.0.1', '2026-05-10 16:47:22', '1'),
(392, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:47:31', '1'),
(393, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:58:40', '1'),
(394, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 16:58:55', '1'),
(395, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:15:33', '1'),
(396, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:16:33', '1'),
(397, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:16:41', '1'),
(398, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:19:19', '1'),
(399, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:19:49', '1'),
(400, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:20:27', '1'),
(401, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-10 20:20:38', '1'),
(402, 31009367, 'Evento', 'evento', '16', 'MODIFICAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"3\"}', '{\"estatus\":\"1\"}', '127.0.0.1', '2026-05-10 21:17:07', '1'),
(403, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:17:53', '1'),
(404, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:22:41', '1'),
(405, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:22:46', '1'),
(406, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:23:02', '1'),
(407, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:23:07', '1'),
(408, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:24:04', '1'),
(409, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:25:45', '1'),
(410, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:25:50', '1'),
(411, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:26:00', '1'),
(412, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:26:46', '1'),
(413, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:28:31', '1'),
(414, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:28:39', '1'),
(415, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:28:55', '1'),
(416, 31009367, 'Evento', 'evento', '16', 'MOSTRAR', '{\"id_evento\":16,\"id_color\":1,\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-10 21:29:11', '1'),
(417, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-10 23:22:21', '1'),
(418, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 23:23:22', '1'),
(419, 31009367, 'Seguridad', 'users', '31009367', 'LOGOUT', NULL, NULL, '127.0.0.1', '2026-05-10 23:23:26', '1'),
(420, 31009367, 'Seguridad', 'users', '31009367', 'LOGIN', NULL, NULL, '127.0.0.1', '2026-05-10 23:26:36', '1'),
(421, 31009367, 'Evento', 'evento', '1', 'CREAR', NULL, '{\"nombre_evento\":\"A\\u00d1O NUEVO\",\"tipo_evento\":\"1\",\"id_color\":1,\"estatus\":\"1\",\"id_evento\":1}', '127.0.0.1', '2026-05-10 23:52:12', '1'),
(422, 31009367, 'Evento', 'evento', '2', 'CREAR', NULL, '{\"nombre_evento\":\"D\\u00cdA DE LA DEMOCRAC\\u00cdA\",\"tipo_evento\":\"1\",\"id_color\":2,\"estatus\":\"1\",\"id_evento\":2}', '127.0.0.1', '2026-05-10 23:53:33', '1'),
(423, 31009367, 'Evento', 'evento', '3', 'CREAR', NULL, '{\"nombre_evento\":\"CARNAVAL\",\"tipo_evento\":\"1\",\"id_color\":3,\"estatus\":\"1\",\"id_evento\":3}', '127.0.0.1', '2026-05-10 23:53:45', '1'),
(424, 31009367, 'Evento', 'evento', '4', 'CREAR', NULL, '{\"nombre_evento\":\"D\\u00cdA DE TUR\\u00c9N - NO LABORABLE SOLO N\\u00daCLEO ACADEMICO TUREN \",\"tipo_evento\":\"1\",\"id_color\":4,\"estatus\":\"1\",\"id_evento\":4}', '127.0.0.1', '2026-05-10 23:55:08', '1'),
(425, 31009367, 'Evento', 'evento', '5', 'CREAR', NULL, '{\"nombre_evento\":\"JUEVES y VIERNES SANTO\",\"tipo_evento\":\"1\",\"id_color\":5,\"estatus\":\"1\",\"id_evento\":5}', '127.0.0.1', '2026-05-10 23:59:42', '1'),
(426, 31009367, 'Evento', 'evento', '6', 'CREAR', NULL, '{\"nombre_evento\":\"DECLARACION DE LA INDEPENDENCIA\",\"tipo_evento\":\"1\",\"id_color\":6,\"estatus\":\"1\",\"id_evento\":6}', '127.0.0.1', '2026-05-11 00:02:43', '1'),
(427, 31009367, 'Evento', 'evento', '7', 'CREAR', NULL, '{\"nombre_evento\":\"D\\u00cdA DEL TRABAJADOR\",\"tipo_evento\":\"1\",\"id_color\":7,\"estatus\":\"1\",\"id_evento\":7}', '127.0.0.1', '2026-05-11 00:02:59', '1'),
(428, 31009367, 'Evento', 'evento', '8', 'CREAR', NULL, '{\"nombre_evento\":\"D\\u00cdA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN N\\u00daCLEO ACAD\\u00c9MICO TUREN\",\"tipo_evento\":\"1\",\"id_color\":8,\"estatus\":\"1\",\"id_evento\":8}', '127.0.0.1', '2026-05-11 00:03:09', '1'),
(429, 31009367, 'Evento', 'evento', '9', 'CREAR', NULL, '{\"nombre_evento\":\"D\\u00cdA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL\",\"tipo_evento\":\"1\",\"id_color\":9,\"estatus\":\"1\",\"id_evento\":9}', '127.0.0.1', '2026-05-11 00:03:18', '1'),
(430, 31009367, 'Evento', 'evento', '10', 'CREAR', NULL, '{\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"id_color\":10,\"estatus\":\"1\",\"id_evento\":10}', '127.0.0.1', '2026-05-11 00:03:27', '1'),
(431, 31009367, 'Evento', 'evento', '10', 'MOSTRAR', '{\"id_evento\":10,\"id_color\":10,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-11 00:26:35', '1'),
(432, 31009367, 'Evento', 'evento', '10', 'MOSTRAR', '{\"id_evento\":10,\"id_color\":10,\"nombre_evento\":\"D\\u00cdA DE P\\u00c1EZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL\",\"tipo_evento\":\"1\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-11 00:26:42', '1'),
(433, 31009367, 'CalendarioAcademico', 'calendario_academico', '1', 'CREAR', NULL, '{\"semana_calendario_academico\":51,\"dia_inicio_calendario_academico\":\"2026-01-31\",\"dia_fin_calendario_academico\":\"2027-01-22\",\"estatus\":\"1\",\"id_calendario_academico\":1}', '127.0.0.1', '2026-05-11 00:28:39', '1'),
(434, 31009367, 'Calendario', 'calendario', 'reporte', 'REPORTE', NULL, NULL, '127.0.0.1', '2026-05-11 00:28:44', '1'),
(435, 31009367, 'Evento', 'evento', '11', 'CREAR', NULL, '{\"nombre_evento\":\"Correcci\\u00f3n de notas\",\"tipo_evento\":\"2\",\"id_color\":11,\"estatus\":\"1\",\"id_evento\":11}', '127.0.0.1', '2026-05-11 00:37:55', '1'),
(436, 31009367, 'Evento', 'evento', '11', 'MOSTRAR', '{\"id_evento\":11,\"id_color\":11,\"nombre_evento\":\"Correcci\\u00f3n de notas\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-11 00:38:25', '1'),
(437, 31009367, 'Evento', 'evento', '11', 'MODIFICAR', '{\"id_evento\":11,\"id_color\":11,\"nombre_evento\":\"Correcci\\u00f3n de notas\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', '{\"estatus\":\"3\"}', '127.0.0.1', '2026-05-11 00:38:32', '1'),
(438, 31009367, 'Evento', 'evento', '11', 'MODIFICAR', '{\"id_evento\":11,\"id_color\":11,\"nombre_evento\":\"Correcci\\u00f3n de notas\",\"tipo_evento\":\"2\",\"estatus\":\"3\"}', '{\"estatus\":\"1\"}', '127.0.0.1', '2026-05-11 00:38:35', '1'),
(439, 31009367, 'Evento', 'evento', '11', 'MOSTRAR', '{\"id_evento\":11,\"id_color\":11,\"nombre_evento\":\"Correcci\\u00f3n de notas\",\"tipo_evento\":\"2\",\"estatus\":\"1\"}', NULL, '127.0.0.1', '2026-05-11 00:38:37', '1');

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
-- Estructura de tabla para la tabla `calendario_academico`
--

CREATE TABLE `calendario_academico` (
  `id_calendario_academico` int(11) NOT NULL,
  `semana_calendario_academico` int(11) DEFAULT NULL,
  `dia_inicio_calendario_academico` date DEFAULT NULL,
  `dia_fin_calendario_academico` date DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calendario_academico`
--

INSERT INTO `calendario_academico` (`id_calendario_academico`, `semana_calendario_academico`, `dia_inicio_calendario_academico`, `dia_fin_calendario_academico`, `estatus`) VALUES
(1, 51, '2026-01-31', '2027-01-22', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `color`
--

CREATE TABLE `color` (
  `id_color` int(11) NOT NULL,
  `nombre_color` varchar(255) DEFAULT NULL,
  `codigo_color` varchar(20) DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `color`
--

INSERT INTO `color` (`id_color`, `nombre_color`, `codigo_color`, `estatus`) VALUES
(1, 'Rojo', '#DC3545', '1'),
(2, 'Azul', '#007BFF', '1'),
(3, 'Verde', '#28A745', '1'),
(4, 'Amarillo', '#FFC107', '1'),
(5, 'Naranja', '#FD7E14', '1'),
(6, 'Morado', '#6F42C1', '1'),
(7, 'Rosa', '#E83E8C', '1'),
(8, 'Cian', '#17A2B8', '1'),
(9, 'Índigo', '#6610F2', '1'),
(10, 'Gris Oscuro', '#343A40', '1'),
(11, 'Marrón', '#795548', '1'),
(12, 'Morado', '#6F42C1', '1'),
(13, 'Rosa', '#E83E8C', '1'),
(14, 'Cian', '#17A2B8', '1'),
(15, 'Índigo', '#6610F2', '1'),
(16, 'Gris Oscuro', '#343A40', '1'),
(17, 'Marrón', '#795548', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id_contenido` int(11) NOT NULL,
  `titulo_contenido` text DEFAULT NULL,
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
  `estatus` enum('1','2','3') DEFAULT '1'
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
  `estatus` enum('1','2','3','4') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evento`
--

CREATE TABLE `detalle_evento` (
  `id_detalle_evento` int(11) NOT NULL,
  `id_evento` int(11) DEFAULT NULL,
  `id_calendario_academico` int(11) DEFAULT NULL,
  `dia_inicio_detalle_evento` date DEFAULT NULL,
  `dia_fin_detalle_evento` date DEFAULT NULL,
  `semana_detalle_evento` int(11) DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_evento`
--

INSERT INTO `detalle_evento` (`id_detalle_evento`, `id_evento`, `id_calendario_academico`, `dia_inicio_detalle_evento`, `dia_fin_detalle_evento`, `semana_detalle_evento`, `estatus`) VALUES
(1, 5, 1, '2026-02-17', '2026-02-22', NULL, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_objetivo`
--

CREATE TABLE `detalle_objetivo` (
  `id_detalle_objetivo` int(11) NOT NULL,
  `id_contenido` int(11) DEFAULT NULL,
  `id_objetivo` int(11) DEFAULT NULL,
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
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id_evento` int(11) NOT NULL,
  `id_color` int(11) DEFAULT NULL,
  `nombre_evento` varchar(100) DEFAULT NULL,
  `tipo_evento` enum('1','2','3','4') DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`id_evento`, `id_color`, `nombre_evento`, `tipo_evento`, `estatus`) VALUES
(1, 1, 'AÑO NUEVO', '1', '1'),
(2, 2, 'DÍA DE LA DEMOCRACÍA', '1', '1'),
(3, 3, 'CARNAVAL', '1', '1'),
(4, 4, 'DÍA DE TURÉN - NO LABORABLE SOLO NÚCLEO ACADEMICO TUREN ', '1', '1'),
(5, 5, 'JUEVES y VIERNES SANTO', '1', '1'),
(6, 6, 'DECLARACION DE LA INDEPENDENCIA', '1', '1'),
(7, 7, 'DÍA DEL TRABAJADOR', '1', '1'),
(8, 8, 'DÍA DE SAN ISIDRO EL LABRADOR - NO LABORABLE SOLO EN NÚCLEO ACADÉMICO TUREN', '1', '1'),
(9, 9, 'DÍA DE JACINTO LARA - NO LABORABLE SOLO EN EL CONVENIO CON LA COMUNA SOCIALISTA EL MAIZAL', '1', '1'),
(10, 10, 'DÍA DE PÁEZ - NO LABORABLE SOLO PARA LA SEDE PRINCIPAL', '1', '1'),
(11, 11, 'Corrección de notas', '2', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instrumento`
--

CREATE TABLE `instrumento` (
  `id_instrumento` int(11) NOT NULL,
  `nombre_instrumento` varchar(255) DEFAULT NULL,
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
-- Estructura de tabla para la tabla `objetivo`
--

CREATE TABLE `objetivo` (
  `id_objetivo` int(11) NOT NULL,
  `titulo_objetivo` varchar(255) DEFAULT NULL,
  `id_tema_unidad` int(11) DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `id_permiso` int(11) NOT NULL,
  `nombre_permiso` tinytext DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`id_permiso`, `nombre_permiso`, `estatus`) VALUES
(1, 'Index de Perfil', '1'),
(2, 'Index de Seleccionar Rol', '1'),
(3, 'Listar de Contenido', '1'),
(4, 'Crear de Contenido', '1'),
(5, 'Editar de Contenido', '1'),
(6, 'Ver Detalles de Contenido', '1'),
(7, 'Listar de Tema', '1'),
(8, 'Crear de Tema', '1'),
(9, 'Editar de Tema', '1'),
(10, 'Ver Detalles de Tema', '1'),
(11, 'Crear de Usuarios', '1'),
(12, 'Listar de Usuarios', '1'),
(13, 'Listar de Planificacion', '1'),
(14, 'Crear de Planificacion', '1'),
(15, 'Editar de Planificacion', '1'),
(16, 'Ver Detalles de Planificacion', '1'),
(17, 'Reporte General de Planificacion', '1'),
(18, 'Reporte Detallado de Planificacion', '1'),
(19, 'Reporte de Calendario', '1'),
(20, 'Listar de Indicador Logro', '1'),
(21, 'Crear de Indicador Logro', '1'),
(22, 'Editar de Indicador Logro', '1'),
(23, 'Ver Detalles de Indicador Logro', '1'),
(24, 'Listar de Bibliografia', '1'),
(25, 'Crear de Bibliografia', '1'),
(26, 'Editar de Bibliografia', '1'),
(27, 'Ver Detalles de Bibliografia', '1'),
(28, 'Listar de Recurso', '1'),
(29, 'Crear de Recurso', '1'),
(30, 'Editar de Recurso', '1'),
(31, 'Ver Detalles de Recurso', '1'),
(32, 'Listar de Estrategia', '1'),
(33, 'Crear de Estrategia', '1'),
(34, 'Editar de Estrategia', '1'),
(35, 'Ver Detalles de Estrategia', '1'),
(36, 'Listar de Tecnica Evaluacion', '1'),
(37, 'Crear de Tecnica Evaluacion', '1'),
(38, 'Editar de Tecnica Evaluacion', '1'),
(39, 'Ver Detalles de Tecnica Evaluacion', '1'),
(40, 'Listar de Tipo Evaluacion', '1'),
(41, 'Crear de Tipo Evaluacion', '1'),
(42, 'Editar de Tipo Evaluacion', '1'),
(43, 'Ver Detalles de Tipo Evaluacion', '1'),
(44, 'Listar de Evento', '1'),
(45, 'Crear de Evento', '1'),
(46, 'Ver Detalles de Evento', '1'),
(47, 'Listar de Calendario', '1'),
(48, 'Crear de Calendario', '1'),
(49, 'Ver Detalles de Calendario', '1'),
(50, 'Listar de Permiso', '1'),
(51, 'Editar de Permiso', '1'),
(52, 'Listar de Bitacora', '1'),
(53, 'Ver Detalles de Bitacora', '1'),
(54, 'Cambiar Estatus de Perfil', '1'),
(55, 'Cambiar Estatus de Seleccionar Rol', '1'),
(56, 'Cambiar Estatus de Contenido', '1'),
(57, 'Cambiar Estatus de Tema', '1'),
(58, 'Cambiar Estatus de Usuarios', '1'),
(59, 'Cambiar Estatus de Planificacion', '1'),
(60, 'Cambiar Estatus de Calendario', '1'),
(61, 'Cambiar Estatus de Indicador Logro', '1'),
(62, 'Cambiar Estatus de Bibliografia', '1'),
(63, 'Cambiar Estatus de Recurso', '1'),
(64, 'Cambiar Estatus de Estrategia', '1'),
(65, 'Cambiar Estatus de Tecnica Evaluacion', '1'),
(66, 'Cambiar Estatus de Tipo Evaluacion', '1'),
(67, 'Cambiar Estatus de Evento', '1'),
(68, 'Cambiar Estatus de Permiso', '1'),
(69, 'Cambiar Estatus de Bitacora', '1'),
(70, 'Editar de Evento', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planificacion`
--

CREATE TABLE `planificacion` (
  `id_planificacion` int(11) NOT NULL,
  `id_profesor_asignado` int(11) DEFAULT NULL,
  `aceptado_vocero` int(11) DEFAULT NULL,
  `aceptado_coordinador` int(11) DEFAULT NULL,
  `estatus` enum('1','2','3','4') DEFAULT '1',
  `tipo_planificacion` text DEFAULT NULL,
  `archivo_contrato` varchar(255) DEFAULT NULL,
  `notificado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL,
  `nombre_recurso` varchar(255) DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recurso`
--

INSERT INTO `recurso` (`id_recurso`, `nombre_recurso`, `estatus`) VALUES
(1, '23,', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `id_rol_permiso` int(11) NOT NULL,
  `id_permiso` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`id_rol_permiso`, `id_permiso`, `id_rol`, `estatus`) VALUES
(1, 62, 11, '1'),
(2, 25, 11, '1'),
(3, 26, 11, '1'),
(4, 24, 11, '1'),
(5, 27, 11, '1'),
(6, 69, 11, '1'),
(7, 52, 11, '1'),
(8, 53, 11, '1'),
(9, 60, 11, '1'),
(10, 48, 11, '1'),
(11, 47, 11, '1'),
(12, 19, 11, '1'),
(13, 49, 11, '1'),
(14, 56, 11, '1'),
(15, 4, 11, '1'),
(16, 5, 11, '1'),
(17, 3, 11, '1'),
(18, 6, 11, '1'),
(19, 64, 11, '1'),
(20, 33, 11, '1'),
(21, 34, 11, '1'),
(22, 32, 11, '1'),
(23, 35, 11, '1'),
(24, 67, 11, '1'),
(25, 45, 11, '1'),
(26, 44, 11, '1'),
(27, 46, 11, '1'),
(28, 61, 11, '1'),
(29, 21, 11, '1'),
(30, 22, 11, '1'),
(31, 20, 11, '1'),
(32, 23, 11, '1'),
(33, 54, 11, '1'),
(34, 1, 11, '1'),
(35, 68, 11, '1'),
(36, 51, 11, '1'),
(37, 50, 11, '1'),
(38, 18, 11, '1'),
(39, 59, 11, '1'),
(40, 14, 11, '1'),
(41, 15, 11, '1'),
(42, 13, 11, '1'),
(43, 17, 11, '1'),
(44, 16, 11, '1'),
(45, 63, 11, '1'),
(46, 29, 11, '1'),
(47, 30, 11, '1'),
(48, 28, 11, '1'),
(49, 31, 11, '1'),
(50, 55, 11, '1'),
(51, 2, 11, '1'),
(52, 65, 11, '1'),
(53, 37, 11, '1'),
(54, 38, 11, '1'),
(55, 36, 11, '1'),
(56, 39, 11, '1'),
(57, 57, 11, '1'),
(58, 8, 11, '1'),
(59, 9, 11, '1'),
(60, 7, 11, '1'),
(61, 10, 11, '1'),
(62, 66, 11, '1'),
(63, 41, 11, '1'),
(64, 42, 11, '1'),
(65, 40, 11, '1'),
(66, 43, 11, '1'),
(67, 58, 11, '1'),
(68, 11, 11, '1'),
(69, 12, 11, '1'),
(70, 70, 11, '1'),
(71, 67, 31, '1'),
(72, 45, 31, '1'),
(73, 70, 31, '1'),
(74, 44, 31, '1'),
(75, 46, 31, '1'),
(76, 69, 31, '1'),
(77, 52, 31, '1'),
(78, 53, 31, '1'),
(79, 60, 31, '1'),
(80, 48, 31, '1'),
(81, 47, 31, '1'),
(82, 19, 31, '1'),
(83, 49, 31, '1'),
(84, 68, 31, '1'),
(85, 51, 31, '1'),
(86, 50, 31, '1');

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
('KBzkD6WBuZIpfb3LR2EXJTrn9ThKrdPinGzpLmHE', 43331, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoicUNGbUdsbmdJWFduMjl1TktqZGZKWTFMN0V3b1lkMmRibUZBMUtaciI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9jYWxlbmRhcmlvL2xpc3QiO31zOjExOiJhY3RpdmVfcm9sZSI7aTozMTtzOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo0MzMzMTt9', 1778447654);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_actividad`
--

CREATE TABLE `tecnica_actividad` (
  `id_tecnica_actividad` int(11) NOT NULL,
  `nombre_tecnica_actividad` varchar(255) DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnica_actividad`
--

INSERT INTO `tecnica_actividad` (`id_tecnica_actividad`, `nombre_tecnica_actividad`, `estatus`) VALUES
(1, 'pppppppppp', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnica_evaluacion`
--

CREATE TABLE `tecnica_evaluacion` (
  `id_tecnica_evaluacion` int(11) NOT NULL,
  `nombre_tecnica_evaluacion` text DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnica_evaluacion`
--

INSERT INTO `tecnica_evaluacion` (`id_tecnica_evaluacion`, `nombre_tecnica_evaluacion`, `estatus`) VALUES
(1, 'ññññ', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema_unidad`
--

CREATE TABLE `tema_unidad` (
  `id_tema_unidad` int(11) NOT NULL,
  `id_unidad_curricular` varchar(7) DEFAULT NULL,
  `titulo_tema` text DEFAULT NULL,
  `unidad_tema` enum('1','2','3','4') DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_evaluacion`
--

CREATE TABLE `tipo_evaluacion` (
  `id_tipo_evaluacion` int(11) NOT NULL,
  `nombre_tipo_evaluacion` text DEFAULT NULL,
  `estatus` enum('1','2','3') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_evaluacion`
--

INSERT INTO `tipo_evaluacion` (`id_tipo_evaluacion`, `nombre_tipo_evaluacion`, `estatus`) VALUES
(1, 'dasdsa', '1');

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
  `estatus` enum('1','2','3','4','5') DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indices de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  ADD PRIMARY KEY (`id_calendario_academico`);

--
-- Indices de la tabla `color`
--
ALTER TABLE `color`
  ADD PRIMARY KEY (`id_color`);

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
  ADD KEY `fk_detbibliografia_bibliografia` (`id_bibliografia`),
  ADD KEY `fk_detbibliografia_unidadcorte` (`id_unidad_corte`);

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
  ADD KEY `fk_deteval_unidadcorte` (`id_unidad_corte`),
  ADD KEY `fk_deteval_instrumento` (`id_instrumento`);

--
-- Indices de la tabla `detalle_evento`
--
ALTER TABLE `detalle_evento`
  ADD PRIMARY KEY (`id_detalle_evento`),
  ADD KEY `fk_detalle_evento_evento` (`id_evento`),
  ADD KEY `fk_detalle_evento_calendario` (`id_calendario_academico`);

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
  ADD KEY `fk_evento_color` (`id_color`);

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
  MODIFY `id_bibliografia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=440;

--
-- AUTO_INCREMENT de la tabla `calendario_academico`
--
ALTER TABLE `calendario_academico`
  MODIFY `id_calendario_academico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `color`
--
ALTER TABLE `color`
  MODIFY `id_color` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
-- AUTO_INCREMENT de la tabla `detalle_evento`
--
ALTER TABLE `detalle_evento`
  MODIFY `id_detalle_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id_evento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
-- AUTO_INCREMENT de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  MODIFY `id_objetivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `planificacion`
--
ALTER TABLE `planificacion`
  MODIFY `id_planificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  MODIFY `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `tecnica_actividad`
--
ALTER TABLE `tecnica_actividad`
  MODIFY `id_tecnica_actividad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tecnica_evaluacion`
--
ALTER TABLE `tecnica_evaluacion`
  MODIFY `id_tecnica_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tema_unidad`
--
ALTER TABLE `tema_unidad`
  MODIFY `id_tema_unidad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_evaluacion`
--
ALTER TABLE `tipo_evaluacion`
  MODIFY `id_tipo_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `unidad_corte`
--
ALTER TABLE `unidad_corte`
  MODIFY `id_unidad_corte` int(11) NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `detalle_evento`
--
ALTER TABLE `detalle_evento`
  ADD CONSTRAINT `fk_detalle_evento_calendario` FOREIGN KEY (`id_calendario_academico`) REFERENCES `calendario_academico` (`id_calendario_academico`),
  ADD CONSTRAINT `fk_detalle_evento_evento` FOREIGN KEY (`id_evento`) REFERENCES `evento` (`id_evento`);

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
  ADD CONSTRAINT `fk_evento_color` FOREIGN KEY (`id_color`) REFERENCES `color` (`id_color`);

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
