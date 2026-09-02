-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`, `email`, `direccion`) VALUES
(1, 'Ana López', '699999999', 'ana@correo.com', 'Calle Sol 3, Sevilla'),
(2, 'Luis Pérez', '600333444', 'luis@correo.com', 'Calle Luna 7, Málaga'),
(3, 'Marta Ruiz', '600555666', 'marta@correo.com', 'Calle Río 12, Córdoba'),
(4, 'Carlos Soto', '600777888', 'carlos@correo.com', 'Calle Nueva 5, Granada'),
(5, 'Lucía Torres', '600888999', 'lucia@correo.com', 'Avenida Sur 10, Cádiz'),
(6, 'Pedro Martín', '644444444', 'pedro@correo.com', 'Calle Centro 8, Jaén'),
(7, 'Sara Núñez', '655555555', 'sara@correo.com', 'Calle Norte 20, Almería'),
(9, 'Eva Molina', '677777777', 'eva@correo.com', 'Calle Este 9, Murcia');


-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre`, `telefono`, `puesto`) VALUES
(1, 'Carlos Gómez', '611111111', 'Supervisor'),
(2, 'Laura Díaz', '622222222', 'Encargada'),
(3, 'David Romero', '633333333', 'Dependiente');


-- Volcado de datos para la tabla `linea_pedido`
--

INSERT INTO `linea_pedido` (`id_pedido`, `codigo_producto`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 1, 599.00),
(1, 3, 1, 59.00),
(2, 2, 1, 159.00),
(2, 4, 1, 25.00),
(3, 4, 1, 25.00),
(3, 5, 1, 95.00),
(4, 6, 1, 39.00),
(5, 5, 1, 95.00);


-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `fecha`, `total`, `iva_aplicado`, `id_cliente`, `id_empleado`) VALUES
(1, '2025-02-01', 684.00, 21.00, 1, 1),
(2, '2025-02-03', 184.00, 21.00, 2, 2),
(3, '2025-02-05', 120.00, 21.00, 3, 1),
(4, '2025-03-01', 39.00, 21.00, 6, 2),
(5, '2025-03-02', 95.00, 21.00, 7, 1);


-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`codigo`, `nombre`, `marca`, `precio_compra`, `precio_venta`, `stock`) VALUES
(1, 'Portátil 15 pulgadas', 'Lenovo', 450.00, 658.90, 12),
(2, 'Monitor 24 pulgadas', 'Samsung', 110.00, 159.00, 20),
(3, 'Teclado mecánico', 'Logitech', 35.00, 59.00, 30),
(4, 'Ratón inalámbrico', 'HP', 12.00, 25.00, 50),
(5, 'Disco SSD 1TB', 'Kingston', 60.00, 95.00, 18),
(6, 'Webcam HD', 'Logitech', 20.00, 39.00, 9),
(7, 'Impresora láser', 'HP', 90.00, 145.00, 6);


-- Volcado de datos para la tabla `producto_oferta`
--

INSERT INTO `producto_oferta` (`codigo`, `nombre`, `marca`, `precio_venta`, `stock`) VALUES
(1, 'Portátil 15 pulgadas', 'Lenovo', 658.90, 12),
(2, 'Monitor 24 pulgadas', 'Samsung', 159.00, 20),
(7, 'Impresora láser', 'HP', 145.00, 6);


-- Volcado de datos para la tabla `suministro`
--

INSERT INTO `suministro` (`nif_proveedor`, `codigo_producto`, `precio_suministro`, `plazo_entrega`) VALUES
('A12345678', 1, 430.00, 5),
('A12345678', 2, 105.00, 4),
('B23456789', 3, 32.00, 3),
('C34567890', 5, 58.00, 6);

------------------------------
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `email` (`email`);


-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`);


-- Indices de la tabla `linea_pedido`
--
ALTER TABLE `linea_pedido`
  ADD PRIMARY KEY (`id_pedido`,`codigo_producto`),
  ADD KEY `fk_linea_pedido_producto` (`codigo_producto`);


-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `fk_pedido_cliente` (`id_cliente`),
  ADD KEY `fk_pedido_empleado` (`id_empleado`);


-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`codigo`);


-- Indices de la tabla `producto_oferta`
--
ALTER TABLE `producto_oferta`
  ADD PRIMARY KEY (`codigo`);


-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`nif`),
  ADD UNIQUE KEY `email` (`email`);


-- Indices de la tabla `suministro`
--
ALTER TABLE `suministro`
  ADD PRIMARY KEY (`nif_proveedor`,`codigo_producto`),
  ADD KEY `fk_suministro_producto` (`codigo_producto`);


-----------------------------
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;


-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int UNSIGNED NOT NULL AUTO_INCREMENT;


-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `codigo` int UNSIGNED NOT NULL AUTO_INCREMENT;


-----------------------------
-- Filtros para la tabla `linea_pedido`
--
ALTER TABLE `linea_pedido`
  ADD CONSTRAINT `fk_linea_pedido_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_linea_pedido_producto` FOREIGN KEY (`codigo_producto`) REFERENCES `producto` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE;


-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pedido_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE RESTRICT ON UPDATE CASCADE;


-- Filtros para la tabla `suministro`
--
ALTER TABLE `suministro`
  ADD CONSTRAINT `fk_suministro_producto` FOREIGN KEY (`codigo_producto`) REFERENCES `producto` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_suministro_proveedor` FOREIGN KEY (`nif_proveedor`) REFERENCES `proveedor` (`nif`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;
