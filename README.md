# TecnoCenter Database

Relational database project built with MariaDB, modelling the operations of **TecnoCenter**, a technology store: products, suppliers, employees, customers and their orders.

This repository shows **the full lifecycle of the database** from the client's requirements and the first draft of the Entity Relationship Diagram, to a working implementation using sample data, queries, functions, procedures, triggers, views and user permissions.

> This project was built and tested locally using **XAMPP** (MariaDB) and **phpMyAdmin**.

## Design process

### Client's Initial Requirements

 **TecnoCenter Database Requirements and Guidelines**
> A computer hardware store, by the name of ***TecnoCenter***, is looking to digitalize the management of its inventory, product suppliers, sales and employees. 
> 
> Each **product** is identified uniquely through a reference number, and has a name, brand, purchase price, store price and stock level.
> 
> **Vendors** are identified by their NIF (tax identification number) and have a record of their name, telephone number, email address and business address.
> 
> **Customers** can place **orders** that are recorded with a date, total amount charged and VAT applied. Every order consists of one or more **order lines** that specify the quantity of each given product.

### Entity-Relationship Diagram

![Entity-Relationship Diagram -TecnoCenter](https://github.com/marialafsan/tecnocenter-database/blob/main/01-database-design/relational-model.jpg?raw=true)

### Relational model

**Requirements Modification &rarr; *Addition of Customer and Employee details***

> Following the review of the proposed model, the client wants to include some extra information about the customers and employees.
> 
> Recording customer data opens up the possibility to send discount codes, coupons and personalized marketing to create brand loyalty.

![Relational Model](https://github.com/marialafsan/tecnocenter-database/blob/main/01-database-design/er-diagram.png?raw=true)

## This database models

 - **Products** 
 - **Vendors**
 - **Employees**
 - **Customers**
 - **Orders**

## Entity overview

| Table          | Description                                 | Primary key                         |
|----------------|---------------------------------------------|-------------------------------------|
| `producto`     | **Product**                         | `codigo`                         |
| `proveedor`    | **Vendor**                                   | `nif`                             |
| `suministro`   | **Supply** </br> Which vendor supplies which product </br>**(N:M)**   | `nif_proveedor` + `codigo_producto` |
| `empleado`     | **Employee**                                   | `id_empleado`                        |
| `cliente`      | **Customer**                                   | `id_cliente`                        |
| `pedido`       | **Order**                             | `id_pedido`                         |
| `linea_pedido` | **Order Line** </br> **(N:M)** </br>order &harr; product        | `id_pedido` + `codigo_producto`     |

**Relationships:**
- One `employer` manages many `orders` *(1:N)*
- One `client` purchases many `orders` *(1:N)*
- `supplier` ↔ `product` is **many-to-many**, the relationship is reflected by the table `supply`
- `pedido` ↔ `producto` is **many-to-many**, reflected in the table `linea_pedido`


