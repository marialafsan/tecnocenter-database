---------------
-- TRIGGERS --
---------------
--
-- 1. Design a trigger that reduces the stock of a product when inserting an order line
--

DELIMITER $$

CREATE TRIGGER reducir_stock
BEFORE INSERT ON linea_pedido FOR EACH ROW
BEGIN
    DECLARE var_stock INT;

    SELECT stock INTO var_stock
    FROM producto
    WHERE codigo = NEW.codigo_producto;

    IF var_stock > 0 THEN

        UPDATE producto SET stock = stock -1 
        WHERE codigo = NEW.codigo_producto;

    END IF;
END$$

DELIMITER ;

-- To test the trigger, we can create a transaction like the following:

START TRANSACTION;

SELECT nombre, marca, stock FROM producto WHERE codigo = 1;

INSERT INTO pedido (fecha, total, iva_aplicado, id_cliente, id_empleado)
VALUES ('2025-05-06',599.00,21.00, 1,1);

SET @ultimo_pedido = LAST_INSERT_ID();

INSERT INTO linea_producto (codigo_pedido, codigo_producto, cantidad, 
precio_unitario) VALUES (@ultimo_pedido,1,1,724.79);

SELECT nombre, marca, stock FROM producto WHERE codigo = 1;

COMMIT;


----------------
-- PROCEDURES --
----------------
--
-- 1. Create a procedure that displays products with a stock level under 10 units
--

DELIMITER $$

CREATE PROCEDURE prod_stock_bajo ()
BEGIN
    SELECT * FROM producto WHERE stock <= 10;
END$$

DELIMITER;

-- To execute the procedure:

CALL prod_stock_bajo();


--
-- 2. Procedure that displays products by brand name
--

DELIMITER $$

CREATE PROCEDURE productos_de_marca_x (IN marca_x VARCHAR(50))
BEGIN
    SELECT * FROM producto
    WHERE marca = marca_x;
END$$

DELIMITER ;

-- To execute the procedure:

CALL productos_de_marca_x('Logitech');


--
-- 3. Flow Control. Design a procedure that receives a product's reference number and displays if there's stock. Use a conditional sentence
--

DELIMITER $$

CREATE PROCEDURE hay_stock (IN codigo_prod_x INT)
BEGIN
   DECLARE stock_prod_x INT;
   
   SELECT stock INTO stock_prod_x
   FROM producto
   WHERE codigo = codigo_prod_x;

   IF stock_prod_x > 0 THEN
      SELECT 'Hay stock';
   ELSE
      SELECT 'Sin stock';
   END IF;
END$$

DELIMITER ;

-- To execute the procedure:

CALL hay_stock ();