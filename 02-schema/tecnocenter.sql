DROP DATABASE IF EXISTS tecnocenter;

CREATE DATABASE tecnocenter
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE tecnocenter;
CREATE TABLE cliente (
    id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(80) NOT NULL UNIQUE,
    direccion VARCHAR(120)
) ENGINE=InnoDB;

CREATE TABLE empleado (
    id_empleado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(15),
    puesto VARCHAR(40) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE producto (
    codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    precio_compra DECIMAL(8,2) NOT NULL,
    precio_venta DECIMAL(8,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_precio_compra CHECK (precio_compra > 0),
    CONSTRAINT chk_precio_venta CHECK (precio_venta > 0),
    CONSTRAINT chk_stock CHECK (stock >= 0)
) ENGINE=InnoDB;

CREATE TABLE proveedor (
    nif VARCHAR(9) PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(80) UNIQUE,
    direccion VARCHAR(120)
) ENGINE=InnoDB;

CREATE TABLE pedido (
    id_pedido INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    iva_aplicado DECIMAL(5,2) NOT NULL,
    id_cliente INT UNSIGNED NOT NULL,
    id_empleado INT UNSIGNED NOT NULL,
    CONSTRAINT chk_total CHECK (total >= 0),
    CONSTRAINT chk_iva CHECK (iva_aplicado >= 0),
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_pedido_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES empleado(id_empleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE linea_pedido (
    id_pedido INT UNSIGNED NOT NULL,
    codigo_producto INT UNSIGNED NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_pedido, codigo_producto),
    CONSTRAINT chk_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_precio_unitario CHECK (precio_unitario > 0),
    CONSTRAINT fk_linea_pedido_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_linea_pedido_producto
        FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE suministro (
    nif_proveedor VARCHAR(9) NOT NULL,
    codigo_producto INT UNSIGNED NOT NULL,
    precio_suministro DECIMAL(8,2) NOT NULL,
    plazo_entrega INT NOT NULL,
    PRIMARY KEY (nif_proveedor, codigo_producto),
    CONSTRAINT chk_precio_suministro CHECK (precio_suministro > 0),
    CONSTRAINT chk_plazo CHECK (plazo_entrega >= 0),
    CONSTRAINT fk_suministro_proveedor
        FOREIGN KEY (nif_proveedor)
        REFERENCES proveedor(nif)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_suministro_producto
        FOREIGN KEY (codigo_producto)
        REFERENCES producto(codigo)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;