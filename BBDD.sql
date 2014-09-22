-- phpMyAdmin SQL Dump
-- version 2.11.4
-- http://www.phpmyadmin.net
--
-- Host: s155.eatj.com:3307
-- Generation Time: Sep 22, 2014 at 07:01 AM
-- Server version: 5.0.77
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


-- --------------------------------------------------------

--
-- Table structure for table `alumnos`
--

CREATE TABLE IF NOT EXISTS `alumnos` (
  `IdAlumno` int(11) NOT NULL auto_increment,
  `login` varchar(255) NOT NULL,
  PRIMARY KEY  (`IdAlumno`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `alumnos`
--


-- --------------------------------------------------------

--
-- Table structure for table `asignatura`
--

CREATE TABLE IF NOT EXISTS `asignatura` (
  `IdAsignatura` int(11) NOT NULL auto_increment,
  `NombreAsignatura` varchar(255) NOT NULL,
  `IdProfesor` int(11) NOT NULL,
  PRIMARY KEY  (`IdAsignatura`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `asignatura`
--


-- --------------------------------------------------------

--
-- Table structure for table `asignatura_alumno`
--

CREATE TABLE IF NOT EXISTS `asignatura_alumno` (
  `IdAsig_Alum` int(11) NOT NULL auto_increment,
  `IdAsignatura` int(11) NOT NULL,
  `IdAlumno` int(11) NOT NULL,
  PRIMARY KEY  (`IdAsig_Alum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `asignatura_alumno`
--


-- --------------------------------------------------------

--
-- Table structure for table `calificaciones`
--

CREATE TABLE IF NOT EXISTS `calificaciones` (
  `idCalificacion` int(11) NOT NULL auto_increment,
  `IdAsignatura` int(11) NOT NULL,
  `IdAlumno` int(11) NOT NULL,
  `1C_teoria1` int(11) NOT NULL,
  `1C_teoria2` int(11) NOT NULL,
  `1C_problema` int(11) NOT NULL,
  `2C_teoria1` int(11) NOT NULL,
  `2C_teoria2` int(11) NOT NULL,
  `2C_problema` int(11) NOT NULL,
  `3C_teoria1` int(11) NOT NULL,
  `3C_teoria2` int(11) NOT NULL,
  `3C_problema` int(11) NOT NULL,
  PRIMARY KEY  (`idCalificacion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=1 ;

--
-- Dumping data for table `calificaciones`
--


-- --------------------------------------------------------

--
-- Table structure for table `datosLDAP`
--

CREATE TABLE IF NOT EXISTS `datosLDAP` (
  `provider_url` text NOT NULL,
  `basedn` text NOT NULL,
  `version` int(11) NOT NULL,
  `securityProtocol` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `datosLDAP`
--

INSERT INTO `datosLDAP` (`provider_url`, `basedn`, `version`, `securityProtocol`) VALUES
('ldap://ldap.uc3m.es:389', 'ou=Gente,o=Universidad Carlos III,c=es', 3, 'simple');

-- --------------------------------------------------------

--
-- Table structure for table `profesores`
--

CREATE TABLE IF NOT EXISTS `profesores` (
  `IdProfesor` int(11) NOT NULL auto_increment,
  `login` int(11) NOT NULL,
  PRIMARY KEY  (`IdProfesor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `profesores`
--


-- --------------------------------------------------------

--
-- Table structure for table `Usuarios`
--

CREATE TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` int(11) NOT NULL auto_increment,
  `login` varchar(255) default NULL,
  `pass` varchar(255) default NULL,
  `nombreUsuario` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `tipo` varchar(255) default NULL,
  `fechaCreacion` datetime NOT NULL,
  `ultimoLogon` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`idUsuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `Usuarios`
--

INSERT INTO `Usuarios` (`idUsuario`, `login`, `pass`, `nombreUsuario`, `email`, `tipo`, `fechaCreacion`, `ultimoLogon`) VALUES
(1, 'g44vL1Y8OxE=', '21232f297a57a5a743894a0e4a801fc3', 'g44vL1Y8OxE=', 'dlMojoVCiHh0XwKLad7Zhg==', 'g44vL1Y8OxE=', '2014-08-27 00:00:00', '2014-09-22 06:55:21');
