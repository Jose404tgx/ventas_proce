-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-05-2025 a las 02:28:02
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
-- Base de datos: `bd`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_categoria` (IN `p_id` INT, IN `p_descripcion` VARCHAR(150))   BEGIN
  UPDATE categorias SET descripcion = p_descripcion WHERE id_categoria = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_producto` (IN `p_id` INT, IN `p_descripcion` VARCHAR(150), IN `p_precio` DECIMAL(10,2), IN `p_stock` INT, IN `p_id_categoria` INT, IN `p_id_proveedor` INT)   BEGIN
  UPDATE productos
  SET descripcion = p_descripcion,
      precio = p_precio,
      stock = p_stock,
      id_categoria = p_id_categoria,
      id_proveedor = p_id_proveedor
  WHERE id_producto = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_proveedor` (IN `p_id` INT, IN `p_razonsocial` VARCHAR(150), IN `p_direccion` VARCHAR(200), IN `p_telefono` VARCHAR(50))   BEGIN
  UPDATE proveedores 
  SET razonsocial = p_razonsocial,
      direccion = p_direccion,
      telefono = p_telefono
  WHERE id_proveedor = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_categoria` (IN `p_descripcion` VARCHAR(150))   BEGIN
  INSERT INTO categorias(descripcion) VALUES (p_descripcion);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_producto` (IN `p_descripcion` VARCHAR(150), IN `p_precio` DECIMAL(10,2), IN `p_stock` INT, IN `p_id_categoria` INT, IN `p_id_proveedor` INT)   BEGIN
  INSERT INTO productos(descripcion, precio, stock, id_categoria, id_proveedor)
  VALUES (p_descripcion, p_precio, p_stock, p_id_categoria, p_id_proveedor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_proveedor` (IN `p_razonsocial` VARCHAR(150), IN `p_direccion` VARCHAR(200), IN `p_telefono` VARCHAR(50))   BEGIN
  INSERT INTO proveedores(razonsocial, direccion, telefono) VALUES (p_razonsocial, p_direccion, p_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_categoria` (IN `p_id` INT)   BEGIN
  DELETE FROM categorias WHERE id_categoria = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_producto` (IN `p_id` INT)   BEGIN
  DELETE FROM productos WHERE id_producto = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_proveedor` (IN `p_id` INT)   BEGIN
  DELETE FROM proveedores WHERE id_proveedor = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_categorias` ()   BEGIN
  SELECT * FROM categorias;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_proveedores` ()   BEGIN
  SELECT * FROM proveedores;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_categoria_por_id` (IN `p_id` INT)   BEGIN
  SELECT * FROM categorias WHERE id_categoria = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_producto_por_id` (IN `p_id` INT)   BEGIN
  SELECT * FROM productos WHERE id_producto = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_proveedor_por_id` (IN `p_id` INT)   BEGIN
  SELECT * FROM proveedores WHERE id_proveedor = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_usuario_por_email` (IN `p_email` VARCHAR(255))   BEGIN
    SELECT id_usuario, nombre, email, password, rol
    FROM usuario
    WHERE email = p_email
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_cliente` (IN `p_id_cliente` INT, IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(50))   BEGIN
  UPDATE clientes
  SET nombres = p_nombres,
      apellidos = p_apellidos,
      direccion = p_direccion,
      telefono = p_telefono
  WHERE id_cliente = p_id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_cliente` (IN `p_id_cliente` INT)   BEGIN
  DELETE FROM clientes
  WHERE id_cliente = p_id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_cliente` (IN `p_nombres` VARCHAR(50), IN `p_apellidos` VARCHAR(50), IN `p_direccion` VARCHAR(50), IN `p_telefono` VARCHAR(50))   BEGIN
  INSERT INTO clientes (nombres, apellidos, direccion, telefono)
  VALUES (p_nombres, p_apellidos, p_direccion, p_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_detalle_venta` (IN `p_id_venta` INT, IN `p_id_producto` INT, IN `p_cantidad` INT)   BEGIN
    INSERT INTO detalle_ventas (id_venta, id_producto, cantidad)
    VALUES (p_id_venta, p_id_producto, p_cantidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_venta` (IN `p_id_cliente` INT, IN `p_fecha` DATE)   BEGIN
    INSERT INTO ventas (id_cliente, fecha) VALUES (p_id_cliente, p_fecha);
    SELECT LAST_INSERT_ID() AS nueva_venta_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_clientes` ()   BEGIN
  SELECT * FROM clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_detalle_venta` ()   BEGIN
    SELECT 
        dv.id_detventa,
        dv.id_venta,
        dv.id_producto,
        p.descripcion AS producto,
        dv.cantidad
    FROM detalle_ventas dv
    JOIN productos p ON dv.id_producto = p.id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_listar_productos` ()   BEGIN
    SELECT 
        p.id_producto,
        p.descripcion,
        p.precio,
        p.stock,
        p.id_categoria,
        c.descripcion AS categoria,
        p.id_proveedor,
        pr.razonsocial AS proveedor
    FROM productos p
    JOIN categorias c ON p.id_categoria = c.id_categoria
    JOIN proveedores pr ON p.id_proveedor = pr.id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_categoria` (IN `id_cat` INT)   BEGIN
  SELECT * FROM categorias WHERE id_categoria = id_cat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_clientes_venta` ()   BEGIN
    SELECT id_cliente, CONCAT(nombres, ' ', apellidos) AS nombre_cliente FROM clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_cliente_por_id` (IN `p_id_cliente` INT)   BEGIN
    SELECT * FROM clientes WHERE id_cliente = p_id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_cliente_por_id_ven` (IN `_id_cliente` INT)   BEGIN
  SELECT id_cliente, nombres, apellidos
  FROM clientes
  WHERE id_cliente = _id_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_producto` (IN `p_id_producto` INT)   BEGIN
    SELECT id_producto, descripcion, precio, stock, id_categoria, id_proveedor
    FROM productos
    WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_productos_venta` ()   BEGIN
    SELECT id_producto, descripcion, precio FROM productos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_producto_por_id` (IN `p_id_producto` INT)   BEGIN
    SELECT descripcion, precio FROM productos WHERE id_producto = p_id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_proveedor` (IN `p_id_proveedor` INT)   BEGIN
    SELECT id_proveedor, razonsocial, direccion, telefono
    FROM proveedores
    WHERE id_proveedor = p_id_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obtener_ventas` ()   BEGIN
    SELECT * FROM ventas;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `descripcion`) VALUES
(4, 'lentejas'),
(5, 'menestras');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombres`, `apellidos`, `direccion`, `telefono`) VALUES
(8, 'luis', 'utos ceras', 'av. san carlos 2275', '96565656'),
(10, 'carlos', 'santos campos', 'Jr. salaverry 789', '865677');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id_detventa` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id_detventa`, `id_venta`, `id_producto`, `cantidad`) VALUES
(20, 20, 5, 2),
(21, 21, 5, 2),
(22, 22, 5, 23),
(23, 23, 5, 3),
(24, 24, 5, 2),
(25, 24, 5, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `precio` decimal(18,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_proveedor`) VALUES
(5, 'frejol castillo', 6.00, 12, 4, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `razonsocial` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `razonsocial`, `direccion`, `telefono`) VALUES
(6, 'alicorp', 'av. los nogales 890', '343545345'),
(7, 'gesa', 'av. los gamonales 567', '54654654');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `email`, `password`, `rol`, `fecha_registro`) VALUES
(3, 'Jose Luis', 'thegrax4@gmail.com', '$2y$10$8rHTv5naY0fyF1epJwfxc.3.eVceFCEenFNqeowaCkNb8CRzEzMue', 'administrador', '2025-05-29 16:39:06'),
(4, 'Jhandel Jesus', 'jhand@gmail.com', '$2y$10$FVrbWqaaFrbsjkpLw0SC6uJ0MC8JRDpx0j1rpdLcNgl2mPrZqHKCG', 'encargado', '2025-05-29 16:39:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `fecha`, `id_cliente`) VALUES
(17, '2025-04-08 00:43:19', 8),
(18, '2025-04-08 00:46:03', 10),
(19, '2025-04-08 00:46:46', 8),
(20, '2025-05-29 00:00:00', 10),
(21, '2025-05-29 00:00:00', 8),
(22, '2025-05-29 00:00:00', 8),
(23, '2025-05-30 00:00:00', 10),
(24, '2025-05-30 00:00:00', 8);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id_detventa`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_venta` (`id_venta`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id_detventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_ventas_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
