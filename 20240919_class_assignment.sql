/* SQL installation script:
    Name:                   Date Created:
                            Date Modified:
    Purpose:
*/
-- Opening print statement
SELECT '' AS 'Installation Starting!!!';
-- Remove the database if it is already there
DROP DATABASE IF EXISTS  20240919_testdb;

/* Create the database after checking making sure it is
    not already there
*/

-- The following line is pure Standard SQL
CREATE DATABASE IF NOT EXISTS  20240919_testdb
-- The following line is unique to MySQL it is optional
-- If left out the MySQL database will take the default settings
-- of the database.
-- EXPLAIN CHARACTER SET:
-- EXPLAIN COLLATE:
CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Let's see if the database is created
SHOW DATABASES;
SELECT '' AS '########################';

-- Let's enter the database
USE testdb_20240917;

-- Let's create some tables
CREATE TABLE warehouses(
        warehouse_id    INT, AUTO_INCREMENT,
        warehouse_location VARCHAR(20),

        PRIMARY KEY(warehouse_id),
);
CREATE TABLE products(
        product_id      INT,
        product_name    VARCHAR(20), AUTO_INCREMENT,
        product_price   INT,
        warehouse_id    INT,

        PRIMARY KEY(product_id),
        FOREIGN KEY(warehouse_id) REFERENCES warehouses(warehouse_id)
);
CREATE TABLE deliveries(
        delivery_id    INT, AUTO_INCREMENT,
        delivery_date  DATE,
        warehouse_id   INT,

        PRIMARY KEY(delivery_id),
        FOREIGN KEY(warehouse_id) REFERENCES warehouses(warehouse_id)
);
CREATE TABLE orders_info(
        order_info_id   INT,
        order_id        INT,     AUTO_INCREMENT,
        product_id      INT,
        product_quantity  INT,

        PRIMARY KEY(order_info_id),
        FOREIGN KEY(product_id) REFERENCES products(product_id)
);
CREATE TABLE orders(
        order_id        INT,     AUTO_INCREMENT,
        order_date      Date,
        order_info_id   INT,
        order_value     INT,
        order_currency  VARCHAR(10),

        PRIMARY KEY(order_id),
        FOREIGN KEY(order_info_id) REFERENCES order_info(order_info_id)
);
--Closing print statement
SELECT '' AS 'Installation Completed, check for errors!!!';
