---------------
-- FUNCTIONS --
---------------
--
-- 1. Create a function that calculates the price applying a 21% VAT
--

CREATE FUNCTION calcular_iva (precio DECIMAL(8,2))
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    RETURN precio * 1.21;
END;

---
-- Test query:
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