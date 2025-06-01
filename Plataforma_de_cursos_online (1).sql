-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 01-06-2025 a las 19:04:56
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Plataforma de cursos online`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `codigo` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `id_profesor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`codigo`, `titulo`, `descripcion`, `categoria`, `id_profesor`) VALUES
(1, 'JavaScript Básico', 'Curso introductorio a JS', 'Desarrollo Web', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrega`
--

CREATE TABLE `entrega` (
  `id_entrega` int(11) NOT NULL,
  `fecha_envio` date NOT NULL,
  `archivo_entregado` varchar(255) NOT NULL,
  `nota` decimal(10,0) NOT NULL,
  `id_estudiante` int(11) NOT NULL,
  `id_tarea` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entrega`
--

INSERT INTO `entrega` (`id_entrega`, `fecha_envio`, `archivo_entregado`, `nota`, `id_estudiante`, `id_tarea`) VALUES
(1, '2025-06-10', 'proyecto_final.pdf', 95, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `id_estudiante` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `fecha_registro` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `correo`, `fecha_registro`) VALUES
(1, 'Carlos', 'Pérez', 'carlos@correo.com', '2025-06-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE `inscripcion` (
  `id_estudiante` int(11) NOT NULL,
  `codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inscripcion`
--

INSERT INTO `inscripcion` (`id_estudiante`, `codigo`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Profesor`
--

CREATE TABLE `Profesor` (
  `id_profesor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `especialidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `Profesor`
--

INSERT INTO `Profesor` (`id_profesor`, `nombre`, `correo`, `especialidad`) VALUES
(1, 'Laura González', 'laura@ejemplo.com', 'Programación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea`
--

CREATE TABLE `tarea` (
  `id_tarea` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `puntaje_maximo` int(11) NOT NULL,
  `codigo_curso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarea`
--

INSERT INTO `tarea` (`id_tarea`, `titulo`, `fecha_entrega`, `puntaje_maximo`, `codigo_curso`) VALUES
(1, 'Proyecto final', '2025-06-15', 100, 1),
(2, 'Proyecto final', '2025-06-15', 100, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_entregas_completas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_entregas_completas` (
`nombre_estudiante` varchar(100)
,`apellido` varchar(100)
,`curso` varchar(100)
,`tarea` varchar(100)
,`profesor` varchar(100)
,`nota` decimal(10,0)
,`archivo_entregado` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_promedios_estudiantes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_promedios_estudiantes` (
`id_estudiante` int(11)
,`nombre` varchar(100)
,`apellido` varchar(100)
,`promedio_nota` decimal(13,2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_entregas_completas`
--
DROP TABLE IF EXISTS `vista_entregas_completas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plataforma de cursos online`.`vista_entregas_completas`  AS SELECT `e`.`nombre` AS `nombre_estudiante`, `e`.`apellido` AS `apellido`, `c`.`titulo` AS `curso`, `t`.`titulo` AS `tarea`, `p`.`nombre` AS `profesor`, `en`.`nota` AS `nota`, `en`.`archivo_entregado` AS `archivo_entregado` FROM ((((`plataforma de cursos online`.`entrega` `en` join `plataforma de cursos online`.`estudiante` `e` on(`en`.`id_estudiante` = `e`.`id_estudiante`)) join `plataforma de cursos online`.`tarea` `t` on(`en`.`id_tarea` = `t`.`id_tarea`)) join `plataforma de cursos online`.`curso` `c` on(`t`.`codigo_curso` = `c`.`codigo`)) join `plataforma de cursos online`.`profesor` `p` on(`c`.`id_profesor` = `p`.`id_profesor`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_promedios_estudiantes`
--
DROP TABLE IF EXISTS `vista_promedios_estudiantes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `plataforma de cursos online`.`vista_promedios_estudiantes`  AS SELECT `e`.`id_estudiante` AS `id_estudiante`, `e`.`nombre` AS `nombre`, `e`.`apellido` AS `apellido`, round(avg(`en`.`nota`),2) AS `promedio_nota` FROM (`plataforma de cursos online`.`entrega` `en` join `plataforma de cursos online`.`estudiante` `e` on(`en`.`id_estudiante` = `e`.`id_estudiante`)) GROUP BY `e`.`id_estudiante`, `e`.`nombre`, `e`.`apellido` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `id_profesor` (`id_profesor`);

--
-- Indices de la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD PRIMARY KEY (`id_entrega`),
  ADD KEY `fk_entrega_tarea` (`id_tarea`),
  ADD KEY `fk_entrega_estudiante` (`id_estudiante`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD KEY `id_estudiante` (`id_estudiante`),
  ADD KEY `codigo` (`codigo`);

--
-- Indices de la tabla `Profesor`
--
ALTER TABLE `Profesor`
  ADD PRIMARY KEY (`id_profesor`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `tarea`
--
ALTER TABLE `tarea`
  ADD PRIMARY KEY (`id_tarea`),
  ADD KEY `codigo_curso` (`codigo_curso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `entrega`
--
ALTER TABLE `entrega`
  MODIFY `id_entrega` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `id_estudiante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Profesor`
--
ALTER TABLE `Profesor`
  MODIFY `id_profesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tarea`
--
ALTER TABLE `tarea`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `Profesor` (`id_profesor`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD CONSTRAINT `fk_entrega_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_entrega_tarea` FOREIGN KEY (`id_tarea`) REFERENCES `tarea` (`id_tarea`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`codigo`) REFERENCES `curso` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tarea`
--
ALTER TABLE `tarea`
  ADD CONSTRAINT `tarea_ibfk_1` FOREIGN KEY (`codigo_curso`) REFERENCES `curso` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
