--------------------------
-- ADDING NEW REGISTERS --
--------------------------
--
-- 1. Insert two new clients, two new products and a new employee into the database
--

INSERT INTO cliente
(nombre, telefono, email, direccion) 
VALUES 
    ('Elena Romero', 123456789, 
'e.romero@correo.es', 'CasaElena 1'),
    ('Domingo Alférez', 123466789, 
'd.alfarez@correo.es', 'CasaDomin 1');

INSERT INTO producto
(nombre, marca, precio_compra, precio_venta, stock)
VALUES
    ('REDMI A5 4G', 'Xiaomi', '80.00', '89.00',
20),
    ('Xperia 10 VII', 'Sony', '300.00', '449.00',
100);

INSERT INTO empleado
(nombre, telefono, puesto)
VALUES
('Fátima Ferrera', 123456799, 'Dependiente');

--------------------------
-- MODIFYING REGISTERS  --
--------------------------
--
-- 1. Change a client's phone number
--

UPDATE cliente SET telefono = 222334455 
WHERE id_cliente = 9;

--
-- 2. Increase the sales price of all products by 10%
--

UPDATE producto SET precio_venta = precio * 1.10;

--
-- 3. Change an employees job title
--

UPDATE empleado SET puesto = 'Encargado' WHERE id_empleado = 3;

----------------------------------
-- INSERTING DATA USING A QUERY --
----------------------------------
--
-- 1. Create a table called ´producto_oferta´ (discounted_product) and fill it with products data, but include only the ones whose price is over 100
--

DROP TABLE IF EXISTS producto_oferta;
CREATE TABLE producto_oferta (
codigo INT(10) PRIMARY KEY,
nombre VARCHAR(80),
marca VARCHAR(50),
precio_compra DECIMAL(8,2)
CHECK (precio_compra > 0),
precio_venta DECIMAL(8,2)
CHECK (precio_venta > precio_compra),
stock INT(11)
CHECK (stock >= 0)
);
INSERT INTO producto_oferta (codigo, nombre, marca, 
precio_compra, precio_venta, stock) 
SELECT * FROM producto 
WHERE precio_venta > 100;

