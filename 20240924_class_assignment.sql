/* SQL installation script:
    Name:                   Date Created:
                            Date Modified:
    Purpose:
*/
-- Opening print statement
SELECT '' AS 'Installation Starting!!!';
-- Remove the database if it is already there
DROP DATABASE IF EXISTS  20240924_testdb;

/* Create the database after checking making sure it is
    not already there
*/

-- The following line is pure Standard SQL
CREATE DATABASE IF NOT EXISTS  20240924_testdb
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
CREATE TABLE ORDERITEM(
        Id              INT,
        Orderld         INT,
        productld       INT,
        UnitPrice       INT,
        Quantity        INT,

        PRIMARY KEY(Id),
);
CREATE TABLE ORDER(
        Id              INT,
        OrderDate       INT,
        Customerld      INT,
        TotalAmount     INT,

        PRIMARY KEY(Id),
        FOREIGN KEY(Id) REFERENCES ORDERITEM(Id)
);
CREATE TABLE PRODUCT(
        Id              INT,
        ProductName     INT,
        Supplierld      INT,
        UnitPrice       INT,
        Package         INT,
        IsDiscontinued  INT,

        PRIMARY KEY(Id),
        FOREIGN KEY(Id) REFERENCES ORDERITEM(Id)
);
CREATE TABLE SUPPLIER(
        Id              INT,
        CompanyName     INT,
        ContactName     INT,
        City            INT,
        Country         INT,
        Phone           INT,
        Fax             INT,

        PRIMARY KEY(Id),
        FOREIGN KEY(Id) REFERENCES PRODUCT(Id)
);
CREATE TABLE CUSTOMER(
        Id              INT,
        FirstName       INT,
        LastName        INT,
        City            INT,
        Country         INT,
        Phone           INT,

        PRIMARY KEY(Id),
        FOREIGN KEY(Id) REFERENCES ORDER(Id)
);
--Closing print statement 
SELECT '' AS 'Installation Completed, check for errors!!!';
