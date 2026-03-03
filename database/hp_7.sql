-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-03-2026 a las 21:54:40
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
(1, 'Todos', '2026-03-02 20:54:33', NULL, '1');

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
-- Indices de la tabla `instrumento`
--
ALTER TABLE `instrumento`
  ADD PRIMARY KEY (`id_instrumento`);

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
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT de la tabla `instrumento`
--
ALTER TABLE `instrumento`
  MODIFY `id_instrumento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `objetivo`
--
ALTER TABLE `objetivo`
  MODIFY `id_objetivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id_rol_permiso` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_usuario_rol` int(11) NOT NULL AUTO_INCREMENT;

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
