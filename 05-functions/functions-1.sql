--------------------------
-- FUNCTIONS --
--------------------------
--
-- 1. Create a function that calculates the price applying a 21% VAT
--

CREATE FUNCTION calcular_iva (precio DECIMAL(8,2))
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    RETURN precio * 1.21;
END;

