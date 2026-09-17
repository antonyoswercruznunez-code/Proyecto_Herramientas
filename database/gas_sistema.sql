-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-07-2026 a las 08:09:38
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
-- Base de datos: `gas_sistema`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacenes`
--

CREATE TABLE `almacenes` (
  `id` int(11) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` enum('central','sucursal','deposito') NOT NULL DEFAULT 'sucursal',
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `almacenes`
--

INSERT INTO `almacenes` (`id`, `sucursal_id`, `nombre`, `tipo`, `estado`) VALUES
(1, 1, 'Almacén - Sucursal de Gas', 'sucursal', 0),
(2, 2, 'Almacén - Sucursal de Bidones', 'sucursal', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_sessions`
--

CREATE TABLE `app_sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `usuario_nombre` varchar(100) DEFAULT '',
  `accion` varchar(50) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `descripcion` text DEFAULT '',
  `ip` varchar(45) DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id`, `usuario_id`, `usuario_nombre`, `accion`, `modulo`, `descripcion`, `ip`, `created_at`) VALUES
(1, 1, 'Admin Principal', 'ABRIR', 'caja', 'Apertura caja sucursal 1 - S/150', '', '2026-05-28 01:18:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_eventos`
--

CREATE TABLE `auditoria_eventos` (
  `id` bigint(20) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `cliente_web_id` int(11) DEFAULT NULL,
  `accion` varchar(80) NOT NULL,
  `modulo` varchar(60) NOT NULL,
  `entidad` varchar(80) NOT NULL DEFAULT '',
  `entidad_id` varchar(80) NOT NULL DEFAULT '',
  `descripcion` varchar(500) NOT NULL DEFAULT '',
  `datos_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`datos_json`)),
  `ip` varchar(45) NOT NULL DEFAULT '',
  `user_agent` varchar(500) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auditoria_eventos`
--

INSERT INTO `auditoria_eventos` (`id`, `usuario_id`, `cliente_web_id`, `accion`, `modulo`, `entidad`, `entidad_id`, `descripcion`, `datos_json`, `ip`, `user_agent`, `created_at`) VALUES
(1, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-08 23:07:35'),
(2, 1, NULL, 'logo_subido', 'tienda', 'tienda_imagenes', '12', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-08 23:09:46'),
(3, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-08 23:10:23'),
(4, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:29:14'),
(5, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '12', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:29:28'),
(6, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '10', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:29:44'),
(7, 1, NULL, 'temporada_creada', 'temporadas', 'temporadas', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:34:15'),
(8, 1, NULL, 'descuento_temporada_creado', 'temporadas', 'temporada_descuentos', '1', '', '{\"temporada_id\":1,\"producto_id\":12,\"categoria_id\":null,\"porcentaje\":4}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:34:34'),
(9, 1, NULL, 'descuento_temporada_creado', 'temporadas', 'temporada_descuentos', '2', '', '{\"temporada_id\":1,\"producto_id\":5,\"categoria_id\":null,\"porcentaje\":3}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:34:47'),
(10, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '12', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:35:01'),
(11, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '10', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 17:35:48'),
(12, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 18:18:04'),
(13, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 18:35:32'),
(14, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 18:35:39'),
(15, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 18:36:28'),
(16, 1, NULL, 'venta_creada', 'ventas', 'ventas', '50', '', '{\"numero\":\"NV01-000045\",\"total\":310,\"sucursal_id\":1}', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 18:41:16'),
(17, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 18:47:06'),
(18, 1, NULL, 'voucher_admin_subido', 'pedidos_web', 'pedidos_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 20:46:05'),
(19, 1, NULL, 'pedido_observado', 'pedidos_web', 'pedidos_web', '1', 'Aprobado', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 20:46:14'),
(20, 1, NULL, 'voucher_admin_subido', 'pedidos_web', 'pedidos_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 20:49:52'),
(21, 1, NULL, 'pedido_rechazado', 'pedidos_web', 'pedidos_web', '1', 'AADEE', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 20:57:14'),
(22, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:20:33'),
(23, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:20:40'),
(24, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:22:00'),
(25, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:22:06'),
(26, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:54:13'),
(27, 1, NULL, 'horario_recojo_actualizado', 'recojo', 'recojo_fechas', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:54:44'),
(28, 1, NULL, 'horario_recojo_actualizado', 'recojo', 'recojo_fechas', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:54:47'),
(29, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:57:55'),
(30, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 21:58:38'),
(31, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 22:02:27'),
(32, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 22:02:41'),
(33, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:03:13'),
(34, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:03:13'),
(35, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 22:12:40'),
(36, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:12:55'),
(37, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:13:50'),
(38, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:13:50'),
(39, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:13:51'),
(40, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:13:53'),
(41, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:13:53'),
(42, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:13:53'),
(43, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:14:04'),
(44, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:14:12'),
(45, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:15:24'),
(46, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-16 22:23:10'),
(47, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:25:29'),
(48, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:28:10'),
(49, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:31:23'),
(50, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:35:30'),
(51, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:36:34'),
(52, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:36:42'),
(53, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-16 23:37:39'),
(54, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 00:07:05'),
(55, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 00:41:50'),
(56, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 00:55:22'),
(57, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 00:56:28'),
(58, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 00:56:34'),
(59, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 00:58:21'),
(60, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 01:36:29'),
(61, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 01:36:33'),
(62, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 01:36:44'),
(63, 1, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 02:24:06'),
(64, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 02:24:41'),
(65, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 02:27:41'),
(66, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', '2026-07-17 02:28:24'),
(67, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:09:56'),
(68, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:11:04'),
(69, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:11:36'),
(70, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:14:42'),
(71, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '3', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:16:23'),
(72, 1, NULL, 'horario_recojo_eliminado', 'recojo', 'recojo_fechas', '3', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:16:28'),
(73, 1, NULL, 'horario_recojo_eliminado', 'recojo', 'recojo_fechas', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:16:32'),
(74, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:16:57'),
(75, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:17:26'),
(76, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '4', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:17:48'),
(77, 1, NULL, 'horario_recojo_eliminado', 'recojo', 'recojo_fechas', '4', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:17:57'),
(78, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '5', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:18:09'),
(79, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:18:30'),
(80, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:19:27'),
(81, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:20:08'),
(82, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:20:50'),
(83, 1, NULL, 'slider_subido', 'tienda', 'tienda_imagenes', '13', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:21:34'),
(84, 1, NULL, 'imagen_pago_actualizada', 'tienda', 'configuracion', 'yape_qr_ruta', '', '{\"tipo\":\"yape\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:22:28'),
(85, 1, NULL, 'imagen_pago_actualizada', 'tienda', 'configuracion', 'plin_qr_ruta', '', '{\"tipo\":\"plin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:22:30'),
(86, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:25:47'),
(87, NULL, 1, 'pedido_web_creado', 'ecommerce', 'pedidos_web', '2', '', '{\"numero\":\"WEB-000002\",\"multisucursal\":true}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:26:12'),
(88, NULL, 1, 'voucher_cliente_subido', 'ecommerce', 'pedidos_web', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:26:12'),
(89, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 11:27:11'),
(90, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 12:12:02'),
(91, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 12:43:14'),
(92, 1, NULL, 'pedido_aprobado', 'pedidos_web', 'pedidos_web', '2', '', '{\"venta_id\":56,\"numero\":\"NV01-000046\",\"sucursales\":[2,3]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 12:57:28'),
(93, 1, NULL, 'slider_eliminado', 'tienda', 'tienda_imagenes', '13', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 13:21:30'),
(94, 1, NULL, 'slider_subido', 'tienda', 'tienda_imagenes', '14', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 13:21:40'),
(95, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 13:22:24'),
(96, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 13:24:01'),
(97, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:06:31'),
(98, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:08:42'),
(99, 1, NULL, 'imagen_pago_actualizada', 'tienda', 'configuracion', 'yape_qr_ruta', '', '{\"tipo\":\"yape\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:10:48'),
(100, 1, NULL, 'imagen_pago_actualizada', 'tienda', 'configuracion', 'plin_qr_ruta', '', '{\"tipo\":\"plin\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:10:54'),
(101, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:11:24'),
(102, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:14:24'),
(103, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:15:20'),
(104, NULL, 1, 'pedido_web_creado', 'ecommerce', 'pedidos_web', '3', '', '{\"numero\":\"WEB-000003\",\"multisucursal\":true}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:16:13'),
(105, NULL, 1, 'voucher_cliente_subido', 'ecommerce', 'pedidos_web', '3', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:16:13'),
(106, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:16:37'),
(107, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:22:43'),
(108, NULL, 1, 'pedido_web_creado', 'ecommerce', 'pedidos_web', '4', '', '{\"numero\":\"WEB-000004\",\"multisucursal\":false}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:23:28'),
(109, NULL, 1, 'voucher_cliente_subido', 'ecommerce', 'pedidos_web', '4', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:23:28'),
(110, NULL, 1, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:24:30'),
(111, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 14:25:40'),
(112, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 15:00:08'),
(113, NULL, 1, 'pedido_web_creado', 'ecommerce', 'pedidos_web', '5', '', '{\"numero\":\"WEB-000005\",\"multisucursal\":false}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 15:00:44'),
(114, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 15:00:59'),
(115, 1, NULL, 'pedido_aprobado', 'pedidos_web', 'pedidos_web', '5', '', '{\"venta_id\":57,\"numero\":\"NV01-000047\",\"sucursales\":[3]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 15:01:42'),
(116, 1, NULL, 'correo_pedido_reenviado', 'pedidos_web', 'pedidos_web', '5', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 15:04:10'),
(117, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 15:06:41'),
(118, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 23:27:36'),
(119, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"pendiente\",\"nuevo\":\"preparando\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 23:49:42'),
(120, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"preparando\",\"nuevo\":\"listo\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-17 23:49:47'),
(121, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 00:05:50'),
(122, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:44:08'),
(123, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:46:39'),
(124, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:46:43'),
(125, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:47:29'),
(126, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:47:38'),
(127, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:54:52'),
(128, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 20:56:54'),
(129, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:08:16'),
(130, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:08:22'),
(131, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:11:51'),
(132, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:12:00'),
(133, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:21:51'),
(134, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:36:33'),
(135, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 21:41:15'),
(136, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 23:01:21'),
(137, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 23:01:26'),
(138, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 23:03:02'),
(139, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-18 23:03:15'),
(140, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 18:39:24'),
(141, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '12', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 18:47:19'),
(142, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '10', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 18:47:26'),
(143, 1, NULL, 'slider_subido', 'tienda', 'tienda_imagenes', '15', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 18:49:27'),
(144, 1, NULL, 'slider_eliminado', 'tienda', 'tienda_imagenes', '15', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 18:49:57'),
(145, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '2', '', '{\"anterior\":\"pendiente\",\"nuevo\":\"preparando\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:08:15'),
(146, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '2', '', '{\"anterior\":\"preparando\",\"nuevo\":\"listo\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:08:19'),
(147, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"listo\",\"nuevo\":\"incidencia\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:11:47'),
(148, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '2', '', '{\"anterior\":\"listo\",\"nuevo\":\"incidencia\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:11:56'),
(149, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '1', '', '{\"anterior\":\"pendiente\",\"nuevo\":\"incidencia\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:20'),
(150, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"incidencia\",\"nuevo\":\"preparando\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:31'),
(151, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"preparando\",\"nuevo\":\"listo\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:33'),
(152, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '2', '', '{\"anterior\":\"incidencia\",\"nuevo\":\"preparando\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:38'),
(153, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '1', '', '{\"anterior\":\"incidencia\",\"nuevo\":\"preparando\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:42'),
(154, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '2', '', '{\"anterior\":\"preparando\",\"nuevo\":\"listo\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:53'),
(155, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '1', '', '{\"anterior\":\"preparando\",\"nuevo\":\"listo\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:12:55'),
(156, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:22:54'),
(157, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:23:00'),
(158, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:23:07'),
(159, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:23:18'),
(160, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:24:33'),
(161, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:24:41'),
(162, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:26:12'),
(163, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:26:57'),
(164, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '6', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:27:52'),
(165, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '7', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:27:56'),
(166, 1, NULL, 'horario_recojo_creado', 'recojo', 'recojo_fechas', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:27:59'),
(167, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:28:16'),
(168, NULL, 1, 'pedido_web_creado', 'ecommerce', 'pedidos_web', '6', '', '{\"numero\":\"WEB-000006\",\"multisucursal\":true}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:28:55'),
(169, NULL, 1, 'voucher_cliente_subido', 'ecommerce', 'pedidos_web', '6', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:28:56'),
(170, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:29:11'),
(171, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"listo\",\"nuevo\":\"incidencia\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:49:57'),
(172, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"incidencia\",\"nuevo\":\"preparando\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:50:17'),
(173, 1, NULL, 'entrega_estado', 'recojo', 'pedido_entregas_sucursal', '3', '', '{\"anterior\":\"preparando\",\"nuevo\":\"listo\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 19:50:22'),
(174, 1, NULL, 'horario_recojo_eliminado', 'recojo', 'recojo_fechas', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 20:12:35'),
(175, 1, NULL, 'horario_recojo_eliminado', 'recojo', 'recojo_fechas', '5', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 20:12:41'),
(176, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:05:09'),
(177, NULL, NULL, 'login_fallido', 'auth', '', '', 'Intento de inicio de sesión fallido', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:05:15'),
(178, 2, NULL, 'login_exitoso', 'auth', 'usuario', '2', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:05:18'),
(179, 2, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:05:26'),
(180, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:05:47'),
(181, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:08:02'),
(182, NULL, NULL, 'login_fallido', 'auth', '', '', 'Intento de inicio de sesión fallido', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:08:08'),
(183, NULL, NULL, 'login_fallido', 'auth', '', '', 'Intento de inicio de sesión fallido', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:08:12'),
(184, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:08:25'),
(185, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:08:52'),
(186, NULL, NULL, 'login_fallido', 'auth', '', '', 'Intento de inicio de sesión fallido', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:09:01'),
(187, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 21:09:14'),
(188, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-19 23:49:49'),
(189, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:19:01'),
(190, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '12', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:19:11'),
(191, 1, NULL, 'logo_activado', 'tienda', 'tienda_imagenes', '10', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:19:32'),
(192, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:21:25'),
(193, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:23:08'),
(194, NULL, 1, 'cliente_web_google_login', 'ecommerce', 'clientes_web', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:23:48'),
(195, 1, NULL, 'login_exitoso', 'auth', 'usuario', '1', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:24:21'),
(196, 1, NULL, 'pedido_aprobado', 'pedidos_web', 'pedidos_web', '6', '', '{\"venta_id\":62,\"numero\":\"NV01-000048\",\"sucursales\":[1,2,3]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:42:10'),
(197, 1, NULL, 'logout', 'auth', '', '', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 00:51:46'),
(198, NULL, NULL, 'recuperacion_solicitada', 'auth', 'usuario', '8', '', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', '2026-07-20 01:00:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas`
--

CREATE TABLE `cajas` (
  `id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `fecha_apertura` datetime DEFAULT current_timestamp(),
  `fecha_cierre` datetime DEFAULT NULL,
  `monto_inicial` decimal(10,2) DEFAULT 0.00,
  `monto_final` decimal(10,2) DEFAULT NULL,
  `total_ventas` decimal(10,2) DEFAULT 0.00,
  `total_ingresos` decimal(10,2) DEFAULT 0.00,
  `total_egresos` decimal(10,2) DEFAULT 0.00,
  `estado` varchar(30) NOT NULL DEFAULT 'abierta',
  `observacion` text DEFAULT NULL,
  `usuario_apertura_id` int(11) DEFAULT NULL,
  `usuario_cierre_id` int(11) DEFAULT NULL,
  `monto_esperado` decimal(10,2) DEFAULT NULL,
  `monto_real` decimal(10,2) DEFAULT NULL,
  `diferencia` decimal(10,2) DEFAULT NULL,
  `fecha_cierre_programada` datetime DEFAULT NULL,
  `fecha_bloqueo_automatico` datetime DEFAULT NULL,
  `fecha_cierre_automatico` datetime DEFAULT NULL,
  `apertura_automatica` tinyint(4) NOT NULL DEFAULT 0,
  `cierre_automatico_pendiente` tinyint(4) NOT NULL DEFAULT 0,
  `observacion_apertura` text DEFAULT '',
  `observacion_cierre` text DEFAULT '',
  `caja_fisica_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas_fisicas`
--

CREATE TABLE `cajas_fisicas` (
  `id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `monto_inicial` decimal(10,2) NOT NULL DEFAULT 0.00,
  `activo` tinyint(4) NOT NULL DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `hora_apertura` time NOT NULL DEFAULT '08:00:00',
  `hora_cierre` time NOT NULL DEFAULT '22:00:00',
  `configurada` tinyint(4) NOT NULL DEFAULT 0,
  `orden` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `monto_inicial_predeterminado` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cajas_fisicas`
--

INSERT INTO `cajas_fisicas` (`id`, `sucursal_id`, `codigo`, `monto_inicial`, `activo`, `created_by`, `created_at`, `updated_by`, `updated_at`, `hora_apertura`, `hora_cierre`, `configurada`, `orden`, `monto_inicial_predeterminado`) VALUES
(1, 1, 'Caja 01', 100.00, 1, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(2, 1, 'Caja 02', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(3, 1, 'Caja 03', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(4, 1, 'Caja 04', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(5, 1, 'Caja 05', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(6, 2, 'Caja 01', 100.00, 1, 1, '2026-07-06 22:52:50', NULL, '2026-07-18 20:45:27', '20:18:00', '23:59:00', 0, 1, 100.00),
(7, 2, 'Caja 02', 100.00, 1, 1, '2026-07-06 22:52:50', NULL, '2026-07-07 00:45:28', '00:00:00', '00:47:00', 0, 1, 0.00),
(8, 2, 'Caja 03', 100.00, 1, 1, '2026-07-06 22:52:50', NULL, '2026-07-07 00:47:08', '00:00:00', '00:48:00', 0, 1, 0.00),
(9, 2, 'Caja 04', 100.00, 1, 1, '2026-07-06 22:52:50', NULL, '2026-07-07 00:51:10', '08:00:00', '22:00:00', 0, 1, 0.00),
(10, 2, 'Caja 05', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(11, 3, 'Caja 01', 100.00, 1, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(12, 3, 'Caja 02', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(13, 3, 'Caja 03', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(14, 3, 'Caja 04', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00),
(15, 3, 'Caja 05', 100.00, 0, 1, '2026-07-06 22:52:50', NULL, NULL, '08:00:00', '22:00:00', 0, 1, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_movimientos`
--

CREATE TABLE `caja_movimientos` (
  `id` int(11) NOT NULL,
  `sesion_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL DEFAULT 1,
  `tipo` enum('ingreso','egreso') NOT NULL,
  `concepto` varchar(200) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caja_movimientos`
--

INSERT INTO `caja_movimientos` (`id`, `sesion_id`, `sucursal_id`, `tipo`, `concepto`, `monto`, `venta_id`, `usuario_id`, `created_at`) VALUES
(1, 1, 1, 'ingreso', 'sfd', 100.00, NULL, 1, '2026-05-28 01:19:18'),
(2, 1, 1, 'egreso', 'prueba gasto', 20.00, NULL, 1, '2026-06-18 10:02:36'),
(3, 3, 1, 'ingreso', 'Venta NV01-000024', 325.00, 24, 1, '2026-06-20 00:37:01'),
(4, 3, 1, 'egreso', '..', 100.00, NULL, 1, '2026-06-20 13:43:33'),
(5, 4, 1, 'ingreso', 'Fondo', 150.00, NULL, 2, '2026-06-20 15:42:05'),
(6, 3, 1, 'ingreso', 'Venta NV01-000026', 275.00, 29, 1, '2026-06-20 18:14:07'),
(7, 3, 1, 'ingreso', 'Venta NV01-000027', 335.00, 30, 1, '2026-06-20 18:16:29'),
(8, 3, 1, 'ingreso', 'Fondo', 140.00, NULL, 1, '2026-06-20 18:18:46'),
(9, 5, 1, 'ingreso', 'Venta NV01-000028', 335.00, 31, 4, '2026-06-20 18:43:27'),
(10, 5, 1, 'ingreso', 'Venta NV01-000029', 335.00, 32, 4, '2026-06-20 18:44:05'),
(11, 3, 1, 'ingreso', 'Venta NV01-000030', 310.00, 33, 1, '2026-06-21 23:18:34'),
(12, 6, 1, 'ingreso', 'Venta NV01-000032', 2875.00, 35, 2, '2026-06-24 21:17:16'),
(13, 7, 1, 'ingreso', 'Venta NV01-000033', 40.00, 36, 1, '2026-06-25 11:38:02'),
(14, 7, 1, 'ingreso', 'Venta NV01-000034', 18.00, 37, 1, '2026-06-25 11:45:21'),
(15, 6, 1, 'ingreso', 'Venta NV01-000035', 295.00, 38, 2, '2026-06-26 16:49:48'),
(16, 4, 1, 'egreso', 'Almuerzo', 10.00, NULL, 1, '2026-07-01 14:27:29'),
(17, 5, 2, 'ingreso', 'Venta NV01-000043', 30.00, 46, 1, '2026-07-03 12:10:11'),
(18, 7, 2, 'ingreso', 'Venta NV01-000044', 10.00, 47, 2, '2026-07-07 00:19:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja_sesiones`
--

CREATE TABLE `caja_sesiones` (
  `id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `abierta_at` datetime NOT NULL DEFAULT current_timestamp(),
  `cerrada_at` datetime DEFAULT NULL,
  `monto_inicial` decimal(10,2) NOT NULL DEFAULT 0.00,
  `monto_final` decimal(10,2) DEFAULT NULL,
  `total_ventas` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_ingresos` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_egresos` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estado` enum('abierta','cerrada','conciliada','pendiente_arqueo','pendiente_revision','observada') NOT NULL DEFAULT 'abierta',
  `observacion` text DEFAULT '',
  `numero_caja` int(10) UNSIGNED DEFAULT NULL COMMENT 'Correlativo secuencial por sucursal',
  `conciliada_at` datetime DEFAULT NULL COMMENT 'Cuándo se marcó como conciliada',
  `conciliada_por` int(11) DEFAULT NULL COMMENT 'FK usuarios.id - quién concilió',
  `revertida_at` datetime DEFAULT NULL COMMENT 'Cuándo se revirtió',
  `revertida_por` int(11) DEFAULT NULL COMMENT 'FK usuarios.id - quién revirtió',
  `caja_fisica_id` int(11) DEFAULT NULL,
  `bloqueada_at` datetime DEFAULT NULL,
  `arqueado_por` int(11) DEFAULT NULL,
  `arqueo_at` datetime DEFAULT NULL,
  `revisada_por` int(11) DEFAULT NULL,
  `revisada_at` datetime DEFAULT NULL,
  `observacion_revision` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caja_sesiones`
--

INSERT INTO `caja_sesiones` (`id`, `sucursal_id`, `usuario_id`, `abierta_at`, `cerrada_at`, `monto_inicial`, `monto_final`, `total_ventas`, `total_ingresos`, `total_egresos`, `estado`, `observacion`, `numero_caja`, `conciliada_at`, `conciliada_por`, `revertida_at`, `revertida_por`, `caja_fisica_id`, `bloqueada_at`, `arqueado_por`, `arqueo_at`, `revisada_por`, `revisada_at`, `observacion_revision`) VALUES
(1, 2, 1, '2026-06-30 11:38:28', '2026-06-30 12:47:25', 0.00, 10.00, 0.00, 100.00, 20.00, 'cerrada', 'safas', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 2, '2026-06-30 11:44:44', '2026-06-30 11:57:55', 100.00, 10.00, 0.00, 0.00, 0.00, 'cerrada', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 2, '2026-06-30 12:12:19', '2026-06-30 12:52:21', 100.00, 1385.00, 1245.00, 140.00, 100.00, 'cerrada', '', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, '2026-07-01 14:27:02', '2026-07-01 14:47:09', 0.00, 140.00, 0.00, 150.00, 10.00, 'cerrada', '', 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 2, 1, '2026-07-03 12:09:54', '2026-07-06 22:34:41', 100.00, 800.00, 700.00, 0.00, 0.00, 'cerrada', '', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 1, '2026-07-06 22:34:52', '2026-07-06 22:35:10', 0.00, 100.00, 3170.00, 0.00, 0.00, 'cerrada', 'me robaron', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 2, 2, '2026-07-07 00:18:26', '2026-07-07 00:20:16', 100.00, 168.00, 68.00, 0.00, 0.00, 'conciliada', 'Todo ok', 3, '2026-07-07 00:21:21', 1, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 2, 2, '2026-07-07 00:42:48', '2026-07-07 00:51:44', 0.00, 0.00, 0.00, 0.00, 0.00, 'conciliada', '', 4, '2026-07-07 00:53:12', 1, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 2, 3, '2026-07-07 00:47:31', '2026-07-07 11:58:42', 0.00, 0.00, 0.00, 0.00, 0.00, 'cerrada', '', 5, NULL, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 2, 2, '2026-07-18 21:09:07', NULL, 100.00, NULL, 0.00, 0.00, 0.00, 'abierta', 'aa', 6, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT '',
  `icono` varchar(50) DEFAULT 'ti-tag',
  `color` varchar(20) DEFAULT '#e53e3e',
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `icono`, `color`, `estado`, `created_at`) VALUES
(1, 'Bidones', 'Bidones de agua', 'ti-tag', '#e53e3e', 0, '2026-05-30 00:38:45'),
(2, 'Gas', 'Balones y cilindros de gas', 'ti-tag', '#e53e3e', 0, '2026-05-30 00:38:45'),
(3, 'Accesorios', 'Tapas, caños y accesorios', 'ti-tag', '#e53e3e', 0, '2026-05-30 00:38:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `tipo_doc` enum('dni','ruc') NOT NULL DEFAULT 'dni',
  `numero_doc` varchar(20) NOT NULL,
  `nombre` varchar(200) NOT NULL DEFAULT '',
  `razon_social` varchar(200) DEFAULT '',
  `direccion` text DEFAULT '',
  `telefono` varchar(30) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `tipo_cliente` enum('minorista','mayorista','distribuidor') NOT NULL DEFAULT 'minorista',
  `sucursal_registro_id` int(11) DEFAULT NULL,
  `usuario_registro_id` int(11) DEFAULT NULL,
  `origen_api` tinyint(4) NOT NULL DEFAULT 0,
  `activo` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `limite_credito` decimal(10,2) DEFAULT 0.00,
  `dias_credito` int(11) DEFAULT 0,
  `es_general` tinyint(4) DEFAULT 0,
  `apellido_paterno` varchar(100) DEFAULT '',
  `apellido_materno` varchar(100) DEFAULT '',
  `distrito` varchar(100) DEFAULT '',
  `provincia` varchar(100) DEFAULT '',
  `departamento` varchar(100) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `tipo_doc`, `numero_doc`, `nombre`, `razon_social`, `direccion`, `telefono`, `email`, `tipo_cliente`, `sucursal_registro_id`, `usuario_registro_id`, `origen_api`, `activo`, `created_at`, `updated_at`, `limite_credito`, `dias_credito`, `es_general`, `apellido_paterno`, `apellido_materno`, `distrito`, `provincia`, `departamento`) VALUES
(6, 'dni', '75107608', 'ANTONY BRAYAN', '', 'CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE', '952903481', 'antonycamposgarnique@gmail.com', 'minorista', 1, 1, 0, 1, '2026-05-30 20:05:47', '2026-07-20 00:42:10', 0.00, 0, 0, 'CAMPOS', 'GARNIQUE', 'LA VICTORIA', 'CHICLAYO', 'LAMBAYEQUE'),
(7, 'dni', '42796099', 'AURORA', '', 'CALLE JOSE DE LOS SANTOS LT. 5 P. JOVEN CHOSICA DEL NORTE', '956177834', 'aurora84.gg@gmail.com', 'minorista', 1, 1, 0, 1, '2026-05-30 20:06:35', '2026-06-09 10:06:30', 0.00, 0, 0, 'GARNIQUE', 'GONZALES', 'LA VICTORIA', 'CHICLAYO', 'LAMBAYEQUE'),
(8, 'ruc', '20119407738', 'EMP. DE TRANS. FLORES HNOS. SRL.', 'EMP. DE TRANS. FLORES HNOS. SRL.', 'AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO', '952903481', 'antonycamposgarnique@gmail.com', 'minorista', 1, 1, 0, 1, '2026-05-30 20:07:39', '2026-07-17 15:01:42', 0.00, 0, 0, '', '', 'LA VICTORIA', 'LIMA', 'LIMA'),
(9, 'dni', '75109801', 'MICHAEL JORDAN', '', 'CR. PANAMERICANA SUR P. JOVEN CHOSICA DEL NORTE', '', '', 'minorista', 1, 1, 0, 1, '2026-05-30 20:22:08', NULL, 0.00, 0, 0, 'CAMPOS', 'GARNIQUE', 'LA VICTORIA', 'CHICLAYO', 'LAMBAYEQUE'),
(10, 'dni', '77458975', 'JOEL ANDERSON', '', '', '', '', 'minorista', 1, 1, 0, 1, '2026-05-30 21:09:36', NULL, 0.00, 0, 0, 'CAMPOS', 'GARNIQUE', 'LA VICTORIA', 'CHICLAYO', 'LAMBAYEQUE'),
(11, 'dni', '74123659', 'RODRIGO', '', 'JR. TORTUGAS URB. LOS CEDROS DE VILLA MZ. J-6 LT. 6', '', '', 'minorista', 1, 1, 0, 1, '2026-05-30 21:15:35', NULL, 0.00, 0, 0, 'REINOSO', 'TENORIO', 'CHORRILLOS', 'LIMA', 'LIMA'),
(12, 'dni', '47001858', 'VERONIKA BEATRIZ', '', 'CALLE HUAYNA CAPAC 1399', '', '', 'minorista', 1, 1, 1, 1, '2026-05-31 00:15:59', '2026-06-26 16:50:23', 0.00, 0, 0, 'MEDINA', 'NUÑEZ', 'LA VICTORIA', 'CHICLAYO', 'LAMBAYEQUE'),
(13, 'dni', '75796042', 'GEORGE JUNIOR', '', 'QUINTA SAN ISIDRO', '', '', 'minorista', 1, 1, 1, 1, '2026-06-01 09:39:10', NULL, 0.00, 0, 0, 'BAZAN', 'CARRION', 'MONSEFU', 'CHICLAYO', 'LAMBAYEQUE'),
(14, 'dni', '43564879', 'ROLANDO JOSE', '', 'JR JOSE CHARRIARSE 1117', '', '', 'minorista', 1, 1, 0, 2, '2026-06-05 09:39:21', '2026-06-05 09:39:43', 0.00, 0, 0, 'GRANDA', 'FIGUEROA', 'SAN JUAN DE MIRAFLORES', 'LIMA', 'LIMA'),
(15, 'dni', '74140248', 'JAIME ADOLFO', '', 'CALLE 28 DE JULIO 830A', '', '', 'minorista', 1, 1, 1, 1, '2026-06-08 09:58:42', NULL, 0.00, 0, 0, 'LOPEZ', 'SCIPION', 'LAMBAYEQUE', 'LAMBAYEQUE', 'LAMBAYEQUE'),
(16, 'dni', '77276899', 'OSCAR ALEXIS', '', 'CALLE FRANCISCO PIZARRO 567 P.J SAN ANTONIO', '', '', 'minorista', 1, 1, 1, 1, '2026-06-20 18:08:49', NULL, 0.00, 0, 0, 'SANCHEZ', 'BUSTAMANTE', 'CHICLAYO', 'CHICLAYO', 'LAMBAYEQUE'),
(17, 'ruc', '20607518751', 'DISTRIBUCIONES MAOZ E.I.R.L.', 'DISTRIBUCIONES MAOZ E.I.R.L.', 'CAL. FRANCISCO PIZARRO NRO. 567      SAN ANTONIO', '', '', 'minorista', 1, 1, 1, 1, '2026-06-20 18:09:18', NULL, 0.00, 0, 0, '', '', 'CHICLAYO', 'CHICLAYO', 'LAMBAYEQUE'),
(18, 'dni', '46597849', 'LICETH ANABEL', '', 'PANAMERICANA 1115', '', '', 'minorista', 1, 1, 0, 1, '2026-06-27 20:06:10', NULL, 0.00, 0, 0, 'BRACAMONTE', 'TORRES', 'LAS LOMAS', 'PIURA', 'PIURA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_web`
--

CREATE TABLE `clientes_web` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `google_id` varchar(100) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email_verificado` tinyint(4) NOT NULL DEFAULT 0,
  `proveedor` enum('local','google') NOT NULL DEFAULT 'local',
  `cliente_id` int(11) DEFAULT NULL,
  `activo` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes_web`
--

INSERT INTO `clientes_web` (`id`, `nombre`, `email`, `password`, `google_id`, `avatar`, `telefono`, `email_verificado`, `proveedor`, `cliente_id`, `activo`, `created_at`, `updated_at`) VALUES
(1, 'antony Campos Garnique', 'antonycamposgarnique@gmail.com', NULL, '104242091954721118537', 'https://lh3.googleusercontent.com/a/ACg8ocITJwa_xdMSGcj9-mBrDEOFo8vMbLixAN6uLQPlK5t5Dzq4pw=s96-c', NULL, 1, 'google', 6, 1, '2026-07-01 22:08:11', '2026-07-20 00:42:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `numero` varchar(30) NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL DEFAULT 1,
  `usuario_id` int(11) NOT NULL,
  `subtotal` decimal(10,2) DEFAULT 0.00,
  `igv` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT 0.00,
  `estado` enum('pendiente','recibida','anulada') DEFAULT 'pendiente',
  `observacion` text DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_items`
--

CREATE TABLE `compra_items` (
  `id` int(11) NOT NULL,
  `compra_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobantes`
--

CREATE TABLE `comprobantes` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `tipo` enum('boleta','factura','nota_credito','nota_debito') NOT NULL,
  `serie` varchar(10) NOT NULL,
  `numero` int(11) NOT NULL,
  `numero_full` varchar(20) NOT NULL,
  `hash_cpe` varchar(100) DEFAULT NULL COMMENT 'Hash del XML que devuelve MiAPI',
  `op_tributaria` varchar(20) DEFAULT 'Gravada (0101)',
  `subtotal` decimal(10,2) DEFAULT 0.00,
  `igv` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT 0.00,
  `xml_path` varchar(255) DEFAULT NULL,
  `xml_sin_firmar_path` varchar(500) DEFAULT NULL,
  `pdf_a4_path` varchar(255) DEFAULT NULL,
  `pdf_ticket_path` varchar(255) DEFAULT NULL,
  `cdr_path` varchar(255) DEFAULT NULL,
  `cdr_estado` varchar(20) DEFAULT NULL,
  `cdr_codigo` varchar(10) DEFAULT NULL COMMENT 'Código de respuesta SUNAT (0=ok)',
  `cdr_mensaje` varchar(500) DEFAULT NULL COMMENT 'Mensaje de SUNAT',
  `motivo_anula` varchar(255) DEFAULT NULL COMMENT 'Motivo si es NC/ND o baja',
  `comprobante_ref` varchar(20) DEFAULT NULL COMMENT 'Documento original al que refiere NC/ND',
  `estado_sunat` varchar(20) DEFAULT NULL,
  `sunat_response` text DEFAULT NULL,
  `emitido_at` datetime DEFAULT NULL,
  `enviado_at` datetime DEFAULT NULL,
  `aceptado_at` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `comprobantes`
--

INSERT INTO `comprobantes` (`id`, `venta_id`, `tipo`, `serie`, `numero`, `numero_full`, `hash_cpe`, `op_tributaria`, `subtotal`, `igv`, `total`, `xml_path`, `xml_sin_firmar_path`, `pdf_a4_path`, `pdf_ticket_path`, `cdr_path`, `cdr_estado`, `cdr_codigo`, `cdr_mensaje`, `motivo_anula`, `comprobante_ref`, `estado_sunat`, `sunat_response`, `emitido_at`, `enviado_at`, `aceptado_at`, `created_by`, `created_at`) VALUES
(1, 1, 'factura', 'F001', 1, 'F001-000001', '/2+Rzs4XmmNrvcEnDqSIWF6Aofw=', 'Gravada (0101)', 788.98, 142.02, 931.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-1.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-1.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-1.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-1.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-1.XML', 'aceptado', '0', 'La Factura numero F001-1, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"/2+Rzs4XmmNrvcEnDqSIWF6Aofw=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-1.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-1.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-1.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-1.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-1.XML\",\"code\":\"0\",\"mensaje\":\"La Factura numero F001-1, ha sido aceptada\"}}', '2026-06-07 16:58:11', '2026-06-07 16:58:12', '2026-06-07 16:58:12', 1, '2026-06-07 16:58:11'),
(2, 2, 'boleta', 'B001', 1, 'B001-000001', 'mEdzGqqnulpm82LEbhPxqG6tUig=', 'Gravada (0101)', 50.85, 9.15, 60.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-1.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-1.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-1.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-1.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-1.XML', 'aceptado', '0', 'La Boleta numero B001-1, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"mEdzGqqnulpm82LEbhPxqG6tUig=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-1.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-1.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-1.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-1.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-1.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-1, ha sido aceptada\"}}', '2026-06-08 09:14:53', '2026-06-08 09:14:54', '2026-06-08 09:14:54', 1, '2026-06-08 09:14:53'),
(3, 3, 'boleta', 'B001', 2, 'B001-000002', 'IGk1nctSEelvqEK54Rb5oNIo7Qk=', 'Gravada (0101)', 19.49, 3.51, 23.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-2.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-2.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-2.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-2.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-2.XML', 'aceptado', '0', 'La Boleta numero B001-2, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"IGk1nctSEelvqEK54Rb5oNIo7Qk=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-2.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-2.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-2.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-2.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-2.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-2, ha sido aceptada\"}}', '2026-06-08 09:29:35', '2026-06-08 09:29:37', '2026-06-08 09:29:37', 3, '2026-06-08 09:29:35'),
(4, 4, 'factura', 'F001', 2, 'F001-000002', 'UGcQAclt30f5dzdjduuObiRi/B0=', 'Gravada (0101)', 29.66, 5.34, 35.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-2.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-2.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-2.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-2.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-2.XML', 'aceptado', '0', 'La Factura numero F001-2, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"UGcQAclt30f5dzdjduuObiRi/B0=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-2.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-2.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-2.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-2.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-2.XML\",\"code\":\"0\",\"mensaje\":\"La Factura numero F001-2, ha sido aceptada\"}}', '2026-06-08 09:30:43', '2026-06-08 09:30:44', '2026-06-08 09:30:44', 3, '2026-06-08 09:30:43'),
(5, 5, 'boleta', 'B001', 3, 'B001-000003', 'IbZDgJj0godMw+hQ58rc34j+XYI=', 'Gravada (0101)', 27.97, 5.03, 33.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-3.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-3.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-3.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-3.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-3.XML', 'aceptado', '0', 'La Boleta numero B001-3, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"IbZDgJj0godMw+hQ58rc34j+XYI=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-3.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-3.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-3.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-3.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-3.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-3, ha sido aceptada\"}}', '2026-06-08 09:59:04', '2026-06-08 09:59:05', '2026-06-08 09:59:05', 1, '2026-06-08 09:59:04'),
(6, 6, 'boleta', 'B001', 4, 'B001-000004', 'iPJkln8iCYtQDcUhOAuSgcU1s4c=', 'Gravada (0101)', 218.64, 39.36, 258.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-4.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-4.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-4.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-4.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-4.XML', 'aceptado', '0', 'La Boleta numero B001-4, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"iPJkln8iCYtQDcUhOAuSgcU1s4c=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-4.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-4.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-4.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-4.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-4.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-4, ha sido aceptada\"}}', '2026-06-08 14:05:04', '2026-06-08 14:05:04', '2026-06-08 14:05:04', 1, '2026-06-08 14:05:04'),
(7, 11, 'boleta', 'B001', 5, 'B001-000005', 'GUyQtHxiO+CgfmWmbLoNAV2WTps=', 'Gravada (0101)', 254.24, 45.76, 300.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-5.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-5.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-5.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-5.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-5.XML', 'aceptado', '0', 'La Boleta numero B001-5, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"GUyQtHxiO+CgfmWmbLoNAV2WTps=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-5.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-5.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-5.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-5.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-5.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-5, ha sido aceptada\"}}', '2026-06-09 00:33:50', '2026-06-09 00:33:51', '2026-06-09 00:33:51', 2, '2026-06-09 00:33:50'),
(8, 12, 'boleta', 'B001', 6, 'B001-000006', '+v4YMiAq9eUlkm6TG34Pe1hXaXE=', 'Gravada (0101)', 61.86, 11.14, 73.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-6.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-6.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-6.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-6.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-6.XML', 'aceptado', '0', 'La Boleta numero B001-6, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"+v4YMiAq9eUlkm6TG34Pe1hXaXE=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-6.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-6.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-6.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-6.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-6.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-6, ha sido aceptada\"}}', '2026-06-09 00:56:05', '2026-06-09 00:56:06', '2026-06-09 00:56:06', 1, '2026-06-09 00:56:05'),
(9, 13, 'boleta', 'B001', 7, 'B001-000007', 'FxbC6sZmetP/FagarfhAxI+jS0w=', 'Gravada (0101)', 203.39, 36.61, 240.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-7.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-7.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-7.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-7.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-7.XML', 'aceptado', '0', 'La Boleta numero B001-7, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"FxbC6sZmetP/FagarfhAxI+jS0w=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-7.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-7.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-7.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-7.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-7.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-7, ha sido aceptada\"}}', '2026-06-09 12:02:04', '2026-06-09 12:02:05', '2026-06-09 12:02:05', 1, '2026-06-09 12:02:04'),
(10, 15, 'boleta', 'B001', 8, 'B001-000008', 'woZ6Mgtmvtm/MhkLIgO/rOPIEig=', 'Gravada (0101)', 106.78, 19.22, 126.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-8.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-8.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-8.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-8.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-8.XML', 'aceptado', '0', 'La Boleta numero B001-8, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"woZ6Mgtmvtm/MhkLIgO/rOPIEig=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-8.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-8.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-8.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-8.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-8.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-8, ha sido aceptada\"}}', '2026-06-15 08:42:11', '2026-06-15 08:42:12', '2026-06-15 08:42:12', 1, '2026-06-15 08:42:11'),
(11, 16, 'factura', 'F001', 3, 'F001-000003', 'iis9UvtELraStLNneP9txhm4yd8=', 'Gravada (0101)', 290.68, 52.32, 343.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-3.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-3.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-3.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-3.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-3.XML', 'aceptado', '0', 'La Factura numero F001-3, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"iis9UvtELraStLNneP9txhm4yd8=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-3.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-3.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-3.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-3.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-3.XML\",\"code\":\"0\",\"mensaje\":\"La Factura numero F001-3, ha sido aceptada\"}}', '2026-06-16 11:39:38', '2026-06-16 11:39:39', '2026-06-16 11:39:39', 1, '2026-06-16 11:39:38'),
(12, 17, 'boleta', 'B001', 9, 'B001-000009', 'DQuZde8X1vL7kR0CtXe+L5IlsA0=', 'Gravada (0101)', 8.47, 1.53, 10.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-9.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-9.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-9.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-9.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-9.XML', 'aceptado', '0', 'La Boleta numero B001-9, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"DQuZde8X1vL7kR0CtXe+L5IlsA0=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-9.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-9.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-9.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-9.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-9.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-9, ha sido aceptada\"}}', '2026-06-16 12:39:36', '2026-06-16 12:39:37', '2026-06-16 12:39:37', 1, '2026-06-16 12:39:36'),
(13, 24, 'boleta', 'B001', 10, 'B001-000010', '2JeDbB8nTjOry80bNDa2j+emVxs=', 'Gravada (0101)', 275.42, 49.58, 325.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-10.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-10.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-10.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-10.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-10.XML', 'aceptado', '0', 'La Boleta numero B001-10, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"2JeDbB8nTjOry80bNDa2j+emVxs=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-10.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-10.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-10.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-10.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-10.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-10, ha sido aceptada\"}}', '2026-06-20 15:28:55', '2026-06-20 15:28:55', '2026-06-20 15:28:55', 1, '2026-06-20 15:28:55'),
(14, 30, 'boleta', 'B001', 11, 'B001-000011', 'xfDf1tI8j2L5HddJ0nYqqZa4dYQ=', 'Gravada (0101)', 283.89, 51.11, 335.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-11.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-11.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-11.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-11.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-11.XML', 'aceptado', '0', 'La Boleta numero B001-11, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"xfDf1tI8j2L5HddJ0nYqqZa4dYQ=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-11.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-11.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-11.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-11.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-11.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-11, ha sido aceptada\"}}', '2026-06-20 18:20:34', '2026-06-20 18:20:35', '2026-06-20 18:20:35', 1, '2026-06-20 18:20:34'),
(15, 26, 'boleta', 'B001', 12, 'B001-000012', '0y4g2dkdNBdQ9TshmF1F+6iwtWQ=', 'Gravada (0101)', 271.18, 48.82, 320.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-12.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-12.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-12.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-12.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-12.XML', 'aceptado', '0', 'La Boleta numero B001-12, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"0y4g2dkdNBdQ9TshmF1F+6iwtWQ=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-12.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-12.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-12.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-12.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-12.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-12, ha sido aceptada\"}}', '2026-06-20 18:21:23', '2026-06-20 18:21:24', '2026-06-20 18:21:24', 1, '2026-06-20 18:21:23'),
(16, 31, 'boleta', 'B001', 13, 'B001-000013', 'JUBDbSzsRvLY9BmAesqggR8HQM4=', 'Gravada (0101)', 283.89, 51.11, 335.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-13.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-13.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-13.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-13.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-13.XML', 'aceptado', '0', 'La Boleta numero B001-13, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"JUBDbSzsRvLY9BmAesqggR8HQM4=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-13.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-13.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-13.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-13.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-13.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-13, ha sido aceptada\"}}', '2026-06-20 18:43:42', '2026-06-20 18:43:43', '2026-06-20 18:43:43', 4, '2026-06-20 18:43:42'),
(17, 33, 'boleta', 'B001', 14, 'B001-000014', 'WMsSGoVCFu19cNqlkMY0zBSlIME=', 'Gravada (0101)', 262.71, 47.29, 310.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-14.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-14.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-14.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-14.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-14.XML', 'aceptado', '0', 'La Boleta numero B001-14, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"WMsSGoVCFu19cNqlkMY0zBSlIME=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-14.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-14.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-14.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-14.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-14.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-14, ha sido aceptada\"}}', '2026-06-21 23:52:39', '2026-06-21 23:52:40', '2026-06-21 23:52:40', 1, '2026-06-21 23:52:39'),
(18, 34, 'boleta', 'B001', 15, 'B001-000015', 'zMF49/exgcMVII9omCd6ikAYbk8=', 'Gravada (0101)', 262.71, 47.29, 310.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-15.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-15.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-15.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-15.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-15.XML', 'aceptado', '0', 'La Boleta numero B001-15, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"zMF49/exgcMVII9omCd6ikAYbk8=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-15.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-15.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-15.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-15.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-15.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-15, ha sido aceptada\"}}', '2026-06-23 10:51:43', '2026-06-23 10:51:44', '2026-06-23 10:51:44', 1, '2026-06-23 10:51:43'),
(19, 35, 'boleta', 'B001', 16, 'B001-000016', 'DZF6W4QUkmRAWqUSxB/sz9GbzVg=', 'Gravada (0101)', 2436.45, 438.55, 2875.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-16.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-16.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-16.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-16.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-16.XML', 'aceptado', '0', 'La Boleta numero B001-16, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"DZF6W4QUkmRAWqUSxB/sz9GbzVg=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-16.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-16.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-16.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-16.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-16.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-16, ha sido aceptada\"}}', '2026-06-24 21:17:23', '2026-06-24 21:17:24', '2026-06-24 21:17:24', 2, '2026-06-24 21:17:23'),
(20, 32, 'boleta', 'B001', 17, 'B001-000017', 'X7WG4Xz/bYhewlul2/zgexHYozQ=', 'Gravada (0101)', 283.89, 51.11, 335.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-17.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-17.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-17.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-17.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-17.XML', 'aceptado', '0', 'La Boleta numero B001-17, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"X7WG4Xz/bYhewlul2/zgexHYozQ=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-17.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-17.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-17.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-17.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-17.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-17, ha sido aceptada\"}}', '2026-06-27 12:17:48', '2026-06-27 12:17:49', '2026-06-27 12:17:49', 1, '2026-06-27 12:17:48'),
(21, 46, 'boleta', 'B001', 18, 'B001-000018', 'lMMguUge+FyXkKgclY26DR9RiJ0=', 'Gravada (0101)', 25.42, 4.58, 30.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-18.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-18.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-18.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-18.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-18.XML', 'aceptado', '0', 'La Boleta numero B001-18, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"lMMguUge+FyXkKgclY26DR9RiJ0=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-18.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-18.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-18.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-18.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-18.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-18, ha sido aceptada\"}}', '2026-07-03 12:18:16', '2026-07-03 12:18:17', '2026-07-03 12:18:17', 1, '2026-07-03 12:18:16'),
(22, 47, 'boleta', 'B001', 19, 'B001-000019', 'ZI/PjCvOED4kmSHvT9Ej8i2pkmw=', 'Gravada (0101)', 8.47, 1.53, 10.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-19.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-19.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-19.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-19.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-19.XML', 'aceptado', '0', 'La Boleta numero B001-19, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"ZI/PjCvOED4kmSHvT9Ej8i2pkmw=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-19.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-19.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-19.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-19.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-19.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-19, ha sido aceptada\"}}', '2026-07-16 17:48:00', '2026-07-16 17:48:01', '2026-07-16 17:48:01', 1, '2026-07-16 17:48:00'),
(23, 50, 'boleta', 'B001', 20, 'B001-000020', 'l4SnzkxC4gLiD/PaUcDlIuDp7zc=', 'Gravada (0101)', 262.71, 47.29, 310.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-20.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-20.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-20.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-20.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-20.XML', 'aceptado', '0', 'La Boleta numero B001-20, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"l4SnzkxC4gLiD/PaUcDlIuDp7zc=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-03-B001-20.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-03-B001-20.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-03-B001-20.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-03-B001-20.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-03-B001-20.XML\",\"code\":\"0\",\"mensaje\":\"La Boleta numero B001-20, ha sido aceptada\"}}', '2026-07-16 19:01:09', '2026-07-16 19:01:10', '2026-07-16 19:01:10', 1, '2026-07-16 19:01:09'),
(24, 14, 'factura', 'F001', 4, 'F001-000004', 'ysfY/PBKOTuW6CFuiN2ivcpcYG8=', 'Gravada (0101)', 8.48, 1.52, 10.00, 'https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-4.XML', 'https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-4.XML', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-4.pdf', 'https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-4.pdf', 'https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-4.XML', 'aceptado', '0', 'La Factura numero F001-4, ha sido aceptada', NULL, NULL, 'aceptado', '{\"respuesta\":{\"success\":true,\"status\":200,\"hash\":\"ysfY/PBKOTuW6CFuiN2ivcpcYG8=\",\"xml-sin-firmar\":\"https://miapi.cloud/apifact/documents/xml/20607518751/unsigned/20607518751-01-F001-4.XML\",\"xml-firmado\":\"https://miapi.cloud/apifact/documents/xml/20607518751/signed/20607518751-01-F001-4.XML\",\"pdf-a4\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/a4/20607518751-01-F001-4.pdf\",\"pdf-ticket\":\"https://miapi.cloud/apifact/documents/pdf/20607518751/invoice/ticket/20607518751-01-F001-4.pdf\",\"cdr\":\"https://miapi.cloud/apifact/documents/cdr/20607518751/R-20607518751-01-F001-4.XML\",\"code\":\"0\",\"mensaje\":\"La Factura numero F001-4, ha sido aceptada\"}}', '2026-07-18 21:22:25', '2026-07-18 21:22:29', '2026-07-18 21:22:29', 1, '2026-07-18 21:22:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunicaciones_baja`
--

CREATE TABLE `comunicaciones_baja` (
  `id` int(11) NOT NULL,
  `tipo` varchar(5) NOT NULL DEFAULT 'RA' COMMENT 'RA=baja de facturas',
  `identificador` varchar(20) NOT NULL,
  `correlativo` int(11) NOT NULL DEFAULT 1,
  `fecha_referencia` date NOT NULL COMMENT 'Fecha del comprobante a dar de baja',
  `fecha_envio` date NOT NULL,
  `ticket` varchar(100) DEFAULT NULL,
  `estado_sunat` enum('pendiente','enviado','aceptado','rechazado') DEFAULT 'pendiente',
  `cdr_mensaje` varchar(500) DEFAULT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunicacion_baja_items`
--

CREATE TABLE `comunicacion_baja_items` (
  `id` int(11) NOT NULL,
  `baja_id` int(11) NOT NULL,
  `comprobante_id` int(11) DEFAULT NULL,
  `tipo_doc` varchar(2) NOT NULL COMMENT '01=factura',
  `serie` varchar(10) NOT NULL,
  `correlativo` varchar(20) NOT NULL,
  `motivo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `clave` varchar(100) NOT NULL,
  `valor` text NOT NULL DEFAULT '',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `grupo` varchar(50) NOT NULL DEFAULT 'general'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`clave`, `valor`, `updated_at`, `grupo`) VALUES
('app_url', '', '2026-07-08 20:24:09', 'sistema'),
('delivery_activo', 'true', '2026-05-30 00:38:44', 'ecommerce'),
('document_link_hours', '168', '2026-07-08 20:24:09', 'sistema'),
('ecommerce_activo', 'true', '2026-05-30 00:38:44', 'ecommerce'),
('ecommerce_sucursal_central_id', '1', '2026-07-08 20:24:09', 'ecommerce'),
('ecommerce_whatsapp', '', '2026-05-30 00:38:44', 'ecommerce'),
('email_empresa', '', '2026-05-30 00:38:44', 'empresa'),
('empresa_direccion', '', '2026-06-27 20:59:23', 'empresa'),
('empresa_email', '', '2026-06-27 20:59:23', 'empresa'),
('empresa_nombre', 'DISTRIBUCIONES MAOZ E.I.R.L', '2026-06-30 10:00:50', 'empresa'),
('empresa_ruc', '20607518751', '2026-06-30 10:01:14', 'empresa'),
('empresa_telefono', '', '2026-06-27 20:59:23', 'empresa'),
('igv_porcentaje', '18', '2026-05-30 14:32:45', 'facturacion'),
('mail_from_name', 'Distribuciones MAOZ', '2026-06-06 04:10:41', 'correo'),
('mail_host', 'smtp.gmail.com', '2026-05-30 00:38:44', 'correo'),
('mail_pass', '', '2026-06-16 12:52:16', 'correo'),
('mail_port', '587', '2026-06-27 14:54:16', 'correo'),
('mail_user', 'antonycamposgarnique@gmail.com', '2026-06-27 14:30:20', 'correo'),
('miapi_token', '', '2026-06-27 17:25:23', 'facturacion'),
('miapi_url', 'https://miapi.cloud', '2026-06-06 02:11:29', 'facturacion'),
('moneda', 'PEN', '2026-05-30 00:38:44', 'facturacion'),
('plin_numero', '99988877', '2026-05-30 00:38:44', 'pagos'),
('plin_qr_ruta', '/media/pagos/1784315454472-2553827a51f15f8aa21265ad.webp', '2026-07-17 14:10:54', 'pagos'),
('public_url', '', '2026-07-08 20:24:09', 'sistema'),
('recojo_activo', 'true', '2026-05-30 00:38:44', 'ecommerce'),
('reserva_web_minutes', '30', '2026-07-08 20:24:09', 'ecommerce'),
('schema_version', '37', '2026-07-14 16:20:47', 'sistema'),
('serie_boleta', 'B001', '2026-05-30 14:32:45', 'facturacion'),
('serie_factura', 'F001', '2026-05-30 14:32:45', 'facturacion'),
('serie_nota', 'NV01', '2026-05-30 14:32:45', 'facturacion'),
('session_lock_minutes', '20', '2026-07-08 20:24:09', 'seguridad'),
('session_max_hours', '8', '2026-07-08 20:24:09', 'seguridad'),
('sunat_clave_secreta', '', '2026-06-06 02:11:29', 'facturacion'),
('sunat_modo', 'beta', '2026-06-06 02:11:29', 'facturacion'),
('sunat_razon_social', 'DISTRIBUCIONES MAOZ E.I.R.L.', '2026-06-06 02:11:29', 'facturacion'),
('sunat_ruc_emisor', '20607510751', '2026-06-06 02:11:29', 'facturacion'),
('tienda_descripcion', 'Tu tienda de mascotas de confianza', '2026-07-01 21:36:07', 'ecommerce'),
('tienda_direccion', '', '2026-07-01 21:36:07', 'ecommerce'),
('tienda_facebook', '', '2026-07-01 21:36:07', 'ecommerce'),
('tienda_horario', 'Lun-Sab 9:00 - 20:00', '2026-07-01 21:36:07', 'ecommerce'),
('tienda_instagram', '', '2026-07-01 21:36:07', 'ecommerce'),
('tienda_nombre', 'Mundo Pet', '2026-07-01 21:36:07', 'ecommerce'),
('transferencia_banco', '', '2026-05-30 00:38:44', 'pagos'),
('transferencia_cci', '', '2026-05-30 00:38:44', 'pagos'),
('transferencia_cuenta', '', '2026-05-30 00:38:44', 'pagos'),
('transferencia_titular', '', '2026-05-30 00:38:44', 'pagos'),
('yape_numero', '999888777', '2026-05-30 00:38:44', 'pagos'),
('yape_qr_ruta', '/media/pagos/1784315448078-2b3807b5fa8c7daf7b5ffd04.webp', '2026-07-17 14:10:48', 'pagos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correlativos_comprobante`
--

CREATE TABLE `correlativos_comprobante` (
  `serie` varchar(10) NOT NULL,
  `ultimo_numero` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `correlativos_comprobante`
--

INSERT INTO `correlativos_comprobante` (`serie`, `ultimo_numero`, `updated_at`) VALUES
('B001', 18, '2026-07-06 22:52:51'),
('F001', 3, '2026-07-06 22:52:51'),
('NV01', 42, '2026-07-06 22:52:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `sucursal_id` int(11) NOT NULL DEFAULT 1,
  `vendedor_id` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `igv` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `observacion` text DEFAULT '',
  `estado` varchar(20) NOT NULL DEFAULT 'vigente',
  `vence_at` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cotizaciones`
--

INSERT INTO `cotizaciones` (`id`, `cliente_id`, `sucursal_id`, `vendedor_id`, `subtotal`, `descuento`, `igv`, `total`, `observacion`, `estado`, `vence_at`, `created_at`) VALUES
(1, 6, 1, 1, 238.00, 0.00, 0.00, 238.00, '', 'eliminada', '2026-06-16', '2026-06-09 02:20:36'),
(2, NULL, 1, 1, 45.00, 0.00, 0.00, 45.00, '', 'eliminada', '2026-06-16', '2026-06-09 16:50:24'),
(3, NULL, 1, 1, 5.00, 0.00, 0.00, 5.00, '', 'eliminada', '2026-06-26', '2026-06-15 10:42:53'),
(4, 13, 1, 1, 335.00, 0.00, 0.00, 335.00, '', 'vigente', '2026-06-22', '2026-06-15 11:44:22'),
(5, 16, 1, 4, 310.00, 0.00, 0.00, 310.00, '', 'vigente', '2026-07-20', '2026-06-20 18:45:29'),
(6, NULL, 1, 1, 400.00, 0.00, 0.00, 400.00, '', 'vigente', '2026-07-01', '2026-06-24 22:16:23'),
(7, NULL, 1, 1, 4000.00, 0.00, 0.00, 4000.00, '', 'eliminada', '2026-07-01', '2026-06-24 22:18:32'),
(8, NULL, 1, 1, 4000.00, 0.00, 0.00, 4000.00, '', 'vigente', '2026-07-01', '2026-06-24 22:19:57'),
(9, NULL, 1, 1, 50.00, 0.00, 0.00, 50.00, '', 'vigente', '2026-07-01', '2026-06-24 22:20:22'),
(10, NULL, 1, 1, 4000.00, 0.00, 0.00, 4000.00, '', 'vigente', '2026-07-01', '2026-06-24 22:31:50'),
(11, 16, 1, 1, 363.00, 0.00, 0.00, 363.00, '', 'vigente', '2026-07-10', '2026-06-25 10:50:06'),
(12, NULL, 1, 1, 35.00, 0.00, 0.00, 35.00, '', 'vigente', '2026-07-04', '2026-06-27 15:23:54'),
(13, NULL, 1, 1, 10.00, 0.00, 0.00, 10.00, '', 'vigente', '2026-07-04', '2026-06-27 20:03:58'),
(14, NULL, 1, 1, 30.00, 0.00, 0.00, 30.00, '', 'vigente', '2026-07-16', '2026-07-01 14:25:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion_items`
--

CREATE TABLE `cotizacion_items` (
  `id` int(11) NOT NULL,
  `cotizacion_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizacion_items`
--

INSERT INTO `cotizacion_items` (`id`, `cotizacion_id`, `producto_id`, `presentacion_id`, `cantidad`, `precio_unit`, `subtotal`) VALUES
(1, 1, 5, NULL, 1, 5.00, 5.00),
(2, 1, 2, NULL, 1, 220.00, 220.00),
(3, 1, 6, NULL, 1, 10.00, 10.00),
(4, 1, 7, NULL, 1, 3.00, 3.00),
(5, 2, 3, NULL, 1, 25.00, 25.00),
(6, 2, 4, NULL, 1, 15.00, 15.00),
(7, 2, 5, NULL, 1, 5.00, 5.00),
(8, 3, 8, NULL, 1, 5.00, 5.00),
(9, 4, 6, NULL, 1, 10.00, 10.00),
(10, 4, 5, NULL, 1, 5.00, 5.00),
(11, 4, 1, NULL, 1, 65.00, 65.00),
(12, 4, 2, NULL, 1, 220.00, 220.00),
(13, 4, 8, NULL, 1, 5.00, 5.00),
(14, 4, 4, NULL, 1, 15.00, 15.00),
(15, 4, 7, NULL, 5, 3.00, 15.00),
(16, 5, 1, NULL, 1, 65.00, 65.00),
(17, 5, 2, NULL, 1, 220.00, 220.00),
(18, 5, 3, NULL, 1, 25.00, 25.00),
(19, 6, 1, NULL, 10, 40.00, 400.00),
(20, 7, 1, NULL, 100, 40.00, 4000.00),
(21, 8, 1, NULL, 100, 40.00, 4000.00),
(22, 9, 1, NULL, 1, 50.00, 50.00),
(23, 10, 1, NULL, 100, 40.00, 4000.00),
(24, 11, 12, NULL, 1, 18.00, 18.00),
(25, 11, 4, NULL, 1, 15.00, 15.00),
(26, 11, 5, NULL, 1, 5.00, 5.00),
(27, 11, 1, NULL, 1, 50.00, 50.00),
(28, 11, 3, NULL, 1, 25.00, 25.00),
(29, 11, 7, NULL, 1, 3.00, 3.00),
(30, 11, 2, NULL, 1, 220.00, 220.00),
(31, 11, 8, NULL, 1, 5.00, 5.00),
(32, 11, 11, NULL, 1, 12.00, 12.00),
(33, 11, 6, NULL, 1, 10.00, 10.00),
(34, 12, 6, NULL, 1, 10.00, 10.00),
(35, 12, 4, NULL, 1, 15.00, 15.00),
(36, 12, 5, NULL, 1, 5.00, 5.00),
(37, 12, 8, NULL, 1, 5.00, 5.00),
(38, 13, 6, NULL, 1, 10.00, 10.00),
(39, 14, 6, NULL, 1, 10.00, 10.00),
(40, 14, 8, NULL, 1, 5.00, 5.00),
(41, 14, 4, NULL, 1, 15.00, 15.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `creditos`
--

CREATE TABLE `creditos` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `pagado` decimal(10,2) NOT NULL DEFAULT 0.00,
  `saldo` decimal(10,2) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `crm_cliente_etiquetas`
--

CREATE TABLE `crm_cliente_etiquetas` (
  `cliente_id` int(11) NOT NULL,
  `etiqueta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `crm_etiquetas`
--

CREATE TABLE `crm_etiquetas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#0EA5E9',
  `sucursal_id` int(11) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `crm_interacciones`
--

CREATE TABLE `crm_interacciones` (
  `id` bigint(20) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `tipo` enum('llamada','whatsapp','correo','visita','nota') NOT NULL DEFAULT 'nota',
  `asunto` varchar(180) NOT NULL,
  `detalle` text NOT NULL,
  `resultado` varchar(180) NOT NULL DEFAULT '',
  `proximo_contacto_at` datetime DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `crm_tareas`
--

CREATE TABLE `crm_tareas` (
  `id` bigint(20) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `titulo` varchar(180) NOT NULL,
  `descripcion` text NOT NULL,
  `prioridad` enum('baja','media','alta') NOT NULL DEFAULT 'media',
  `estado` enum('pendiente','completada','cancelada') NOT NULL DEFAULT 'pendiente',
  `vence_at` datetime DEFAULT NULL,
  `asignado_a` int(11) NOT NULL,
  `creado_por` int(11) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `completado_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_por_cobrar`
--

CREATE TABLE `cuentas_por_cobrar` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL DEFAULT 1,
  `monto_total` decimal(10,2) NOT NULL,
  `monto_pagado` decimal(10,2) DEFAULT 0.00,
  `monto_pendiente` decimal(10,2) NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` enum('pendiente','parcial','pagado','vencido') DEFAULT 'pendiente',
  `observacion` text DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotas`
--

CREATE TABLE `cuotas` (
  `id` int(11) NOT NULL,
  `credito_id` int(11) NOT NULL,
  `nro_cuota` int(11) NOT NULL,
  `fecha_vence` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `pagado` decimal(10,2) NOT NULL DEFAULT 0.00,
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `despachos_web`
--

CREATE TABLE `despachos_web` (
  `id` int(11) NOT NULL,
  `pedido_web_id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `modalidad` enum('recojo','delivery') NOT NULL DEFAULT 'recojo',
  `estado` varchar(35) NOT NULL DEFAULT 'pendiente_verificacion',
  `codigo_entrega` varchar(30) NOT NULL,
  `contacto_nombre` varchar(200) DEFAULT '',
  `telefono` varchar(30) DEFAULT '',
  `direccion` text DEFAULT '',
  `responsable_reparto` varchar(150) DEFAULT '',
  `usuario_preparacion_id` int(11) DEFAULT NULL,
  `usuario_salida_id` int(11) DEFAULT NULL,
  `usuario_entrega_id` int(11) DEFAULT NULL,
  `fecha_preparacion` datetime DEFAULT NULL,
  `fecha_listo` datetime DEFAULT NULL,
  `fecha_en_camino` datetime DEFAULT NULL,
  `fecha_entregado` datetime DEFAULT NULL,
  `observacion` text DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_cotizaciones`
--

CREATE TABLE `detalle_cotizaciones` (
  `id` int(11) NOT NULL,
  `cotizacion_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedidos_web`
--

CREATE TABLE `detalle_pedidos_web` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direcciones_web`
--

CREATE TABLE `direcciones_web` (
  `id` int(11) NOT NULL,
  `cliente_web_id` int(11) NOT NULL,
  `alias` varchar(50) DEFAULT NULL,
  `direccion` text NOT NULL,
  `referencia` varchar(200) DEFAULT NULL,
  `distrito` varchar(100) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `departamento` varchar(100) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `es_principal` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos_publicos`
--

CREATE TABLE `documentos_publicos` (
  `id` bigint(20) NOT NULL,
  `tipo` enum('venta','cotizacion','comprobante') NOT NULL,
  `entidad_id` int(11) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `archivo_relativo` varchar(500) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_access_at` datetime DEFAULT NULL,
  `access_count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos_publicos`
--

INSERT INTO `documentos_publicos` (`id`, `tipo`, `entidad_id`, `token_hash`, `archivo_relativo`, `expires_at`, `revoked_at`, `created_by`, `created_at`, `last_access_at`, `access_count`) VALUES
(1, 'venta', 50, '9ad80965a883b8c53eafe33df0d93a00c082433c62ba7728a13c2ac2925758b0', 'NV01-000045.pdf', '2026-07-23 18:42:01', NULL, 1, '2026-07-16 18:42:01', '2026-07-16 18:42:14', 1),
(2, 'venta', 45, 'a7c927cc5f5fc942eee5df2f751c8e9367ab1a925c9d7a4f77adf850ea681f8f', 'NV01-000042.pdf', '2026-07-23 19:08:59', NULL, 1, '2026-07-16 19:08:59', '2026-07-16 19:09:11', 1),
(3, 'cotizacion', 14, 'd4a3ecf2ae246f625372a8c69304863211102e42190903aef98fd67298f602fb', 'COT-00014.pdf', '2026-07-23 19:10:32', NULL, 1, '2026-07-16 19:10:32', '2026-07-16 19:10:44', 1),
(4, 'venta', 45, '4be9f88722336045200e79bda5753c0c738dbd567a3694f28cd21e8696c4c901', 'NV01-000042.pdf', '2026-07-24 11:15:16', NULL, 1, '2026-07-17 11:15:16', NULL, 0),
(5, 'venta', 45, 'd2141550c62cc8c593527e0134865d9c775f1bb9332efe847be347209f0abced', 'NV01-000042.pdf', '2026-07-24 14:55:19', NULL, 1, '2026-07-17 14:55:19', '2026-07-17 14:55:36', 2),
(6, 'venta', 44, '8a03fb44e22e2fb20290575f2c9ca2ff97caed458912c7964e5e31d7803abe29', 'NV01-000041.pdf', '2026-07-24 23:28:29', NULL, 1, '2026-07-17 23:28:29', '2026-07-17 23:29:51', 1),
(7, 'venta', 57, '7df3d0a0cd4b3d66b147b67f4e7864950144dce194071f5b3d8df53a8d7ec525', 'NV01-000047.pdf', '2026-07-25 20:53:18', NULL, 1, '2026-07-18 20:53:18', '2026-07-18 20:53:24', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) NOT NULL,
  `almacen_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id`, `producto_id`, `presentacion_id`, `almacen_id`, `stock`) VALUES
(1, 1, 1, 1, 0),
(2, 2, 2, 1, 0),
(3, 3, 3, 1, 0),
(4, 4, 4, 2, 0),
(5, 5, 5, 2, 0),
(6, 6, 6, 2, 46),
(7, 7, 7, 2, 0),
(8, 8, 8, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_movimientos`
--

CREATE TABLE `inventario_movimientos` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `tipo` enum('SALIDA_VENTA','REPOSICION','AJUSTE_MANUAL','DEVOLUCION','ENTRADA','SALIDA','AJUSTE_ENTRADA','AJUSTE_SALIDA','INGRESO_INICIAL','TRANSFERENCIA_SALIDA','TRANSFERENCIA_ENTRADA','ANULACION') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `stock_antes` int(11) NOT NULL DEFAULT 0,
  `stock_despues` int(11) NOT NULL DEFAULT 0,
  `venta_id` int(11) DEFAULT NULL,
  `referencia` varchar(255) DEFAULT '',
  `precio_unit` decimal(10,2) DEFAULT 0.00,
  `usuario_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inventario_movimientos`
--

INSERT INTO `inventario_movimientos` (`id`, `producto_id`, `presentacion_id`, `sucursal_id`, `almacen_id`, `tipo`, `cantidad`, `stock_antes`, `stock_despues`, `venta_id`, `referencia`, `precio_unit`, `usuario_id`, `created_at`) VALUES
(1, 6, NULL, 2, NULL, 'AJUSTE_MANUAL', 50, 0, 50, NULL, 'gfsd', 0.00, 1, '2026-05-27 15:29:41'),
(2, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 50, 49, 1, 'Venta B001-000001', 10.00, 1, '2026-05-29 13:12:25'),
(3, 6, NULL, 2, NULL, 'DEVOLUCION', 1, 49, 50, 1, 'Anulación B001-000001', 10.00, 1, '2026-05-29 13:12:31'),
(4, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 50, 49, 2, 'Tienda web NV01-000001', 10.00, 1, '2026-05-29 13:12:59'),
(5, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 49, 48, 3, 'Tienda web NV01-000002', 10.00, 1, '2026-05-29 13:13:26'),
(6, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 48, 47, 4, 'Tienda web NV01-000003', 10.00, 1, '2026-05-29 13:13:33'),
(7, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 47, 46, 5, 'Tienda web NV01-000004', 10.00, 1, '2026-05-29 13:13:59'),
(8, 9, NULL, 1, NULL, '', 40, 0, 40, NULL, 'Stock inicial', 0.00, 1, '2026-05-30 18:38:33'),
(9, 6, NULL, 1, NULL, 'REPOSICION', 10, 46, 56, NULL, 'B001', 0.00, 1, '2026-05-30 22:37:48'),
(10, 6, NULL, 1, NULL, 'AJUSTE_MANUAL', 55, 56, 55, NULL, '9349843', 0.00, 1, '2026-05-30 22:38:11'),
(11, 1, NULL, 1, NULL, 'REPOSICION', 50, 0, 50, NULL, 'B001', 0.00, 2, '2026-05-30 22:42:44'),
(12, 6, NULL, 1, NULL, 'REPOSICION', 10, 55, 65, NULL, 'Reposición', 0.00, 1, '2026-05-30 23:01:01'),
(15, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 65, 64, NULL, 'B001-000002', 0.00, 1, '2026-05-31 00:09:22'),
(16, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 64, 63, NULL, 'NV01-000005', 0.00, 1, '2026-05-31 00:14:35'),
(17, 6, NULL, 1, NULL, '', 1, 63, 64, NULL, 'Anulación B001-000002', 0.00, 1, '2026-05-31 00:14:48'),
(18, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 64, 63, NULL, 'NV01-000006', 0.00, 1, '2026-05-31 00:16:09'),
(19, 6, NULL, 1, NULL, '', 1, 63, 64, NULL, 'Anulación NV01-000006', 0.00, 1, '2026-05-31 00:16:42'),
(20, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 64, 63, NULL, 'NV01-000007', 0.00, 1, '2026-05-31 00:22:17'),
(21, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 63, 62, NULL, 'NV01-000008', 0.00, 1, '2026-05-31 01:13:33'),
(22, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 50, 49, NULL, 'NV01-000008', 0.00, 1, '2026-05-31 01:13:33'),
(23, 6, NULL, NULL, NULL, 'AJUSTE_MANUAL', 1, 62, 61, NULL, 'asf | Ref: f32', 0.00, 1, '2026-06-01 00:38:07'),
(24, 6, NULL, NULL, NULL, '', 10, 61, 71, NULL, 'afs | Ref: B0012 | asf', 0.00, 1, '2026-06-01 00:38:19'),
(25, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 49, 48, NULL, 'NV01-000009', 0.00, 1, '2026-06-01 00:59:35'),
(27, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 48, 47, NULL, 'NV01-000010', 0.00, 1, '2026-06-01 01:01:21'),
(28, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 71, 70, NULL, 'NV01-000010', 0.00, 1, '2026-06-01 01:01:21'),
(29, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 70, 69, NULL, 'NV01-000011', 0.00, 1, '2026-06-01 01:09:14'),
(30, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 69, 68, NULL, 'NV01-000012', 0.00, 1, '2026-06-01 08:03:59'),
(31, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 47, 46, NULL, 'NV01-000012', 0.00, 1, '2026-06-01 08:03:59'),
(32, 6, NULL, 1, NULL, '', 1, 68, 69, NULL, 'Anulación NV01-000011', 0.00, 1, '2026-06-01 08:04:06'),
(33, 1, NULL, 1, NULL, '', 1, 46, 47, NULL, 'Anulación NV01-000010', 0.00, 1, '2026-06-01 08:04:10'),
(34, 6, NULL, 1, NULL, '', 1, 69, 70, NULL, 'Anulación NV01-000010', 0.00, 1, '2026-06-01 08:04:10'),
(35, 1, NULL, 1, NULL, '', 1, 47, 48, NULL, 'Anulación NV01-000009', 0.00, 1, '2026-06-01 08:04:14'),
(38, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 70, 69, NULL, 'NV01-000013', 0.00, 1, '2026-06-01 10:12:50'),
(43, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 48, 47, NULL, 'NV01-000014', 0.00, 1, '2026-06-03 20:40:02'),
(44, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 69, 68, NULL, 'NV01-000014', 0.00, 1, '2026-06-03 20:40:02'),
(45, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 47, 46, NULL, 'NV01-000015', 0.00, 1, '2026-06-05 13:20:51'),
(46, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 68, 67, NULL, 'NV01-000015', 0.00, 1, '2026-06-05 13:20:51'),
(47, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 67, 66, NULL, 'NV01-000016', 0.00, 1, '2026-06-05 13:24:48'),
(48, 6, NULL, 1, NULL, '', 1, 66, 67, NULL, 'Anulación NV01-000016', 0.00, 1, '2026-06-05 13:25:31'),
(49, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 67, 66, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 02:57:07'),
(50, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 46, 45, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 03:09:09'),
(51, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 66, 65, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 03:09:09'),
(52, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 65, 64, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 03:10:24'),
(53, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 45, 44, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 03:10:24'),
(54, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 64, 63, NULL, 'NV01-000004', 0.00, 1, '2026-06-06 03:16:32'),
(55, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 63, 62, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 03:25:37'),
(56, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 44, 43, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 03:25:37'),
(57, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 62, 61, NULL, 'NV01-000006', 0.00, 1, '2026-06-06 03:45:20'),
(58, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 43, 42, NULL, 'NV01-000006', 0.00, 1, '2026-06-06 03:45:20'),
(59, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 61, 60, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 03:55:53'),
(60, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 42, 41, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 03:55:53'),
(61, 6, NULL, 1, NULL, 'SALIDA_VENTA', 3, 60, 57, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 03:59:15'),
(62, 1, NULL, 1, NULL, 'SALIDA_VENTA', 5, 41, 36, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 03:59:15'),
(63, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 57, 56, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 04:40:39'),
(64, 1, NULL, 1, NULL, 'SALIDA_VENTA', 6, 36, 30, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 04:40:39'),
(65, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 56, 55, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 10:09:30'),
(66, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 30, 29, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 10:09:30'),
(67, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 55, 54, NULL, 'NV01-000004', 0.00, 1, '2026-06-06 11:09:40'),
(68, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 29, 28, NULL, 'NV01-000004', 0.00, 1, '2026-06-06 11:09:40'),
(69, 6, NULL, 1, NULL, 'SALIDA_VENTA', 4, 54, 50, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 11:48:22'),
(70, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 50, 49, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 13:57:25'),
(71, 6, NULL, 1, NULL, 'SALIDA_VENTA', 7, 49, 42, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 14:14:58'),
(72, 6, NULL, 1, NULL, 'SALIDA_VENTA', 5, 42, 37, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 14:15:55'),
(73, 1, NULL, 1, NULL, 'SALIDA_VENTA', 6, 28, 22, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 14:15:55'),
(74, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 37, 36, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 17:02:07'),
(75, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 22, 21, NULL, 'NV01-000001', 0.00, 1, '2026-06-06 17:02:07'),
(76, 6, NULL, 1, NULL, 'SALIDA_VENTA', 3, 36, 33, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 18:43:21'),
(77, 1, NULL, 1, NULL, 'SALIDA_VENTA', 3, 21, 18, NULL, 'NV01-000002', 0.00, 1, '2026-06-06 18:43:21'),
(78, 6, NULL, 1, NULL, 'SALIDA_VENTA', 4, 33, 29, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 19:03:35'),
(79, 1, NULL, 1, NULL, 'SALIDA_VENTA', 5, 18, 13, NULL, 'NV01-000003', 0.00, 1, '2026-06-06 19:03:35'),
(80, 6, NULL, 1, NULL, 'SALIDA_VENTA', 4, 29, 25, NULL, 'NV01-000004', 0.00, 1, '2026-06-06 19:35:14'),
(81, 1, NULL, 1, NULL, 'SALIDA_VENTA', 5, 13, 8, NULL, 'NV01-000004', 0.00, 1, '2026-06-06 19:35:14'),
(82, 4, NULL, NULL, NULL, 'AJUSTE_MANUAL', 30, 0, 30, NULL, '.. | Ref: F-013', 0.00, 1, '2026-06-06 19:45:47'),
(83, 4, NULL, NULL, NULL, '', 40, 30, 70, NULL, '..', 0.00, 1, '2026-06-06 19:46:00'),
(84, 8, NULL, NULL, NULL, '', 40, 0, 40, NULL, '..', 0.00, 1, '2026-06-06 19:46:08'),
(85, 5, NULL, NULL, NULL, '', 301, 0, 301, NULL, '..', 0.00, 1, '2026-06-06 19:46:18'),
(86, 8, NULL, NULL, NULL, '', 139, 40, 179, NULL, '..', 0.00, 1, '2026-06-06 19:46:25'),
(87, 1, NULL, NULL, NULL, '', 10, 8, 18, NULL, '..', 0.00, 1, '2026-06-06 19:46:35'),
(88, 2, NULL, NULL, NULL, '', 100, 0, 100, NULL, '..', 0.00, 1, '2026-06-06 19:46:41'),
(89, 3, NULL, NULL, NULL, '', 100, 0, 100, NULL, '..', 0.00, 1, '2026-06-06 19:46:47'),
(90, 7, NULL, NULL, NULL, '', 1000, 0, 1000, NULL, '..', 0.00, 1, '2026-06-06 19:46:55'),
(91, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 301, 300, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(92, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 18, 17, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(93, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 179, 178, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(94, 4, NULL, 1, NULL, 'SALIDA_VENTA', 2, 70, 68, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(95, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1000, 999, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(96, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 100, 99, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(97, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 100, 99, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(98, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 25, 24, NULL, 'NV01-000005', 0.00, 1, '2026-06-06 19:47:34'),
(99, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 300, 299, NULL, 'NV01-000006', 0.00, 1, '2026-06-07 00:22:07'),
(100, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 99, 98, NULL, 'NV01-000006', 0.00, 1, '2026-06-07 00:22:07'),
(101, 5, NULL, 1, NULL, '', 1, 299, 300, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(102, 1, NULL, 1, NULL, '', 1, 17, 18, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(103, 8, NULL, 1, NULL, '', 1, 178, 179, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(104, 4, NULL, 1, NULL, '', 2, 68, 70, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(105, 7, NULL, 1, NULL, '', 1, 999, 1000, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(106, 2, NULL, 1, NULL, '', 1, 98, 99, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(107, 3, NULL, 1, NULL, '', 1, 99, 100, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(108, 6, NULL, 1, NULL, '', 1, 24, 25, NULL, 'Anulación NV01-000005', 0.00, 1, '2026-06-07 00:28:10'),
(109, 5, NULL, 1, NULL, 'SALIDA_VENTA', 2, 300, 298, NULL, 'NV01-000007', 0.00, 1, '2026-06-07 00:49:08'),
(110, 8, NULL, 1, NULL, 'SALIDA_VENTA', 2, 179, 177, NULL, 'NV01-000007', 0.00, 1, '2026-06-07 00:49:08'),
(111, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 100, 99, NULL, 'NV01-000007', 0.00, 1, '2026-06-07 00:49:08'),
(112, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1000, 999, NULL, 'NV01-000007', 0.00, 1, '2026-06-07 00:49:08'),
(113, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 18, 17, NULL, 'NV01-000007', 0.00, 1, '2026-06-07 00:49:08'),
(114, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 99, 98, NULL, 'NV01-000007', 0.00, 1, '2026-06-07 00:49:08'),
(115, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 25, 24, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 15:53:25'),
(116, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 98, 97, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 15:53:25'),
(117, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 99, 98, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 15:53:25'),
(118, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 999, 998, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 15:53:25'),
(119, 1, NULL, 1, NULL, 'SALIDA_VENTA', 2, 17, 15, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(120, 2, NULL, 1, NULL, 'SALIDA_VENTA', 3, 97, 94, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(121, 6, NULL, 1, NULL, 'SALIDA_VENTA', 2, 24, 22, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(122, 3, NULL, 1, NULL, 'SALIDA_VENTA', 4, 98, 94, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(123, 7, NULL, 1, NULL, 'SALIDA_VENTA', 2, 998, 996, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(124, 5, NULL, 1, NULL, 'SALIDA_VENTA', 2, 298, 296, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(125, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 177, 176, NULL, 'NV01-000001', 0.00, 1, '2026-06-07 16:57:09'),
(126, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 296, 295, NULL, 'NV01-000002', 0.00, 1, '2026-06-08 09:14:46'),
(127, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 176, 175, NULL, 'NV01-000002', 0.00, 1, '2026-06-08 09:14:46'),
(128, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 22, 21, NULL, 'NV01-000002', 0.00, 1, '2026-06-08 09:14:46'),
(129, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 70, 69, NULL, 'NV01-000002', 0.00, 1, '2026-06-08 09:14:46'),
(130, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 94, 93, NULL, 'NV01-000002', 0.00, 1, '2026-06-08 09:14:46'),
(131, 5, NULL, 2, NULL, 'SALIDA_VENTA', 1, 295, 294, NULL, 'NV01-000003', 0.00, 3, '2026-06-08 09:23:59'),
(132, 4, NULL, 2, NULL, 'SALIDA_VENTA', 1, 69, 68, NULL, 'NV01-000003', 0.00, 3, '2026-06-08 09:23:59'),
(133, 7, NULL, 2, NULL, 'SALIDA_VENTA', 1, 996, 995, NULL, 'NV01-000003', 0.00, 3, '2026-06-08 09:23:59'),
(134, 5, NULL, 2, NULL, 'SALIDA_VENTA', 1, 294, 293, NULL, 'NV01-000004', 0.00, 3, '2026-06-08 09:30:36'),
(135, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 21, 20, NULL, 'NV01-000004', 0.00, 3, '2026-06-08 09:30:36'),
(136, 8, NULL, 2, NULL, 'SALIDA_VENTA', 1, 175, 174, NULL, 'NV01-000004', 0.00, 3, '2026-06-08 09:30:36'),
(137, 4, NULL, 2, NULL, 'SALIDA_VENTA', 1, 68, 67, NULL, 'NV01-000004', 0.00, 3, '2026-06-08 09:30:36'),
(138, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 293, 292, NULL, 'NV01-000005', 0.00, 1, '2026-06-08 09:58:54'),
(139, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 67, 66, NULL, 'NV01-000005', 0.00, 1, '2026-06-08 09:58:54'),
(140, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 20, 19, NULL, 'NV01-000005', 0.00, 1, '2026-06-08 09:58:54'),
(141, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 995, 994, NULL, 'NV01-000005', 0.00, 1, '2026-06-08 09:58:54'),
(142, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 94, 93, NULL, 'NV01-000006', 0.00, 1, '2026-06-08 14:04:29'),
(143, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 19, 18, NULL, 'NV01-000006', 0.00, 1, '2026-06-08 14:04:29'),
(144, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 994, 993, NULL, 'NV01-000006', 0.00, 1, '2026-06-08 14:04:29'),
(145, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 93, 92, NULL, 'NV01-000006', 0.00, 1, '2026-06-08 14:04:29'),
(146, 6, NULL, NULL, NULL, 'AJUSTE_MANUAL', 18, 18, 0, NULL, 'motivo de testing', 0.00, 1, '2026-06-08 23:27:10'),
(147, 6, NULL, NULL, NULL, 'AJUSTE_MANUAL', 1, 0, 1, NULL, 'testing', 0.00, 1, '2026-06-08 23:27:34'),
(148, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1, 0, NULL, 'NV01-000007', 0.00, 1, '2026-06-08 23:27:54'),
(149, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 174, 173, NULL, 'NV01-000008', 0.00, 1, '2026-06-08 23:29:31'),
(150, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 292, 291, NULL, 'NV01-000009', 0.00, 1, '2026-06-08 23:34:46'),
(151, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 173, 172, NULL, 'NV01-000010', 0.00, 1, '2026-06-08 23:38:31'),
(152, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 15, 14, NULL, 'NV01-000011', 0.00, 2, '2026-06-09 00:33:25'),
(153, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 93, 92, NULL, 'NV01-000011', 0.00, 2, '2026-06-09 00:33:25'),
(154, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 92, 91, NULL, 'NV01-000011', 0.00, 2, '2026-06-09 00:33:25'),
(155, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 14, 13, NULL, 'NV01-000012', 0.00, 1, '2026-06-09 00:55:47'),
(156, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 172, 171, NULL, 'NV01-000012', 0.00, 1, '2026-06-09 00:55:47'),
(157, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 993, 992, NULL, 'NV01-000012', 0.00, 1, '2026-06-09 00:55:47'),
(158, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 66, 65, NULL, 'NV01-000013', 0.00, 1, '2026-06-09 12:01:27'),
(159, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 291, 290, NULL, 'NV01-000013', 0.00, 1, '2026-06-09 12:01:27'),
(160, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 92, 91, NULL, 'NV01-000013', 0.00, 1, '2026-06-09 12:01:27'),
(161, 6, NULL, NULL, NULL, '', 50, 0, 50, NULL, 'mercaderia | Ref: B0013 | ..', 0.00, 1, '2026-06-09 12:05:51'),
(162, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 290, 289, NULL, 'NV01-000014', 0.00, 1, '2026-06-09 12:09:43'),
(163, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 171, 170, NULL, 'NV01-000014', 0.00, 1, '2026-06-09 12:09:43'),
(164, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 50, 49, NULL, 'NV01-000015', 0.00, 1, '2026-06-15 08:41:37'),
(165, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 65, 64, NULL, 'NV01-000015', 0.00, 1, '2026-06-15 08:41:37'),
(166, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 13, 12, NULL, 'NV01-000015', 0.00, 1, '2026-06-15 08:41:37'),
(167, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 91, 90, NULL, 'NV01-000015', 0.00, 1, '2026-06-15 08:41:37'),
(168, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 170, 169, NULL, 'NV01-000015', 0.00, 1, '2026-06-15 08:41:37'),
(169, 7, NULL, 1, NULL, 'SALIDA_VENTA', 2, 992, 990, NULL, 'NV01-000015', 0.00, 1, '2026-06-15 08:41:37'),
(170, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 64, 63, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(171, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 49, 48, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(172, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 12, 11, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(173, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 289, 288, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(174, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 90, 89, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(175, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 990, 989, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(176, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 91, 90, NULL, 'NV01-000016', 0.00, 1, '2026-06-16 11:39:31'),
(177, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 48, 47, NULL, 'NV01-000017', 0.00, 1, '2026-06-16 12:28:24'),
(178, 5, NULL, 1, NULL, 'SALIDA_VENTA', 2, 288, 286, NULL, 'NV01-000018', 0.00, 1, '2026-06-16 12:54:47'),
(179, 2, NULL, 1, NULL, 'SALIDA_VENTA', 2, 90, 88, NULL, 'NV01-000018', 0.00, 1, '2026-06-16 12:54:47'),
(180, 6, NULL, 1, NULL, 'SALIDA_VENTA', 2, 47, 45, NULL, 'NV01-000018', 0.00, 1, '2026-06-16 12:54:47'),
(181, 7, NULL, 1, NULL, 'SALIDA_VENTA', 2, 989, 987, NULL, 'NV01-000018', 0.00, 1, '2026-06-16 12:54:47'),
(182, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 63, 62, NULL, 'NV01-000018', 0.00, 1, '2026-06-16 12:54:47'),
(183, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 45, 44, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(184, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 286, 285, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(185, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 11, 10, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(186, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 88, 87, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(187, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 169, 168, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(188, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 62, 61, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(189, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 987, 982, NULL, 'NV01-000019', 0.00, 1, '2026-06-16 13:09:30'),
(190, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 285, 284, NULL, 'NV01-000020', 0.00, 1, '2026-06-16 15:15:21'),
(191, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 87, 86, NULL, 'NV01-000020', 0.00, 1, '2026-06-16 15:15:21'),
(192, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 44, 43, NULL, 'NV01-000020', 0.00, 1, '2026-06-16 15:15:21'),
(193, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 982, 981, NULL, 'NV01-000020', 0.00, 1, '2026-06-16 15:15:21'),
(194, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 43, 42, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(195, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 284, 283, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(196, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 10, 9, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(197, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 86, 85, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(198, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 168, 167, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(199, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 61, 60, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(200, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 981, 976, NULL, 'NV01-000021', 0.00, 1, '2026-06-18 10:23:50'),
(201, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 42, 41, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(202, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 283, 282, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(203, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 9, 8, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(204, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 85, 84, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(205, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 167, 166, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(206, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 60, 59, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(207, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 976, 971, NULL, 'NV01-000022', 0.00, 1, '2026-06-20 00:01:56'),
(208, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 8, 7, NULL, 'NV01-000023', 0.00, 1, '2026-06-20 00:04:25'),
(209, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 282, 281, NULL, 'NV01-000023', 0.00, 1, '2026-06-20 00:04:25'),
(210, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 166, 165, NULL, 'NV01-000023', 0.00, 1, '2026-06-20 00:04:25'),
(211, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 59, 58, NULL, 'NV01-000023', 0.00, 1, '2026-06-20 00:04:25'),
(212, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 281, 280, NULL, 'NV01-000024', 0.00, 1, '2026-06-20 00:37:01'),
(213, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 7, 6, NULL, 'NV01-000024', 0.00, 1, '2026-06-20 00:37:01'),
(214, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 84, 83, NULL, 'NV01-000024', 0.00, 1, '2026-06-20 00:37:01'),
(215, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 165, 164, NULL, 'NV01-000024', 0.00, 1, '2026-06-20 00:37:01'),
(216, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 58, 57, NULL, 'NV01-000024', 0.00, 1, '2026-06-20 00:37:01'),
(217, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 971, 966, NULL, 'NV01-000024', 0.00, 1, '2026-06-20 00:37:01'),
(223, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 6, 5, NULL, 'NV01-000025', 0.00, 1, '2026-06-20 16:27:40'),
(224, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 83, 82, NULL, 'NV01-000025', 0.00, 1, '2026-06-20 16:27:40'),
(225, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 164, 163, NULL, 'NV01-000025', 0.00, 1, '2026-06-20 16:27:40'),
(226, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 57, 56, NULL, 'NV01-000025', 0.00, 1, '2026-06-20 16:27:40'),
(227, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 966, 961, NULL, 'NV01-000025', 0.00, 1, '2026-06-20 16:27:40'),
(235, 6, NULL, NULL, NULL, '', 20, 41, 21, NULL, '... | Ref: B001111', 0.00, 1, '2026-06-20 18:05:21'),
(236, 6, NULL, NULL, NULL, '', 10, 21, 11, NULL, 'Bidones nuevos colores | Ref: B00119', 0.00, 1, '2026-06-20 18:06:27'),
(243, 6, NULL, 1, NULL, 'SALIDA_VENTA', 6, 11, 5, NULL, 'NV01-000026', 0.00, 1, '2026-06-20 18:14:07'),
(244, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 280, 279, NULL, 'NV01-000026', 0.00, 1, '2026-06-20 18:14:07'),
(245, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 5, 4, NULL, 'NV01-000026', 0.00, 1, '2026-06-20 18:14:07'),
(246, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 56, 55, NULL, 'NV01-000026', 0.00, 1, '2026-06-20 18:14:07'),
(247, 8, NULL, 1, NULL, 'SALIDA_VENTA', 2, 163, 161, NULL, 'NV01-000026', 0.00, 1, '2026-06-20 18:14:07'),
(248, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 82, 81, NULL, 'NV01-000026', 0.00, 1, '2026-06-20 18:14:07'),
(249, 6, NULL, 1, NULL, '', 6, 5, 11, NULL, 'Anulación NV01-000026', 0.00, 1, '2026-06-20 18:15:48'),
(250, 5, NULL, 1, NULL, '', 1, 279, 280, NULL, 'Anulación NV01-000026', 0.00, 1, '2026-06-20 18:15:48'),
(251, 1, NULL, 1, NULL, '', 1, 4, 5, NULL, 'Anulación NV01-000026', 0.00, 1, '2026-06-20 18:15:48'),
(252, 4, NULL, 1, NULL, '', 1, 55, 56, NULL, 'Anulación NV01-000026', 0.00, 1, '2026-06-20 18:15:48'),
(253, 8, NULL, 1, NULL, '', 2, 161, 163, NULL, 'Anulación NV01-000026', 0.00, 1, '2026-06-20 18:15:48'),
(254, 2, NULL, 1, NULL, '', 1, 81, 82, NULL, 'Anulación NV01-000026', 0.00, 1, '2026-06-20 18:15:48'),
(255, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 11, 10, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(256, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 280, 279, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(257, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 5, 4, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(258, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 82, 81, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(259, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 163, 162, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(260, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 56, 55, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(261, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 961, 956, NULL, 'NV01-000027', 0.00, 1, '2026-06-20 18:16:29'),
(262, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 10, 9, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(263, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 279, 278, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(264, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 4, 3, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(265, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 81, 80, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(266, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 162, 161, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(267, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 55, 54, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(268, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 956, 951, NULL, 'NV01-000028', 0.00, 4, '2026-06-20 18:43:27'),
(269, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 9, 8, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(270, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 278, 277, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(271, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 3, 2, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(272, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 80, 79, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(273, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 161, 160, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(274, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 54, 53, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(275, 7, NULL, 1, NULL, 'SALIDA_VENTA', 5, 951, 946, NULL, 'NV01-000029', 0.00, 4, '2026-06-20 18:44:05'),
(276, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 2, 1, NULL, 'NV01-000030', 0.00, 1, '2026-06-21 23:18:34'),
(277, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 79, 78, NULL, 'NV01-000030', 0.00, 1, '2026-06-21 23:18:34'),
(278, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 89, 88, NULL, 'NV01-000030', 0.00, 1, '2026-06-21 23:18:34'),
(279, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1, 0, NULL, 'NV01-000031', 0.00, 1, '2026-06-22 10:40:43'),
(280, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 78, 77, NULL, 'NV01-000031', 0.00, 1, '2026-06-22 10:40:43'),
(281, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 88, 87, NULL, 'NV01-000031', 0.00, 1, '2026-06-22 10:40:43'),
(282, 12, NULL, NULL, NULL, '', 40, 0, 40, NULL, '... | Ref: B0011', 0.00, 1, '2026-06-23 10:27:14'),
(283, 6, NULL, NULL, NULL, '', 1000, 8, 1008, NULL, 'Bidones nuevos colores', 0.00, 1, '2026-06-24 20:32:36'),
(284, 11, NULL, NULL, NULL, '', 1000, 0, 1000, NULL, 'Bidones nuevos colores', 0.00, 1, '2026-06-24 20:32:48'),
(285, 1, NULL, NULL, NULL, '', 100, 0, 100, NULL, 'mercaderia | Ref: B001', 0.00, 1, '2026-06-24 21:05:25'),
(286, 1, NULL, 1, NULL, 'SALIDA_VENTA', 10, 100, 90, NULL, 'NV01-000032', 0.00, 2, '2026-06-24 21:17:16'),
(287, 2, NULL, 1, NULL, 'SALIDA_VENTA', 10, 77, 67, NULL, 'NV01-000032', 0.00, 2, '2026-06-24 21:17:16'),
(288, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 87, 86, NULL, 'NV01-000032', 0.00, 2, '2026-06-24 21:17:16'),
(289, 12, NULL, 2, NULL, 'SALIDA_VENTA', 1, 40, 39, NULL, 'NV01-000033', 0.00, 1, '2026-06-25 11:38:02'),
(290, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 1008, 1007, NULL, 'NV01-000033', 0.00, 1, '2026-06-25 11:38:02'),
(291, 11, NULL, 2, NULL, 'SALIDA_VENTA', 1, 1000, 999, NULL, 'NV01-000033', 0.00, 1, '2026-06-25 11:38:02'),
(292, 12, NULL, 3, NULL, 'SALIDA_VENTA', 1, 39, 38, NULL, 'NV01-000034', 0.00, 1, '2026-06-25 11:45:21'),
(293, 12, NULL, 3, NULL, '', 1, 38, 39, NULL, 'Anulación NV01-000034', 0.00, 1, '2026-06-26 00:02:15'),
(294, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 90, 89, NULL, 'NV01-000035', 0.00, 2, '2026-06-26 16:49:48'),
(295, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 67, 66, NULL, 'NV01-000035', 0.00, 2, '2026-06-26 16:49:48'),
(296, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 86, 85, NULL, 'NV01-000035', 0.00, 2, '2026-06-26 16:49:48'),
(297, 12, NULL, 3, NULL, 'SALIDA_VENTA', 9, 39, 30, NULL, 'NV01-000036', 0.00, 9, '2026-06-27 00:10:53'),
(298, 11, NULL, 3, NULL, 'SALIDA_VENTA', 3, 999, 996, NULL, 'NV01-000036', 0.00, 9, '2026-06-27 00:10:53'),
(299, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1007, 1006, NULL, 'NV01-000037', 0.00, 1, '2026-06-27 14:04:33'),
(300, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 53, 52, NULL, 'NV01-000037', 0.00, 1, '2026-06-27 14:04:33'),
(301, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 277, 276, NULL, 'NV01-000037', 0.00, 1, '2026-06-27 14:04:33'),
(302, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1006, 1005, NULL, 'NV01-000038', 0.00, 1, '2026-06-27 20:04:13'),
(303, 12, NULL, NULL, NULL, '', 100, 30, 130, NULL, 'mercaderia | Ref: B00111', 0.00, 1, '2026-06-27 20:05:05'),
(304, 6, NULL, 1, NULL, 'SALIDA_VENTA', 2, 1005, 1003, NULL, 'NV01-000039', 0.00, 1, '2026-06-27 20:57:49'),
(305, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 52, 51, NULL, 'NV01-000039', 0.00, 1, '2026-06-27 20:57:49'),
(306, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 160, 159, NULL, 'NV01-000039', 0.00, 1, '2026-06-27 20:57:49'),
(307, 5, NULL, 1, NULL, 'SALIDA_VENTA', 1, 276, 275, NULL, 'NV01-000039', 0.00, 1, '2026-06-27 20:57:49'),
(308, 7, NULL, 1, NULL, 'SALIDA_VENTA', 1, 946, 945, NULL, 'NV01-000039', 0.00, 1, '2026-06-27 20:57:49'),
(309, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1003, 1002, NULL, 'NV01-000040', 0.00, 1, '2026-07-01 14:26:05'),
(310, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 159, 158, NULL, 'NV01-000040', 0.00, 1, '2026-07-01 14:26:05'),
(311, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 51, 50, NULL, 'NV01-000040', 0.00, 1, '2026-07-01 14:26:05'),
(312, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1002, 1001, NULL, 'NV01-000041', 0.00, 2, '2026-07-03 11:48:33'),
(313, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 158, 157, NULL, 'NV01-000041', 0.00, 2, '2026-07-03 11:48:33'),
(314, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 50, 49, NULL, 'NV01-000041', 0.00, 2, '2026-07-03 11:48:33'),
(315, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1001, 1000, NULL, 'NV01-000042', 0.00, 1, '2026-07-03 12:01:35'),
(316, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 157, 156, NULL, 'NV01-000042', 0.00, 1, '2026-07-03 12:01:35'),
(317, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 49, 48, NULL, 'NV01-000042', 0.00, 1, '2026-07-03 12:01:35'),
(318, 6, NULL, 1, NULL, 'SALIDA_VENTA', 1, 1000, 999, NULL, 'NV01-000043', 0.00, 1, '2026-07-03 12:10:10'),
(319, 8, NULL, 1, NULL, 'SALIDA_VENTA', 1, 156, 155, NULL, 'NV01-000043', 0.00, 1, '2026-07-03 12:10:10'),
(320, 4, NULL, 1, NULL, 'SALIDA_VENTA', 1, 48, 47, NULL, 'NV01-000043', 0.00, 1, '2026-07-03 12:10:10'),
(321, 6, NULL, 2, NULL, 'SALIDA_VENTA', 1, 999, 998, NULL, 'NV01-000044', 0.00, 2, '2026-07-07 00:19:52'),
(322, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 89, 88, NULL, 'NV01-000045', 0.00, 1, '2026-07-16 18:41:16'),
(323, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 66, 65, NULL, 'NV01-000045', 0.00, 1, '2026-07-16 18:41:16'),
(324, 3, NULL, 1, NULL, 'SALIDA_VENTA', 1, 85, 84, NULL, 'NV01-000045', 0.00, 1, '2026-07-16 18:41:16'),
(325, 6, NULL, 1, NULL, 'ANULACION', 1, 998, 999, NULL, 'Anulación NV01-000037', 0.00, 1, '2026-07-16 20:39:14'),
(326, 4, NULL, 1, NULL, 'ANULACION', 1, 47, 48, NULL, 'Anulación NV01-000037', 0.00, 1, '2026-07-16 20:39:14'),
(327, 5, NULL, 1, NULL, 'ANULACION', 1, 275, 276, NULL, 'Anulación NV01-000037', 0.00, 1, '2026-07-16 20:39:14'),
(328, 7, NULL, 2, NULL, 'SALIDA_VENTA', 1, 945, 944, 56, 'NV01-000046', 3.00, 1, '2026-07-17 12:57:28'),
(329, 12, NULL, 3, NULL, 'SALIDA_VENTA', 1, 130, 129, 56, 'NV01-000046', 57.60, 1, '2026-07-17 12:57:28'),
(330, 6, NULL, 1, NULL, 'ANULACION', 1, 999, 1000, NULL, 'Anulación NV01-000038', 0.00, 1, '2026-07-17 14:56:00'),
(331, 11, NULL, 3, NULL, 'SALIDA_VENTA', 1, 996, 995, 57, 'NV01-000047', 12.00, 1, '2026-07-17 15:01:42'),
(332, 1, NULL, 1, NULL, 'SALIDA_VENTA', 1, 88, 87, 62, 'NV01-000048', 50.00, 1, '2026-07-20 00:42:10'),
(333, 2, NULL, 1, NULL, 'SALIDA_VENTA', 1, 65, 64, 62, 'NV01-000048', 220.00, 1, '2026-07-20 00:42:10'),
(334, 4, NULL, 2, NULL, 'SALIDA_VENTA', 1, 48, 47, 62, 'NV01-000048', 15.00, 1, '2026-07-20 00:42:10'),
(335, 5, NULL, 2, NULL, 'SALIDA_VENTA', 1, 276, 275, 62, 'NV01-000048', 4.85, 1, '2026-07-20 00:42:10'),
(336, 11, NULL, 3, NULL, 'SALIDA_VENTA', 1, 995, 994, 62, 'NV01-000048', 12.00, 1, '2026-07-20 00:42:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_transferencias`
--

CREATE TABLE `inventario_transferencias` (
  `id` bigint(20) NOT NULL,
  `codigo` varchar(40) NOT NULL,
  `sucursal_origen_id` int(11) NOT NULL,
  `sucursal_destino_id` int(11) NOT NULL,
  `estado` enum('borrador','enviada','recibida','cancelada') NOT NULL DEFAULT 'borrador',
  `motivo` varchar(300) NOT NULL,
  `creado_por` int(11) NOT NULL,
  `enviado_por` int(11) DEFAULT NULL,
  `recibido_por` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `enviado_at` datetime DEFAULT NULL,
  `recibido_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_transferencia_items`
--

CREATE TABLE `inventario_transferencia_items` (
  `id` bigint(20) NOT NULL,
  `transferencia_id` bigint(20) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `producto_destino_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_intentos`
--

CREATE TABLE `login_intentos` (
  `id` bigint(20) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `identificador` varchar(150) NOT NULL,
  `ip` varchar(45) NOT NULL DEFAULT '',
  `user_agent` varchar(500) NOT NULL DEFAULT '',
  `exitoso` tinyint(4) NOT NULL DEFAULT 0,
  `motivo` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `login_intentos`
--

INSERT INTO `login_intentos` (`id`, `usuario_id`, `identificador`, `ip`, `user_agent`, `exitoso`, `motivo`, `created_at`) VALUES
(2, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 17:29:14'),
(3, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:10'),
(4, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:12'),
(5, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:14'),
(6, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:15'),
(7, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-16 18:20:16'),
(8, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:17'),
(9, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:18'),
(10, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:19'),
(11, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:20'),
(12, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-16 18:20:21'),
(13, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:20:22'),
(14, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:34:43'),
(15, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 18:35:32'),
(16, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:44'),
(17, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:46'),
(18, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:47'),
(19, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:48'),
(20, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-16 18:35:49'),
(21, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:50'),
(22, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:51'),
(23, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:52'),
(24, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:53'),
(25, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-16 18:35:54'),
(26, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 18:35:56'),
(27, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 18:36:28'),
(28, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 18:47:06'),
(29, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 21:20:40'),
(30, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 21:22:06'),
(31, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 21:58:38'),
(32, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 22:12:40'),
(33, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 0, 'password', '2026-07-16 22:13:33'),
(34, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 0, 'password', '2026-07-16 22:13:35'),
(35, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 1, 'ok', '2026-07-16 22:14:04'),
(36, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 0, 'password', '2026-07-16 22:14:22'),
(37, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 1, 'ok', '2026-07-16 22:15:24'),
(38, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 1, 'ok', '2026-07-16 22:23:10'),
(39, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 23:25:29'),
(40, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 23:28:00'),
(41, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-16 23:28:03'),
(42, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 23:28:10'),
(43, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 23:35:30'),
(44, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-16 23:37:39'),
(45, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 00:06:58'),
(46, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 00:07:05'),
(47, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 00:41:41'),
(48, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 00:41:50'),
(49, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 00:55:16'),
(50, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 00:55:22'),
(51, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 00:56:34'),
(52, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 01:36:44'),
(53, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 02:24:41'),
(54, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36', 1, 'ok', '2026-07-17 02:28:24'),
(55, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 11:09:49'),
(56, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:09:56'),
(57, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:11:36'),
(58, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:14:42'),
(59, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:17:26'),
(60, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:19:27'),
(61, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 11:20:43'),
(62, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:20:50'),
(63, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 11:26:29'),
(64, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 11:27:11'),
(65, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 12:12:02'),
(66, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 12:43:14'),
(67, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 13:24:01'),
(68, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 14:08:42'),
(69, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:14:18'),
(70, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 14:14:24'),
(71, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 14:16:37'),
(72, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:47'),
(73, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:52'),
(74, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:53'),
(75, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:54'),
(76, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-17 14:23:55'),
(77, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:56'),
(78, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:57'),
(79, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:58'),
(80, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:23:59'),
(81, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-17 14:24:00'),
(82, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-17 14:24:01'),
(83, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 14:25:40'),
(84, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 15:00:59'),
(85, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-17 23:27:36'),
(86, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 20:44:08'),
(87, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 20:46:43'),
(88, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 20:47:38'),
(89, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 20:56:54'),
(90, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 21:08:22'),
(91, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 21:12:00'),
(92, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 21:21:51'),
(93, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 21:41:15'),
(94, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 23:01:26'),
(95, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-18 23:03:15'),
(96, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 18:39:24'),
(97, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 19:23:00'),
(98, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 19:23:18'),
(99, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 19:24:41'),
(100, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 19:26:57'),
(101, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 19:29:11'),
(102, NULL, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'credenciales', '2026-07-19 21:05:15'),
(103, 2, 'sara2', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 21:05:18'),
(104, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 21:05:47'),
(105, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'credenciales', '2026-07-19 21:08:08'),
(106, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'credenciales', '2026-07-19 21:08:12'),
(107, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 21:08:25'),
(108, 2, 'sara', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'credenciales', '2026-07-19 21:09:01'),
(109, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-19 21:09:14'),
(110, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-20 00:19:01'),
(111, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-20 00:23:08'),
(112, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 1, 'ok', '2026-07-20 00:24:21'),
(113, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:52:11'),
(114, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:52:12'),
(115, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:52:13'),
(116, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:52:14'),
(117, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'bloqueado_por_intentos', '2026-07-20 00:52:16'),
(118, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:54:57'),
(119, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:54:58'),
(120, 1, 'admin', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 0, 'password', '2026-07-20 00:54:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logos_temporada`
--

CREATE TABLE `logos_temporada` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `temporada` varchar(50) NOT NULL,
  `ruta` varchar(500) NOT NULL,
  `activo` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `tipo` varchar(30) DEFAULT 'admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos_pago`
--

CREATE TABLE `metodos_pago` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `metodos_pago`
--

INSERT INTO `metodos_pago` (`id`, `nombre`, `estado`) VALUES
(1, 'Efectivo', 0),
(2, 'Yape', 0),
(3, 'Plin', 0),
(4, 'Tarjeta', 0),
(5, 'Transferencia', 0),
(6, 'Efectivo', 0),
(7, 'Yape', 0),
(8, 'Plin', 0),
(9, 'Tarjeta', 0),
(10, 'Transferencia', 0),
(11, 'Efectivo', 0),
(12, 'Yape', 0),
(13, 'Plin', 0),
(14, 'Tarjeta', 0),
(15, 'Transferencia', 0),
(16, 'Efectivo', 0),
(17, 'Yape', 0),
(18, 'Plin', 0),
(19, 'Tarjeta', 0),
(20, 'Transferencia', 0),
(21, 'Efectivo', 0),
(22, 'Yape', 0),
(23, 'Plin', 0),
(24, 'Tarjeta', 0),
(25, 'Transferencia', 0),
(26, 'Efectivo', 0),
(27, 'Yape', 0),
(28, 'Plin', 0),
(29, 'Tarjeta', 0),
(30, 'Transferencia', 0),
(31, 'Efectivo', 0),
(32, 'Yape', 0),
(33, 'Plin', 0),
(34, 'Tarjeta', 0),
(35, 'Transferencia', 0),
(36, 'Efectivo', 0),
(37, 'Yape', 0),
(38, 'Plin', 0),
(39, 'Tarjeta', 0),
(40, 'Transferencia', 0),
(41, 'Efectivo', 0),
(42, 'Yape', 0),
(43, 'Plin', 0),
(44, 'Tarjeta', 0),
(45, 'Transferencia', 0),
(46, 'Efectivo', 0),
(47, 'Yape', 0),
(48, 'Plin', 0),
(49, 'Tarjeta', 0),
(50, 'Transferencia', 0),
(51, 'Efectivo', 0),
(52, 'Yape', 0),
(53, 'Plin', 0),
(54, 'Tarjeta', 0),
(55, 'Transferencia', 0),
(56, 'Efectivo', 0),
(57, 'Yape', 0),
(58, 'Plin', 0),
(59, 'Tarjeta', 0),
(60, 'Transferencia', 0),
(61, 'Efectivo', 0),
(62, 'Yape', 0),
(63, 'Plin', 0),
(64, 'Tarjeta', 0),
(65, 'Transferencia', 0),
(66, 'Efectivo', 0),
(67, 'Yape', 0),
(68, 'Plin', 0),
(69, 'Tarjeta', 0),
(70, 'Transferencia', 0),
(71, 'Efectivo', 0),
(72, 'Yape', 0),
(73, 'Plin', 0),
(74, 'Tarjeta', 0),
(75, 'Transferencia', 0),
(76, 'Efectivo', 0),
(77, 'Yape', 0),
(78, 'Plin', 0),
(79, 'Tarjeta', 0),
(80, 'Transferencia', 0),
(81, 'Efectivo', 0),
(82, 'Yape', 0),
(83, 'Plin', 0),
(84, 'Tarjeta', 0),
(85, 'Transferencia', 0),
(86, 'Efectivo', 0),
(87, 'Yape', 0),
(88, 'Plin', 0),
(89, 'Tarjeta', 0),
(90, 'Transferencia', 0),
(91, 'Efectivo', 0),
(92, 'Yape', 0),
(93, 'Plin', 0),
(94, 'Tarjeta', 0),
(95, 'Transferencia', 0),
(96, 'Efectivo', 0),
(97, 'Yape', 0),
(98, 'Plin', 0),
(99, 'Tarjeta', 0),
(100, 'Transferencia', 0),
(101, 'Efectivo', 0),
(102, 'Yape', 0),
(103, 'Plin', 0),
(104, 'Tarjeta', 0),
(105, 'Transferencia', 0),
(106, 'Efectivo', 0),
(107, 'Yape', 0),
(108, 'Plin', 0),
(109, 'Tarjeta', 0),
(110, 'Transferencia', 0),
(111, 'Efectivo', 0),
(112, 'Yape', 0),
(113, 'Plin', 0),
(114, 'Tarjeta', 0),
(115, 'Transferencia', 0),
(116, 'Efectivo', 0),
(117, 'Yape', 0),
(118, 'Plin', 0),
(119, 'Tarjeta', 0),
(120, 'Transferencia', 0),
(121, 'Efectivo', 0),
(122, 'Yape', 0),
(123, 'Plin', 0),
(124, 'Tarjeta', 0),
(125, 'Transferencia', 0),
(126, 'Efectivo', 0),
(127, 'Yape', 0),
(128, 'Plin', 0),
(129, 'Tarjeta', 0),
(130, 'Transferencia', 0),
(131, 'Efectivo', 0),
(132, 'Yape', 0),
(133, 'Plin', 0),
(134, 'Tarjeta', 0),
(135, 'Transferencia', 0),
(136, 'Efectivo', 0),
(137, 'Yape', 0),
(138, 'Plin', 0),
(139, 'Tarjeta', 0),
(140, 'Transferencia', 0),
(141, 'Efectivo', 0),
(142, 'Yape', 0),
(143, 'Plin', 0),
(144, 'Tarjeta', 0),
(145, 'Transferencia', 0),
(146, 'Efectivo', 0),
(147, 'Yape', 0),
(148, 'Plin', 0),
(149, 'Tarjeta', 0),
(150, 'Transferencia', 0),
(151, 'Efectivo', 0),
(152, 'Yape', 0),
(153, 'Plin', 0),
(154, 'Tarjeta', 0),
(155, 'Transferencia', 0),
(156, 'Efectivo', 0),
(157, 'Yape', 0),
(158, 'Plin', 0),
(159, 'Tarjeta', 0),
(160, 'Transferencia', 0),
(161, 'Efectivo', 0),
(162, 'Yape', 0),
(163, 'Plin', 0),
(164, 'Tarjeta', 0),
(165, 'Transferencia', 0),
(166, 'Efectivo', 0),
(167, 'Yape', 0),
(168, 'Plin', 0),
(169, 'Tarjeta', 0),
(170, 'Transferencia', 0),
(171, 'Efectivo', 0),
(172, 'Yape', 0),
(173, 'Plin', 0),
(174, 'Tarjeta', 0),
(175, 'Transferencia', 0),
(176, 'Efectivo', 0),
(177, 'Yape', 0),
(178, 'Plin', 0),
(179, 'Tarjeta', 0),
(180, 'Transferencia', 0),
(181, 'Efectivo', 0),
(182, 'Yape', 0),
(183, 'Plin', 0),
(184, 'Tarjeta', 0),
(185, 'Transferencia', 0),
(186, 'Efectivo', 0),
(187, 'Yape', 0),
(188, 'Plin', 0),
(189, 'Tarjeta', 0),
(190, 'Transferencia', 0),
(191, 'Efectivo', 0),
(192, 'Yape', 0),
(193, 'Plin', 0),
(194, 'Tarjeta', 0),
(195, 'Transferencia', 0),
(196, 'Efectivo', 0),
(197, 'Yape', 0),
(198, 'Plin', 0),
(199, 'Tarjeta', 0),
(200, 'Transferencia', 0),
(201, 'Efectivo', 0),
(202, 'Yape', 0),
(203, 'Plin', 0),
(204, 'Tarjeta', 0),
(205, 'Transferencia', 0),
(206, 'Efectivo', 0),
(207, 'Yape', 0),
(208, 'Plin', 0),
(209, 'Tarjeta', 0),
(210, 'Transferencia', 0),
(211, 'Efectivo', 0),
(212, 'Yape', 0),
(213, 'Plin', 0),
(214, 'Tarjeta', 0),
(215, 'Transferencia', 0),
(216, 'Efectivo', 0),
(217, 'Yape', 0),
(218, 'Plin', 0),
(219, 'Tarjeta', 0),
(220, 'Transferencia', 0),
(221, 'Efectivo', 0),
(222, 'Yape', 0),
(223, 'Plin', 0),
(224, 'Tarjeta', 0),
(225, 'Transferencia', 0),
(226, 'Efectivo', 0),
(227, 'Yape', 0),
(228, 'Plin', 0),
(229, 'Tarjeta', 0),
(230, 'Transferencia', 0),
(231, 'Efectivo', 0),
(232, 'Yape', 0),
(233, 'Plin', 0),
(234, 'Tarjeta', 0),
(235, 'Transferencia', 0),
(236, 'Efectivo', 0),
(237, 'Yape', 0),
(238, 'Plin', 0),
(239, 'Tarjeta', 0),
(240, 'Transferencia', 0),
(241, 'Efectivo', 0),
(242, 'Yape', 0),
(243, 'Plin', 0),
(244, 'Tarjeta', 0),
(245, 'Transferencia', 0),
(246, 'Efectivo', 0),
(247, 'Yape', 0),
(248, 'Plin', 0),
(249, 'Tarjeta', 0),
(250, 'Transferencia', 0),
(251, 'Efectivo', 0),
(252, 'Yape', 0),
(253, 'Plin', 0),
(254, 'Tarjeta', 0),
(255, 'Transferencia', 0),
(256, 'Efectivo', 0),
(257, 'Yape', 0),
(258, 'Plin', 0),
(259, 'Tarjeta', 0),
(260, 'Transferencia', 0),
(261, 'Efectivo', 0),
(262, 'Yape', 0),
(263, 'Plin', 0),
(264, 'Tarjeta', 0),
(265, 'Transferencia', 0),
(266, 'Efectivo', 0),
(267, 'Yape', 0),
(268, 'Plin', 0),
(269, 'Tarjeta', 0),
(270, 'Transferencia', 0),
(271, 'Efectivo', 0),
(272, 'Yape', 0),
(273, 'Plin', 0),
(274, 'Tarjeta', 0),
(275, 'Transferencia', 0),
(276, 'Efectivo', 0),
(277, 'Yape', 0),
(278, 'Plin', 0),
(279, 'Tarjeta', 0),
(280, 'Transferencia', 0),
(281, 'Efectivo', 0),
(282, 'Yape', 0),
(283, 'Plin', 0),
(284, 'Tarjeta', 0),
(285, 'Transferencia', 0),
(286, 'Efectivo', 0),
(287, 'Yape', 0),
(288, 'Plin', 0),
(289, 'Tarjeta', 0),
(290, 'Transferencia', 0),
(291, 'Efectivo', 0),
(292, 'Yape', 0),
(293, 'Plin', 0),
(294, 'Tarjeta', 0),
(295, 'Transferencia', 0),
(296, 'Efectivo', 0),
(297, 'Yape', 0),
(298, 'Plin', 0),
(299, 'Tarjeta', 0),
(300, 'Transferencia', 0),
(301, 'Efectivo', 0),
(302, 'Yape', 0),
(303, 'Plin', 0),
(304, 'Tarjeta', 0),
(305, 'Transferencia', 0),
(306, 'Efectivo', 0),
(307, 'Yape', 0),
(308, 'Plin', 0),
(309, 'Tarjeta', 0),
(310, 'Transferencia', 0),
(311, 'Efectivo', 0),
(312, 'Yape', 0),
(313, 'Plin', 0),
(314, 'Tarjeta', 0),
(315, 'Transferencia', 0),
(316, 'Efectivo', 0),
(317, 'Yape', 0),
(318, 'Plin', 0),
(319, 'Tarjeta', 0),
(320, 'Transferencia', 0),
(321, 'Efectivo', 0),
(322, 'Yape', 0),
(323, 'Plin', 0),
(324, 'Tarjeta', 0),
(325, 'Transferencia', 0),
(326, 'Efectivo', 0),
(327, 'Yape', 0),
(328, 'Plin', 0),
(329, 'Tarjeta', 0),
(330, 'Transferencia', 0),
(331, 'Efectivo', 0),
(332, 'Yape', 0),
(333, 'Plin', 0),
(334, 'Tarjeta', 0),
(335, 'Transferencia', 0),
(336, 'Efectivo', 0),
(337, 'Yape', 0),
(338, 'Plin', 0),
(339, 'Tarjeta', 0),
(340, 'Transferencia', 0),
(341, 'Efectivo', 0),
(342, 'Yape', 0),
(343, 'Plin', 0),
(344, 'Tarjeta', 0),
(345, 'Transferencia', 0),
(346, 'Efectivo', 0),
(347, 'Yape', 0),
(348, 'Plin', 0),
(349, 'Tarjeta', 0),
(350, 'Transferencia', 0),
(351, 'Efectivo', 0),
(352, 'Yape', 0),
(353, 'Plin', 0),
(354, 'Tarjeta', 0),
(355, 'Transferencia', 0),
(356, 'Efectivo', 0),
(357, 'Yape', 0),
(358, 'Plin', 0),
(359, 'Tarjeta', 0),
(360, 'Transferencia', 0),
(361, 'Efectivo', 0),
(362, 'Yape', 0),
(363, 'Plin', 0),
(364, 'Tarjeta', 0),
(365, 'Transferencia', 0),
(366, 'Efectivo', 0),
(367, 'Yape', 0),
(368, 'Plin', 0),
(369, 'Tarjeta', 0),
(370, 'Transferencia', 0),
(371, 'Efectivo', 0),
(372, 'Yape', 0),
(373, 'Plin', 0),
(374, 'Tarjeta', 0),
(375, 'Transferencia', 0),
(376, 'Efectivo', 0),
(377, 'Yape', 0),
(378, 'Plin', 0),
(379, 'Tarjeta', 0),
(380, 'Transferencia', 0),
(381, 'Efectivo', 0),
(382, 'Yape', 0),
(383, 'Plin', 0),
(384, 'Tarjeta', 0),
(385, 'Transferencia', 0),
(386, 'Efectivo', 0),
(387, 'Yape', 0),
(388, 'Plin', 0),
(389, 'Tarjeta', 0),
(390, 'Transferencia', 0),
(391, 'Efectivo', 0),
(392, 'Yape', 0),
(393, 'Plin', 0),
(394, 'Tarjeta', 0),
(395, 'Transferencia', 0),
(396, 'Efectivo', 0),
(397, 'Yape', 0),
(398, 'Plin', 0),
(399, 'Tarjeta', 0),
(400, 'Transferencia', 0),
(401, 'Efectivo', 0),
(402, 'Yape', 0),
(403, 'Plin', 0),
(404, 'Tarjeta', 0),
(405, 'Transferencia', 0),
(406, 'Efectivo', 0),
(407, 'Yape', 0),
(408, 'Plin', 0),
(409, 'Tarjeta', 0),
(410, 'Transferencia', 0),
(411, 'Efectivo', 0),
(412, 'Yape', 0),
(413, 'Plin', 0),
(414, 'Tarjeta', 0),
(415, 'Transferencia', 0),
(416, 'Efectivo', 0),
(417, 'Yape', 0),
(418, 'Plin', 0),
(419, 'Tarjeta', 0),
(420, 'Transferencia', 0),
(421, 'Efectivo', 0),
(422, 'Yape', 0),
(423, 'Plin', 0),
(424, 'Tarjeta', 0),
(425, 'Transferencia', 0),
(426, 'Efectivo', 0),
(427, 'Yape', 0),
(428, 'Plin', 0),
(429, 'Tarjeta', 0),
(430, 'Transferencia', 0),
(431, 'Efectivo', 0),
(432, 'Yape', 0),
(433, 'Plin', 0),
(434, 'Tarjeta', 0),
(435, 'Transferencia', 0),
(436, 'Efectivo', 0),
(437, 'Yape', 0),
(438, 'Plin', 0),
(439, 'Tarjeta', 0),
(440, 'Transferencia', 0),
(441, 'Efectivo', 0),
(442, 'Yape', 0),
(443, 'Plin', 0),
(444, 'Tarjeta', 0),
(445, 'Transferencia', 0),
(446, 'Efectivo', 0),
(447, 'Yape', 0),
(448, 'Plin', 0),
(449, 'Tarjeta', 0),
(450, 'Transferencia', 0),
(451, 'Efectivo', 0),
(452, 'Yape', 0),
(453, 'Plin', 0),
(454, 'Tarjeta', 0),
(455, 'Transferencia', 0),
(456, 'Efectivo', 0),
(457, 'Yape', 0),
(458, 'Plin', 0),
(459, 'Tarjeta', 0),
(460, 'Transferencia', 0),
(461, 'Efectivo', 0),
(462, 'Yape', 0),
(463, 'Plin', 0),
(464, 'Tarjeta', 0),
(465, 'Transferencia', 0),
(466, 'Efectivo', 0),
(467, 'Yape', 0),
(468, 'Plin', 0),
(469, 'Tarjeta', 0),
(470, 'Transferencia', 0),
(471, 'Efectivo', 0),
(472, 'Yape', 0),
(473, 'Plin', 0),
(474, 'Tarjeta', 0),
(475, 'Transferencia', 0),
(476, 'Efectivo', 0),
(477, 'Yape', 0),
(478, 'Plin', 0),
(479, 'Tarjeta', 0),
(480, 'Transferencia', 0),
(481, 'Efectivo', 0),
(482, 'Yape', 0),
(483, 'Plin', 0),
(484, 'Tarjeta', 0),
(485, 'Transferencia', 0),
(486, 'Efectivo', 0),
(487, 'Yape', 0),
(488, 'Plin', 0),
(489, 'Tarjeta', 0),
(490, 'Transferencia', 0),
(491, 'Efectivo', 0),
(492, 'Yape', 0),
(493, 'Plin', 0),
(494, 'Tarjeta', 0),
(495, 'Transferencia', 0),
(496, 'Efectivo', 0),
(497, 'Yape', 0),
(498, 'Plin', 0),
(499, 'Tarjeta', 0),
(500, 'Transferencia', 0),
(501, 'Efectivo', 0),
(502, 'Yape', 0),
(503, 'Plin', 0),
(504, 'Tarjeta', 0),
(505, 'Transferencia', 0),
(506, 'Efectivo', 0),
(507, 'Yape', 0),
(508, 'Plin', 0),
(509, 'Tarjeta', 0),
(510, 'Transferencia', 0),
(511, 'Efectivo', 0),
(512, 'Yape', 0),
(513, 'Plin', 0),
(514, 'Tarjeta', 0),
(515, 'Transferencia', 0),
(516, 'Efectivo', 0),
(517, 'Yape', 0),
(518, 'Plin', 0),
(519, 'Tarjeta', 0),
(520, 'Transferencia', 0),
(521, 'Efectivo', 0),
(522, 'Yape', 0),
(523, 'Plin', 0),
(524, 'Tarjeta', 0),
(525, 'Transferencia', 0),
(526, 'Efectivo', 0),
(527, 'Yape', 0),
(528, 'Plin', 0),
(529, 'Tarjeta', 0),
(530, 'Transferencia', 0),
(531, 'Efectivo', 0),
(532, 'Yape', 0),
(533, 'Plin', 0),
(534, 'Tarjeta', 0),
(535, 'Transferencia', 0),
(536, 'Efectivo', 0),
(537, 'Yape', 0),
(538, 'Plin', 0),
(539, 'Tarjeta', 0),
(540, 'Transferencia', 0),
(541, 'Efectivo', 0),
(542, 'Yape', 0),
(543, 'Plin', 0),
(544, 'Tarjeta', 0),
(545, 'Transferencia', 0),
(546, 'Efectivo', 0),
(547, 'Yape', 0),
(548, 'Plin', 0),
(549, 'Tarjeta', 0),
(550, 'Transferencia', 0),
(551, 'Efectivo', 0),
(552, 'Yape', 0),
(553, 'Plin', 0),
(554, 'Tarjeta', 0),
(555, 'Transferencia', 0),
(556, 'Efectivo', 0),
(557, 'Yape', 0),
(558, 'Plin', 0),
(559, 'Tarjeta', 0),
(560, 'Transferencia', 0),
(561, 'Efectivo', 0),
(562, 'Yape', 0),
(563, 'Plin', 0),
(564, 'Tarjeta', 0),
(565, 'Transferencia', 0),
(566, 'Efectivo', 0),
(567, 'Yape', 0),
(568, 'Plin', 0),
(569, 'Tarjeta', 0),
(570, 'Transferencia', 0),
(571, 'Efectivo', 0),
(572, 'Yape', 0),
(573, 'Plin', 0),
(574, 'Tarjeta', 0),
(575, 'Transferencia', 0),
(576, 'Efectivo', 0),
(577, 'Yape', 0),
(578, 'Plin', 0),
(579, 'Tarjeta', 0),
(580, 'Transferencia', 0),
(581, 'Efectivo', 0),
(582, 'Yape', 0),
(583, 'Plin', 0),
(584, 'Tarjeta', 0),
(585, 'Transferencia', 0),
(586, 'Efectivo', 0),
(587, 'Yape', 0),
(588, 'Plin', 0),
(589, 'Tarjeta', 0),
(590, 'Transferencia', 0),
(591, 'Efectivo', 0),
(592, 'Yape', 0),
(593, 'Plin', 0),
(594, 'Tarjeta', 0),
(595, 'Transferencia', 0),
(596, 'Efectivo', 0),
(597, 'Yape', 0),
(598, 'Plin', 0),
(599, 'Tarjeta', 0),
(600, 'Transferencia', 0),
(601, 'Efectivo', 0),
(602, 'Yape', 0),
(603, 'Plin', 0),
(604, 'Tarjeta', 0),
(605, 'Transferencia', 0),
(606, 'Efectivo', 0),
(607, 'Yape', 0),
(608, 'Plin', 0),
(609, 'Tarjeta', 0),
(610, 'Transferencia', 0),
(611, 'Efectivo', 0),
(612, 'Yape', 0),
(613, 'Plin', 0),
(614, 'Tarjeta', 0),
(615, 'Transferencia', 0),
(616, 'Efectivo', 0),
(617, 'Yape', 0),
(618, 'Plin', 0),
(619, 'Tarjeta', 0),
(620, 'Transferencia', 0),
(621, 'Efectivo', 0),
(622, 'Yape', 0),
(623, 'Plin', 0),
(624, 'Tarjeta', 0),
(625, 'Transferencia', 0),
(626, 'Efectivo', 0),
(627, 'Yape', 0),
(628, 'Plin', 0),
(629, 'Tarjeta', 0),
(630, 'Transferencia', 0),
(631, 'Efectivo', 0),
(632, 'Yape', 0),
(633, 'Plin', 0),
(634, 'Tarjeta', 0),
(635, 'Transferencia', 0),
(636, 'Efectivo', 0),
(637, 'Yape', 0),
(638, 'Plin', 0),
(639, 'Tarjeta', 0),
(640, 'Transferencia', 0),
(641, 'Efectivo', 0),
(642, 'Yape', 0),
(643, 'Plin', 0),
(644, 'Tarjeta', 0),
(645, 'Transferencia', 0),
(646, 'Efectivo', 0),
(647, 'Yape', 0),
(648, 'Plin', 0),
(649, 'Tarjeta', 0),
(650, 'Transferencia', 0),
(651, 'Efectivo', 0),
(652, 'Yape', 0),
(653, 'Plin', 0),
(654, 'Tarjeta', 0),
(655, 'Transferencia', 0),
(656, 'Efectivo', 0),
(657, 'Yape', 0),
(658, 'Plin', 0),
(659, 'Tarjeta', 0),
(660, 'Transferencia', 0),
(661, 'Efectivo', 0),
(662, 'Yape', 0),
(663, 'Plin', 0),
(664, 'Tarjeta', 0),
(665, 'Transferencia', 0),
(666, 'Efectivo', 0),
(667, 'Yape', 0),
(668, 'Plin', 0),
(669, 'Tarjeta', 0),
(670, 'Transferencia', 0),
(671, 'Efectivo', 0),
(672, 'Yape', 0),
(673, 'Plin', 0),
(674, 'Tarjeta', 0),
(675, 'Transferencia', 0),
(676, 'Efectivo', 0),
(677, 'Yape', 0),
(678, 'Plin', 0),
(679, 'Tarjeta', 0),
(680, 'Transferencia', 0),
(681, 'Efectivo', 0),
(682, 'Yape', 0),
(683, 'Plin', 0),
(684, 'Tarjeta', 0),
(685, 'Transferencia', 0),
(686, 'Efectivo', 0),
(687, 'Yape', 0),
(688, 'Plin', 0),
(689, 'Tarjeta', 0),
(690, 'Transferencia', 0),
(691, 'Efectivo', 0),
(692, 'Yape', 0),
(693, 'Plin', 0),
(694, 'Tarjeta', 0),
(695, 'Transferencia', 0),
(696, 'Efectivo', 0),
(697, 'Yape', 0),
(698, 'Plin', 0),
(699, 'Tarjeta', 0),
(700, 'Transferencia', 0),
(701, 'Efectivo', 0),
(702, 'Yape', 0),
(703, 'Plin', 0),
(704, 'Tarjeta', 0),
(705, 'Transferencia', 0),
(706, 'Efectivo', 0),
(707, 'Yape', 0),
(708, 'Plin', 0),
(709, 'Tarjeta', 0),
(710, 'Transferencia', 0),
(711, 'Efectivo', 0),
(712, 'Yape', 0),
(713, 'Plin', 0),
(714, 'Tarjeta', 0),
(715, 'Transferencia', 0),
(716, 'Efectivo', 0),
(717, 'Yape', 0),
(718, 'Plin', 0),
(719, 'Tarjeta', 0),
(720, 'Transferencia', 0),
(721, 'Efectivo', 0),
(722, 'Yape', 0),
(723, 'Plin', 0),
(724, 'Tarjeta', 0),
(725, 'Transferencia', 0),
(726, 'Efectivo', 0),
(727, 'Yape', 0),
(728, 'Plin', 0),
(729, 'Tarjeta', 0),
(730, 'Transferencia', 0),
(731, 'Efectivo', 0),
(732, 'Yape', 0),
(733, 'Plin', 0),
(734, 'Tarjeta', 0),
(735, 'Transferencia', 0),
(736, 'Efectivo', 0),
(737, 'Yape', 0),
(738, 'Plin', 0),
(739, 'Tarjeta', 0),
(740, 'Transferencia', 0),
(741, 'Efectivo', 0),
(742, 'Yape', 0),
(743, 'Plin', 0),
(744, 'Tarjeta', 0),
(745, 'Transferencia', 0),
(746, 'Efectivo', 0),
(747, 'Yape', 0),
(748, 'Plin', 0),
(749, 'Tarjeta', 0),
(750, 'Transferencia', 0),
(751, 'Efectivo', 0),
(752, 'Yape', 0),
(753, 'Plin', 0),
(754, 'Tarjeta', 0),
(755, 'Transferencia', 0),
(756, 'Efectivo', 0),
(757, 'Yape', 0),
(758, 'Plin', 0),
(759, 'Tarjeta', 0),
(760, 'Transferencia', 0),
(761, 'Efectivo', 0),
(762, 'Yape', 0),
(763, 'Plin', 0),
(764, 'Tarjeta', 0),
(765, 'Transferencia', 0),
(766, 'Efectivo', 0),
(767, 'Yape', 0),
(768, 'Plin', 0),
(769, 'Tarjeta', 0),
(770, 'Transferencia', 0),
(771, 'Efectivo', 0),
(772, 'Yape', 0),
(773, 'Plin', 0),
(774, 'Tarjeta', 0),
(775, 'Transferencia', 0),
(776, 'Efectivo', 0),
(777, 'Yape', 0),
(778, 'Plin', 0),
(779, 'Tarjeta', 0),
(780, 'Transferencia', 0),
(781, 'Efectivo', 0),
(782, 'Yape', 0),
(783, 'Plin', 0),
(784, 'Tarjeta', 0),
(785, 'Transferencia', 0),
(786, 'Efectivo', 0),
(787, 'Yape', 0),
(788, 'Plin', 0),
(789, 'Tarjeta', 0),
(790, 'Transferencia', 0),
(791, 'Efectivo', 0),
(792, 'Yape', 0),
(793, 'Plin', 0),
(794, 'Tarjeta', 0),
(795, 'Transferencia', 0),
(796, 'Efectivo', 0),
(797, 'Yape', 0),
(798, 'Plin', 0),
(799, 'Tarjeta', 0),
(800, 'Transferencia', 0),
(801, 'Efectivo', 0),
(802, 'Yape', 0),
(803, 'Plin', 0),
(804, 'Tarjeta', 0),
(805, 'Transferencia', 0),
(806, 'Efectivo', 0),
(807, 'Yape', 0),
(808, 'Plin', 0),
(809, 'Tarjeta', 0),
(810, 'Transferencia', 0),
(811, 'Efectivo', 0),
(812, 'Yape', 0),
(813, 'Plin', 0),
(814, 'Tarjeta', 0),
(815, 'Transferencia', 0),
(816, 'Efectivo', 0),
(817, 'Yape', 0),
(818, 'Plin', 0),
(819, 'Tarjeta', 0),
(820, 'Transferencia', 0),
(821, 'Efectivo', 0),
(822, 'Yape', 0),
(823, 'Plin', 0),
(824, 'Tarjeta', 0),
(825, 'Transferencia', 0),
(826, 'Efectivo', 0),
(827, 'Yape', 0),
(828, 'Plin', 0),
(829, 'Tarjeta', 0),
(830, 'Transferencia', 0),
(831, 'Efectivo', 0),
(832, 'Yape', 0),
(833, 'Plin', 0),
(834, 'Tarjeta', 0),
(835, 'Transferencia', 0),
(836, 'Efectivo', 0),
(837, 'Yape', 0),
(838, 'Plin', 0),
(839, 'Tarjeta', 0),
(840, 'Transferencia', 0),
(841, 'Efectivo', 0),
(842, 'Yape', 0),
(843, 'Plin', 0),
(844, 'Tarjeta', 0),
(845, 'Transferencia', 0),
(846, 'Efectivo', 0),
(847, 'Yape', 0),
(848, 'Plin', 0),
(849, 'Tarjeta', 0),
(850, 'Transferencia', 0),
(851, 'Efectivo', 0),
(852, 'Yape', 0),
(853, 'Plin', 0),
(854, 'Tarjeta', 0),
(855, 'Transferencia', 0),
(856, 'Efectivo', 0),
(857, 'Yape', 0),
(858, 'Plin', 0),
(859, 'Tarjeta', 0),
(860, 'Transferencia', 0),
(861, 'Efectivo', 0),
(862, 'Yape', 0),
(863, 'Plin', 0),
(864, 'Tarjeta', 0),
(865, 'Transferencia', 0),
(866, 'Efectivo', 0),
(867, 'Yape', 0),
(868, 'Plin', 0),
(869, 'Tarjeta', 0),
(870, 'Transferencia', 0),
(871, 'Efectivo', 0),
(872, 'Yape', 0),
(873, 'Plin', 0),
(874, 'Tarjeta', 0),
(875, 'Transferencia', 0),
(876, 'Efectivo', 0),
(877, 'Yape', 0),
(878, 'Plin', 0),
(879, 'Tarjeta', 0),
(880, 'Transferencia', 0),
(881, 'Efectivo', 0),
(882, 'Yape', 0),
(883, 'Plin', 0),
(884, 'Tarjeta', 0),
(885, 'Transferencia', 0),
(886, 'Efectivo', 0),
(887, 'Yape', 0),
(888, 'Plin', 0),
(889, 'Tarjeta', 0),
(890, 'Transferencia', 0),
(891, 'Efectivo', 0),
(892, 'Yape', 0),
(893, 'Plin', 0),
(894, 'Tarjeta', 0),
(895, 'Transferencia', 0),
(896, 'Efectivo', 0),
(897, 'Yape', 0),
(898, 'Plin', 0),
(899, 'Tarjeta', 0),
(900, 'Transferencia', 0),
(901, 'Efectivo', 0),
(902, 'Yape', 0),
(903, 'Plin', 0),
(904, 'Tarjeta', 0),
(905, 'Transferencia', 0),
(906, 'Efectivo', 0),
(907, 'Yape', 0),
(908, 'Plin', 0),
(909, 'Tarjeta', 0),
(910, 'Transferencia', 0),
(911, 'Efectivo', 0),
(912, 'Yape', 0),
(913, 'Plin', 0),
(914, 'Tarjeta', 0),
(915, 'Transferencia', 0),
(916, 'Efectivo', 0),
(917, 'Yape', 0),
(918, 'Plin', 0),
(919, 'Tarjeta', 0),
(920, 'Transferencia', 0),
(921, 'Efectivo', 0),
(922, 'Yape', 0),
(923, 'Plin', 0),
(924, 'Tarjeta', 0),
(925, 'Transferencia', 0),
(926, 'Efectivo', 0),
(927, 'Yape', 0),
(928, 'Plin', 0),
(929, 'Tarjeta', 0),
(930, 'Transferencia', 0),
(931, 'Efectivo', 0),
(932, 'Yape', 0),
(933, 'Plin', 0),
(934, 'Tarjeta', 0),
(935, 'Transferencia', 0),
(936, 'Efectivo', 0),
(937, 'Yape', 0),
(938, 'Plin', 0),
(939, 'Tarjeta', 0),
(940, 'Transferencia', 0),
(941, 'Efectivo', 0),
(942, 'Yape', 0),
(943, 'Plin', 0),
(944, 'Tarjeta', 0),
(945, 'Transferencia', 0),
(946, 'Efectivo', 0),
(947, 'Yape', 0),
(948, 'Plin', 0),
(949, 'Tarjeta', 0),
(950, 'Transferencia', 0),
(951, 'Efectivo', 0),
(952, 'Yape', 0),
(953, 'Plin', 0),
(954, 'Tarjeta', 0),
(955, 'Transferencia', 0),
(956, 'Efectivo', 0),
(957, 'Yape', 0),
(958, 'Plin', 0),
(959, 'Tarjeta', 0),
(960, 'Transferencia', 0),
(961, 'Efectivo', 0),
(962, 'Yape', 0),
(963, 'Plin', 0),
(964, 'Tarjeta', 0),
(965, 'Transferencia', 0),
(966, 'Efectivo', 0),
(967, 'Yape', 0),
(968, 'Plin', 0),
(969, 'Tarjeta', 0),
(970, 'Transferencia', 0),
(971, 'Efectivo', 0),
(972, 'Yape', 0),
(973, 'Plin', 0),
(974, 'Tarjeta', 0),
(975, 'Transferencia', 0),
(976, 'Efectivo', 0),
(977, 'Yape', 0),
(978, 'Plin', 0),
(979, 'Tarjeta', 0),
(980, 'Transferencia', 0),
(981, 'Efectivo', 0),
(982, 'Yape', 0),
(983, 'Plin', 0),
(984, 'Tarjeta', 0),
(985, 'Transferencia', 0),
(986, 'Efectivo', 0),
(987, 'Yape', 0),
(988, 'Plin', 0),
(989, 'Tarjeta', 0),
(990, 'Transferencia', 0),
(991, 'Efectivo', 0),
(992, 'Yape', 0),
(993, 'Plin', 0),
(994, 'Tarjeta', 0),
(995, 'Transferencia', 0),
(996, 'Efectivo', 0),
(997, 'Yape', 0),
(998, 'Plin', 0),
(999, 'Tarjeta', 0),
(1000, 'Transferencia', 0),
(1001, 'Efectivo', 0),
(1002, 'Yape', 0),
(1003, 'Plin', 0),
(1004, 'Tarjeta', 0),
(1005, 'Transferencia', 0),
(1006, 'Efectivo', 0),
(1007, 'Yape', 0),
(1008, 'Plin', 0),
(1009, 'Tarjeta', 0),
(1010, 'Transferencia', 0),
(1011, 'Efectivo', 0),
(1012, 'Yape', 0),
(1013, 'Plin', 0),
(1014, 'Tarjeta', 0),
(1015, 'Transferencia', 0),
(1016, 'Efectivo', 0),
(1017, 'Yape', 0),
(1018, 'Plin', 0),
(1019, 'Tarjeta', 0),
(1020, 'Transferencia', 0),
(1021, 'Efectivo', 0),
(1022, 'Yape', 0),
(1023, 'Plin', 0),
(1024, 'Tarjeta', 0),
(1025, 'Transferencia', 0),
(1026, 'Efectivo', 0),
(1027, 'Yape', 0),
(1028, 'Plin', 0),
(1029, 'Tarjeta', 0),
(1030, 'Transferencia', 0),
(1031, 'Efectivo', 0),
(1032, 'Yape', 0),
(1033, 'Plin', 0),
(1034, 'Tarjeta', 0),
(1035, 'Transferencia', 0),
(1036, 'Efectivo', 0),
(1037, 'Yape', 0),
(1038, 'Plin', 0),
(1039, 'Tarjeta', 0),
(1040, 'Transferencia', 0),
(1041, 'Efectivo', 0),
(1042, 'Yape', 0),
(1043, 'Plin', 0),
(1044, 'Tarjeta', 0),
(1045, 'Transferencia', 0),
(1046, 'Efectivo', 0),
(1047, 'Yape', 0),
(1048, 'Plin', 0),
(1049, 'Tarjeta', 0),
(1050, 'Transferencia', 0),
(1051, 'Efectivo', 0),
(1052, 'Yape', 0),
(1053, 'Plin', 0),
(1054, 'Tarjeta', 0),
(1055, 'Transferencia', 0),
(1056, 'Efectivo', 0),
(1057, 'Yape', 0),
(1058, 'Plin', 0),
(1059, 'Tarjeta', 0),
(1060, 'Transferencia', 0),
(1061, 'Efectivo', 0),
(1062, 'Yape', 0),
(1063, 'Plin', 0),
(1064, 'Tarjeta', 0),
(1065, 'Transferencia', 0),
(1066, 'Efectivo', 0),
(1067, 'Yape', 0),
(1068, 'Plin', 0),
(1069, 'Tarjeta', 0),
(1070, 'Transferencia', 0),
(1071, 'Efectivo', 0),
(1072, 'Yape', 0),
(1073, 'Plin', 0),
(1074, 'Tarjeta', 0),
(1075, 'Transferencia', 0),
(1076, 'Efectivo', 0),
(1077, 'Yape', 0),
(1078, 'Plin', 0),
(1079, 'Tarjeta', 0),
(1080, 'Transferencia', 0),
(1081, 'Efectivo', 0),
(1082, 'Yape', 0),
(1083, 'Plin', 0),
(1084, 'Tarjeta', 0),
(1085, 'Transferencia', 0),
(1086, 'Efectivo', 0),
(1087, 'Yape', 0),
(1088, 'Plin', 0),
(1089, 'Tarjeta', 0),
(1090, 'Transferencia', 0),
(1091, 'Efectivo', 0),
(1092, 'Yape', 0),
(1093, 'Plin', 0),
(1094, 'Tarjeta', 0),
(1095, 'Transferencia', 0),
(1096, 'Efectivo', 0),
(1097, 'Yape', 0),
(1098, 'Plin', 0),
(1099, 'Tarjeta', 0),
(1100, 'Transferencia', 0),
(1101, 'Efectivo', 0),
(1102, 'Yape', 0),
(1103, 'Plin', 0),
(1104, 'Tarjeta', 0),
(1105, 'Transferencia', 0),
(1106, 'Efectivo', 0),
(1107, 'Yape', 0),
(1108, 'Plin', 0),
(1109, 'Tarjeta', 0),
(1110, 'Transferencia', 0),
(1111, 'Efectivo', 0),
(1112, 'Yape', 0),
(1113, 'Plin', 0),
(1114, 'Tarjeta', 0),
(1115, 'Transferencia', 0),
(1116, 'Efectivo', 0),
(1117, 'Yape', 0),
(1118, 'Plin', 0),
(1119, 'Tarjeta', 0),
(1120, 'Transferencia', 0),
(1121, 'Efectivo', 0),
(1122, 'Yape', 0),
(1123, 'Plin', 0),
(1124, 'Tarjeta', 0),
(1125, 'Transferencia', 0),
(1126, 'Efectivo', 0),
(1127, 'Yape', 0),
(1128, 'Plin', 0),
(1129, 'Tarjeta', 0),
(1130, 'Transferencia', 0),
(1131, 'Efectivo', 0),
(1132, 'Yape', 0),
(1133, 'Plin', 0),
(1134, 'Tarjeta', 0),
(1135, 'Transferencia', 0),
(1136, 'Efectivo', 0),
(1137, 'Yape', 0),
(1138, 'Plin', 0),
(1139, 'Tarjeta', 0),
(1140, 'Transferencia', 0),
(1141, 'Efectivo', 0),
(1142, 'Yape', 0),
(1143, 'Plin', 0),
(1144, 'Tarjeta', 0),
(1145, 'Transferencia', 0),
(1146, 'Efectivo', 0),
(1147, 'Yape', 0),
(1148, 'Plin', 0),
(1149, 'Tarjeta', 0),
(1150, 'Transferencia', 0),
(1151, 'Efectivo', 0),
(1152, 'Yape', 0),
(1153, 'Plin', 0),
(1154, 'Tarjeta', 0),
(1155, 'Transferencia', 0),
(1156, 'Efectivo', 0),
(1157, 'Yape', 0),
(1158, 'Plin', 0),
(1159, 'Tarjeta', 0),
(1160, 'Transferencia', 0),
(1161, 'Efectivo', 0),
(1162, 'Yape', 0),
(1163, 'Plin', 0),
(1164, 'Tarjeta', 0),
(1165, 'Transferencia', 0),
(1166, 'Efectivo', 0),
(1167, 'Yape', 0),
(1168, 'Plin', 0),
(1169, 'Tarjeta', 0),
(1170, 'Transferencia', 0),
(1171, 'Efectivo', 0),
(1172, 'Yape', 0),
(1173, 'Plin', 0),
(1174, 'Tarjeta', 0),
(1175, 'Transferencia', 0),
(1176, 'Efectivo', 0),
(1177, 'Yape', 0),
(1178, 'Plin', 0),
(1179, 'Tarjeta', 0),
(1180, 'Transferencia', 0),
(1181, 'Efectivo', 0),
(1182, 'Yape', 0),
(1183, 'Plin', 0),
(1184, 'Tarjeta', 0),
(1185, 'Transferencia', 0),
(1186, 'Efectivo', 0),
(1187, 'Yape', 0),
(1188, 'Plin', 0),
(1189, 'Tarjeta', 0),
(1190, 'Transferencia', 0),
(1191, 'Efectivo', 0),
(1192, 'Yape', 0),
(1193, 'Plin', 0),
(1194, 'Tarjeta', 0),
(1195, 'Transferencia', 0),
(1196, 'Efectivo', 0),
(1197, 'Yape', 0),
(1198, 'Plin', 0),
(1199, 'Tarjeta', 0),
(1200, 'Transferencia', 0),
(1201, 'Efectivo', 0),
(1202, 'Yape', 0),
(1203, 'Plin', 0),
(1204, 'Tarjeta', 0),
(1205, 'Transferencia', 0),
(1206, 'Efectivo', 0),
(1207, 'Yape', 0),
(1208, 'Plin', 0),
(1209, 'Tarjeta', 0),
(1210, 'Transferencia', 0),
(1211, 'Efectivo', 0),
(1212, 'Yape', 0),
(1213, 'Plin', 0),
(1214, 'Tarjeta', 0),
(1215, 'Transferencia', 0),
(1216, 'Efectivo', 0),
(1217, 'Yape', 0),
(1218, 'Plin', 0),
(1219, 'Tarjeta', 0),
(1220, 'Transferencia', 0),
(1221, 'Efectivo', 0),
(1222, 'Yape', 0),
(1223, 'Plin', 0),
(1224, 'Tarjeta', 0),
(1225, 'Transferencia', 0),
(1226, 'Efectivo', 0),
(1227, 'Yape', 0),
(1228, 'Plin', 0),
(1229, 'Tarjeta', 0),
(1230, 'Transferencia', 0),
(1231, 'Efectivo', 0),
(1232, 'Yape', 0),
(1233, 'Plin', 0),
(1234, 'Tarjeta', 0),
(1235, 'Transferencia', 0),
(1236, 'Efectivo', 0),
(1237, 'Yape', 0),
(1238, 'Plin', 0),
(1239, 'Tarjeta', 0),
(1240, 'Transferencia', 0),
(1241, 'Efectivo', 0),
(1242, 'Yape', 0),
(1243, 'Plin', 0),
(1244, 'Tarjeta', 0),
(1245, 'Transferencia', 0),
(1246, 'Efectivo', 0),
(1247, 'Yape', 0),
(1248, 'Plin', 0),
(1249, 'Tarjeta', 0),
(1250, 'Transferencia', 0),
(1251, 'Efectivo', 0),
(1252, 'Yape', 0),
(1253, 'Plin', 0),
(1254, 'Tarjeta', 0),
(1255, 'Transferencia', 0),
(1256, 'Efectivo', 0),
(1257, 'Yape', 0),
(1258, 'Plin', 0),
(1259, 'Tarjeta', 0),
(1260, 'Transferencia', 0),
(1261, 'Efectivo', 0),
(1262, 'Yape', 0),
(1263, 'Plin', 0),
(1264, 'Tarjeta', 0),
(1265, 'Transferencia', 0),
(1266, 'Efectivo', 0),
(1267, 'Yape', 0),
(1268, 'Plin', 0),
(1269, 'Tarjeta', 0),
(1270, 'Transferencia', 0),
(1271, 'Efectivo', 0),
(1272, 'Yape', 0),
(1273, 'Plin', 0),
(1274, 'Tarjeta', 0),
(1275, 'Transferencia', 0),
(1276, 'Efectivo', 0),
(1277, 'Yape', 0),
(1278, 'Plin', 0),
(1279, 'Tarjeta', 0),
(1280, 'Transferencia', 0),
(1281, 'Efectivo', 0),
(1282, 'Yape', 0),
(1283, 'Plin', 0),
(1284, 'Tarjeta', 0),
(1285, 'Transferencia', 0),
(1286, 'Efectivo', 0),
(1287, 'Yape', 0),
(1288, 'Plin', 0),
(1289, 'Tarjeta', 0),
(1290, 'Transferencia', 0),
(1291, 'Efectivo', 0),
(1292, 'Efectivo', 0),
(1293, 'Yape', 0),
(1294, 'Plin', 0),
(1295, 'Tarjeta', 0),
(1296, 'Transferencia', 0),
(1297, 'Efectivo', 0),
(1298, 'Yape', 0),
(1299, 'Plin', 0),
(1300, 'Tarjeta', 0),
(1301, 'Transferencia', 0),
(1302, 'Efectivo', 0),
(1303, 'Yape', 0),
(1304, 'Plin', 0),
(1305, 'Tarjeta', 0),
(1306, 'Transferencia', 0),
(1307, 'Efectivo', 0),
(1308, 'Yape', 0),
(1309, 'Plin', 0),
(1310, 'Tarjeta', 0),
(1311, 'Transferencia', 0),
(1312, 'Efectivo', 0),
(1313, 'Yape', 0),
(1314, 'Plin', 0),
(1315, 'Tarjeta', 0),
(1316, 'Transferencia', 0),
(1317, 'Efectivo', 0),
(1318, 'Yape', 0),
(1319, 'Plin', 0),
(1320, 'Tarjeta', 0),
(1321, 'Transferencia', 0),
(1322, 'Efectivo', 0),
(1323, 'Yape', 0),
(1324, 'Plin', 0),
(1325, 'Tarjeta', 0),
(1326, 'Transferencia', 0),
(1327, 'Efectivo', 0),
(1328, 'Yape', 0),
(1329, 'Plin', 0),
(1330, 'Tarjeta', 0),
(1331, 'Transferencia', 0),
(1332, 'Efectivo', 0),
(1333, 'Yape', 0),
(1334, 'Plin', 0),
(1335, 'Tarjeta', 0),
(1336, 'Transferencia', 0),
(1337, 'Efectivo', 0),
(1338, 'Yape', 0),
(1339, 'Plin', 0),
(1340, 'Tarjeta', 0),
(1341, 'Transferencia', 0),
(1342, 'Efectivo', 0),
(1343, 'Yape', 0),
(1344, 'Plin', 0),
(1345, 'Tarjeta', 0),
(1346, 'Transferencia', 0),
(1347, 'Efectivo', 0),
(1348, 'Yape', 0),
(1349, 'Plin', 0),
(1350, 'Tarjeta', 0),
(1351, 'Transferencia', 0),
(1352, 'Efectivo', 0),
(1353, 'Yape', 0),
(1354, 'Plin', 0),
(1355, 'Tarjeta', 0),
(1356, 'Transferencia', 0),
(1357, 'Efectivo', 0),
(1358, 'Yape', 0),
(1359, 'Plin', 0),
(1360, 'Tarjeta', 0),
(1361, 'Transferencia', 0),
(1362, 'Efectivo', 0),
(1363, 'Yape', 0),
(1364, 'Plin', 0),
(1365, 'Tarjeta', 0),
(1366, 'Transferencia', 0),
(1367, 'Efectivo', 0),
(1368, 'Yape', 0),
(1369, 'Plin', 0),
(1370, 'Tarjeta', 0),
(1371, 'Transferencia', 0),
(1372, 'Efectivo', 0),
(1373, 'Yape', 0),
(1374, 'Plin', 0),
(1375, 'Tarjeta', 0),
(1376, 'Transferencia', 0),
(1377, 'Efectivo', 0),
(1378, 'Yape', 0),
(1379, 'Plin', 0),
(1380, 'Tarjeta', 0),
(1381, 'Transferencia', 0),
(1382, 'Efectivo', 0),
(1383, 'Yape', 0),
(1384, 'Plin', 0),
(1385, 'Tarjeta', 0),
(1386, 'Transferencia', 0),
(1387, 'Efectivo', 0),
(1388, 'Yape', 0),
(1389, 'Plin', 0),
(1390, 'Tarjeta', 0),
(1391, 'Transferencia', 0),
(1392, 'Efectivo', 0),
(1393, 'Yape', 0),
(1394, 'Plin', 0),
(1395, 'Tarjeta', 0),
(1396, 'Transferencia', 0),
(1397, 'Efectivo', 0),
(1398, 'Yape', 0),
(1399, 'Plin', 0),
(1400, 'Tarjeta', 0),
(1401, 'Transferencia', 0),
(1402, 'Efectivo', 0),
(1403, 'Yape', 0),
(1404, 'Plin', 0),
(1405, 'Tarjeta', 0),
(1406, 'Transferencia', 0),
(1407, 'Efectivo', 0),
(1408, 'Yape', 0),
(1409, 'Plin', 0),
(1410, 'Tarjeta', 0),
(1411, 'Transferencia', 0),
(1412, 'Efectivo', 0),
(1413, 'Yape', 0),
(1414, 'Plin', 0),
(1415, 'Tarjeta', 0),
(1416, 'Transferencia', 0),
(1417, 'Efectivo', 0),
(1418, 'Yape', 0),
(1419, 'Plin', 0),
(1420, 'Tarjeta', 0),
(1421, 'Transferencia', 0),
(1422, 'Efectivo', 0),
(1423, 'Yape', 0),
(1424, 'Plin', 0),
(1425, 'Tarjeta', 0),
(1426, 'Transferencia', 0),
(1427, 'Efectivo', 0),
(1428, 'Yape', 0),
(1429, 'Plin', 0),
(1430, 'Tarjeta', 0),
(1431, 'Transferencia', 0),
(1432, 'Efectivo', 0),
(1433, 'Yape', 0),
(1434, 'Plin', 0),
(1435, 'Tarjeta', 0),
(1436, 'Transferencia', 0),
(1437, 'Efectivo', 0),
(1438, 'Yape', 0),
(1439, 'Plin', 0),
(1440, 'Tarjeta', 0),
(1441, 'Transferencia', 0),
(1442, 'Efectivo', 0),
(1443, 'Yape', 0),
(1444, 'Plin', 0),
(1445, 'Tarjeta', 0),
(1446, 'Transferencia', 0),
(1447, 'Efectivo', 0),
(1448, 'Yape', 0),
(1449, 'Plin', 0),
(1450, 'Tarjeta', 0),
(1451, 'Transferencia', 0),
(1452, 'Efectivo', 0),
(1453, 'Yape', 0),
(1454, 'Plin', 0),
(1455, 'Tarjeta', 0),
(1456, 'Transferencia', 0),
(1457, 'Efectivo', 0),
(1458, 'Yape', 0),
(1459, 'Plin', 0),
(1460, 'Tarjeta', 0),
(1461, 'Transferencia', 0),
(1462, 'Efectivo', 0),
(1463, 'Yape', 0),
(1464, 'Plin', 0),
(1465, 'Tarjeta', 0),
(1466, 'Transferencia', 0),
(1467, 'Efectivo', 0),
(1468, 'Yape', 0),
(1469, 'Plin', 0),
(1470, 'Tarjeta', 0),
(1471, 'Transferencia', 0),
(1472, 'Efectivo', 0),
(1473, 'Yape', 0),
(1474, 'Plin', 0),
(1475, 'Tarjeta', 0),
(1476, 'Transferencia', 0),
(1477, 'Efectivo', 0),
(1478, 'Yape', 0),
(1479, 'Plin', 0),
(1480, 'Tarjeta', 0),
(1481, 'Transferencia', 0),
(1482, 'Efectivo', 0),
(1483, 'Yape', 0),
(1484, 'Plin', 0),
(1485, 'Tarjeta', 0),
(1486, 'Transferencia', 0),
(1487, 'Efectivo', 0),
(1488, 'Yape', 0),
(1489, 'Plin', 0),
(1490, 'Tarjeta', 0),
(1491, 'Transferencia', 0),
(1492, 'Efectivo', 0),
(1493, 'Yape', 0),
(1494, 'Plin', 0),
(1495, 'Tarjeta', 0),
(1496, 'Transferencia', 0),
(1497, 'Efectivo', 0),
(1498, 'Yape', 0),
(1499, 'Plin', 0),
(1500, 'Tarjeta', 0),
(1501, 'Transferencia', 0),
(1502, 'Efectivo', 0),
(1503, 'Yape', 0),
(1504, 'Plin', 0),
(1505, 'Tarjeta', 0),
(1506, 'Transferencia', 0),
(1507, 'Efectivo', 0),
(1508, 'Yape', 0),
(1509, 'Plin', 0),
(1510, 'Tarjeta', 0),
(1511, 'Transferencia', 0),
(1512, 'Efectivo', 0),
(1513, 'Yape', 0),
(1514, 'Plin', 0),
(1515, 'Tarjeta', 0),
(1516, 'Transferencia', 0),
(1517, 'Efectivo', 0),
(1518, 'Yape', 0),
(1519, 'Plin', 0),
(1520, 'Tarjeta', 0),
(1521, 'Transferencia', 0),
(1522, 'Efectivo', 0),
(1523, 'Yape', 0),
(1524, 'Plin', 0),
(1525, 'Tarjeta', 0),
(1526, 'Transferencia', 0),
(1527, 'Efectivo', 0),
(1528, 'Yape', 0),
(1529, 'Plin', 0),
(1530, 'Tarjeta', 0),
(1531, 'Transferencia', 0),
(1532, 'Efectivo', 0),
(1533, 'Yape', 0),
(1534, 'Plin', 0),
(1535, 'Tarjeta', 0),
(1536, 'Transferencia', 0),
(1537, 'Efectivo', 0),
(1538, 'Yape', 0),
(1539, 'Plin', 0),
(1540, 'Tarjeta', 0),
(1541, 'Transferencia', 0),
(1542, 'Efectivo', 0),
(1543, 'Yape', 0),
(1544, 'Plin', 0),
(1545, 'Tarjeta', 0),
(1546, 'Transferencia', 0),
(1547, 'Efectivo', 0),
(1548, 'Yape', 0),
(1549, 'Plin', 0),
(1550, 'Tarjeta', 0),
(1551, 'Transferencia', 0),
(1552, 'Efectivo', 0),
(1553, 'Yape', 0),
(1554, 'Plin', 0),
(1555, 'Tarjeta', 0),
(1556, 'Transferencia', 0),
(1557, 'Efectivo', 0),
(1558, 'Yape', 0),
(1559, 'Plin', 0),
(1560, 'Tarjeta', 0),
(1561, 'Transferencia', 0),
(1562, 'Efectivo', 0),
(1563, 'Yape', 0),
(1564, 'Plin', 0),
(1565, 'Tarjeta', 0),
(1566, 'Transferencia', 0),
(1567, 'Efectivo', 0),
(1568, 'Yape', 0),
(1569, 'Plin', 0),
(1570, 'Tarjeta', 0),
(1571, 'Transferencia', 0),
(1572, 'Efectivo', 0),
(1573, 'Yape', 0),
(1574, 'Plin', 0),
(1575, 'Tarjeta', 0),
(1576, 'Transferencia', 0),
(1577, 'Efectivo', 0),
(1578, 'Yape', 0),
(1579, 'Plin', 0),
(1580, 'Tarjeta', 0),
(1581, 'Transferencia', 0),
(1582, 'Efectivo', 0),
(1583, 'Yape', 0),
(1584, 'Plin', 0),
(1585, 'Tarjeta', 0),
(1586, 'Transferencia', 0),
(1587, 'Efectivo', 0),
(1588, 'Yape', 0),
(1589, 'Plin', 0),
(1590, 'Tarjeta', 0),
(1591, 'Transferencia', 0),
(1592, 'Efectivo', 0),
(1593, 'Yape', 0),
(1594, 'Plin', 0),
(1595, 'Tarjeta', 0),
(1596, 'Transferencia', 0),
(1597, 'Efectivo', 0),
(1598, 'Yape', 0),
(1599, 'Plin', 0),
(1600, 'Tarjeta', 0),
(1601, 'Transferencia', 0),
(1602, 'Efectivo', 0),
(1603, 'Yape', 0),
(1604, 'Plin', 0),
(1605, 'Tarjeta', 0),
(1606, 'Transferencia', 0),
(1607, 'Efectivo', 0),
(1608, 'Yape', 0),
(1609, 'Plin', 0),
(1610, 'Tarjeta', 0),
(1611, 'Transferencia', 0),
(1612, 'IziPay', 0),
(1613, 'Efectivo', 0),
(1614, 'Yape', 0),
(1615, 'Plin', 0),
(1616, 'Tarjeta', 0),
(1617, 'Transferencia', 0),
(1618, 'Efectivo', 0),
(1619, 'Yape', 0),
(1620, 'Plin', 0),
(1621, 'Tarjeta', 0),
(1622, 'Transferencia', 0),
(1623, 'Efectivo', 0),
(1624, 'Yape', 0),
(1625, 'Plin', 0),
(1626, 'Tarjeta', 0),
(1627, 'Transferencia', 0),
(1628, 'Efectivo', 0),
(1629, 'Yape', 0),
(1630, 'Plin', 0),
(1631, 'Tarjeta', 0),
(1632, 'Transferencia', 0),
(1633, 'Efectivo', 0),
(1634, 'Yape', 0),
(1635, 'Plin', 0),
(1636, 'Tarjeta', 0),
(1637, 'Transferencia', 0),
(1638, 'Efectivo', 0),
(1639, 'Yape', 0),
(1640, 'Plin', 0),
(1641, 'Tarjeta', 0),
(1642, 'Transferencia', 0),
(1643, 'Efectivo', 0),
(1644, 'Yape', 0),
(1645, 'Plin', 0),
(1646, 'Tarjeta', 0),
(1647, 'Transferencia', 0),
(1648, 'Efectivo', 0),
(1649, 'Yape', 0),
(1650, 'Plin', 0),
(1651, 'Tarjeta', 0),
(1652, 'Transferencia', 0),
(1653, 'Efectivo', 0),
(1654, 'Yape', 0),
(1655, 'Plin', 0),
(1656, 'Tarjeta', 0),
(1657, 'Transferencia', 0),
(1658, 'Efectivo', 0),
(1659, 'Yape', 0),
(1660, 'Plin', 0),
(1661, 'Tarjeta', 0),
(1662, 'Transferencia', 0),
(1663, 'Efectivo', 0),
(1664, 'Yape', 0),
(1665, 'Plin', 0),
(1666, 'Tarjeta', 0),
(1667, 'Transferencia', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones`
--

CREATE TABLE `opciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `icono` varchar(50) DEFAULT '',
  `ruta` varchar(150) NOT NULL,
  `orden` int(11) DEFAULT 1,
  `padre_id` int(11) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `activo` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opciones`
--

INSERT INTO `opciones` (`id`, `nombre`, `slug`, `icono`, `ruta`, `orden`, `padre_id`, `estado`, `activo`) VALUES
(1, 'Dashboard', 'dashboard', 'ti-layout-dashboard', '/', 1, NULL, 0, 0),
(2, 'Usuarios', 'usuarios', 'ti-users', '/usuarios', 2, NULL, 0, 0),
(3, 'Perfiles', 'perfiles', 'ti-shield', '/perfiles', 3, NULL, 0, 0),
(4, 'Productos', 'productos', 'ti-package', '/productos', 4, NULL, 0, 0),
(5, 'Inventario', 'inventario', 'ti-box', '/inventario', 5, NULL, 0, 0),
(6, 'Ventas', 'ventas', 'ti-shopping-cart', '/ventas', 6, NULL, 0, 0),
(7, 'Clientes', 'clientes', 'ti-user-circle', '/clientes', 7, NULL, 0, 0),
(8, 'Gestión de empresa', 'config', 'ti-building', '/config', 11, NULL, 0, 0),
(9, 'Categorías', 'categorias', 'ti-tag', '/categorias', 9, NULL, 0, 0),
(11, 'Cotizaciones', 'cotizaciones', 'ti-file-text', '/cotizaciones', 11, NULL, 0, 0),
(12, 'Verificación de pagos', 'verificacion-pagos', 'ti-shield-check', '/pagos', 8, NULL, 0, 0),
(13, 'Temporadas', 'temporadas', 'ti-percent', '/temporadas', 13, NULL, 0, 0),
(14, 'Comprobantes', 'comprobantes', 'ti-receipt', '/comprobantes', 14, NULL, 0, 0),
(15, 'Gestión Tienda', 'gestion-tienda', 'ti-shop', '/gestion-tienda', 15, NULL, 0, 0),
(16, 'Recojo en Tienda', 'recojo', 'ti-geo-alt', '/recojo', 16, NULL, 0, 0),
(17, 'Apertura de caja', 'apertura_caja', 'ti-cash-register', '/apertura-caja', 9, NULL, 0, 0),
(18, 'Reportes financieros', 'reportes', 'ti-chart-line', '/reportes', 10, NULL, 0, 0),
(19, 'CRM', 'crm', 'ti-address-book', '/crm', 19, NULL, 0, 0),
(115, 'Recojo en tienda', 'recojo_tienda', 'ti-package-export', '/recojo-tienda', 11, NULL, 0, 0),
(116, 'Logística y reparto', 'logistica', 'ti-truck-delivery', '/logistica', 17, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `metodo` varchar(30) DEFAULT 'efectivo',
  `metodo_pago_id` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `referencia` varchar(100) DEFAULT '',
  `estado_conciliacion` varchar(12) DEFAULT NULL,
  `conciliado_por` int(11) DEFAULT NULL,
  `conciliado_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `venta_id`, `metodo`, `metodo_pago_id`, `monto`, `referencia`, `estado_conciliacion`, `conciliado_por`, `conciliado_at`, `created_at`) VALUES
(1, 1, 'efectivo', 0, 931.00, '', NULL, NULL, NULL, '2026-06-07 16:57:09'),
(2, 2, 'efectivo', 0, 60.00, '', NULL, NULL, NULL, '2026-06-08 09:14:46'),
(3, 3, 'efectivo', 0, 23.00, '', NULL, NULL, NULL, '2026-06-08 09:23:59'),
(4, 4, 'efectivo', 0, 35.00, '', NULL, NULL, NULL, '2026-06-08 09:30:36'),
(5, 5, 'efectivo', 0, 33.00, '', NULL, NULL, NULL, '2026-06-08 09:58:54'),
(6, 6, 'efectivo', 0, 220.00, '', NULL, NULL, NULL, '2026-06-08 14:04:29'),
(7, 6, 'efectivo', 0, 38.00, '', NULL, NULL, NULL, '2026-06-08 14:04:29'),
(8, 7, 'efectivo', 0, 10.00, '', NULL, NULL, NULL, '2026-06-08 23:27:54'),
(9, 8, 'efectivo', 0, 5.00, '', NULL, NULL, NULL, '2026-06-08 23:29:31'),
(10, 9, 'efectivo', 0, 5.00, '', NULL, NULL, NULL, '2026-06-08 23:34:46'),
(11, 10, 'efectivo', 0, 5.00, '', NULL, NULL, NULL, '2026-06-08 23:38:31'),
(12, 11, 'efectivo', 0, 310.00, '', NULL, NULL, NULL, '2026-06-09 00:33:25'),
(13, 12, 'efectivo', 0, 73.00, '', NULL, NULL, NULL, '2026-06-09 00:55:47'),
(14, 13, 'efectivo', 0, 240.00, '', NULL, NULL, NULL, '2026-06-09 12:01:27'),
(15, 14, 'yape', 0, 5.00, '', 'conciliado', 2, '2026-06-20 16:15:55', '2026-06-09 12:09:43'),
(16, 14, 'plin', 0, 5.00, '', 'conciliado', 2, '2026-06-20 16:15:51', '2026-06-09 12:09:43'),
(17, 15, 'efectivo', 0, 126.00, '', NULL, NULL, NULL, '2026-06-15 08:41:37'),
(18, 16, 'transferencia', 0, 343.00, '', 'conciliado', 2, '2026-06-20 16:15:50', '2026-06-16 11:39:31'),
(19, 17, 'efectivo', 0, 10.00, '', NULL, NULL, NULL, '2026-06-16 12:28:24'),
(20, 18, 'efectivo', 0, 491.00, '', NULL, NULL, NULL, '2026-06-16 12:54:47'),
(21, 19, 'efectivo', 0, 335.00, '', NULL, NULL, NULL, '2026-06-16 13:09:30'),
(22, 20, 'yape', 0, 238.00, '123', 'conciliado', 2, '2026-06-20 16:15:49', '2026-06-16 15:15:21'),
(23, 21, 'efectivo', 0, 335.00, '', NULL, NULL, NULL, '2026-06-18 10:23:50'),
(24, 22, 'efectivo', 0, 335.00, '', NULL, NULL, NULL, '2026-06-20 00:01:56'),
(25, 23, 'yape', 0, 90.00, '956', 'conciliado', 2, '2026-06-20 15:46:28', '2026-06-20 00:04:25'),
(26, 24, 'efectivo', 0, 325.00, '', NULL, NULL, NULL, '2026-06-20 00:37:01'),
(27, 26, 'yape', 0, 320.00, '321', 'conciliado', 1, '2026-06-21 23:18:57', '2026-06-20 16:27:40'),
(29, 29, 'efectivo', 0, 275.00, '', NULL, NULL, NULL, '2026-06-20 18:14:07'),
(30, 29, 'yape', 0, 100.00, '635', 'conciliado', 1, '2026-06-21 23:51:05', '2026-06-20 18:14:07'),
(31, 30, 'efectivo', 0, 335.00, '', NULL, NULL, NULL, '2026-06-20 18:16:29'),
(32, 31, 'efectivo', 0, 335.00, '', NULL, NULL, NULL, '2026-06-20 18:43:27'),
(33, 32, 'efectivo', 0, 335.00, '', NULL, NULL, NULL, '2026-06-20 18:44:05'),
(34, 33, 'efectivo', 0, 310.00, '', NULL, NULL, NULL, '2026-06-21 23:18:34'),
(35, 34, 'izipay', 0, 310.00, '541', 'conciliado', 1, '2026-06-26 15:07:12', '2026-06-22 10:40:43'),
(36, 35, 'efectivo', 0, 2875.00, '', NULL, NULL, NULL, '2026-06-24 21:17:16'),
(37, 36, 'efectivo', 0, 40.00, '', NULL, NULL, NULL, '2026-06-25 11:38:02'),
(38, 37, 'efectivo', 0, 18.00, '', NULL, NULL, NULL, '2026-06-25 11:45:21'),
(39, 38, 'efectivo', 0, 295.00, '', NULL, NULL, NULL, '2026-06-26 16:49:48'),
(40, 39, 'yape', 0, 198.00, '713', NULL, NULL, NULL, '2026-06-27 00:10:53'),
(41, 40, 'yape', 0, 30.00, '232', NULL, NULL, NULL, '2026-06-27 14:04:33'),
(42, 41, 'yape', 0, 10.00, '917', NULL, NULL, NULL, '2026-06-27 20:04:13'),
(43, 42, 'yape', 0, 10.00, '912', 'conciliado', 2, '2026-06-30 12:02:12', '2026-06-27 20:57:49'),
(44, 42, 'izipay', 0, 37.00, '242', 'conciliado', 2, '2026-06-30 12:02:01', '2026-06-27 20:57:49'),
(45, 42, 'transferencia', 0, 1.00, '242211313', 'conciliado', 1, '2026-06-30 12:53:44', '2026-06-27 20:57:49'),
(46, 43, 'yape', 0, 30.00, '412', NULL, NULL, NULL, '2026-07-01 14:26:05'),
(47, 44, 'yape', 0, 30.00, '711', 'conciliado', 2, '2026-07-03 11:48:55', '2026-07-03 11:48:33'),
(48, 45, 'yape', 0, 30.00, '235', 'conciliado', 1, '2026-07-03 12:03:08', '2026-07-03 12:01:35'),
(49, 46, 'efectivo', 0, 30.00, '', NULL, NULL, NULL, '2026-07-03 12:10:11'),
(50, 47, 'efectivo', 0, 10.00, '', NULL, NULL, NULL, '2026-07-07 00:19:52'),
(51, 50, 'yape', 2, 310.00, '891', 'pendiente', NULL, NULL, '2026-07-16 18:41:16'),
(52, 56, 'yape', 2, 60.60, '124', 'pendiente', NULL, NULL, '2026-07-17 12:57:28'),
(53, 57, 'yape', 2, 12.00, '1231', 'conciliado', 1, '2026-07-18 20:46:21', '2026-07-17 15:01:42'),
(54, 62, 'yape', 2, 301.85, '113', 'pendiente', NULL, NULL, '2026-07-20 00:42:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_credito`
--

CREATE TABLE `pagos_credito` (
  `id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo` enum('efectivo','yape','plin','transferencia') DEFAULT 'efectivo',
  `referencia` varchar(100) DEFAULT '',
  `usuario_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_operaciones_unicas`
--

CREATE TABLE `pagos_operaciones_unicas` (
  `id` bigint(20) NOT NULL,
  `metodo` varchar(30) NOT NULL,
  `referencia` varchar(100) NOT NULL,
  `pago_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos_operaciones_unicas`
--

INSERT INTO `pagos_operaciones_unicas` (`id`, `metodo`, `referencia`, `pago_id`, `venta_id`, `created_at`) VALUES
(1, 'izipay', '242', 44, 42, '2026-07-08 20:24:10'),
(2, 'izipay', '541', 35, 34, '2026-07-08 20:24:10'),
(3, 'transferencia', '242211313', 45, 42, '2026-07-08 20:24:10'),
(4, 'yape', '123', 22, 20, '2026-07-08 20:24:10'),
(5, 'yape', '232', 41, 40, '2026-07-08 20:24:10'),
(6, 'yape', '235', 48, 45, '2026-07-08 20:24:10'),
(7, 'yape', '321', 27, 26, '2026-07-08 20:24:10'),
(8, 'yape', '412', 46, 43, '2026-07-08 20:24:10'),
(9, 'yape', '635', 30, 29, '2026-07-08 20:24:10'),
(10, 'yape', '711', 47, 44, '2026-07-08 20:24:10'),
(11, 'yape', '713', 40, 39, '2026-07-08 20:24:10'),
(12, 'yape', '912', 43, 42, '2026-07-08 20:24:10'),
(13, 'yape', '917', 42, 41, '2026-07-08 20:24:10'),
(14, 'yape', '956', 25, 23, '2026-07-08 20:24:10'),
(16, 'yape', '891', 51, 50, '2026-07-16 18:41:16'),
(19, 'yape', '124', 52, 56, '2026-07-17 12:57:28'),
(20, 'yape', '1231', 53, 57, '2026-07-17 15:01:42'),
(21, 'yape', '113', 54, 62, '2026-07-20 00:42:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_verificacion`
--

CREATE TABLE `pagos_verificacion` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `numero_orden` varchar(50) DEFAULT '',
  `sucursal_id` int(11) NOT NULL DEFAULT 1,
  `metodo` enum('yape','plin','transferencia','efectivo') NOT NULL DEFAULT 'efectivo',
  `monto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `numero_operacion` varchar(100) DEFAULT '',
  `imagen_voucher` varchar(500) DEFAULT '',
  `comprobante_admin` varchar(500) DEFAULT '',
  `estado` enum('pendiente','aprobado','rechazado') NOT NULL DEFAULT 'pendiente',
  `estado_pedido` enum('pendiente','preparando','despachado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
  `verificado_por` int(11) DEFAULT NULL,
  `verificado_at` datetime DEFAULT NULL,
  `notas` text DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp(),
  `pedido_web_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` bigint(20) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `intentos` int(11) NOT NULL DEFAULT 0,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `usuario_id`, `token_hash`, `intentos`, `expires_at`, `used_at`, `created_at`) VALUES
(1, 8, '4266cde817e70e16ff2694091c85f7482bc724f64a5a9bd664842ac70d900bd9', 0, '2026-07-16 22:12:38', '2026-07-16 22:03:10', '2026-07-16 22:02:38'),
(2, 8, '9e9fba5bf18fbf2d411e0ae34db133c0c0fb2006eeba3a47b9b01b7c12125681', 0, '2026-07-16 22:13:10', '2026-07-16 22:03:10', '2026-07-16 22:03:10'),
(3, 8, '9f6f3a8459aef15fde87bebab3f6f4fed84697743b582f48651cd0db3e1577d1', 0, '2026-07-16 22:13:10', '2026-07-16 22:13:47', '2026-07-16 22:03:10'),
(4, 8, '05dda54fefe6969f4266a003dc3eeecf789161c79f6df2cea341094d904db223', 0, '2026-07-16 22:23:47', '2026-07-16 22:13:48', '2026-07-16 22:13:47'),
(5, 8, '53574fa59c18bdb065e51ce3d582a12723cc1b931d66a21192e9531f84bb3ed5', 0, '2026-07-16 22:23:48', '2026-07-16 22:13:49', '2026-07-16 22:13:48'),
(6, 8, '3d9f399fec3b9835e780f29bde2c22924d092482f37715614c34c2c7d4083399', 0, '2026-07-16 22:23:49', '2026-07-16 22:13:50', '2026-07-16 22:13:49'),
(7, 8, 'fe7b2e5c9b41bc860bb6abcb954ff2e7993b87f11337aad5dbfbc81b432efecd', 0, '2026-07-16 22:23:50', '2026-07-16 22:13:50', '2026-07-16 22:13:50'),
(8, 8, 'f7b3f419ff432c9cb315d0663b07c7e15ff54e1a556b1f5e4a0bcf3853cc3c1d', 0, '2026-07-16 22:23:50', '2026-07-16 22:13:51', '2026-07-16 22:13:50'),
(9, 8, '7014ab830746fe828b3d19b27b3f26d7a6239093bbcce8d5d8a2ebf984ed2af4', 0, '2026-07-16 22:23:51', '2026-07-16 23:31:30', '2026-07-16 22:13:51'),
(10, 8, 'ea07a698ed10c53c9dcb92c0daca33abf28a04eb637bf81a84da405122cf711b', 0, '2026-07-16 23:41:30', '2026-07-16 23:36:39', '2026-07-16 23:31:30'),
(11, 8, 'c56209f52a27849692767106674398926b20f3942207e66700f271651af29463', 0, '2026-07-16 23:46:39', '2026-07-17 00:55:08', '2026-07-16 23:36:39'),
(12, 8, '2b2d0ef119922a84bbb24a9565ddb0948d33b86cdf7161e17a12977aadec1bfb', 0, '2026-07-17 01:05:08', '2026-07-17 01:36:25', '2026-07-17 00:55:08'),
(13, 8, 'be671d9475f59431c336d0fab3feb0acfc3735cd83eaf3ff3f9c1f70686ebeaf', 0, '2026-07-17 01:46:25', '2026-07-17 01:36:29', '2026-07-17 01:36:25'),
(14, 8, '644518b26efc7ee593becfe5497e5bd2812d6da4633dd9f0bf938db2bac5daa5', 0, '2026-07-17 01:46:29', '2026-07-17 02:24:02', '2026-07-17 01:36:29'),
(15, 8, '8fc00d4dbcaf3627da3e742969df23c9b59febc966f5d307b41bc3c2d3165658', 0, '2026-07-17 02:34:03', '2026-07-17 14:24:26', '2026-07-17 02:24:03'),
(16, 8, '546be03a466d156b442dd7498365c897f3087f2c9d9ed667875af624bfce8d59', 0, '2026-07-17 14:34:26', '2026-07-20 01:00:34', '2026-07-17 14:24:26'),
(17, 8, '2159f2a6217a46d59e89ae0d44e6c357f3371be0db6836069860d7c9c5ddb288', 0, '2026-07-20 01:10:34', NULL, '2026-07-20 01:00:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_web`
--

CREATE TABLE `pedidos_web` (
  `id` int(11) NOT NULL,
  `numero_orden` varchar(50) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `cliente_web_id` int(11) DEFAULT NULL,
  `tipo_entrega` enum('delivery','recojo') NOT NULL DEFAULT 'delivery',
  `recojo_fecha_id` int(11) DEFAULT NULL,
  `direccion_entrega` text DEFAULT '',
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `igv` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `metodo_pago` varchar(30) DEFAULT 'yape',
  `codigo_operacion` varchar(100) DEFAULT '',
  `comprobante_cliente` varchar(500) DEFAULT '',
  `comprobante_admin` varchar(500) DEFAULT '',
  `notas_admin` text DEFAULT '',
  `estado_pago` varchar(20) NOT NULL DEFAULT 'pendiente',
  `estado_pedido` enum('pendiente','preparando','despachado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
  `verificado_by` int(11) DEFAULT NULL,
  `verificado_at` datetime DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `codigo` varchar(30) DEFAULT NULL,
  `cliente_nombre` varchar(200) NOT NULL DEFAULT 'Cliente web',
  `cliente_doc` varchar(20) DEFAULT '',
  `telefono` varchar(30) DEFAULT '',
  `direccion` text DEFAULT '',
  `numero_operacion` varchar(100) NOT NULL DEFAULT '',
  `imagen_voucher` varchar(500) DEFAULT '',
  `stock_liberado` tinyint(4) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `cliente_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`cliente_snapshot`)),
  `direccion_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`direccion_snapshot`)),
  `facturacion_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`facturacion_snapshot`)),
  `es_multisucursal` tinyint(4) NOT NULL DEFAULT 0,
  `processed_by` int(11) DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `reserva_expires_at` datetime DEFAULT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `rechazo_motivo` varchar(500) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos_web`
--

INSERT INTO `pedidos_web` (`id`, `numero_orden`, `cliente_id`, `cliente_web_id`, `tipo_entrega`, `recojo_fecha_id`, `direccion_entrega`, `subtotal`, `igv`, `total`, `metodo_pago`, `codigo_operacion`, `comprobante_cliente`, `comprobante_admin`, `notas_admin`, `estado_pago`, `estado_pedido`, `verificado_by`, `verificado_at`, `venta_id`, `sucursal_id`, `estado`, `created_at`, `codigo`, `cliente_nombre`, `cliente_doc`, `telefono`, `direccion`, `numero_operacion`, `imagen_voucher`, `stock_liberado`, `updated_at`, `cliente_snapshot`, `direccion_snapshot`, `facturacion_snapshot`, `es_multisucursal`, `processed_by`, `processed_at`, `reserva_expires_at`, `version`, `rechazo_motivo`) VALUES
(1, 'WEB-000001', NULL, 1, 'recojo', NULL, '', 260.00, 0.00, 260.00, 'yape', '', '', 'storage/private/vouchers/1784252992808-0e3bbe7887f459cf2c895edc.webp', 'Aprobado', 'rechazado', 'cancelado', NULL, NULL, NULL, 1, 0, '2026-07-01 22:09:33', 'WEB-000001', 'Cliente web', '', '', '', '', '', 0, '2026-07-16 20:57:14', NULL, NULL, NULL, 0, 1, '2026-07-16 20:57:14', NULL, 1, 'AADEE'),
(2, 'WEB-000002', 6, 1, 'delivery', NULL, 'CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE', 60.60, 0.00, 60.60, 'yape', '124', 'storage/private/vouchers/1784305572307-7ae0e79e0ab97c1f5168ef19.webp', '', 'Venta generada desde pedido web WEB-000002. Canal: ecommerce.', 'aprobado', 'preparando', 1, '2026-07-17 12:57:28', 56, NULL, 0, '2026-07-17 11:26:12', NULL, 'Cliente web', '', '', '', '124', 'storage/private/vouchers/1784305572307-7ae0e79e0ab97c1f5168ef19.webp', 0, '2026-07-17 12:57:28', '{\"tipo_doc\":\"dni\",\"numero_doc\":\"75107608\",\"nombre\":\"ANTONY BRAYAN\",\"razon_social\":\"\",\"apellido_paterno\":\"CAMPOS\",\"apellido_materno\":\"GARNIQUE\",\"nombre_completo\":\"ANTONY BRAYAN CAMPOS GARNIQUE\",\"direccion_api\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"CHICLAYO\",\"departamento\":\"LAMBAYEQUE\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-17 11:25:51\"}', '{\"departamento\":\"LAMBAYEQUE\",\"provincia\":\"CHICLAYO\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"recibe\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{}', 1, 1, '2026-07-17 12:57:28', '2026-07-17 11:56:12', 2, ''),
(3, 'WEB-000003', NULL, 1, 'delivery', NULL, 'CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE', 307.00, 0.00, 307.00, 'yape', '1121', 'storage/private/vouchers/1784315773567-821a9f193b9077c68f6a9555.webp', '', '', 'pendiente', 'pendiente', NULL, NULL, NULL, NULL, 0, '2026-07-17 14:16:13', NULL, 'Cliente web', '', '', '', '', 'storage/private/vouchers/1784315773567-821a9f193b9077c68f6a9555.webp', 0, '2026-07-17 14:16:13', '{\"tipo_doc\":\"dni\",\"numero_doc\":\"75107608\",\"nombre\":\"ANTONY BRAYAN\",\"razon_social\":\"\",\"apellido_paterno\":\"CAMPOS\",\"apellido_materno\":\"GARNIQUE\",\"nombre_completo\":\"ANTONY BRAYAN CAMPOS GARNIQUE\",\"direccion_api\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"CHICLAYO\",\"departamento\":\"LAMBAYEQUE\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-17 14:15:44\"}', '{\"departamento\":\"LAMBAYEQUE\",\"provincia\":\"CHICLAYO\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"fafsas\",\"lat\":null,\"lng\":null,\"recibe\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{}', 1, NULL, NULL, '2026-07-17 14:46:13', 1, ''),
(4, 'WEB-000004', NULL, 1, 'delivery', NULL, 'AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO', 50.00, 0.00, 50.00, 'yape', '112', 'storage/private/vouchers/1784316208835-1405e836952d936d1709badb.webp', '', '', 'pendiente', 'pendiente', NULL, NULL, NULL, 1, 0, '2026-07-17 14:23:28', NULL, 'Cliente web', '', '', '', '', 'storage/private/vouchers/1784316208835-1405e836952d936d1709badb.webp', 0, '2026-07-17 14:23:28', '{\"tipo_doc\":\"ruc\",\"numero_doc\":\"20119407738\",\"nombre\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"razon_social\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"apellido_paterno\":\"\",\"apellido_materno\":\"\",\"nombre_completo\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"direccion_api\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"LIMA\",\"departamento\":\"LIMA\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-17 14:22:50\"}', '{\"departamento\":\"LIMA\",\"provincia\":\"LIMA\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"recibe\":\"EMP. DE TRANS. FLORES HNOS. SRL.\"}', '{}', 0, NULL, NULL, '2026-07-17 14:53:28', 1, ''),
(5, 'WEB-000005', 8, 1, 'delivery', NULL, 'AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO', 12.00, 0.00, 12.00, 'yape', '1231', '', '', 'Venta generada desde pedido web WEB-000005. Canal: ecommerce.', 'aprobado', 'preparando', 1, '2026-07-17 15:01:42', 57, 3, 0, '2026-07-17 15:00:44', NULL, 'Cliente web', '', '', '', '1231', '', 0, '2026-07-17 15:01:42', '{\"tipo_doc\":\"ruc\",\"numero_doc\":\"20119407738\",\"nombre\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"razon_social\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"apellido_paterno\":\"\",\"apellido_materno\":\"\",\"nombre_completo\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"direccion_api\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"LIMA\",\"departamento\":\"LIMA\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-17 15:00:35\"}', '{\"departamento\":\"LIMA\",\"provincia\":\"LIMA\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"referencia\":\"fafsas\",\"lat\":null,\"lng\":null,\"recibe\":\"EMP. DE TRANS. FLORES HNOS. SRL.\"}', '{}', 0, 1, '2026-07-17 15:01:42', '2026-07-17 15:30:44', 2, ''),
(6, 'WEB-000006', 6, 1, 'recojo', NULL, 'CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE', 301.85, 0.00, 301.85, 'yape', '113', 'storage/private/vouchers/1784507335982-ec6368ba0dd73e70f9e424cc.webp', '', 'Venta generada desde pedido web WEB-000006. Canal: ecommerce.', 'aprobado', 'preparando', 1, '2026-07-20 00:42:10', 62, NULL, 0, '2026-07-19 19:28:55', NULL, 'Cliente web', '', '', '', '113', 'storage/private/vouchers/1784507335982-ec6368ba0dd73e70f9e424cc.webp', 0, '2026-07-20 00:42:10', '{\"tipo_doc\":\"dni\",\"numero_doc\":\"75107608\",\"nombre\":\"ANTONY BRAYAN\",\"razon_social\":\"\",\"apellido_paterno\":\"CAMPOS\",\"apellido_materno\":\"GARNIQUE\",\"nombre_completo\":\"ANTONY BRAYAN CAMPOS GARNIQUE\",\"direccion_api\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"CHICLAYO\",\"departamento\":\"LAMBAYEQUE\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-19 19:28:20\"}', '{\"departamento\":\"LAMBAYEQUE\",\"provincia\":\"CHICLAYO\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"recibe\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{}', 1, 1, '2026-07-20 00:42:10', '2026-07-19 19:58:55', 2, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_entregas_sucursal`
--

CREATE TABLE `pedido_entregas_sucursal` (
  `id` bigint(20) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `sucursal_id` int(11) NOT NULL,
  `tipo_entrega` enum('delivery','recojo') NOT NULL,
  `estado` enum('pendiente','preparando','listo','en_ruta','entregado','incidencia','cancelado') NOT NULL DEFAULT 'pendiente',
  `codigo_recojo_hash` char(64) DEFAULT NULL,
  `codigo_recojo_enc` text DEFAULT NULL,
  `codigo_generado_at` datetime DEFAULT NULL,
  `codigo_usado_at` datetime DEFAULT NULL,
  `preparado_por` int(11) DEFAULT NULL,
  `entregado_por` int(11) DEFAULT NULL,
  `persona_recibe` varchar(200) NOT NULL DEFAULT '',
  `documento_recibe` varchar(20) NOT NULL DEFAULT '',
  `observacion` varchar(500) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido_entregas_sucursal`
--

INSERT INTO `pedido_entregas_sucursal` (`id`, `pedido_id`, `venta_id`, `sucursal_id`, `tipo_entrega`, `estado`, `codigo_recojo_hash`, `codigo_recojo_enc`, `codigo_generado_at`, `codigo_usado_at`, `preparado_por`, `entregado_por`, `persona_recibe`, `documento_recibe`, `observacion`, `created_at`, `updated_at`) VALUES
(1, 2, 56, 2, 'delivery', 'listo', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '2026-07-17 12:57:28', '2026-07-19 19:12:55'),
(2, 2, 56, 3, 'delivery', 'listo', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '2026-07-17 12:57:28', '2026-07-19 19:12:53'),
(3, 5, 57, 3, 'delivery', 'listo', NULL, NULL, NULL, NULL, 1, NULL, '', '', '', '2026-07-17 15:01:42', '2026-07-19 19:50:22'),
(4, 6, 62, 1, 'recojo', 'pendiente', 'a2f64bd07ca8f2b6b225ffb965d6e4c6240ced7519406495ae8a9ba86640a394', 'v1.ImMjW6vGgFMxIZQZ.hKZ3qIH6xxrf3IyDFi-t7g.dxRaMjA', '2026-07-20 05:42:10', NULL, NULL, NULL, '', '', '', '2026-07-20 00:42:10', NULL),
(5, 6, 62, 2, 'recojo', 'pendiente', '4c37f014e94089e248f517bba6c7bab4f32fa71c757cebc84e36cb6194732bf5', 'v1.iEs--_DmOttjez7H.gj9z4W4TGFpbZPN8Vl9ovA.xvFfy74', '2026-07-20 05:42:10', NULL, NULL, NULL, '', '', '', '2026-07-20 00:42:10', NULL),
(6, 6, 62, 3, 'recojo', 'pendiente', '8032a278413e1ef44070e15c7b67c7cd4dd23898c10535f17f5112eccb437c21', 'v1.l6bPvz_hdQGGKTJa.YT3ZEC5ECP6T8GztlBORJA.TBh3NwI', '2026-07-20 05:42:10', NULL, NULL, NULL, '', '', '', '2026-07-20 00:42:10', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_items`
--

CREATE TABLE `pedido_items` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `costo_unitario_snapshot` decimal(10,2) NOT NULL DEFAULT 0.00,
  `nombre_snapshot` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_items`
--

INSERT INTO `pedido_items` (`id`, `pedido_id`, `producto_id`, `presentacion_id`, `cantidad`, `precio_unit`, `subtotal`, `sucursal_id`, `costo_unitario_snapshot`, `nombre_snapshot`) VALUES
(1, 1, 3, NULL, 1, 25.00, 25.00, NULL, 0.00, ''),
(2, 1, 4, NULL, 1, 15.00, 15.00, NULL, 0.00, ''),
(3, 1, 2, NULL, 1, 220.00, 220.00, NULL, 0.00, ''),
(4, 2, 7, NULL, 1, 3.00, 3.00, 2, 1.00, 'Tapa bidón'),
(5, 2, 12, NULL, 1, 57.60, 57.60, 3, 40.00, 'Bidón con agua'),
(6, 3, 2, NULL, 1, 220.00, 220.00, 1, 150.00, 'Gas lleno 45kg'),
(7, 3, 3, NULL, 3, 25.00, 75.00, 1, 0.00, 'Gas vacío 10kg'),
(8, 3, 11, NULL, 1, 12.00, 12.00, 3, 0.00, 'Bidón vacío'),
(9, 4, 3, NULL, 2, 25.00, 50.00, 1, 0.00, 'Gas vacío 10kg'),
(10, 5, 11, NULL, 1, 12.00, 12.00, 3, 0.00, 'Bidón vacío'),
(11, 6, 1, NULL, 1, 50.00, 50.00, 1, 20.00, 'Gas lleno 10kg'),
(12, 6, 2, NULL, 1, 220.00, 220.00, 1, 150.00, 'Gas lleno 45kg'),
(13, 6, 4, NULL, 1, 15.00, 15.00, 2, 8.00, 'Bidón lleno 20L'),
(14, 6, 5, NULL, 1, 4.85, 4.85, 2, 0.00, 'Bidón vacío 20L'),
(15, 6, 11, NULL, 1, 12.00, 12.00, 3, 0.00, 'Bidón vacío');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_recojo_reservas`
--

CREATE TABLE `pedido_recojo_reservas` (
  `id` bigint(20) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `horario_id` int(11) NOT NULL,
  `estado` enum('reservado','confirmado','liberado','utilizado') NOT NULL DEFAULT 'reservado',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedido_recojo_reservas`
--

INSERT INTO `pedido_recojo_reservas` (`id`, `pedido_id`, `sucursal_id`, `horario_id`, `estado`, `created_at`, `updated_at`) VALUES
(1, 6, 1, 7, 'liberado', '2026-07-19 19:28:55', '2026-07-19 20:01:14'),
(2, 6, 2, 6, 'liberado', '2026-07-19 19:28:55', '2026-07-19 20:01:14'),
(3, 6, 3, 8, 'liberado', '2026-07-19 19:28:55', '2026-07-19 20:01:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles`
--

CREATE TABLE `perfiles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `es_global` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perfiles`
--

INSERT INTO `perfiles` (`id`, `nombre`, `descripcion`, `estado`, `created_at`, `es_global`) VALUES
(1, 'Administrador', 'Acceso total al sistema', 0, '2026-05-26 15:35:42', 1),
(2, 'Vendedor', 'Acceso módulo ventas', 0, '2026-05-26 15:35:42', 0),
(3, 'Almacenero', 'Acceso módulo inventario', 0, '2026-05-26 15:35:42', 0),
(4, 'Ventas', 'Encargado de ventas', 0, '2026-05-30 20:52:21', 0),
(7, 'Caja', 'Recepción de Caja', 2, '2026-06-05 08:11:28', 0),
(8, 'Repartidor', 'Cajas', 0, '2026-06-23 11:52:43', 0),
(9, 'Supervisor', 'Supervisor', 0, '2026-06-27 12:23:27', 0),
(10, 'Administradores', 'admin', 2, '2026-07-19 21:36:41', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_opciones`
--

CREATE TABLE `perfil_opciones` (
  `perfil_id` int(11) NOT NULL,
  `opcion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perfil_opciones`
--

INSERT INTO `perfil_opciones` (`perfil_id`, `opcion_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 115),
(1, 116),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 115),
(2, 116),
(3, 1),
(3, 4),
(3, 5),
(8, 17),
(8, 116),
(9, 116);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_permisos`
--

CREATE TABLE `perfil_permisos` (
  `perfil_id` int(11) NOT NULL,
  `opcion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `perfil_permisos`
--

INSERT INTO `perfil_permisos` (`perfil_id`, `opcion_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(2, 1),
(2, 6),
(2, 7),
(3, 1),
(3, 4),
(3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil_permisos_accion`
--

CREATE TABLE `perfil_permisos_accion` (
  `perfil_id` int(11) NOT NULL,
  `permiso_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `perfil_permisos_accion`
--

INSERT INTO `perfil_permisos_accion` (`perfil_id`, `permiso_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(1, 30),
(1, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42),
(1, 43),
(1, 44),
(1, 45),
(1, 46),
(1, 47),
(1, 48),
(1, 49),
(1, 50),
(1, 51),
(1, 52),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(2, 30),
(2, 31),
(2, 32),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(2, 39),
(2, 40),
(2, 41),
(2, 42),
(2, 43),
(2, 44),
(2, 45),
(2, 46),
(2, 47),
(2, 48),
(2, 49),
(2, 50),
(2, 51),
(2, 52),
(3, 1),
(3, 14),
(3, 21),
(3, 22),
(3, 24),
(8, 49),
(8, 51),
(9, 1),
(9, 5),
(9, 6),
(9, 14),
(9, 21),
(9, 22),
(9, 25),
(9, 26),
(9, 27),
(9, 29),
(9, 30),
(9, 31),
(9, 33),
(9, 34),
(9, 39),
(9, 40),
(9, 42),
(9, 43),
(9, 47),
(9, 48),
(9, 49),
(9, 50),
(9, 51);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos_accion`
--

CREATE TABLE `permisos_accion` (
  `id` int(11) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `modulo` varchar(60) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permisos_accion`
--

INSERT INTO `permisos_accion` (`id`, `slug`, `modulo`, `nombre`, `descripcion`) VALUES
(1, 'dashboard.ver', 'dashboard', 'Ver dashboard', ''),
(2, 'dashboard.ver_finanzas', 'dashboard', 'Ver finanzas', ''),
(3, 'dashboard.ver_costos', 'dashboard', 'Ver costos y margen', ''),
(4, 'dashboard.ver_global', 'dashboard', 'Ver todas las sucursales', ''),
(5, 'clientes.ver', 'clientes', 'Ver clientes', ''),
(6, 'clientes.gestionar', 'clientes', 'Gestionar clientes', ''),
(7, 'categorias.gestionar', 'categorias', 'Gestionar categorías', ''),
(8, 'presentaciones.gestionar', 'presentaciones', 'Gestionar presentaciones', ''),
(9, 'comprobantes.ver', 'comprobantes', 'Ver comprobantes', ''),
(10, 'usuarios.ver', 'usuarios', 'Ver usuarios', ''),
(11, 'usuarios.gestionar', 'usuarios', 'Gestionar usuarios', ''),
(12, 'perfiles.ver', 'perfiles', 'Ver perfiles', ''),
(13, 'perfiles.gestionar', 'perfiles', 'Gestionar perfiles y permisos', ''),
(14, 'productos.ver', 'productos', 'Ver productos', ''),
(15, 'productos.crear', 'productos', 'Crear productos', ''),
(16, 'productos.editar', 'productos', 'Editar productos', ''),
(17, 'productos.eliminar', 'productos', 'Eliminar productos', ''),
(18, 'productos.imagenes', 'productos', 'Gestionar imágenes', ''),
(19, 'productos.volumen', 'productos', 'Gestionar precios por volumen', ''),
(20, 'productos.ver_costo', 'productos', 'Ver costo', ''),
(21, 'inventario.ver', 'inventario', 'Ver inventario', ''),
(22, 'inventario.mover', 'inventario', 'Registrar movimientos', ''),
(23, 'inventario.ajustar', 'inventario', 'Ajustar stock', ''),
(24, 'inventario.transferir', 'inventario', 'Transferir entre sucursales', ''),
(25, 'ventas.ver', 'ventas', 'Ver ventas', ''),
(26, 'ventas.crear', 'ventas', 'Crear ventas', ''),
(27, 'ventas.anular', 'ventas', 'Anular ventas', ''),
(28, 'ventas.emitir', 'ventas', 'Emitir comprobantes', ''),
(29, 'cotizaciones.ver', 'cotizaciones', 'Ver cotizaciones', ''),
(30, 'cotizaciones.gestionar', 'cotizaciones', 'Gestionar cotizaciones', ''),
(31, 'caja.ver', 'caja', 'Ver caja', ''),
(32, 'caja.operar', 'caja', 'Operar caja', ''),
(33, 'caja.supervisar', 'caja', 'Supervisar caja', ''),
(34, 'reportes.ver', 'reportes', 'Ver reportes', ''),
(35, 'reportes.exportar', 'reportes', 'Exportar reportes', ''),
(36, 'reportes.ver_finanzas', 'reportes', 'Ver finanzas', ''),
(37, 'reportes.ver_costos', 'reportes', 'Ver costos', ''),
(38, 'tienda.gestionar', 'tienda', 'Gestionar tienda', ''),
(39, 'pedidos_web.ver', 'pedidos_web', 'Ver pedidos web', ''),
(40, 'pedidos_web.aprobar_sucursal', 'pedidos_web', 'Aprobar pedidos de su sucursal', ''),
(41, 'pedidos_web.aprobar_multisucursal', 'pedidos_web', 'Aprobar pedidos multisucursal', ''),
(42, 'pedidos_web.preparar', 'pedidos_web', 'Preparar pedidos', ''),
(43, 'pedidos_web.entregar', 'pedidos_web', 'Entregar pedidos', ''),
(44, 'recojo.configurar', 'recojo', 'Configurar recojo', ''),
(45, 'config.ver', 'config', 'Ver configuración', ''),
(46, 'config.gestionar', 'config', 'Gestionar configuración', ''),
(47, 'crm.ver', 'crm', 'Ver CRM', ''),
(48, 'crm.gestionar', 'crm', 'Gestionar CRM', ''),
(49, 'logistica.ver', 'logistica', 'Ver logística', 'Consultar repartidores, camiones, rutas y entregas'),
(50, 'logistica.gestionar', 'logistica', 'Gestionar logística', 'Crear y editar repartidores, vehículos y rutas'),
(51, 'logistica.operar', 'logistica', 'Operar rutas', 'Iniciar rutas y registrar entregas o incidencias'),
(52, 'logistica.ver_global', 'logistica', 'Ver logística global', 'Consultar todas las sucursales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precios_volumen`
--

CREATE TABLE `precios_volumen` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad_desde` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `precios_volumen`
--

INSERT INTO `precios_volumen` (`id`, `producto_id`, `cantidad_desde`, `precio_unit`, `created_at`) VALUES
(1, 1, 10, 40.00, '2026-06-24 21:52:33'),
(7, 12, 9, 55.00, '2026-07-16 21:29:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presentaciones`
--

CREATE TABLE `presentaciones` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `catalogo_id` int(11) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio_costo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precio_venta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `es_principal` tinyint(4) NOT NULL DEFAULT 0,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `stock` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `presentaciones`
--

INSERT INTO `presentaciones` (`id`, `producto_id`, `catalogo_id`, `nombre`, `precio_costo`, `precio_venta`, `es_principal`, `estado`, `stock`) VALUES
(1, 1, NULL, 'Gas lleno 10kg', 40.00, 65.00, 1, 0, 0),
(2, 2, NULL, 'Gas lleno 45kg', 150.00, 220.00, 1, 0, 0),
(3, 3, NULL, 'Gas vacío 10kg', 0.00, 25.00, 1, 0, 0),
(4, 4, NULL, 'Bidón lleno 20L', 8.00, 15.00, 0, 0, 19),
(5, 5, NULL, 'Bidón vacío 20L', 0.00, 5.00, 1, 0, 0),
(6, 6, NULL, 'Bidón lleno 10L', 5.00, 10.00, 1, 2, 0),
(7, 7, NULL, 'Tapa bidón', 1.00, 3.00, 1, 0, 0),
(8, 8, NULL, 'Caño bidón', 2.00, 5.00, 1, 0, 0),
(9, 9, NULL, 'Bidon 1 litro', 10.00, 20.00, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presentaciones_catalogo`
--

CREATE TABLE `presentaciones_catalogo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `presentaciones_catalogo`
--

INSERT INTO `presentaciones_catalogo` (`id`, `nombre`, `descripcion`, `estado`) VALUES
(1, 'Bidón 20L', 'Bidón de agua 20 litros', 0),
(2, 'Bidón 10L', 'Bidón de agua 10 litros', 0),
(3, 'Bidón 5L', 'Bidón de agua 5 litros', 0),
(4, 'Balón 10kg', 'Balón de gas 10 kilogramos', 0),
(5, 'Balón 45kg', 'Balón de gas 45 kilogramos', 0),
(6, 'Unidad', 'Unidad estándar', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT '',
  `marca` varchar(100) DEFAULT '',
  `modelo` varchar(100) DEFAULT '',
  `sku` varchar(100) DEFAULT NULL,
  `codigo_barras` varchar(100) DEFAULT '',
  `precio_costo` decimal(10,2) DEFAULT 0.00,
  `precio_venta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `porcentaje_oferta` decimal(5,2) DEFAULT 0.00,
  `peso_kg` decimal(6,2) DEFAULT NULL,
  `dimensiones` varchar(50) DEFAULT NULL,
  `garantia_meses` int(11) DEFAULT 0,
  `atributo_extra` varchar(100) DEFAULT NULL,
  `stock_minimo` int(11) DEFAULT 0,
  `stock_maximo` int(11) DEFAULT 0,
  `imagen` varchar(255) DEFAULT '',
  `sucursal_id` int(11) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `stock_actual` int(11) NOT NULL DEFAULT 0,
  `valoracion` decimal(3,1) DEFAULT 0.0,
  `categoria_id` int(11) DEFAULT NULL,
  `unidad` varchar(30) DEFAULT 'unidad'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `marca`, `modelo`, `sku`, `codigo_barras`, `precio_costo`, `precio_venta`, `porcentaje_oferta`, `peso_kg`, `dimensiones`, `garantia_meses`, `atributo_extra`, `stock_minimo`, `stock_maximo`, `imagen`, `sucursal_id`, `estado`, `created_at`, `stock_actual`, `valoracion`, `categoria_id`, `unidad`) VALUES
(1, 'Gas lleno 10kg', 'Balón de gas 10kg lleno', '', '', 'GAS-10K-L', '', 20.00, 50.00, 0.00, NULL, NULL, 0, NULL, 10, 100, '', 1, 0, '2026-05-26 15:35:42', 87, 0.0, 2, 'unidad'),
(2, 'Gas lleno 45kg', 'Balón de gas 45kg lleno', '', '', 'GAS-45K-L', '', 150.00, 220.00, 0.00, NULL, NULL, 0, NULL, 5, 50, '', 1, 0, '2026-05-26 15:35:42', 64, 0.0, 2, 'unidad'),
(3, 'Gas vacío 10kg', 'Balón vacío para rellenar', '', '', 'GAS-10K-V', '', 0.00, 25.00, 0.00, NULL, NULL, 0, NULL, 5, 80, '', 1, 0, '2026-05-26 15:35:42', 84, 0.0, 2, 'unidad'),
(4, 'Bidón lleno 20L', 'Bidón de agua 20L lleno', '', '', 'BID-20L-L', '', 8.00, 15.00, 0.00, NULL, NULL, 0, NULL, 20, 200, '', 2, 0, '2026-05-26 15:35:42', 47, 0.0, 1, 'unidad'),
(5, 'Bidón vacío 20L', 'Bidón de agua 20L vacío', '', '', 'BID-20L-V', '', 0.00, 5.00, 0.00, NULL, NULL, 0, NULL, 10, 150, '', 2, 0, '2026-05-26 15:35:42', 275, 0.0, 1, 'unidad'),
(6, 'Bidón lleno 10L', 'Bidón de agua 10L lleno', '', '', 'BID-10L-L', '', 1000.00, 10.00, 0.00, NULL, NULL, 0, NULL, 12, 150, '', 2, 0, '2026-05-26 15:35:42', 1000, 0.0, 1, 'unidad'),
(7, 'Tapa bidón', 'Tapa para bidón estándar', '', '', 'TAP-BID', '', 1.00, 3.00, 0.00, NULL, NULL, 0, NULL, 50, 500, '', 2, 0, '2026-05-26 15:35:42', 944, 0.0, 3, 'unidad'),
(8, 'Caño bidón', 'Caño para bidón de agua', '', '', 'CAN-BID', '', 2.00, 5.00, 0.00, NULL, NULL, 0, NULL, 30, 300, '', 2, 0, '2026-05-26 15:35:42', 155, 0.0, 3, 'unidad'),
(10, 'ad', 'adfs', '', '', '', '', 12.00, 14.00, 0.00, NULL, NULL, 0, NULL, 0, 0, '', NULL, 2, '2026-05-30 18:56:11', 0, 0.0, 3, 'unidad'),
(11, 'Bidón vacío', 'Bidón retornable vacío', '', '', '', '', 0.00, 12.00, 0.00, NULL, NULL, 0, NULL, 0, 0, '', 3, 0, '2026-06-22 12:54:30', 994, 0.0, NULL, 'unidad'),
(12, 'Bidón con agua', 'Bidón de agua para recarga', '', '', '', '', 40.00, 60.00, 0.00, NULL, NULL, 0, NULL, 10, 0, '', 3, 0, '2026-06-22 12:54:30', 129, 0.0, 1, 'unidad'),
(13, 'Bidón lleno 10L', 'ada', '', '', NULL, '', 100.00, 150.00, 0.00, NULL, NULL, 0, NULL, 0, 0, '', 1, 2, '2026-07-18 22:47:24', 0, 0.0, NULL, 'unidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_imagenes`
--

CREATE TABLE `producto_imagenes` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `ruta` varchar(500) NOT NULL,
  `es_portada` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `orden` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto_imagenes`
--

INSERT INTO `producto_imagenes` (`id`, `producto_id`, `ruta`, `es_portada`, `created_at`, `orden`) VALUES
(5, 5, '/uploads/productos/5/1780185862979.jpg', 1, '2026-05-30 19:04:22', 0),
(6, 5, '/uploads/productos/5/1780185900710.jpg', 0, '2026-05-30 19:05:00', 0),
(7, 6, '/uploads/productos/6/1780185929293.jpg', 0, '2026-05-30 19:05:29', 0),
(8, 6, '/uploads/productos/6/1780185929357.jpg', 0, '2026-05-30 19:05:29', 0),
(9, 4, '/uploads/productos/4/1780185947799.jpg', 1, '2026-05-30 19:05:47', 0),
(10, 1, '/uploads/productos/1/1780198884744.jpg', 1, '2026-05-30 22:41:24', 0),
(13, 6, '/uploads/productos/6/1780208572506.jpg', 0, '2026-05-31 01:22:52', 0),
(14, 6, '/uploads/productos/6/1780208572537.jpg', 0, '2026-05-31 01:22:52', 0),
(15, 6, '/uploads/productos/6/1780208572574.jpg', 0, '2026-05-31 01:22:52', 0),
(16, 6, '/uploads/productos/6/1780208572595.jpg', 0, '2026-05-31 01:22:52', 0),
(17, 6, '/uploads/productos/6/1780208572615.jpg', 0, '2026-05-31 01:22:52', 0),
(18, 6, '/uploads/productos/6/1780290813995.jpg', 0, '2026-06-01 00:13:34', 0),
(19, 6, '/uploads/productos/6/1780665386373.jpg', 1, '2026-06-05 08:16:26', 0),
(20, 12, '/uploads/productos/12/1782189399087.jpg', 1, '2026-06-22 23:36:39', 0),
(21, 11, '/uploads/productos/11/1782189452851.jpg', 1, '2026-06-22 23:37:32', 0),
(23, 12, '/media/productos/12/1784254090992-89b5948b884d3e8d2fda67a8.webp', 0, '2026-07-16 21:08:11', 0),
(24, 13, '/media/productos/13/1784432855852-3edf9b59e5016fd331a19a29.webp', 1, '2026-07-18 22:47:36', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `razon_social` varchar(200) NOT NULL,
  `ruc` varchar(20) DEFAULT '',
  `contacto` varchar(100) DEFAULT '',
  `telefono` varchar(30) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `direccion` text DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recojo_fechas`
--

CREATE TABLE `recojo_fechas` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `cupos_total` int(11) NOT NULL DEFAULT 10,
  `cupos_usados` int(11) NOT NULL DEFAULT 0,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `sucursal_id` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recojo_fechas`
--

INSERT INTO `recojo_fechas` (`id`, `fecha`, `hora_inicio`, `hora_fin`, `cupos_total`, `cupos_usados`, `estado`, `created_at`, `sucursal_id`, `updated_at`) VALUES
(6, '2026-07-21', '09:00:00', '23:00:00', 10, 0, 0, '2026-07-19 19:27:52', 2, '2026-07-19 20:01:14'),
(7, '2026-07-21', '09:00:00', '23:00:00', 10, 0, 0, '2026-07-19 19:27:56', 1, '2026-07-19 20:01:14'),
(8, '2026-07-21', '09:00:00', '23:00:00', 10, 0, 0, '2026-07-19 19:27:59', 3, '2026-07-19 20:01:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repartidores`
--

CREATE TABLE IF NOT EXISTS `repartidores` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `nombres` varchar(160) NOT NULL,
  `documento` varchar(20) NOT NULL DEFAULT '',
  `telefono` varchar(30) NOT NULL DEFAULT '',
  `licencia` varchar(40) NOT NULL DEFAULT '',
  `categoria_licencia` varchar(20) NOT NULL DEFAULT '',
  `licencia_vencimiento` date DEFAULT NULL,
  `contacto_emergencia` varchar(160) NOT NULL DEFAULT '',
  `telefono_emergencia` varchar(30) NOT NULL DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 activo, 0 inactivo, 2 eliminado',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `repartidores`
--

INSERT INTO `repartidores` (`id`, `usuario_id`, `sucursal_id`, `nombres`, `documento`, `telefono`, `licencia`, `categoria_licencia`, `licencia_vencimiento`, `contacto_emergencia`, `telefono_emergencia`, `estado`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'Antony', '91419121', '999999999', 'Activa', 'A-LLS', '2026-07-16', '', '', 1, '2026-07-16 17:44:08', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas_web`
--

CREATE TABLE `reservas_web` (
  `id` bigint(20) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `estado` enum('activa','consumida','liberada','vencida') NOT NULL DEFAULT 'activa',
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reservas_web`
--

INSERT INTO `reservas_web` (`id`, `pedido_id`, `producto_id`, `sucursal_id`, `cantidad`, `estado`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 2, 7, 2, 1, 'vencida', '2026-07-17 11:56:12', '2026-07-17 11:26:12', '2026-07-17 12:00:35'),
(2, 2, 12, 3, 1, 'vencida', '2026-07-17 11:56:12', '2026-07-17 11:26:12', '2026-07-17 12:00:35'),
(3, 3, 2, 1, 1, 'vencida', '2026-07-17 14:46:13', '2026-07-17 14:16:13', '2026-07-17 14:49:17'),
(4, 3, 3, 1, 3, 'vencida', '2026-07-17 14:46:13', '2026-07-17 14:16:13', '2026-07-17 14:49:17'),
(5, 3, 11, 3, 1, 'vencida', '2026-07-17 14:46:13', '2026-07-17 14:16:13', '2026-07-17 14:49:17'),
(6, 4, 3, 1, 2, 'vencida', '2026-07-17 14:53:28', '2026-07-17 14:23:28', '2026-07-17 14:54:17'),
(7, 5, 11, 3, 1, 'consumida', '2026-07-17 15:30:44', '2026-07-17 15:00:44', '2026-07-17 15:01:42'),
(8, 6, 1, 1, 1, 'vencida', '2026-07-19 19:58:55', '2026-07-19 19:28:55', '2026-07-19 20:01:14'),
(9, 6, 2, 1, 1, 'vencida', '2026-07-19 19:58:55', '2026-07-19 19:28:55', '2026-07-19 20:01:14'),
(10, 6, 4, 2, 1, 'vencida', '2026-07-19 19:58:55', '2026-07-19 19:28:55', '2026-07-19 20:01:14'),
(11, 6, 5, 2, 1, 'vencida', '2026-07-19 19:58:55', '2026-07-19 19:28:55', '2026-07-19 20:01:14'),
(12, 6, 11, 3, 1, 'vencida', '2026-07-19 19:58:55', '2026-07-19 19:28:55', '2026-07-19 20:01:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resumenes_boletas`
--

CREATE TABLE `resumenes_boletas` (
  `id` int(11) NOT NULL,
  `tipo` varchar(5) NOT NULL DEFAULT 'RC' COMMENT 'RC=resumen boletas',
  `identificador` varchar(20) NOT NULL COMMENT 'Ej: 20240101 (fecha) o correlativo',
  `correlativo` int(11) NOT NULL DEFAULT 1,
  `fecha_referencia` date NOT NULL COMMENT 'Fecha de las boletas resumidas',
  `fecha_envio` date NOT NULL,
  `ticket` varchar(100) DEFAULT NULL COMMENT 'Ticket que devuelve SUNAT',
  `estado_sunat` enum('pendiente','enviado','aceptado','rechazado') DEFAULT 'pendiente',
  `cdr_mensaje` varchar(500) DEFAULT NULL,
  `total_boletas` int(11) NOT NULL DEFAULT 0,
  `monto_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sucursal_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resumen_boletas_items`
--

CREATE TABLE `resumen_boletas_items` (
  `id` int(11) NOT NULL,
  `resumen_id` int(11) NOT NULL,
  `comprobante_id` int(11) DEFAULT NULL,
  `serie` varchar(10) NOT NULL,
  `correlativo` varchar(20) NOT NULL,
  `importe_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `op_gravadas` decimal(10,2) NOT NULL DEFAULT 0.00,
  `igv_total` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutas_reparto`
--

CREATE TABLE IF NOT EXISTS `rutas_reparto` (
  `id` int(11) NOT NULL,
  `codigo` varchar(40) NOT NULL,
  `fecha` date NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `repartidor_id` int(11) NOT NULL,
  `vehiculo_id` int(11) NOT NULL,
  `estado` enum('planificada','cargada','en_ruta','completada','cancelada') NOT NULL DEFAULT 'planificada',
  `hora_salida_programada` time DEFAULT NULL,
  `hora_salida_real` datetime DEFAULT NULL,
  `hora_retorno` datetime DEFAULT NULL,
  `km_inicial` decimal(12,2) NOT NULL DEFAULT 0.00,
  `km_final` decimal(12,2) NOT NULL DEFAULT 0.00,
  `observaciones` varchar(500) NOT NULL DEFAULT '',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rutas_reparto`
--

INSERT INTO `rutas_reparto` (`id`, `codigo`, `fecha`, `sucursal_id`, `repartidor_id`, `vehiculo_id`, `estado`, `hora_salida_programada`, `hora_salida_real`, `hora_retorno`, `km_inicial`, `km_final`, `observaciones`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'R-20260716-0001', '2026-07-16', 1, 1, 1, 'planificada', '08:00:00', NULL, NULL, 0.00, 0.00, '', 1, '2026-07-16 17:45:20', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta_reparto_pedidos`
--

CREATE TABLE IF NOT EXISTS `ruta_reparto_pedidos` (
  `id` int(11) NOT NULL,
  `ruta_id` int(11) NOT NULL,
  `pedido_web_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `orden` int(11) NOT NULL DEFAULT 1,
  `cliente_nombre` varchar(200) NOT NULL DEFAULT '',
  `telefono` varchar(30) NOT NULL DEFAULT '',
  `direccion` varchar(500) NOT NULL DEFAULT '',
  `monto_cobrar` decimal(12,2) NOT NULL DEFAULT 0.00,
  `peso_estimado_kg` decimal(12,2) NOT NULL DEFAULT 0.00,
  `monto_cobrado` decimal(12,2) NOT NULL DEFAULT 0.00,
  `metodo_cobro` varchar(30) NOT NULL DEFAULT '',
  `estado` enum('pendiente','en_camino','entregado','no_entregado') NOT NULL DEFAULT 'pendiente',
  `receptor_nombre` varchar(160) NOT NULL DEFAULT '',
  `receptor_documento` varchar(20) NOT NULL DEFAULT '',
  `observacion_entrega` varchar(500) NOT NULL DEFAULT '',
  `entregado_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `series_comprobante`
--

CREATE TABLE `series_comprobante` (
  `id` int(11) NOT NULL,
  `tipo` enum('nota_venta','boleta','factura','nota_credito','nota_debito') NOT NULL,
  `serie` varchar(10) NOT NULL,
  `ultimo_numero` int(11) NOT NULL DEFAULT 0,
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `series_comprobante`
--

INSERT INTO `series_comprobante` (`id`, `tipo`, `serie`, `ultimo_numero`, `estado`) VALUES
(2, 'boleta', 'B001', 20, 0),
(3, 'factura', 'F001', 4, 0),
(4, 'nota_venta', 'NV01', 48, 0),
(130, 'nota_credito', 'FC01', 0, 0),
(131, 'nota_credito', 'BC01', 0, 0),
(132, 'nota_debito', 'FD01', 0, 0),
(133, 'nota_debito', 'BD01', 0, 0),
(998, '', 'NV01', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursales`
--

CREATE TABLE `sucursales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` text DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `telefono` varchar(30) DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp(),
  `monto_inicial_caja` decimal(10,2) NOT NULL DEFAULT 100.00,
  `hora_apertura_caja` time NOT NULL DEFAULT '08:00:00',
  `hora_cierre_caja` time NOT NULL DEFAULT '22:00:00',
  `caja_configurada` tinyint(4) NOT NULL DEFAULT 0,
  `max_cajas` smallint(5) UNSIGNED NOT NULL DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sucursales`
--

INSERT INTO `sucursales` (`id`, `nombre`, `direccion`, `estado`, `telefono`, `created_at`, `monto_inicial_caja`, `hora_apertura_caja`, `hora_cierre_caja`, `caja_configurada`, `max_cajas`) VALUES
(1, 'Gas', 'Av. Gas 100', 0, '', '2026-05-30 00:38:45', 100.00, '08:00:00', '22:00:00', 0, 5),
(2, 'Bidones', 'Av. Bidones 200', 0, '', '2026-05-30 00:38:45', 100.00, '08:00:00', '22:00:00', 0, 5),
(3, 'Sucursal de Acuarios', 'Av. Acuarios 300', 0, '', '2026-06-22 12:54:22', 100.00, '08:00:00', '22:00:00', 0, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temporadas`
--

CREATE TABLE `temporadas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `temporadas`
--

INSERT INTO `temporadas` (`id`, `nombre`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
(1, 'Black Friday', '2026-07-16', '2026-07-30', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temporada_descuentos`
--

CREATE TABLE `temporada_descuentos` (
  `id` int(11) NOT NULL,
  `temporada_id` int(11) NOT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `porcentaje` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `temporada_descuentos`
--

INSERT INTO `temporada_descuentos` (`id`, `temporada_id`, `producto_id`, `categoria_id`, `porcentaje`) VALUES
(1, 1, 12, NULL, 4.00),
(2, 1, 5, NULL, 3.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda_imagenes`
--

CREATE TABLE `tienda_imagenes` (
  `id` int(11) NOT NULL,
  `tipo` enum('logo','slider') NOT NULL,
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `ruta` varchar(500) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tienda_imagenes`
--

INSERT INTO `tienda_imagenes` (`id`, `tipo`, `nombre`, `ruta`, `orden`, `estado`, `created_at`) VALUES
(10, 'logo', 'Logo_Pet.jpeg', '/uploads/logos/1782610423425.jpeg', 0, 1, '2026-06-27 20:33:43'),
(12, 'logo', 'b4db16f1-1df2-4255-ae1c-4066f89baf24.jpg', '/media/logos/1783570185750-ad96ea12f9d6b1c8ebd833fc.webp', 0, 0, '2026-07-08 23:09:46'),
(14, 'slider', 'Panel Administrativo - Google Chrome 16_07_2026 11_09_17.png', '/media/sliders/1784312500471-c345647327d86b6e3598fb93.webp', 1, 1, '2026-07-17 13:21:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `perfil_id` int(11) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `es_global` tinyint(4) NOT NULL DEFAULT 0,
  `puede_operar_caja` tinyint(4) NOT NULL DEFAULT 0,
  `pin_cajero_hash` varchar(255) DEFAULT NULL,
  `login_fail_count` int(11) NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `session_version` int(11) NOT NULL DEFAULT 1,
  `last_login_at` datetime DEFAULT NULL,
  `password_changed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `username`, `email`, `password_hash`, `perfil_id`, `sucursal_id`, `estado`, `created_at`, `es_global`, `puede_operar_caja`, `pin_cajero_hash`, `login_fail_count`, `locked_until`, `session_version`, `last_login_at`, `password_changed_at`) VALUES
(1, 'Admin Principal', 'admin', 'admin@empresa.com', '$2b$12$5qJz30Jjms2kYTRfh5AK4O8PgNqIxy6jj/d44POq3yzqUuesdOayW', 1, NULL, 0, '2026-05-26 15:35:42', 1, 0, NULL, 3, NULL, 2, '2026-07-20 00:24:21', '2026-07-16 23:23:24'),
(2, 'Sara', 'sara', '', '$2b$10$0tc.RidcvxAlLCqhEEqk2.Kw3L/DDTOd.Mn7g3RO0ZMWQvBVPZ.Ba', 2, 2, 0, '2026-05-30 20:54:55', 0, 0, '$2b$10$barSeDMEZkWI5U.4Pv/kS.eKUcD6gM89Fz5Pn1KBQ.6pA2ZGyFCVO', 0, NULL, 16, '2026-07-19 21:05:18', NULL),
(3, 'Juan', 'juan', 'jose@gmail.com', '$2b$10$SCk0sHdsYn098g/xgbCqYOQBlIM0B.F8Le3P7ggbK9n3grx2DD7xm', 2, 2, 0, '2026-05-30 22:46:29', 0, 0, '$2b$10$kuTQiDX1xkAsUwQUGMky3.PnfAuwdZ.FS.A6fERX0W4By9xRk6z6C', 0, NULL, 8, NULL, NULL),
(4, 'Junior', 'junior', 'junior@gmail.com', '$2b$10$ZX2HeDrJ0aVR4ivihtINEuWAtvqbMW6a6WnlXCFay0aGa.MkULhTa', 1, 1, 0, '2026-06-05 00:37:05', 0, 0, NULL, 0, NULL, 1, NULL, NULL),
(8, 'antony campos', 'antony', 'antonycamposgarnique@gmail.com', '$2b$10$mdmNz2Uwfht1LAHPrcnzluGJW0m.DcRMDIpRpB/jIYF0wHtHwshme', 1, 1, 0, '2026-06-05 01:05:46', 0, 0, NULL, 0, NULL, 3, NULL, NULL),
(9, 'Valeria', 'valeria', 'valeria@gmail.com', '$2b$10$OiZkgODpA6xsvzf.7vPKcO.SyRBV1o5on5LZUh4FPMQ4Cd1N.Pya.', 2, 3, 0, '2026-06-23 01:36:30', 0, 0, '$2b$10$UWOes2v/jdcmTNUPTMr2AOyyqoY5j0ddeGkW.wrMcem5XASBHwlk.', 0, NULL, 11, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_caja_accesos`
--

CREATE TABLE `usuario_caja_accesos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `caja_id` int(11) NOT NULL,
  `activo` tinyint(4) NOT NULL DEFAULT 1,
  `asignado_por` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE IF NOT EXISTS `vehiculos` (
  `id` int(11) NOT NULL,
  `sucursal_id` int(11) DEFAULT NULL,
  `placa` varchar(15) NOT NULL,
  `tipo` varchar(30) NOT NULL DEFAULT 'camion',
  `marca` varchar(60) NOT NULL DEFAULT '',
  `modelo` varchar(60) NOT NULL DEFAULT '',
  `anio` smallint(6) DEFAULT NULL,
  `capacidad_kg` decimal(12,2) NOT NULL DEFAULT 0.00,
  `capacidad_m3` decimal(10,2) NOT NULL DEFAULT 0.00,
  `soat_vencimiento` date DEFAULT NULL,
  `revision_vencimiento` date DEFAULT NULL,
  `estado_operativo` enum('disponible','en_ruta','mantenimiento','inactivo') NOT NULL DEFAULT 'disponible',
  `observaciones` varchar(500) NOT NULL DEFAULT '',
  `estado` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 activo, 0 inactivo, 2 eliminado',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id`, `sucursal_id`, `placa`, `tipo`, `marca`, `modelo`, `anio`, `capacidad_kg`, `capacidad_m3`, `soat_vencimiento`, `revision_vencimiento`, `estado_operativo`, `observaciones`, `estado`, `created_at`, `updated_at`) VALUES
(1, NULL, 'AFS', 'camion', 'FSA', 'FYVJ', 2027, 120.00, 34.00, '2026-07-23', '2026-07-22', 'disponible', '', 1, '2026-07-16 17:45:01', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `serie` varchar(10) NOT NULL DEFAULT 'V001',
  `tipo_comprobante` enum('nota','boleta','factura','nota_venta','cotizacion') NOT NULL DEFAULT 'nota',
  `tipo_entrega` enum('presencial','delivery','recojo') NOT NULL DEFAULT 'presencial',
  `tipo_venta` enum('contado','credito') NOT NULL DEFAULT 'contado',
  `cliente_id` int(11) DEFAULT NULL,
  `vendedor_id` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `sucursal_id` int(11) NOT NULL DEFAULT 1,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `igv` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `igv_porcentaje` decimal(5,2) NOT NULL DEFAULT 18.00,
  `estado` enum('pendiente_pago','pagado','aprobado','rechazado','anulada','pendiente','pagada') NOT NULL DEFAULT 'pendiente_pago',
  `estado_venta` enum('registrada','anulada') NOT NULL DEFAULT 'registrada',
  `estado_sunat` enum('sin_emitir','emitido','aceptado','rechazado') NOT NULL DEFAULT 'sin_emitir',
  `metodo_pago` enum('efectivo','yape','plin','transferencia','izipay','credito') DEFAULT 'efectivo',
  `observacion` text DEFAULT '',
  `cotizacion_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `caja_id` int(11) DEFAULT NULL,
  `canal` varchar(20) NOT NULL DEFAULT 'pos',
  `cliente_web_nombre` varchar(200) DEFAULT '',
  `cliente_web_doc` varchar(20) DEFAULT '',
  `pedido_web_id` int(11) DEFAULT NULL,
  `es_multisucursal` tinyint(4) NOT NULL DEFAULT 0,
  `cliente_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`cliente_snapshot`)),
  `direccion_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`direccion_snapshot`)),
  `facturacion_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`facturacion_snapshot`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `numero`, `serie`, `tipo_comprobante`, `tipo_entrega`, `tipo_venta`, `cliente_id`, `vendedor_id`, `updated_by`, `sucursal_id`, `subtotal`, `igv`, `total`, `igv_porcentaje`, `estado`, `estado_venta`, `estado_sunat`, `metodo_pago`, `observacion`, `cotizacion_id`, `created_by`, `created_at`, `updated_at`, `descuento`, `caja_id`, `canal`, `cliente_web_nombre`, `cliente_web_doc`, `pedido_web_id`, `es_multisucursal`, `cliente_snapshot`, `direccion_snapshot`, `facturacion_snapshot`) VALUES
(1, 'F001-000001', 'NV01', 'factura', 'presencial', 'contado', 8, 1, NULL, 1, 931.00, 0.00, 931.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-07 16:57:09', '2026-06-07 16:58:12', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(2, 'B001-000001', 'NV01', 'boleta', 'presencial', 'contado', 13, 1, NULL, 1, 60.00, 0.00, 60.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-08 09:14:46', '2026-06-08 09:14:54', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(3, 'B001-000002', 'NV01', 'boleta', 'presencial', 'contado', 6, 3, NULL, 2, 23.00, 0.00, 23.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 3, '2026-06-08 09:23:59', '2026-06-08 09:29:37', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(4, 'F001-000002', 'NV01', 'factura', 'presencial', 'contado', 8, 3, NULL, 2, 35.00, 0.00, 35.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 3, '2026-06-08 09:30:36', '2026-06-08 09:30:44', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(5, 'B001-000003', 'NV01', 'boleta', 'presencial', 'contado', 15, 1, NULL, 1, 33.00, 0.00, 33.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-08 09:58:54', '2026-06-08 09:59:05', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(6, 'B001-000004', 'NV01', 'boleta', 'presencial', 'contado', 6, 1, NULL, 1, 258.00, 0.00, 258.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-08 14:04:29', '2026-06-08 14:05:04', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(7, 'NV01-000007', 'NV01', 'nota', 'presencial', 'contado', NULL, 1, NULL, 1, 10.00, 0.00, 10.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-08 23:27:54', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(8, 'NV01-000008', 'NV01', 'nota', 'presencial', 'contado', NULL, 1, NULL, 1, 5.00, 0.00, 5.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-08 23:29:31', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(11, 'B001-000005', 'NV01', 'boleta', 'presencial', 'contado', 6, 2, NULL, 1, 310.00, 0.00, 300.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 2, '2026-06-09 00:33:25', '2026-06-09 00:33:51', 10.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(12, 'B001-000006', 'NV01', 'boleta', 'presencial', 'contado', 6, 1, NULL, 1, 73.00, 0.00, 73.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-09 00:55:47', '2026-06-09 00:56:06', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(13, 'B001-000007', 'NV01', 'boleta', 'presencial', 'contado', 6, 1, NULL, 1, 240.00, 0.00, 240.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-09 12:01:27', '2026-06-09 12:02:05', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(14, 'F001-000004', 'NV01', 'factura', 'presencial', 'contado', 8, 1, NULL, 1, 10.00, 0.00, 10.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-09 12:09:43', '2026-07-18 21:22:29', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(15, 'B001-000008', 'NV01', 'boleta', 'presencial', 'contado', 6, 1, NULL, 1, 126.00, 0.00, 126.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-15 08:41:37', '2026-06-15 08:42:12', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(16, 'F001-000003', 'NV01', 'factura', 'presencial', 'contado', 8, 1, NULL, 1, 343.00, 0.00, 343.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-16 11:39:31', '2026-06-16 11:39:39', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(17, 'B001-000009', 'NV01', 'boleta', 'presencial', 'contado', 6, 1, NULL, 1, 10.00, 0.00, 10.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 1, '2026-06-16 12:28:24', '2026-06-16 12:39:37', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(18, 'NV01-000018', 'NV01', 'nota', 'presencial', 'contado', 6, 1, NULL, 1, 491.00, 0.00, 491.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 1, 1, '2026-06-16 12:54:47', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(19, 'NV01-000019', 'NV01', 'nota', 'presencial', 'contado', 13, 1, NULL, 1, 335.00, 0.00, 335.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 4, 1, '2026-06-16 13:09:30', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(20, 'NV01-000020', 'NV01', 'nota', 'presencial', 'contado', 6, 1, NULL, 1, 238.00, 0.00, 238.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 1, 1, '2026-06-16 15:15:21', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(21, 'NV01-000021', 'NV01', 'nota', 'presencial', 'contado', 13, 1, NULL, 1, 335.00, 0.00, 335.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 4, 1, '2026-06-18 10:23:50', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(22, 'NV01-000022', 'NV01', 'nota', 'presencial', 'contado', 13, 1, NULL, 1, 335.00, 0.00, 335.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '...', 4, 1, '2026-06-20 00:01:56', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(23, 'NV01-000023', 'NV01', 'nota', 'presencial', 'contado', 6, 1, NULL, 1, 90.00, 0.00, 90.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-20 00:04:25', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(24, 'B001-000010', 'NV01', 'boleta', 'presencial', 'contado', 13, 1, NULL, 1, 325.00, 0.00, 325.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 4, 1, '2026-06-20 00:37:01', '2026-06-20 15:28:56', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(26, 'B001-000012', 'NV01', 'boleta', 'presencial', 'contado', 13, 1, NULL, 1, 320.00, 0.00, 320.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 4, 1, '2026-06-20 16:27:40', '2026-06-20 18:21:24', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(29, 'NV01-000026', 'NV01', 'nota', 'presencial', 'contado', 17, 1, 1, 1, 375.00, 0.00, 375.00, 18.00, 'pendiente_pago', 'anulada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-20 18:14:07', '2026-06-20 18:15:48', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(30, 'B001-000011', 'NV01', 'boleta', 'presencial', 'contado', 13, 1, NULL, 1, 335.00, 0.00, 335.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 4, 1, '2026-06-20 18:16:29', '2026-06-20 18:20:35', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(31, 'B001-000013', 'NV01', 'boleta', 'presencial', 'contado', 13, 4, NULL, 1, 335.00, 0.00, 335.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 4, 4, '2026-06-20 18:43:27', '2026-06-20 18:43:43', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(32, 'B001-000017', 'NV01', 'boleta', 'presencial', 'contado', 6, 4, NULL, 1, 335.00, 0.00, 335.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 4, 4, '2026-06-20 18:44:05', '2026-06-27 12:17:49', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(33, 'B001-000014', 'NV01', 'boleta', 'presencial', 'contado', 16, 1, NULL, 1, 310.00, 0.00, 310.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 5, 1, '2026-06-21 23:18:34', '2026-06-21 23:52:40', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(34, 'B001-000015', 'NV01', 'boleta', 'presencial', 'contado', 16, 1, NULL, 1, 310.00, 0.00, 310.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 5, 1, '2026-06-22 10:40:43', '2026-06-23 10:51:44', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(35, 'B001-000016', 'NV01', 'boleta', 'presencial', 'contado', 13, 2, NULL, 1, 2875.00, 0.00, 2875.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 2, '2026-06-24 21:17:16', '2026-06-24 21:17:24', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(36, 'NV01-000033', 'NV01', 'nota', 'presencial', 'contado', 13, 1, NULL, 2, 40.00, 0.00, 40.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-25 11:38:02', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(37, 'NV01-000034', 'NV01', 'nota', 'presencial', 'contado', NULL, 1, 1, 3, 18.00, 0.00, 18.00, 18.00, 'pendiente_pago', 'anulada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-25 11:45:21', '2026-06-26 00:02:15', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(38, 'NV01-000035', 'NV01', 'nota', 'presencial', 'contado', 12, 2, NULL, 1, 295.00, 0.00, 295.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 2, '2026-06-26 16:49:47', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(39, 'NV01-000036', 'NV01', 'nota', 'presencial', 'contado', 6, 9, NULL, 3, 198.00, 0.00, 198.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 9, '2026-06-27 00:10:53', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(40, 'NV01-000037', 'NV01', 'nota', 'presencial', 'contado', NULL, 1, 1, 1, 30.00, 0.00, 30.00, 18.00, 'pendiente_pago', 'anulada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-27 14:04:33', '2026-07-16 20:39:14', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(41, 'NV01-000038', 'NV01', 'nota', 'presencial', 'contado', NULL, 1, 1, 1, 10.00, 0.00, 10.00, 18.00, 'pendiente_pago', 'anulada', 'sin_emitir', 'efectivo', '', 13, 1, '2026-06-27 20:04:13', '2026-07-17 14:56:00', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(42, 'NV01-000039', 'NV01', 'nota', 'presencial', 'contado', 6, 1, NULL, 1, 48.00, 0.00, 48.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', NULL, 1, '2026-06-27 20:57:49', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(43, 'NV01-000040', 'NV01', 'nota', 'presencial', 'contado', NULL, 1, NULL, 1, 30.00, 0.00, 30.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 14, 1, '2026-07-01 14:26:05', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(44, 'NV01-000041', 'NV01', 'nota', 'presencial', 'contado', NULL, 2, NULL, 1, 30.00, 0.00, 30.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 14, 2, '2026-07-03 11:48:33', NULL, 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(45, 'NV01-000042', 'NV01', 'nota', 'presencial', 'contado', 8, 1, NULL, 1, 30.00, 0.00, 30.00, 18.00, 'pendiente_pago', 'registrada', 'sin_emitir', 'efectivo', '', 14, 1, '2026-07-03 12:01:35', '2026-07-18 21:17:22', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(46, 'B001-000018', 'NV01', 'boleta', 'presencial', 'contado', 6, 1, NULL, 1, 30.00, 0.00, 30.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 14, 1, '2026-07-03 12:10:10', '2026-07-03 12:18:17', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(47, 'B001-000019', 'NV01', 'boleta', 'presencial', 'contado', 6, 2, NULL, 2, 10.00, 0.00, 10.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', NULL, 2, '2026-07-07 00:19:52', '2026-07-16 17:48:01', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(50, 'B001-000020', 'NV01', 'boleta', 'presencial', 'contado', 16, 1, NULL, 1, 310.00, 0.00, 310.00, 18.00, 'pendiente_pago', 'registrada', 'aceptado', 'efectivo', '', 5, 1, '2026-07-16 18:41:16', '2026-07-16 19:01:10', 0.00, NULL, 'pos', '', '', NULL, 0, NULL, NULL, NULL),
(56, 'NV01-000046', 'NV01', 'nota_venta', 'delivery', 'contado', 6, 1, NULL, 1, 60.60, 0.00, 60.60, 18.00, 'aprobado', 'registrada', 'sin_emitir', 'yape', 'Venta generada desde pedido web WEB-000002. Canal: ecommerce.', NULL, 1, '2026-07-17 12:57:28', NULL, 0.00, NULL, 'web', 'ANTONY BRAYAN CAMPOS GARNIQUE', '75107608', 2, 1, '{\"tipo_doc\":\"dni\",\"numero_doc\":\"75107608\",\"nombre\":\"ANTONY BRAYAN\",\"razon_social\":\"\",\"apellido_paterno\":\"CAMPOS\",\"apellido_materno\":\"GARNIQUE\",\"nombre_completo\":\"ANTONY BRAYAN CAMPOS GARNIQUE\",\"direccion_api\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"CHICLAYO\",\"departamento\":\"LAMBAYEQUE\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-17 11:25:51\",\"nombres\":\"ANTONY BRAYAN\",\"direccion_entrega\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"receptor\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{\"departamento\":\"LAMBAYEQUE\",\"provincia\":\"CHICLAYO\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"recibe\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{}'),
(57, 'NV01-000047', 'NV01', 'nota_venta', 'delivery', 'contado', 8, 1, NULL, 3, 12.00, 0.00, 12.00, 18.00, 'aprobado', 'registrada', 'sin_emitir', 'yape', 'Venta generada desde pedido web WEB-000005. Canal: ecommerce.', NULL, 1, '2026-07-17 15:01:42', NULL, 0.00, NULL, 'web', 'EMP. DE TRANS. FLORES HNOS. SRL.', '20119407738', 5, 0, '{\"tipo_doc\":\"ruc\",\"numero_doc\":\"20119407738\",\"nombre\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"razon_social\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"apellido_paterno\":\"\",\"apellido_materno\":\"\",\"nombre_completo\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"direccion_api\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"LIMA\",\"departamento\":\"LIMA\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-17 15:00:35\",\"nombres\":\"EMP. DE TRANS. FLORES HNOS. SRL.\",\"direccion_entrega\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"referencia\":\"fafsas\",\"lat\":null,\"lng\":null,\"receptor\":\"EMP. DE TRANS. FLORES HNOS. SRL.\"}', '{\"departamento\":\"LIMA\",\"provincia\":\"LIMA\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"AV. PASEO DE LA REPUBLICA 619 NRO. 627      CERCADO\",\"referencia\":\"fafsas\",\"lat\":null,\"lng\":null,\"recibe\":\"EMP. DE TRANS. FLORES HNOS. SRL.\"}', '{}'),
(62, 'NV01-000048', 'NV01', 'nota_venta', 'recojo', 'contado', 6, 1, NULL, 1, 301.85, 0.00, 301.85, 18.00, 'aprobado', 'registrada', 'sin_emitir', 'yape', 'Venta generada desde pedido web WEB-000006. Canal: ecommerce.', NULL, 1, '2026-07-20 00:42:10', NULL, 0.00, NULL, 'web', 'ANTONY BRAYAN CAMPOS GARNIQUE', '75107608', 6, 1, '{\"tipo_doc\":\"dni\",\"numero_doc\":\"75107608\",\"nombre\":\"ANTONY BRAYAN\",\"razon_social\":\"\",\"apellido_paterno\":\"CAMPOS\",\"apellido_materno\":\"GARNIQUE\",\"nombre_completo\":\"ANTONY BRAYAN CAMPOS GARNIQUE\",\"direccion_api\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"distrito\":\"LA VICTORIA\",\"provincia\":\"CHICLAYO\",\"departamento\":\"LAMBAYEQUE\",\"telefono\":\"952903481\",\"email\":\"antonycamposgarnique@gmail.com\",\"origen\":\"cliente_erp\",\"consultado_en\":\"2026-07-19 19:28:20\",\"nombres\":\"ANTONY BRAYAN\",\"direccion_entrega\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"receptor\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{\"departamento\":\"LAMBAYEQUE\",\"provincia\":\"CHICLAYO\",\"distrito\":\"LA VICTORIA\",\"direccion\":\"CARRETERA PANAMERICANA SUR KM. 7 PP.JJ. CHOSICA DEL NORTE\",\"referencia\":\"\",\"lat\":null,\"lng\":null,\"recibe\":\"ANTONY BRAYAN CAMPOS GARNIQUE\"}', '{}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_items`
--

CREATE TABLE `venta_items` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unit` decimal(10,2) NOT NULL,
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subtotal` decimal(10,2) NOT NULL,
  `descuento_unit` decimal(10,2) DEFAULT 0.00,
  `sucursal_id` int(11) DEFAULT NULL,
  `costo_unitario` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `venta_items`
--

INSERT INTO `venta_items` (`id`, `venta_id`, `producto_id`, `presentacion_id`, `cantidad`, `precio_unit`, `descuento`, `subtotal`, `descuento_unit`, `sucursal_id`, `costo_unitario`) VALUES
(1, 1, 1, NULL, 2, 65.00, 0.00, 130.00, 0.00, NULL, 0.00),
(2, 1, 2, NULL, 3, 220.00, 0.00, 660.00, 0.00, NULL, 0.00),
(3, 1, 6, NULL, 2, 10.00, 0.00, 20.00, 0.00, NULL, 0.00),
(4, 1, 3, NULL, 4, 25.00, 0.00, 100.00, 0.00, NULL, 0.00),
(5, 1, 7, NULL, 2, 3.00, 0.00, 6.00, 0.00, NULL, 0.00),
(6, 1, 5, NULL, 2, 5.00, 0.00, 10.00, 0.00, NULL, 0.00),
(7, 1, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(8, 2, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(9, 2, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(10, 2, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(11, 2, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(12, 2, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(13, 3, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(14, 3, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(15, 3, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(16, 4, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(17, 4, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(18, 4, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(19, 4, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(20, 5, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(21, 5, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(22, 5, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(23, 5, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(24, 6, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(25, 6, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(26, 6, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(27, 6, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(28, 7, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(29, 8, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(30, 9, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(31, 10, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(32, 11, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(33, 11, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(34, 11, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(35, 12, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(36, 12, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(37, 12, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(38, 13, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(39, 13, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(40, 13, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(41, 14, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(42, 14, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(43, 15, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(44, 15, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(45, 15, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(46, 15, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(47, 15, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(48, 15, 7, NULL, 2, 3.00, 0.00, 6.00, 0.00, NULL, 0.00),
(49, 16, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(50, 16, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(51, 16, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(52, 16, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(53, 16, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(54, 16, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(55, 16, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(56, 17, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(57, 18, 5, NULL, 2, 5.00, 0.00, 10.00, 0.00, NULL, 0.00),
(58, 18, 2, NULL, 2, 220.00, 0.00, 440.00, 0.00, NULL, 0.00),
(59, 18, 6, NULL, 2, 10.00, 0.00, 20.00, 0.00, NULL, 0.00),
(60, 18, 7, NULL, 2, 3.00, 0.00, 6.00, 0.00, NULL, 0.00),
(61, 18, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(62, 19, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(63, 19, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(64, 19, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(65, 19, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(66, 19, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(67, 19, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(68, 19, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(69, 20, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(70, 20, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(71, 20, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(72, 20, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(73, 21, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(74, 21, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(75, 21, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(76, 21, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(77, 21, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(78, 21, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(79, 21, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(80, 22, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(81, 22, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(82, 22, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(83, 22, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(84, 22, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(85, 22, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(86, 22, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(87, 23, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(88, 23, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(89, 23, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(90, 23, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(91, 24, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(92, 24, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(93, 24, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(94, 24, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(95, 24, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(96, 24, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(102, 26, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(103, 26, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(104, 26, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(105, 26, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(106, 26, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(120, 29, 6, NULL, 6, 10.00, 0.00, 60.00, 0.00, NULL, 0.00),
(121, 29, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(122, 29, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(123, 29, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(124, 29, 8, NULL, 2, 5.00, 0.00, 10.00, 0.00, NULL, 0.00),
(125, 29, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(126, 30, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(127, 30, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(128, 30, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(129, 30, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(130, 30, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(131, 30, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(132, 30, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(133, 31, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(134, 31, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(135, 31, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(136, 31, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(137, 31, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(138, 31, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(139, 31, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(140, 32, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(141, 32, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(142, 32, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(143, 32, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(144, 32, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(145, 32, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(146, 32, 7, NULL, 5, 3.00, 0.00, 15.00, 0.00, NULL, 0.00),
(147, 33, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(148, 33, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(149, 33, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(150, 34, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, NULL, 0.00),
(151, 34, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(152, 34, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(153, 35, 1, NULL, 10, 65.00, 0.00, 650.00, 0.00, NULL, 0.00),
(154, 35, 2, NULL, 10, 220.00, 0.00, 2200.00, 0.00, NULL, 0.00),
(155, 35, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(156, 36, 12, NULL, 1, 18.00, 0.00, 18.00, 0.00, NULL, 0.00),
(157, 36, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(158, 36, 11, NULL, 1, 12.00, 0.00, 12.00, 0.00, NULL, 0.00),
(159, 37, 12, NULL, 1, 18.00, 0.00, 18.00, 0.00, NULL, 0.00),
(160, 38, 1, NULL, 1, 50.00, 0.00, 50.00, 0.00, NULL, 0.00),
(161, 38, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, NULL, 0.00),
(162, 38, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, NULL, 0.00),
(163, 39, 12, NULL, 9, 18.00, 0.00, 162.00, 0.00, NULL, 0.00),
(164, 39, 11, NULL, 3, 12.00, 0.00, 36.00, 0.00, NULL, 0.00),
(165, 40, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(166, 40, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(167, 40, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(168, 41, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(169, 42, 6, NULL, 2, 10.00, 0.00, 20.00, 0.00, NULL, 0.00),
(170, 42, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(171, 42, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(172, 42, 5, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(173, 42, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, NULL, 0.00),
(174, 43, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(175, 43, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(176, 43, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(177, 44, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(178, 44, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(179, 44, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(180, 45, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(181, 45, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(182, 45, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(183, 46, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(184, 46, 8, NULL, 1, 5.00, 0.00, 5.00, 0.00, NULL, 0.00),
(185, 46, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, NULL, 0.00),
(186, 47, 6, NULL, 1, 10.00, 0.00, 10.00, 0.00, NULL, 0.00),
(187, 50, 1, NULL, 1, 65.00, 0.00, 65.00, 0.00, 1, 20.00),
(188, 50, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, 1, 150.00),
(189, 50, 3, NULL, 1, 25.00, 0.00, 25.00, 0.00, 1, 0.00),
(190, 56, 7, NULL, 1, 3.00, 0.00, 3.00, 0.00, 2, 1.00),
(191, 56, 12, NULL, 1, 57.60, 0.00, 57.60, 0.00, 3, 40.00),
(192, 57, 11, NULL, 1, 12.00, 0.00, 12.00, 0.00, 3, 0.00),
(193, 62, 1, NULL, 1, 50.00, 0.00, 50.00, 0.00, 1, 20.00),
(194, 62, 2, NULL, 1, 220.00, 0.00, 220.00, 0.00, 1, 150.00),
(195, 62, 4, NULL, 1, 15.00, 0.00, 15.00, 0.00, 2, 8.00),
(196, 62, 5, NULL, 1, 4.85, 0.00, 4.85, 0.00, 2, 0.00),
(197, 62, 11, NULL, 1, 12.00, 0.00, 12.00, 0.00, 3, 0.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `app_sessions`
--
ALTER TABLE `app_sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_modulo` (`modulo`),
  ADD KEY `idx_fecha` (`created_at`);

--
-- Indices de la tabla `auditoria_eventos`
--
ALTER TABLE `auditoria_eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_auditoria_usuario_fecha` (`usuario_id`,`created_at`),
  ADD KEY `idx_auditoria_modulo_fecha` (`modulo`,`created_at`),
  ADD KEY `idx_auditoria_entidad` (`entidad`,`entidad_id`);

--
-- Indices de la tabla `cajas`
--
ALTER TABLE `cajas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_caja_estado` (`estado`),
  ADD KEY `idx_caja_sucursal` (`sucursal_id`),
  ADD KEY `idx_caja_sesion_fisica` (`caja_fisica_id`,`estado`),
  ADD KEY `idx_caja_sesion_usuario` (`usuario_apertura_id`,`estado`),
  ADD KEY `idx_caja_cierre_programado` (`fecha_cierre_programada`);

--
-- Indices de la tabla `cajas_fisicas`
--
ALTER TABLE `cajas_fisicas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_caja_fisica_sucursal_codigo` (`sucursal_id`,`codigo`),
  ADD KEY `idx_caja_fisica_sucursal_activo` (`sucursal_id`,`activo`),
  ADD KEY `idx_caja_fisica_sucursal` (`sucursal_id`,`activo`);

--
-- Indices de la tabla `caja_movimientos`
--
ALTER TABLE `caja_movimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sesion` (`sesion_id`);

--
-- Indices de la tabla `caja_sesiones`
--
ALTER TABLE `caja_sesiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sucursal` (`sucursal_id`),
  ADD KEY `conciliada_por` (`conciliada_por`),
  ADD KEY `revertida_por` (`revertida_por`),
  ADD KEY `idx_caja_usuario` (`usuario_id`,`estado`),
  ADD KEY `idx_caja_sucursal` (`sucursal_id`,`abierta_at`),
  ADD KEY `idx_caja_numero` (`numero_caja`,`sucursal_id`),
  ADD KEY `idx_caja_sesion_usuario_estado` (`usuario_id`,`estado`),
  ADD KEY `idx_caja_sesion_fisica_estado` (`caja_fisica_id`,`estado`),
  ADD KEY `idx_caja_sesion_estado_arqueo` (`estado`,`bloqueada_at`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_doc` (`numero_doc`);

--
-- Indices de la tabla `clientes_web`
--
ALTER TABLE `clientes_web`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_email` (`email`),
  ADD UNIQUE KEY `uq_google` (`google_id`),
  ADD KEY `idx_cliente` (`cliente_id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compra_items`
--
ALTER TABLE `compra_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_compra` (`compra_id`);

--
-- Indices de la tabla `comprobantes`
--
ALTER TABLE `comprobantes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_venta` (`venta_id`),
  ADD UNIQUE KEY `uq_serie_numero` (`tipo`,`serie`,`numero`);

--
-- Indices de la tabla `comunicaciones_baja`
--
ALTER TABLE `comunicaciones_baja`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `comunicacion_baja_items`
--
ALTER TABLE `comunicacion_baja_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_baja` (`baja_id`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`clave`);

--
-- Indices de la tabla `correlativos_comprobante`
--
ALTER TABLE `correlativos_comprobante`
  ADD PRIMARY KEY (`serie`);

--
-- Indices de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cotizacion_items`
--
ALTER TABLE `cotizacion_items`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `creditos`
--
ALTER TABLE `creditos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_venta` (`venta_id`);

--
-- Indices de la tabla `crm_cliente_etiquetas`
--
ALTER TABLE `crm_cliente_etiquetas`
  ADD PRIMARY KEY (`cliente_id`,`etiqueta_id`);

--
-- Indices de la tabla `crm_etiquetas`
--
ALTER TABLE `crm_etiquetas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_crm_etiqueta_sucursal` (`nombre`,`sucursal_id`);

--
-- Indices de la tabla `crm_interacciones`
--
ALTER TABLE `crm_interacciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_crm_interaccion_cliente` (`cliente_id`,`created_at`),
  ADD KEY `idx_crm_interaccion_proximo` (`proximo_contacto_at`);

--
-- Indices de la tabla `crm_tareas`
--
ALTER TABLE `crm_tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_crm_tarea_asignado` (`asignado_a`,`estado`,`vence_at`),
  ADD KEY `idx_crm_tarea_cliente` (`cliente_id`);

--
-- Indices de la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cliente` (`cliente_id`),
  ADD KEY `idx_venta` (`venta_id`);

--
-- Indices de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_credito` (`credito_id`);

--
-- Indices de la tabla `despachos_web`
--
ALTER TABLE `despachos_web`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `venta_id` (`venta_id`),
  ADD UNIQUE KEY `idx_despacho_venta` (`venta_id`),
  ADD KEY `idx_despacho_sucursal` (`sucursal_id`),
  ADD KEY `idx_despacho_estado` (`estado`),
  ADD KEY `idx_despacho_pedido` (`pedido_web_id`),
  ADD KEY `idx_despacho_estado_v24` (`estado`),
  ADD KEY `idx_despacho_sucursal_v24` (`sucursal_id`);

--
-- Indices de la tabla `detalle_cotizaciones`
--
ALTER TABLE `detalle_cotizaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cotizacion` (`cotizacion_id`);

--
-- Indices de la tabla `detalle_pedidos_web`
--
ALTER TABLE `detalle_pedidos_web`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pedido` (`pedido_id`);

--
-- Indices de la tabla `direcciones_web`
--
ALTER TABLE `direcciones_web`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clienteweb` (`cliente_web_id`);

--
-- Indices de la tabla `documentos_publicos`
--
ALTER TABLE `documentos_publicos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_documento_token` (`token_hash`),
  ADD KEY `idx_documento_entidad` (`tipo`,`entidad_id`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pres_almacen` (`presentacion_id`,`almacen_id`);

--
-- Indices de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prod` (`producto_id`),
  ADD KEY `idx_suc` (`sucursal_id`);

--
-- Indices de la tabla `inventario_transferencias`
--
ALTER TABLE `inventario_transferencias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_transferencia_codigo` (`codigo`),
  ADD KEY `idx_transferencia_origen` (`sucursal_origen_id`,`estado`),
  ADD KEY `idx_transferencia_destino` (`sucursal_destino_id`,`estado`);

--
-- Indices de la tabla `inventario_transferencia_items`
--
ALTER TABLE `inventario_transferencia_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_transferencia_producto` (`transferencia_id`,`producto_id`);

--
-- Indices de la tabla `login_intentos`
--
ALTER TABLE `login_intentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_login_identificador_fecha` (`identificador`,`created_at`),
  ADD KEY `idx_login_ip_fecha` (`ip`,`created_at`),
  ADD KEY `idx_login_usuario_fecha` (`usuario_id`,`created_at`);

--
-- Indices de la tabla `logos_temporada`
--
ALTER TABLE `logos_temporada`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_venta` (`venta_id`);

--
-- Indices de la tabla `pagos_credito`
--
ALTER TABLE `pagos_credito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cuenta` (`cuenta_id`);

--
-- Indices de la tabla `pagos_operaciones_unicas`
--
ALTER TABLE `pagos_operaciones_unicas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pago_operacion` (`metodo`,`referencia`),
  ADD KEY `idx_pago_operacion_venta` (`venta_id`);

--
-- Indices de la tabla `pagos_verificacion`
--
ALTER TABLE `pagos_verificacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_venta` (`venta_id`),
  ADD KEY `idx_suc` (`sucursal_id`),
  ADD KEY `idx_pago_fecha` (`created_at`),
  ADD KEY `idx_pagos_pedido_web` (`pedido_web_id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_password_reset_hash` (`token_hash`),
  ADD KEY `idx_password_reset_usuario` (`usuario_id`,`expires_at`);

--
-- Indices de la tabla `pedidos_web`
--
ALTER TABLE `pedidos_web`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_pedido_codigo` (`codigo`),
  ADD KEY `idx_pw_clienteweb` (`cliente_web_id`);

--
-- Indices de la tabla `pedido_entregas_sucursal`
--
ALTER TABLE `pedido_entregas_sucursal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_entrega_pedido_sucursal` (`pedido_id`,`sucursal_id`),
  ADD UNIQUE KEY `uq_codigo_recojo_hash` (`codigo_recojo_hash`),
  ADD KEY `idx_entrega_sucursal_estado` (`sucursal_id`,`estado`);

--
-- Indices de la tabla `pedido_items`
--
ALTER TABLE `pedido_items`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedido_recojo_reservas`
--
ALTER TABLE `pedido_recojo_reservas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_recojo_pedido_sucursal` (`pedido_id`,`sucursal_id`),
  ADD KEY `idx_recojo_horario_estado` (`horario_id`,`estado`);

--
-- Indices de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `perfil_opciones`
--
ALTER TABLE `perfil_opciones`
  ADD PRIMARY KEY (`perfil_id`,`opcion_id`);

--
-- Indices de la tabla `perfil_permisos`
--
ALTER TABLE `perfil_permisos`
  ADD PRIMARY KEY (`perfil_id`,`opcion_id`);

--
-- Indices de la tabla `perfil_permisos_accion`
--
ALTER TABLE `perfil_permisos_accion`
  ADD PRIMARY KEY (`perfil_id`,`permiso_id`),
  ADD KEY `idx_ppa_permiso` (`permiso_id`);

--
-- Indices de la tabla `permisos_accion`
--
ALTER TABLE `permisos_accion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_permiso_accion_slug` (`slug`),
  ADD KEY `idx_permiso_modulo` (`modulo`);

--
-- Indices de la tabla `precios_volumen`
--
ALTER TABLE `precios_volumen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_producto` (`producto_id`);

--
-- Indices de la tabla `presentaciones`
--
ALTER TABLE `presentaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_producto` (`producto_id`);

--
-- Indices de la tabla `presentaciones_catalogo`
--
ALTER TABLE `presentaciones_catalogo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto_imagenes`
--
ALTER TABLE `producto_imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_producto` (`producto_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recojo_fechas`
--
ALTER TABLE `recojo_fechas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_recojo_sucursal_fecha` (`sucursal_id`,`fecha`,`estado`);

--
-- Indices de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_repartidor_usuario` (`usuario_id`),
  ADD KEY `idx_repartidor_sucursal_estado` (`sucursal_id`,`estado`),
  ADD KEY `idx_repartidor_documento` (`documento`);

--
-- Indices de la tabla `reservas_web`
--
ALTER TABLE `reservas_web`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_reserva_pedido_producto_sucursal` (`pedido_id`,`producto_id`,`sucursal_id`),
  ADD KEY `idx_reserva_producto_estado` (`producto_id`,`sucursal_id`,`estado`,`expires_at`);

--
-- Indices de la tabla `resumenes_boletas`
--
ALTER TABLE `resumenes_boletas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fecha` (`fecha_referencia`);

--
-- Indices de la tabla `resumen_boletas_items`
--
ALTER TABLE `resumen_boletas_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_resumen` (`resumen_id`);

--
-- Indices de la tabla `rutas_reparto`
--
ALTER TABLE `rutas_reparto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ruta_codigo` (`codigo`),
  ADD KEY `idx_ruta_fecha_sucursal` (`fecha`,`sucursal_id`),
  ADD KEY `idx_ruta_repartidor` (`repartidor_id`,`fecha`,`estado`),
  ADD KEY `idx_ruta_vehiculo` (`vehiculo_id`,`fecha`,`estado`);

--
-- Indices de la tabla `ruta_reparto_pedidos`
--
ALTER TABLE `ruta_reparto_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ruta_pedido_web` (`pedido_web_id`),
  ADD KEY `idx_ruta_venta` (`venta_id`),
  ADD KEY `idx_ruta_detalle` (`ruta_id`,`orden`),
  ADD KEY `idx_entrega_estado` (`estado`,`entregado_at`);

--
-- Indices de la tabla `series_comprobante`
--
ALTER TABLE `series_comprobante`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tipo_serie` (`tipo`,`serie`);

--
-- Indices de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `temporadas`
--
ALTER TABLE `temporadas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `temporada_descuentos`
--
ALTER TABLE `temporada_descuentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_temporada` (`temporada_id`);

--
-- Indices de la tabla `tienda_imagenes`
--
ALTER TABLE `tienda_imagenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `usuario_caja_accesos`
--
ALTER TABLE `usuario_caja_accesos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_usuario_caja_acceso` (`usuario_id`,`caja_id`),
  ADD KEY `idx_acceso_caja_activo` (`caja_id`,`activo`),
  ADD KEY `idx_acceso_usuario_activo` (`usuario_id`,`activo`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_vehiculo_placa` (`placa`),
  ADD KEY `idx_vehiculo_sucursal_estado` (`sucursal_id`,`estado_operativo`,`estado`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`),
  ADD KEY `idx_ventas_fechas` (`created_at`),
  ADD KEY `idx_ventas_canal` (`canal`),
  ADD KEY `idx_ventas_caja` (`caja_id`),
  ADD KEY `idx_ventas_pedido_web` (`pedido_web_id`);

--
-- Indices de la tabla `venta_items`
--
ALTER TABLE `venta_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_venta` (`venta_id`),
  ADD KEY `idx_prod` (`producto_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacenes`
--
ALTER TABLE `almacenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `auditoria_eventos`
--
ALTER TABLE `auditoria_eventos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=199;

--
-- AUTO_INCREMENT de la tabla `cajas`
--
ALTER TABLE `cajas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cajas_fisicas`
--
ALTER TABLE `cajas_fisicas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT de la tabla `caja_movimientos`
--
ALTER TABLE `caja_movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `caja_sesiones`
--
ALTER TABLE `caja_sesiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `clientes_web`
--
ALTER TABLE `clientes_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra_items`
--
ALTER TABLE `compra_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comprobantes`
--
ALTER TABLE `comprobantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `comunicaciones_baja`
--
ALTER TABLE `comunicaciones_baja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comunicacion_baja_items`
--
ALTER TABLE `comunicacion_baja_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `cotizacion_items`
--
ALTER TABLE `cotizacion_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `creditos`
--
ALTER TABLE `creditos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `crm_etiquetas`
--
ALTER TABLE `crm_etiquetas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `crm_interacciones`
--
ALTER TABLE `crm_interacciones`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `crm_tareas`
--
ALTER TABLE `crm_tareas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuotas`
--
ALTER TABLE `cuotas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `despachos_web`
--
ALTER TABLE `despachos_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_cotizaciones`
--
ALTER TABLE `detalle_cotizaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pedidos_web`
--
ALTER TABLE `detalle_pedidos_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `direcciones_web`
--
ALTER TABLE `direcciones_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `documentos_publicos`
--
ALTER TABLE `documentos_publicos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT de la tabla `inventario_transferencias`
--
ALTER TABLE `inventario_transferencias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario_transferencia_items`
--
ALTER TABLE `inventario_transferencia_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_intentos`
--
ALTER TABLE `login_intentos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT de la tabla `logos_temporada`
--
ALTER TABLE `logos_temporada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1668;

--
-- AUTO_INCREMENT de la tabla `opciones`
--
ALTER TABLE `opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `pagos_credito`
--
ALTER TABLE `pagos_credito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos_operaciones_unicas`
--
ALTER TABLE `pagos_operaciones_unicas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `pagos_verificacion`
--
ALTER TABLE `pagos_verificacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `pedidos_web`
--
ALTER TABLE `pedidos_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pedido_entregas_sucursal`
--
ALTER TABLE `pedido_entregas_sucursal`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pedido_items`
--
ALTER TABLE `pedido_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pedido_recojo_reservas`
--
ALTER TABLE `pedido_recojo_reservas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `permisos_accion`
--
ALTER TABLE `permisos_accion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `precios_volumen`
--
ALTER TABLE `precios_volumen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `presentaciones`
--
ALTER TABLE `presentaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `presentaciones_catalogo`
--
ALTER TABLE `presentaciones_catalogo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `producto_imagenes`
--
ALTER TABLE `producto_imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recojo_fechas`
--
ALTER TABLE `recojo_fechas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `repartidores`
--
ALTER TABLE `repartidores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `reservas_web`
--
ALTER TABLE `reservas_web`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `resumenes_boletas`
--
ALTER TABLE `resumenes_boletas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resumen_boletas_items`
--
ALTER TABLE `resumen_boletas_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rutas_reparto`
--
ALTER TABLE `rutas_reparto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ruta_reparto_pedidos`
--
ALTER TABLE `ruta_reparto_pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `series_comprobante`
--
ALTER TABLE `series_comprobante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1004;

--
-- AUTO_INCREMENT de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `temporadas`
--
ALTER TABLE `temporadas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `temporada_descuentos`
--
ALTER TABLE `temporada_descuentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tienda_imagenes`
--
ALTER TABLE `tienda_imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `usuario_caja_accesos`
--
ALTER TABLE `usuario_caja_accesos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `venta_items`
--
ALTER TABLE `venta_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=198;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `caja_sesiones`
--
ALTER TABLE `caja_sesiones`
  ADD CONSTRAINT `caja_sesiones_ibfk_1` FOREIGN KEY (`conciliada_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `caja_sesiones_ibfk_2` FOREIGN KEY (`revertida_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `clientes_web`
--
ALTER TABLE `clientes_web`
  ADD CONSTRAINT `fk_clienteweb_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `direcciones_web`
--
ALTER TABLE `direcciones_web`
  ADD CONSTRAINT `fk_dir_clienteweb` FOREIGN KEY (`cliente_web_id`) REFERENCES `clientes_web` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `precios_volumen`
--
ALTER TABLE `precios_volumen`
  ADD CONSTRAINT `fk_pv_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `ruta_reparto_pedidos`
--
ALTER TABLE `ruta_reparto_pedidos`
  ADD CONSTRAINT `fk_ruta_detalle_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `rutas_reparto` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- ============================================================
-- MUNDO PET V45 - AJUSTES ADITIVOS SOBRE EL RESPALDO 20-07-2026
-- Conserva todos los registros del usuario. No elimina ventas ni clientes.
-- Compatible con MariaDB 10.4 / XAMPP.
-- ============================================================

-- Datos cifrados de ubicación del cliente (la información visible sigue disponible).
ALTER TABLE `clientes` ADD COLUMN IF NOT EXISTS `direccion_enc` TEXT NULL AFTER `departamento`;
ALTER TABLE `clientes` ADD COLUMN IF NOT EXISTS `distrito_enc` TEXT NULL AFTER `direccion_enc`;
ALTER TABLE `clientes` ADD COLUMN IF NOT EXISTS `provincia_enc` TEXT NULL AFTER `distrito_enc`;
ALTER TABLE `clientes` ADD COLUMN IF NOT EXISTS `departamento_enc` TEXT NULL AFTER `provincia_enc`;

-- Edición y trazabilidad de cotizaciones.
ALTER TABLE `cotizaciones` ADD COLUMN IF NOT EXISTS `updated_at` DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP;

-- Productos transferidos entre sucursales.
ALTER TABLE `productos` ADD COLUMN IF NOT EXISTS `es_transferido` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `productos` ADD COLUMN IF NOT EXISTS `producto_origen_id` INT NULL;
ALTER TABLE `productos` ADD COLUMN IF NOT EXISTS `sucursal_origen_id` INT NULL;
ALTER TABLE `productos` ADD COLUMN IF NOT EXISTS `transferencia_venta_habilitada` TINYINT(1) NOT NULL DEFAULT 1;

-- Descuentos por porcentaje o por monto fijo.
ALTER TABLE `temporada_descuentos` ADD COLUMN IF NOT EXISTS `tipo_descuento` enum('porcentaje','monto') NOT NULL DEFAULT 'porcentaje' AFTER `producto_id`;
ALTER TABLE `temporada_descuentos` ADD COLUMN IF NOT EXISTS `monto` DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER `porcentaje`;
ALTER TABLE `temporada_descuentos` ADD UNIQUE INDEX IF NOT EXISTS `uq_temporada_producto` (`temporada_id`,`producto_id`);

-- Evidencias privadas e historial de reparto.
CREATE TABLE IF NOT EXISTS `reparto_evidencias` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ruta_id` INT NOT NULL,
  `ruta_detalle_id` INT NOT NULL,
  `tipo` ENUM('fachada','entrega','incidencia') NOT NULL DEFAULT 'entrega',
  `archivo_privado` VARCHAR(500) NOT NULL,
  `sha256` CHAR(64) NOT NULL,
  `created_by` INT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eliminado_at` DATETIME NULL,
  `eliminado_por` INT NULL,
  `motivo_eliminacion` VARCHAR(300) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_evidencia_ruta` (`ruta_id`,`ruta_detalle_id`,`eliminado_at`),
  UNIQUE KEY `uq_evidencia_detalle_hash` (`ruta_detalle_id`,`sha256`),
  CONSTRAINT `fk_evidencia_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `rutas_reparto` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_evidencia_detalle` FOREIGN KEY (`ruta_detalle_id`) REFERENCES `ruta_reparto_pedidos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `reparto_historial` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `ruta_id` INT NOT NULL,
  `ruta_detalle_id` INT NULL,
  `estado_anterior` VARCHAR(40) NOT NULL DEFAULT '',
  `estado_nuevo` VARCHAR(40) NOT NULL DEFAULT '',
  `comentario` VARCHAR(500) NOT NULL DEFAULT '',
  `lat` DECIMAL(10,7) NULL,
  `lng` DECIMAL(10,7) NULL,
  `precision_m` DECIMAL(10,2) NULL,
  `usuario_id` INT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_historial_ruta` (`ruta_id`,`ruta_detalle_id`,`created_at`),
  CONSTRAINT `fk_historial_ruta` FOREIGN KEY (`ruta_id`) REFERENCES `rutas_reparto` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_historial_detalle` FOREIGN KEY (`ruta_detalle_id`) REFERENCES `ruta_reparto_pedidos` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Rentabilidad se habilita como módulo configurable. El admin global mantiene bypass total.
INSERT INTO `opciones` (`nombre`,`slug`,`icono`,`ruta`,`orden`,`padre_id`,`estado`,`activo`)
VALUES ('Rentabilidad','rentabilidad','ti-chart-pie-2','/rentabilidad',85,NULL,0,0)
ON DUPLICATE KEY UPDATE `nombre`=VALUES(`nombre`),`icono`=VALUES(`icono`),`ruta`=VALUES(`ruta`),`estado`=0,`activo`=0;

INSERT INTO `permisos_accion` (`slug`,`modulo`,`nombre`,`descripcion`) VALUES
('rentabilidad.ver','rentabilidad','Ver rentabilidad','Consultar ganancias, costos y pérdidas'),
('rentabilidad.ver_costos','rentabilidad','Ver costos de rentabilidad','Consultar costos, márgenes y alertas')
ON DUPLICATE KEY UPDATE `modulo`=VALUES(`modulo`),`nombre`=VALUES(`nombre`),`descripcion`=VALUES(`descripcion`);

-- Configuración visual y operativa de pagos. Se conservan los datos ya existentes.
INSERT INTO `configuracion` (`clave`,`valor`,`updated_at`,`grupo`) VALUES
('yape_activo','true',NOW(),'pagos'),
('yape_titular','',NOW(),'pagos'),
('plin_activo','true',NOW(),'pagos'),
('plin_titular','',NOW(),'pagos'),
('transferencia_activo','true',NOW(),'pagos'),
('transferencia_imagen_ruta','',NOW(),'pagos'),
('izipay_activo','false',NOW(),'pagos'),
('izipay_instrucciones','',NOW(),'pagos'),
('izipay_imagen_ruta','',NOW(),'pagos')
ON DUPLICATE KEY UPDATE `clave`=VALUES(`clave`);

-- Una sola raíz pública para imágenes. El arranque también copia físicamente
-- cualquier archivo existente en public/media hacia public/uploads antes de retirar media.
UPDATE `tienda_imagenes` SET `ruta`=REPLACE(`ruta`,'/media/','/uploads/') WHERE `ruta` LIKE '/media/%';
UPDATE `configuracion` SET `valor`=REPLACE(`valor`,'/media/','/uploads/') WHERE `valor` LIKE '/media/%';
UPDATE `producto_imagenes` SET `ruta`=REPLACE(`ruta`,'/media/','/uploads/') WHERE `ruta` LIKE '/media/%';
UPDATE `productos` SET `imagen`=REPLACE(`imagen`,'/media/','/uploads/') WHERE `imagen` LIKE '/media/%';

-- El negocio trabaja directamente con productos; categorías queda deshabilitado sin borrar su historial.
DELETE po FROM `perfil_opciones` po JOIN `opciones` o ON o.id=po.opcion_id WHERE o.slug='categorias';
DELETE ppa FROM `perfil_permisos_accion` ppa JOIN `permisos_accion` pa ON pa.id=ppa.permiso_id WHERE pa.slug='categorias.gestionar';
DELETE FROM `permisos_accion` WHERE `slug`='categorias.gestionar';
UPDATE `opciones` SET `estado`=2,`activo`=2 WHERE `slug`='categorias';
UPDATE `temporada_descuentos` SET `categoria_id`=NULL WHERE `producto_id` IS NOT NULL;
DELETE FROM `temporada_descuentos` WHERE `producto_id` IS NULL;

INSERT INTO `configuracion` (`clave`,`valor`,`updated_at`,`grupo`)
VALUES ('schema_version','45',NOW(),'sistema')
ON DUPLICATE KEY UPDATE `valor`='45',`updated_at`=NOW(),`grupo`='sistema';

-- Fin V45.

