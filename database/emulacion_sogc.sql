-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-02-2026 a las 16:44:20
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
-- Base de datos: `emulacion_sogc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `est_codigo` varchar(10) NOT NULL,
  `est_nombre` varchar(100) DEFAULT NULL,
  `est_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`est_codigo`, `est_nombre`, `est_estatus`) VALUES
('00', 'NINGUNO (Faltante)', 'A'),
('01', 'DISTRITO CAPI', 'A'),
('02', 'AMAZONAS', 'A'),
('03', 'ANZOÁTEGUI', 'A'),
('04', 'APURE', 'A'),
('05', 'ARAGUA', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `est_cedula` varchar(20) NOT NULL,
  `est_fecha_ingreso` date DEFAULT NULL,
  `est_cod_programa` int(11) DEFAULT NULL,
  `est_ira` decimal(5,2) DEFAULT NULL,
  `est_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`est_cedula`, `est_fecha_ingreso`, `est_cod_programa`, `est_ira`, `est_estatus`) VALUES
('11075583', '2015-01-13', 7, 16.62, 'A'),
('18871515', '2005-07-22', 1, 14.21, 'A'),
('21728119', '2016-09-26', 1, 12.98, 'A'),
('23489738', '2019-05-14', 1, 16.44, 'A'),
('24587378', '2020-01-01', 1, 0.00, 'A'),
('24814620', '2020-01-01', 1, 0.00, 'A'),
('27350241', '2020-01-01', 1, 0.00, 'A'),
('27576913', '2020-01-01', 1, 0.00, 'A'),
('27636134', '2019-09-24', 7, 16.89, 'A'),
('28061545', '2020-01-01', 1, 0.00, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE `inscripcion` (
  `ins_codigo` int(11) NOT NULL,
  `ins_cedula` varchar(20) DEFAULT NULL,
  `ins_cod_seccion_unidad_doc` int(11) DEFAULT NULL,
  `ins_nota_final_100` decimal(5,2) DEFAULT NULL,
  `ins_nota_final_20` int(11) DEFAULT NULL,
  `ins_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripcion`
--

INSERT INTO `inscripcion` (`ins_codigo`, `ins_cedula`, `ins_cod_seccion_unidad_doc`, `ins_nota_final_100`, `ins_nota_final_20`, `ins_estatus`) VALUES
(104426, '28061545', 2881, 90.00, 18, 'A'),
(105981, '24814620', 3769, 75.00, 15, 'A'),
(105997, '24587378', 3582, 87.00, 18, 'A'),
(106019, '27350241', 4187, 82.00, 17, 'A'),
(106132, '27576913', 2914, 57.00, 12, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lapso_academico`
--

CREATE TABLE `lapso_academico` (
  `lap_codigo` int(11) NOT NULL,
  `lap_nombre` varchar(50) DEFAULT NULL,
  `lap_fecha_inicio` date DEFAULT NULL,
  `lap_fecha_fin` date DEFAULT NULL,
  `lap_estatus` char(1) DEFAULT 'A',
  `lap_cerrado` char(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `lapso_academico`
--

INSERT INTO `lapso_academico` (`lap_codigo`, `lap_nombre`, `lap_fecha_inicio`, `lap_fecha_fin`, `lap_estatus`, `lap_cerrado`) VALUES
(0, 'No Regist.', '2014-01-01', '2014-01-01', 'A', 'S'),
(22, '2010-III', '2010-11-01', '2011-02-13', 'A', 'S'),
(23, '2011-1', '2011-02-14', '2011-05-29', 'A', 'S'),
(24, '2011-III', '2011-11-28', '2012-03-25', 'A', 'S'),
(25, '2012-11', '2012-10-22', '2013-03-10', 'A', 'S'),
(31, 'Lapso 31 (Faltante)', '2020-01-01', '2020-06-01', 'A', 'S');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `malla`
--

CREATE TABLE `malla` (
  `mal_codigo` int(11) NOT NULL,
  `mal_nombre` varchar(100) DEFAULT NULL,
  `mal_cod_programa` int(11) DEFAULT NULL,
  `mal_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `malla`
--

INSERT INTO `malla` (`mal_codigo`, `mal_nombre`, `mal_cod_programa`, `mal_estatus`) VALUES
(0, 'Sin malla', 1, 'A'),
(1, 'AGR-2012', 2, 'A'),
(2, 'MALLA 2 (Faltante)', 1, 'A'),
(3, 'AGR-2008', 2, 'A'),
(5, 'ADM-2010', 1, 'A'),
(6, 'MALLA 6 (Faltante)', 1, 'A'),
(8, 'MALLA 8 (Faltante)', 1, 'A'),
(9, 'MALLA 9 (Faltante)', 1, 'A'),
(10, 'ADM-2008', 1, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipio`
--

CREATE TABLE `municipio` (
  `mun_codigo` varchar(10) NOT NULL,
  `mun_nombre` varchar(100) DEFAULT NULL,
  `mun_cod_estado` varchar(10) DEFAULT NULL,
  `mun_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `municipio`
--

INSERT INTO `municipio` (`mun_codigo`, `mun_nombre`, `mun_cod_estado`, `mun_estatus`) VALUES
('0000', 'NINGUNO', '00', 'A'),
('0101', 'LIBERTADOR', '01', 'A'),
('0201', 'AUTÓNOMO AL', '02', 'A'),
('0202', 'AUTÓNOMO AT', '02', 'A'),
('0203', 'AUTÓNOMO ATU', '02', 'A'),
('1102', 'MUNICIPIO 1102 (Faltante)', '01', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `pai_codigo` varchar(10) NOT NULL,
  `pai_nombre` varchar(100) DEFAULT NULL,
  `pai_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`pai_codigo`, `pai_nombre`, `pai_estatus`) VALUES
('100', 'Afganistán', 'A'),
('101', 'Albania', 'A'),
('102', 'Alemania', 'A'),
('103', 'Andorra', 'A'),
('104', 'Angola', 'A'),
('296', 'Venezuela (Faltante)', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parroquia`
--

CREATE TABLE `parroquia` (
  `par_codigo` varchar(10) NOT NULL,
  `par_nombre` varchar(100) DEFAULT NULL,
  `par_cod_municipio` varchar(10) DEFAULT NULL,
  `par_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `parroquia`
--

INSERT INTO `parroquia` (`par_codigo`, `par_nombre`, `par_cod_municipio`, `par_estatus`) VALUES
('000000', 'NINGUNO', '0000', 'A'),
('010101', 'ALTAGRACIA', '0101', 'A'),
('010102', 'ANTÍMANO', '0101', 'A'),
('010103', 'CANDELARIA', '0101', 'A'),
('110201', 'SAN LUIS', '1102', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `per_cedula` varchar(20) NOT NULL,
  `per_nombres` varchar(100) DEFAULT NULL,
  `per_apellidos` varchar(100) DEFAULT NULL,
  `per_genero` char(1) DEFAULT NULL,
  `per_fecha_nacimiento` date DEFAULT NULL,
  `per_cod_pais` varchar(10) DEFAULT NULL,
  `per_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`per_cedula`, `per_nombres`, `per_apellidos`, `per_genero`, `per_fecha_nacimiento`, `per_cod_pais`, `per_estatus`) VALUES
('11075583', 'Estudiante', 'Faltante', '1', '2000-01-01', '296', 'A'),
('12090416', 'Usuario', 'Faltante', '1', '2000-01-01', '296', 'A'),
('12497958', 'YULIMAR DEL', 'RODRIGUEZ A', '1', '1976-09-21', '296', 'A'),
('15308565', 'Usuario', 'Faltante', '1', '2000-01-01', '296', 'A'),
('16752793', 'Docente', 'Faltante', '1', '2000-01-01', '296', 'A'),
('17944637', 'Usuario', 'Faltante', '1', '2000-01-01', '296', 'A'),
('18871515', 'Estudiante', 'Faltante', '1', '2000-01-01', '296', 'A'),
('21159040', 'Usuario', 'Faltante', '1', '2000-01-01', '296', 'A'),
('21728119', 'Estudiante', 'Faltante', '1', '2000-01-01', '296', 'A'),
('23489738', 'Estudiante', 'Faltante', '1', '2000-01-01', '296', 'A'),
('24587378', 'Inscrito', 'Faltante', '1', '2000-01-01', '296', 'A'),
('24814620', 'Inscrito', 'Faltante', '1', '2000-01-01', '296', 'A'),
('25163193', 'JHONATHAN ALE', 'PIÑERO MOLINA', '0', '1995-09-01', '296', 'A'),
('25791108', 'MARIA JOSE', 'MAMBEL LOPE', '1', '1997-05-06', '296', 'A'),
('26167944', 'NAZARET JOSE', 'GOITIA HERMA', '1', '1995-04-30', '296', 'A'),
('27350241', 'Inscrito', 'Faltante', '1', '2000-01-01', '296', 'A'),
('27576913', 'Inscrito', 'Faltante', '1', '2000-01-01', '296', 'A'),
('27636134', 'Estudiante', 'Faltante', '1', '2000-01-01', '296', 'A'),
('27898382', 'ERIXSON JOSE', 'CHIRINOS HER', '0', '1999-01-16', '296', 'A'),
('28061545', 'Inscrito', 'Faltante', '1', '2000-01-01', '296', 'A'),
('7447108', 'Docente', 'Faltante', '1', '2000-01-01', '296', 'A'),
('9837299', 'Usuario', 'Faltante', '1', '2000-01-01', '296', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programa`
--

CREATE TABLE `programa` (
  `pro_codigo` int(11) NOT NULL,
  `pro_nombre` varchar(150) DEFAULT NULL,
  `pro_siglas` varchar(20) DEFAULT NULL,
  `pro_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `programa`
--

INSERT INTO `programa` (`pro_codigo`, `pro_nombre`, `pro_siglas`, `pro_estatus`) VALUES
(1, 'PROGRAMA 1 (Faltante)', 'PNF_1', 'A'),
(2, 'PROGRAMA NA', 'PNFAGR', 'A'),
(3, 'PROGRAMA NA', 'PNFELE', 'A'),
(4, 'PROGRAMA NA', 'PNFINF', 'A'),
(6, 'PROGRAMA NA', 'PNFMEC', 'A'),
(7, 'PROGRAMA 7 (Faltante)', 'PNF_7', 'A'),
(8, 'PROGRAMA NANG', 'PNFDYL', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_codigo` int(11) NOT NULL,
  `rol_nombre` varchar(50) DEFAULT NULL,
  `rol_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_codigo`, `rol_nombre`, `rol_estatus`) VALUES
(4, 'ROL 4 (Faltante)', 'A'),
(7, 'BIENESTAR', 'A'),
(18, 'SECRETARIA G', 'A'),
(19, 'SECRETARIAT', 'A'),
(20, 'BIBLIOTECA', 'A'),
(27, 'CARNETIZACIÓ', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE `seccion` (
  `sec_codigo` int(11) NOT NULL,
  `sec_nombre` varchar(20) DEFAULT NULL,
  `sec_cod_lapso_academico` int(11) DEFAULT NULL,
  `sec_cod_malla` int(11) DEFAULT NULL,
  `sec_capacidad` int(11) DEFAULT NULL,
  `sec_inscritos` int(11) DEFAULT 0,
  `sec_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`sec_codigo`, `sec_nombre`, `sec_cod_lapso_academico`, `sec_cod_malla`, `sec_capacidad`, `sec_inscritos`, `sec_estatus`) VALUES
(453, '336', 31, 2, 35, 0, 'A'),
(468, '036', 31, 2, 35, 12, 'A'),
(481, '616', 31, 1, 35, 0, 'A'),
(488, '701P', 31, 1, 35, 0, 'A'),
(489, '702P', 31, 1, 35, 0, 'A'),
(1180, 'FALT', 31, 0, 35, 0, 'A'),
(1183, 'FALT', 31, 0, 35, 0, 'A'),
(1184, 'FALT', 31, 0, 35, 0, 'A'),
(1208, 'FALT', 31, 0, 35, 0, 'A'),
(1360, 'FALT', 31, 0, 35, 0, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion_unidad_docente`
--

CREATE TABLE `seccion_unidad_docente` (
  `sud_codigo` int(11) NOT NULL,
  `sud_cod_seccion` int(11) DEFAULT NULL,
  `sud_cod_unidad` int(11) DEFAULT NULL,
  `sud_ced_docente` varchar(20) DEFAULT NULL,
  `sud_capacidad` int(11) DEFAULT NULL,
  `sud_nro_inscritos` int(11) DEFAULT 0,
  `sud_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seccion_unidad_docente`
--

INSERT INTO `seccion_unidad_docente` (`sud_codigo`, `sud_cod_seccion`, `sud_cod_unidad`, `sud_ced_docente`, `sud_capacidad`, `sud_nro_inscritos`, `sud_estatus`) VALUES
(2881, 1180, 1, NULL, 0, 0, 'A'),
(2914, 1180, 1, NULL, 0, 0, 'A'),
(3582, 1180, 1, NULL, 0, 0, 'A'),
(3769, 1180, 1, NULL, 0, 0, 'A'),
(4187, 1180, 1, NULL, 0, 0, 'A'),
(5924, 1180, 87, '7447108', 35, 49, 'A'),
(5931, 1183, 87, NULL, 0, 0, '1'),
(5933, 1184, 1, '16752793', 45, 19, 'A'),
(6008, 1208, 543, NULL, 0, 0, 'A'),
(6556, 1360, 607, NULL, 45, 0, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_curricular`
--

CREATE TABLE `unidad_curricular` (
  `ucu_codigo` int(11) NOT NULL,
  `ucu_siglas` varchar(20) DEFAULT NULL,
  `ucu_nombre` varchar(150) DEFAULT NULL,
  `ucu_unidad_credito` int(11) DEFAULT NULL,
  `ucu_cod_malla` int(11) DEFAULT NULL,
  `ucu_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidad_curricular`
--

INSERT INTO `unidad_curricular` (`ucu_codigo`, `ucu_siglas`, `ucu_nombre`, `ucu_unidad_credito`, `ucu_cod_malla`, `ucu_estatus`) VALUES
(1, 'FALT', 'UC 1 (Faltante)', 0, 0, 'A'),
(87, 'FALT', 'UC 87 (Faltante)', 0, 0, 'A'),
(241, 'SAUFE10209', 'FUNDAMENTO', 2, 6, 'A'),
(309, 'PSI106', 'PROYECTO SO', 6, 8, 'A'),
(543, 'FALT', 'UC 543 (Faltante)', 0, 0, 'A'),
(607, 'FALT', 'UC 607 (Faltante)', 0, 0, 'A'),
(789, 'PNN003', 'PROYECTO NA', 2, 5, 'A'),
(807, 'MAT005', 'MATEMÁTICA YO', 5, 6, 'A'),
(939, 'CIA215', 'CALIDAD E ING', 5, 9, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_codigo` int(11) NOT NULL,
  `usu_cedula` varchar(20) DEFAULT NULL,
  `usu_nombre` varchar(50) DEFAULT NULL,
  `usu_clave` varchar(255) DEFAULT NULL,
  `usu_cod_rol` int(11) DEFAULT NULL,
  `usu_estatus` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_codigo`, `usu_cedula`, `usu_nombre`, `usu_clave`, `usu_cod_rol`, `usu_estatus`) VALUES
(20616, '12090416', '12090416', '00bb62387753', 4, 'A'),
(20617, '21159040', '21159040', 'b1c2d098dfa3', 4, 'A'),
(20618, '17944637', '17944637', 'feb29f8076434', 4, 'A'),
(20619, '15308565', '15308565', '8493d79898b', 4, 'A'),
(20620, '9837299', '9837299', '975c1017a946', 4, 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`est_codigo`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`est_cedula`),
  ADD KEY `fk_est_programa` (`est_cod_programa`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD PRIMARY KEY (`ins_codigo`),
  ADD KEY `fk_ins_estudiante` (`ins_cedula`),
  ADD KEY `fk_ins_sud` (`ins_cod_seccion_unidad_doc`);

--
-- Indices de la tabla `lapso_academico`
--
ALTER TABLE `lapso_academico`
  ADD PRIMARY KEY (`lap_codigo`);

--
-- Indices de la tabla `malla`
--
ALTER TABLE `malla`
  ADD PRIMARY KEY (`mal_codigo`),
  ADD KEY `fk_malla_programa` (`mal_cod_programa`);

--
-- Indices de la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD PRIMARY KEY (`mun_codigo`),
  ADD KEY `fk_mun_estado` (`mun_cod_estado`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`pai_codigo`);

--
-- Indices de la tabla `parroquia`
--
ALTER TABLE `parroquia`
  ADD PRIMARY KEY (`par_codigo`),
  ADD KEY `fk_par_municipio` (`par_cod_municipio`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`per_cedula`),
  ADD KEY `fk_per_pais` (`per_cod_pais`);

--
-- Indices de la tabla `programa`
--
ALTER TABLE `programa`
  ADD PRIMARY KEY (`pro_codigo`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_codigo`);

--
-- Indices de la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD PRIMARY KEY (`sec_codigo`),
  ADD KEY `fk_sec_lapso` (`sec_cod_lapso_academico`),
  ADD KEY `fk_sec_malla` (`sec_cod_malla`);

--
-- Indices de la tabla `seccion_unidad_docente`
--
ALTER TABLE `seccion_unidad_docente`
  ADD PRIMARY KEY (`sud_codigo`),
  ADD KEY `fk_sud_seccion` (`sud_cod_seccion`),
  ADD KEY `fk_sud_unidad` (`sud_cod_unidad`),
  ADD KEY `fk_sud_docente` (`sud_ced_docente`);

--
-- Indices de la tabla `unidad_curricular`
--
ALTER TABLE `unidad_curricular`
  ADD PRIMARY KEY (`ucu_codigo`),
  ADD KEY `fk_ucu_malla` (`ucu_cod_malla`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_codigo`),
  ADD KEY `fk_usu_persona` (`usu_cedula`),
  ADD KEY `fk_usu_rol` (`usu_cod_rol`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `fk_est_persona` FOREIGN KEY (`est_cedula`) REFERENCES `persona` (`per_cedula`),
  ADD CONSTRAINT `fk_est_programa` FOREIGN KEY (`est_cod_programa`) REFERENCES `programa` (`pro_codigo`);

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `fk_ins_estudiante` FOREIGN KEY (`ins_cedula`) REFERENCES `estudiante` (`est_cedula`),
  ADD CONSTRAINT `fk_ins_sud` FOREIGN KEY (`ins_cod_seccion_unidad_doc`) REFERENCES `seccion_unidad_docente` (`sud_codigo`);

--
-- Filtros para la tabla `malla`
--
ALTER TABLE `malla`
  ADD CONSTRAINT `fk_malla_programa` FOREIGN KEY (`mal_cod_programa`) REFERENCES `programa` (`pro_codigo`);

--
-- Filtros para la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD CONSTRAINT `fk_mun_estado` FOREIGN KEY (`mun_cod_estado`) REFERENCES `estado` (`est_codigo`);

--
-- Filtros para la tabla `parroquia`
--
ALTER TABLE `parroquia`
  ADD CONSTRAINT `fk_par_municipio` FOREIGN KEY (`par_cod_municipio`) REFERENCES `municipio` (`mun_codigo`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `fk_per_pais` FOREIGN KEY (`per_cod_pais`) REFERENCES `pais` (`pai_codigo`);

--
-- Filtros para la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD CONSTRAINT `fk_sec_lapso` FOREIGN KEY (`sec_cod_lapso_academico`) REFERENCES `lapso_academico` (`lap_codigo`),
  ADD CONSTRAINT `fk_sec_malla` FOREIGN KEY (`sec_cod_malla`) REFERENCES `malla` (`mal_codigo`);

--
-- Filtros para la tabla `seccion_unidad_docente`
--
ALTER TABLE `seccion_unidad_docente`
  ADD CONSTRAINT `fk_sud_docente` FOREIGN KEY (`sud_ced_docente`) REFERENCES `persona` (`per_cedula`),
  ADD CONSTRAINT `fk_sud_seccion` FOREIGN KEY (`sud_cod_seccion`) REFERENCES `seccion` (`sec_codigo`),
  ADD CONSTRAINT `fk_sud_unidad` FOREIGN KEY (`sud_cod_unidad`) REFERENCES `unidad_curricular` (`ucu_codigo`);

--
-- Filtros para la tabla `unidad_curricular`
--
ALTER TABLE `unidad_curricular`
  ADD CONSTRAINT `fk_ucu_malla` FOREIGN KEY (`ucu_cod_malla`) REFERENCES `malla` (`mal_codigo`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usu_persona` FOREIGN KEY (`usu_cedula`) REFERENCES `persona` (`per_cedula`),
  ADD CONSTRAINT `fk_usu_rol` FOREIGN KEY (`usu_cod_rol`) REFERENCES `rol` (`rol_codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
