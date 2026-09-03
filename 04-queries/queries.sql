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


-------------------
-- SCRIPT DESIGN --
-------------------
--
-- 1. Design a SQL script that performs the following task:
--
----- A. Insert a new client
--
----- B. Insert a new order purchased by that client
--
----- C. Insert a new order line
--
----- D. Update the stock level of the product that was just sold
--

-----------------------
--- COMIENZO SCRIPT ---
-----------------------
--
--- BLOQUE 1: Inserción cliente--Guardamos el último id en una variable (@id_cliente)
--
INSERT INTO cliente (nombre, telefono, email, 
direccion) 
VALUES 
('Enrique Trovador', 123456786, 
'e.trova@email.com', 'Calle Trovador, 3');
SET @id_cliente = LAST_INSERT_ID();

--
-- BLOQUE 2: Insertamos el pedido nuevo--Utilizamos el id_cliente guardado y guardamos el --id_pedido en una variable (@id_pedido)
--
INSERT INTO pedido (fecha, total, iva_aplicado,
id_cliente, id_empleado)
VALUES
(CURDATE(),97.90,10.00,@id_cliente, 1);
SET @id_pedido = LAST_INSERT_ID();

--
-- BLOQUE 3: Insertamos la línea de pedido--Utilizamos la variable @id_pedido
--
INSERT INTO linea_pedido (id_pedido, codigo_producto,
cantidad, precio_unitario)
VALUES
(@id_pedido, 8, 1, 97.90);

--
-- BLOQUE 4: Actualizamos el stock del producto para que--refleje los cambios
--
UPDATE producto SET stock = stock-1 
WHERE codigo = 8;--BLOQUE 5: Consulta inserciones
SELECT 
lp.id_pedido AS pedido,
prod.nombre AS producto,
prod.marca, 
c.nombre AS comprador,
prod.stock AS stock_restante
FROM linea_pedido lp
JOIN pedido p ON p.id_pedido = lp.id_pedido
JOIN cliente c ON c.id_cliente = p.id_cliente
JOIN producto prod ON prod.codigo = lp.codigo_producto;
----------------
-- FIN SCRIPT --
----------------



