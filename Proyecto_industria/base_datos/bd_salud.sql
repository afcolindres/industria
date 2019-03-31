-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-03-2019 a las 02:59:54
-- Versión del servidor: 5.7.14
-- Versión de PHP: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_salud`
--
CREATE DATABASE IF NOT EXISTS `bd_salud` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bd_salud`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_buses`
--

DROP TABLE IF EXISTS `tbl_buses`;
CREATE TABLE `tbl_buses` (
  `cod_bus` int(11) NOT NULL,
  `placa` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `hospital_asignado` varchar(45) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_centro_medico`
--

DROP TABLE IF EXISTS `tbl_centro_medico`;
CREATE TABLE `tbl_centro_medico` (
  `cod_centro` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `cantidad_empledos` varchar(45) DEFAULT NULL,
  `descripcion` varchar(2500) DEFAULT NULL,
  `direccion` varchar(1000) NOT NULL,
  `telefono` varchar(25) NOT NULL,
  `pagina_web` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_centro_medico`
--

INSERT INTO `tbl_centro_medico` (`cod_centro`, `nombre`, `cantidad_empledos`, `descripcion`, `direccion`, `telefono`, `pagina_web`) VALUES
(1, 'Hospital escuela', NULL, 'Contamos con personal especializado y entrenado para identificar la problemática de salud dando respuestas técnicas y científicas de acuerdo a nuestras posibilidades procurando con ello mejorar el estado de salud de la población a la que servimos.', 'Tegucigalpa, boulevard Suyapa, avenida 1ro de enero', '2232-2322', 'www.hospitalescuela.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_centro_medico_has_tbl_rutas`
--

DROP TABLE IF EXISTS `tbl_centro_medico_has_tbl_rutas`;
CREATE TABLE `tbl_centro_medico_has_tbl_rutas` (
  `cod_Centro_ruta` int(11) NOT NULL,
  `tbl_centro_medico_cod_centro` int(11) NOT NULL,
  `tbl_rutas_cod_ruta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_colaborador`
--

DROP TABLE IF EXISTS `tbl_colaborador`;
CREATE TABLE `tbl_colaborador` (
  `cod_colaborador` int(11) NOT NULL,
  `tipo_colaborador` int(11) NOT NULL,
  `cod_centro_medico` int(11) NOT NULL,
  `numero_colaborador` varchar(45) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `correo` varchar(50) NOT NULL,
  `contrasena` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_genero`
--

DROP TABLE IF EXISTS `tbl_genero`;
CREATE TABLE `tbl_genero` (
  `cod_genero` int(11) NOT NULL,
  `genero` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_horarios`
--

DROP TABLE IF EXISTS `tbl_horarios`;
CREATE TABLE `tbl_horarios` (
  `cod_hora` int(11) NOT NULL,
  `horario` datetime NOT NULL,
  `nombre_turno` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_lugar`
--

DROP TABLE IF EXISTS `tbl_lugar`;
CREATE TABLE `tbl_lugar` (
  `cod_lugar` int(11) NOT NULL,
  `lugar_hijo` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_persona`
--

DROP TABLE IF EXISTS `tbl_persona`;
CREATE TABLE `tbl_persona` (
  `ID_persona` int(11) NOT NULL,
  `cod_lugar` int(11) DEFAULT NULL,
  `cod_genero` int(11) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `edad` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `correo` varchar(400) NOT NULL,
  `contrasenia` varchar(4000) NOT NULL,
  `direccion` varchar(1000) NOT NULL,
  `tipo_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_persona`
--

INSERT INTO `tbl_persona` (`ID_persona`, `cod_lugar`, `cod_genero`, `nombre`, `apellido`, `edad`, `telefono`, `correo`, `contrasenia`, `direccion`, `tipo_usuario`) VALUES
(2, NULL, NULL, 'Fran', 'Mayen', NULL, '65789086', 'arnold_fcolindres@yahoo.com', '056eafe7cf52220de2df36845b8ed170c67e23e3', 'el hato', 1),
(3, NULL, NULL, 'Juan Alberto', 'Rosales', NULL, '95645356', 'juanro', '1161e6ffd3637b302a5cd74076283a7bd1fc20d3', 'colonia miraflores', 2),
(4, NULL, NULL, 'Ana', 'Padilla', NULL, '98566463', 'ana@padilla.com', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'colonia miraflores', 1),
(5, NULL, NULL, 'Juan', 'Moreno', NULL, '1234', 'moreno@yahoo.com', '1161e6ffd3637b302a5cd74076283a7bd1fc20d3', 'colonia san miguel', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_reserva`
--

DROP TABLE IF EXISTS `tbl_reserva`;
CREATE TABLE `tbl_reserva` (
  `cod_reserva` int(11) NOT NULL,
  `cod_usuario` int(11) NOT NULL,
  `cod_ruta` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_reserva`
--

INSERT INTO `tbl_reserva` (`cod_reserva`, `cod_usuario`, `cod_ruta`) VALUES
(14, 2, 1),
(2, 2, 1),
(3, 3, 1),
(11, 2, 1),
(6, 2, 3),
(15, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_rutas`
--

DROP TABLE IF EXISTS `tbl_rutas`;
CREATE TABLE `tbl_rutas` (
  `cod_ruta` int(11) NOT NULL,
  `cod_hora` int(11) DEFAULT NULL,
  `cod_bus` int(11) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(2000) NOT NULL,
  `hora_salida` varchar(50) NOT NULL,
  `hora_llegada` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_rutas`
--

INSERT INTO `tbl_rutas` (`cod_ruta`, `cod_hora`, `cod_bus`, `nombre`, `descripcion`, `hora_salida`, `hora_llegada`) VALUES
(1, NULL, NULL, 'Hospital-Kennedy', 'Recorrido: Boulevard Suyapa, Colonia el hogar, plaza Miraflores, Kennedy', '8:00 am', '8:30:am');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipos_colaborador`
--

DROP TABLE IF EXISTS `tbl_tipos_colaborador`;
CREATE TABLE `tbl_tipos_colaborador` (
  `tipo_colaborador` int(11) NOT NULL,
  `colaborador` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuario`
--

DROP TABLE IF EXISTS `tbl_usuario`;
CREATE TABLE `tbl_usuario` (
  `cod_usuario` int(11) NOT NULL,
  `contraseña` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_buses`
--
ALTER TABLE `tbl_buses`
  ADD PRIMARY KEY (`cod_bus`);

--
-- Indices de la tabla `tbl_centro_medico`
--
ALTER TABLE `tbl_centro_medico`
  ADD PRIMARY KEY (`cod_centro`);

--
-- Indices de la tabla `tbl_centro_medico_has_tbl_rutas`
--
ALTER TABLE `tbl_centro_medico_has_tbl_rutas`
  ADD PRIMARY KEY (`cod_Centro_ruta`,`tbl_centro_medico_cod_centro`,`tbl_rutas_cod_ruta`),
  ADD KEY `fk_centro_medico_X_ruta` (`tbl_centro_medico_cod_centro`),
  ADD KEY `fk_tbl_ruta_X_centro_medico` (`tbl_rutas_cod_ruta`);

--
-- Indices de la tabla `tbl_colaborador`
--
ALTER TABLE `tbl_colaborador`
  ADD PRIMARY KEY (`cod_colaborador`),
  ADD KEY `fk_Tbl_Colaborador_Tbl_Tipos_colaborador1` (`tipo_colaborador`),
  ADD KEY `fk_Tbl_Colaborador_tbl_centro_medico1` (`cod_centro_medico`);

--
-- Indices de la tabla `tbl_genero`
--
ALTER TABLE `tbl_genero`
  ADD PRIMARY KEY (`cod_genero`);

--
-- Indices de la tabla `tbl_horarios`
--
ALTER TABLE `tbl_horarios`
  ADD PRIMARY KEY (`cod_hora`);

--
-- Indices de la tabla `tbl_lugar`
--
ALTER TABLE `tbl_lugar`
  ADD PRIMARY KEY (`cod_lugar`),
  ADD KEY `fk_Tbl_Lugar_Tbl_Lugar1` (`lugar_hijo`);

--
-- Indices de la tabla `tbl_persona`
--
ALTER TABLE `tbl_persona`
  ADD PRIMARY KEY (`ID_persona`),
  ADD KEY `fk_Tbl_persona_Tbl_Lugar1` (`cod_lugar`),
  ADD KEY `fk_Tbl_persona_Tbl_genero1` (`cod_genero`);

--
-- Indices de la tabla `tbl_reserva`
--
ALTER TABLE `tbl_reserva`
  ADD PRIMARY KEY (`cod_reserva`);

--
-- Indices de la tabla `tbl_rutas`
--
ALTER TABLE `tbl_rutas`
  ADD PRIMARY KEY (`cod_ruta`),
  ADD KEY `fk_tbl_rutas_tbl_horarios1` (`cod_hora`),
  ADD KEY `fk_tbl_rutas_tbl_buses1` (`cod_bus`);

--
-- Indices de la tabla `tbl_tipos_colaborador`
--
ALTER TABLE `tbl_tipos_colaborador`
  ADD PRIMARY KEY (`tipo_colaborador`);

--
-- Indices de la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  ADD PRIMARY KEY (`cod_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_buses`
--
ALTER TABLE `tbl_buses`
  MODIFY `cod_bus` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_centro_medico`
--
ALTER TABLE `tbl_centro_medico`
  MODIFY `cod_centro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tbl_colaborador`
--
ALTER TABLE `tbl_colaborador`
  MODIFY `cod_colaborador` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_genero`
--
ALTER TABLE `tbl_genero`
  MODIFY `cod_genero` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_lugar`
--
ALTER TABLE `tbl_lugar`
  MODIFY `cod_lugar` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_persona`
--
ALTER TABLE `tbl_persona`
  MODIFY `ID_persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tbl_reserva`
--
ALTER TABLE `tbl_reserva`
  MODIFY `cod_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `tbl_rutas`
--
ALTER TABLE `tbl_rutas`
  MODIFY `cod_ruta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `tbl_tipos_colaborador`
--
ALTER TABLE `tbl_tipos_colaborador`
  MODIFY `tipo_colaborador` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tbl_usuario`
--
ALTER TABLE `tbl_usuario`
  MODIFY `cod_usuario` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_centro_medico_has_tbl_rutas`
--
ALTER TABLE `tbl_centro_medico_has_tbl_rutas`
  ADD CONSTRAINT `fk_centro_medico_X_ruta` FOREIGN KEY (`tbl_centro_medico_cod_centro`) REFERENCES `tbl_centro_medico` (`cod_centro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_ruta_X_centro_medico` FOREIGN KEY (`tbl_rutas_cod_ruta`) REFERENCES `tbl_rutas` (`cod_ruta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_colaborador`
--
ALTER TABLE `tbl_colaborador`
  ADD CONSTRAINT `fk_Tbl_Colaborador_Tbl_Tipos_colaborador1` FOREIGN KEY (`tipo_colaborador`) REFERENCES `tbl_tipos_colaborador` (`tipo_colaborador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tbl_Colaborador_Tbl_persona` FOREIGN KEY (`cod_colaborador`) REFERENCES `tbl_persona` (`ID_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tbl_Colaborador_tbl_centro_medico1` FOREIGN KEY (`cod_centro_medico`) REFERENCES `tbl_centro_medico` (`cod_centro`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_lugar`
--
ALTER TABLE `tbl_lugar`
  ADD CONSTRAINT `fk_Tbl_Lugar_Tbl_Lugar1` FOREIGN KEY (`lugar_hijo`) REFERENCES `tbl_lugar` (`cod_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_persona`
--
ALTER TABLE `tbl_persona`
  ADD CONSTRAINT `fk_Tbl_persona_Tbl_Lugar1` FOREIGN KEY (`cod_lugar`) REFERENCES `tbl_lugar` (`cod_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Tbl_persona_Tbl_genero1` FOREIGN KEY (`cod_genero`) REFERENCES `tbl_genero` (`cod_genero`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_rutas`
--
ALTER TABLE `tbl_rutas`
  ADD CONSTRAINT `fk_tbl_rutas_tbl_buses1` FOREIGN KEY (`cod_bus`) REFERENCES `tbl_buses` (`cod_bus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tbl_rutas_tbl_horarios1` FOREIGN KEY (`cod_hora`) REFERENCES `tbl_horarios` (`cod_hora`) ON DELETE NO ACTION ON UPDATE NO ACTION;

DELIMITER $$
--
-- Eventos
--
DROP EVENT `vaciar ruta`$$
CREATE DEFINER=`root`@`localhost` EVENT `vaciar ruta` ON SCHEDULE EVERY 1 DAY STARTS '2019-03-28 20:06:01' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM tbl_reserva 
WHERE cod_ruta =2$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
