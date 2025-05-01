 -- Question 1
 -- Creating a new database to work with normalized product data
CREATE DATABASE ProductNormalization;

-- Using the newly created database
USE ProductNormalization;

-- Creating the initial table that violates 1NF due to multiple products in one column
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Inserting sample data where the 'Products' column contains comma-separated values
INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Using a recursive Common Table Expression (CTE) to generate a sequence of numbers from 1 to 10
-- This will help in splitting the comma-separated products
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)

-- Selecting normalized rows where each product appears in its own row
-- The SUBSTRING_INDEX function extracts the nth item from the comma-separated list
SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM
    ProductDetail
JOIN
    numbers ON n <= 1 + LENGTH(Products) - LENGTH(REPLACE(Products, ',', ''))
ORDER BY
    OrderID, Product;

-- Question 2
-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert customer orders into the Orders table
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert products and quantities into the OrderDetails table
INSERT INTO OrderDetails (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- View all records in the Orders table to confirm successful insertion
SELECT * FROM Orders;
