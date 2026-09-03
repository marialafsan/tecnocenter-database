------------------------
-- USING TRANSACTIONS --
------------------------
--
-- 1. Create a transaction with the following:
--
----- A. Insertion of a new client
--
----- B. Insertion of a new order purchased by that client
--
----- C. Insertion of a new order line
--
----- D. Commit the former insertions
--

START TRANSACTION;

    INSERT INTO cliente
    (nombre, telefono, email, direccion)
    VALUES
    ('Álvaro Sancho', 123456777, 'a.san@mail.com,
    'Calle Santos 2');

    SET @id_cliente = LAST_INSERT_ID();

    SET @precio1 = (SELECT precio_venta FROM producto 
    WHERE codigo=1);

    SET @precio2 = (SELECT precio_venta FROM producto
    WHERE codigo=2);

    SET @total = @precio1 + @precio2;
    INSERT INTO pedido
    (fecha, total, iva_aplicado, id_cliente, id_empleado)
    VALUES
    (CURDATE(), @total, 0.10, @id_cliente, 3);

    SET @id_pedido = LAST_INSERT_ID();
    INSERT INTO linea_pedido
    (id_pedido, codigo_producto, cantidad, precio_unitario)
    VALUES
    (@id_pedido, 1, 1, @precio1);

    INSERT INTO linea_pedido
    (id_pedido, codigo_producto, cantidad, precio_unitario)
    VALUES
    (@id_pedido, 2, 1, @precio2);

COMMIT;

--
-- Consulta para probar la transacción:
--

SELECT p.id_pedido AS pedido,
    prod.nombre, 
    prod.marca, 
    c.nombre AS comprador, 
    p.total AS total 
FROM linea_pedido lp 
JOIN pedido p ON p.id_pedido = lp.id_pedido 
JOIN producto prod ON prod.codigo = lp.codigo_producto
JOIN cliente c ON c.id_cliente = p.id_cliente;


---------------------
-- USE OF ROLLBACK --
---------------------
--
-- 1. Create a transaction like the previous one but this time undo all changes using ROLLBACK
--

START TRANSACTION;

    INSERT INTO cliente (nombre, telefono, email,
    direccion)
    VALUES
    ('Prueba', 999999999, 'prueba@mail.com', 'prueba 0');
    
    SET @id_cliente = LAST_INSERT_ID();

    SET @precio1 = (SELECT precio_venta FROM producto WHERE codigo = 1);

    INSERT INTO pedido (fecha, total, iva_aplicado, id_cliente, id_empleado)
    VALUES (CURDATE(), @precio1, 0.10, @id_cliente, 1);

    SET @id_pedido = LAST_INSERT_ID();

    INSERT INTO linea_pedido (id_pedido, codigo_producto, cantidad, 
    precio_unitario)
    VALUES (@id_pedido, 1, 1, @precio1);

ROLLBACK;


----------------------------------
-- USING SAVEPOINT AND ROLLBACK --
----------------------------------
--
-- 1. Create a transaction where you:
--
----- A. Insert a new client
--
----- B. Create a SAVEPOINT
--
----- C. Insert an order with mistaken data
--
----- D. Return to the SAVEPOINT
--
----- E. End the transaction with the correct data
--

START TRANSACTION;

    INSERT INTO cliente
    (nombre, telefono, email, direccion)
    VALUES
    ('Ramona Flowers', 333445566, 'ramona@mail.com',
    'Calle Canadá 2');
    SET @id_cliente = LAST_INSERT_ID();

SAVEPOINT punto_seguro;

    SET @precioprueba = (SELECT precio_venta FROM producto 
    WHERE codigo=1);

    INSERT INTO pedido
    (fecha, total, iva_aplicado, id_cliente, id_empleado)
    VALUES
    (CURDATE(), @precioprueba, 10.00, @id_cliente, 3);

    SET @id_pedido_prueba = LAST_INSERT_ID();

    INSERT INTO linea_pedido
    (id_pedido, codigo_producto, cantidad, precio_unitario)
    VALUES
    (@id_pedido_prueba, 1, 1, @precioprueba);

ROLLBACK TO punto_seguro;

    SET @precio = (SELECT precio_venta FROM producto 
    WHERE codigo=6);

    INSERT INTO pedido
    (fecha, total, iva_aplicado, id_cliente, id_empleado)
    VALUES
    (CURDATE(), @precio, 10.00, @id_cliente, 3);

    SET @id_pedido = LAST_INSERT_ID();

    INSERT INTO linea_pedido
    (id_pedido, codigo_producto, cantidad, precio_unitario)
    VALUES
    (@id_pedido, 6, 1, @precio);

COMMIT;

---
--Consulta de prueba:
---

SELECT p.id_pedido AS pedido,
    prod.nombre, 
    prod.marca, 
    c.nombre AS comprador, 
    p.total AS total 
FROM linea_pedido lp 
JOIN pedido p ON p.id_pedido = lp.id_pedido 
JOIN producto prod ON prod.codigo = lp.codigo_producto
JOIN cliente c ON c.id_cliente = p.id_cliente;


