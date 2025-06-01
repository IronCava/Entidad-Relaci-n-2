-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 01-06-2025 a las 20:00:58
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
-- Base de datos: `sistema_hospital`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `num_paciente` int(11) DEFAULT NULL,
  `num_medico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id`, `fecha`, `hora`, `num_paciente`, `num_medico`) VALUES
(1, '2025-06-03', '10:30:00', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `ncolegiado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `turno` enum('mañana','tarde') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`ncolegiado`, `nombre`, `especialidad`, `turno`) VALUES
(1, 'Dr. Javier Gómez', 'Traumatología', 'mañana');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `numerohc` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_nac` date NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tlf` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`numerohc`, `nombre`, `fecha_nac`, `direccion`, `tlf`) VALUES
(1, 'Ana Morales', '1985-04-10', 'Calle Mayor 12', '654321987');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE `tratamiento` (
  `id` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `medicamentos` text DEFAULT NULL,
  `duracion` varchar(50) DEFAULT NULL,
  `id_cita` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tratamiento`
--

INSERT INTO `tratamiento` (`id`, `descripcion`, `medicamentos`, `duracion`, `id_cita`) VALUES
(1, 'Rehabilitación tras esguince', 'Ibuprofeno, Reposo', '7 días', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_citas_completas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_citas_completas` (
`id_cita` int(11)
,`fecha` date
,`hora` time
,`paciente` varchar(100)
,`medico` varchar(100)
,`especialidad` varchar(100)
,`turno` enum('mañana','tarde')
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_citas_tratamientos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_citas_tratamientos` (
`id_cita` int(11)
,`paciente` varchar(100)
,`medico` varchar(100)
,`fecha` date
,`hora` time
,`descripcion` text
,`medicamentos` text
,`duracion` varchar(50)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_tratamientos_con_paciente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_tratamientos_con_paciente` (
`id_tratamiento` int(11)
,`descripcion` text
,`medicamentos` text
,`duracion` varchar(50)
,`paciente` varchar(100)
,`fecha_cita` date
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_citas_completas`
--
DROP TABLE IF EXISTS `vista_citas_completas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_citas_completas`  AS SELECT `c`.`id` AS `id_cita`, `c`.`fecha` AS `fecha`, `c`.`hora` AS `hora`, `p`.`nombre` AS `paciente`, `m`.`nombre` AS `medico`, `m`.`especialidad` AS `especialidad`, `m`.`turno` AS `turno` FROM ((`cita` `c` join `paciente` `p` on(`c`.`num_paciente` = `p`.`numerohc`)) join `medico` `m` on(`c`.`num_medico` = `m`.`ncolegiado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_citas_tratamientos`
--
DROP TABLE IF EXISTS `vista_citas_tratamientos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_citas_tratamientos`  AS SELECT `c`.`id` AS `id_cita`, `p`.`nombre` AS `paciente`, `m`.`nombre` AS `medico`, `c`.`fecha` AS `fecha`, `c`.`hora` AS `hora`, `t`.`descripcion` AS `descripcion`, `t`.`medicamentos` AS `medicamentos`, `t`.`duracion` AS `duracion` FROM (((`cita` `c` join `paciente` `p` on(`c`.`num_paciente` = `p`.`numerohc`)) join `medico` `m` on(`c`.`num_medico` = `m`.`ncolegiado`)) left join `tratamiento` `t` on(`t`.`id_cita` = `c`.`id`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_tratamientos_con_paciente`
--
DROP TABLE IF EXISTS `vista_tratamientos_con_paciente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_tratamientos_con_paciente`  AS SELECT `t`.`id` AS `id_tratamiento`, `t`.`descripcion` AS `descripcion`, `t`.`medicamentos` AS `medicamentos`, `t`.`duracion` AS `duracion`, `p`.`nombre` AS `paciente`, `c`.`fecha` AS `fecha_cita` FROM ((`tratamiento` `t` join `cita` `c` on(`t`.`id_cita` = `c`.`id`)) join `paciente` `p` on(`c`.`num_paciente` = `p`.`numerohc`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id`),
  ADD KEY `num_paciente` (`num_paciente`),
  ADD KEY `num_medico` (`num_medico`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`ncolegiado`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`numerohc`);

--
-- Indices de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_cita` (`id_cita`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `medico`
--
ALTER TABLE `medico`
  MODIFY `ncolegiado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `numerohc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`num_paciente`) REFERENCES `paciente` (`numerohc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`num_medico`) REFERENCES `medico` (`ncolegiado`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD CONSTRAINT `tratamiento_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
