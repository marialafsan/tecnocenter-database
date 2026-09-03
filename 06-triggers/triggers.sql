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

---------------
-- EVENTS --
---------------
--
-- 1. Create an event that corrects the negative stock level to 0 each day
--

SET GLOBAL event_scheduler = ON;

DROP EVENT IF EXISTS corregir_stock_negativo;

DELIMITER $$

CREATE EVENT corregir_stock_negativo
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    UPDATE producto
    SET stock = 0
    WHERE stock < 0;
END$$

DELIMITER ;