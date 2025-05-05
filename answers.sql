-- Question 1
--  Create db
CREATE DATABASE shopdb;

--  Use db
USE shopdb;

-- Create table
CREATE TABLE Orders_1NF (
    id INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data into the table
INSERT INTO Orders_1NF(OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2 2NF
-- T1 Orders Table
CREATE TABLE orders(
     OrderID INT PRIMARY KEY,
     CustomerName VARCHAR(100)
);

-- T2 OrderItems
CREATE TABLE OrderItems(
	OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
     OrderID INT,
     Product VARCHAR(100),
     Quantity INT,
     FOREIGN KEY(OrderID) REFERENCES Orders(OrderID)
     
);

-- Insert into Orders Table
INSERT INTO Orders(OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Inserting Values to OrderItems Table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

