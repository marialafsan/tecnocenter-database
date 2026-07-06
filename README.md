# TecnoCenter Database

Relational database project built with MariaDB, modelling the operations of **TecnoCenter**, a technology store: products, suppliers, employees, customers and their orders.

This repository shows **the full lifecycle of the database** from the client's requirements and the first draft of the Entity Relationship Diagram, to a working implementation using sample data, queries, functions, procedures, triggers, views and user permissions.

> This project was built and tested locally using **XAMPP** (MariaDB) and **phpMyAdmin**.

## Design process

### Client's Initial Requirements

 **TecnoCenter Database Requirements and Guidelines**
> A computer hardware store, by the name of TecnoCenter, is looking to digitalize the management of its inventory, suppliers, sales and employees. 
> 
> Each **product** is identified uniquely via a code, and has a name, brand, purchase price, store price and stock level.
> 
> **Suppliers are identified by their NIF (tax identification number) and have a record of their name, telephone number, email address and business address.

### Entity-Relationship Diagram

### Relational model

## This database models

 - **Products**
 - **Suppliers**
 - **Employees**
 - **Customers**
 - **Orders**

## Entity overview

| Table          | Description                                 | Primary key                         |
|----------------|---------------------------------------------|-------------------------------------|
| `producto`     | Products avaliable                          | `codigo`                            |
| `proveedor`    | Suppliers                                   | `nif`                               |
| `suministro`   | Which supplier supplies which product (N:M) | `nif_proveedor` + `codigo_producto` |
| `empleado`     | Employees                                   | `id_empleado`                       |
| `cliente`      | Customers                                   | `id_cliente`                        |
| `pedido`       | Customer orders                             | `id_pedido`                         |
| `linea_pedido` | Product lines  (N:M order–product)          | `id_pedido` + `codigo_producto`     |

**Relationships:**
- One `empleado` handles many `pedido`s *(1:N)*
- One `cliente` places many `pedido`s *(1:N)*
- `proveedor` ↔ `producto` is **many-to-many**, resolved through the creation of the table`suministro`
- `pedido` ↔ `producto` is **many-to-many**, resolved via the table `linea_pedido`


