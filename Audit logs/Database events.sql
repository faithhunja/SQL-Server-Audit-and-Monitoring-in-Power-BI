-- Simulate database events to generate logs using 3 test users

-- Use the AdventureWorks2022 database
USE AdventureWorks2022;
GO

-- Create the Sales.NewCustomer table where SQL statements will be tracked

DROP TABLE IF EXISTS [Sales].[NewCustomer];

CREATE TABLE [Sales].[NewCustomer]
(
 [CustomerID] [int] NOT NULL,
 [PersonID] [int] NULL,
 [StoreID] [int] NULL,
 [TerritoryID] [int] NULL,
 [AccountNumber] [varchar](10) NOT NULL
)

-- Create 3 users

CREATE USER User01 WITHOUT LOGIN;
CREATE USER User02 WITHOUT LOGIN;
CREATE USER User03 WITHOUT LOGIN;

-- Grant the 3 users various permissions

GRANT SELECT ON OBJECT::[AdventureWorks2022].[Sales].[Customer] TO User01, User02, User03;
GO

GRANT ALTER, SELECT, INSERT, DELETE, UPDATE ON OBJECT::[AdventureWorks2022].[Sales].[NewCustomer] TO User01;  
GO

GRANT SELECT, INSERT, DELETE, UPDATE ON OBJECT::[AdventureWorks2022].[Sales].[NewCustomer] TO User02;  
GO

GRANT SELECT ON OBJECT::[AdventureWorks2022].[Sales].[NewCustomer] TO User03;  
GO

-- Simulate User01 database events

EXECUTE AS USER = 'User01';
SELECT * FROM Sales.Customer;

INSERT INTO [Sales].[NewCustomer] 
 (
  CustomerID,
  PersonID,
  StoreID,
  TerritoryID,
  AccountNumber
 )
SELECT 
  CustomerID,
  PersonID,
  StoreID,
  TerritoryID,
  AccountNumber
FROM Sales.Customer WHERE CustomerID < 100
GO

SELECT * FROM Sales.NewCustomer;

ALTER TABLE [Sales].[NewCustomer] ADD NewColumn INT NULL;

UPDATE [Sales].[NewCustomer] 
SET TerritoryID = 0 
WHERE CustomerID = 6;

DELETE FROM [Sales].[NewCustomer] 
WHERE CustomerID = 10;

REVERT;
GO

-- Simulate User02 database events

EXECUTE AS USER = 'User02';

INSERT INTO [Sales].[NewCustomer] 
 (
  CustomerID,
  PersonID,
  StoreID,
  TerritoryID,
  AccountNumber
 )
SELECT 
  CustomerID,
  PersonID,
  StoreID,
  TerritoryID,
  AccountNumber
FROM Sales.Customer WHERE CustomerID > 99 AND CustomerID < 200
GO

SELECT * FROM Sales.NewCustomer;

ALTER TABLE [Sales].[NewCustomer] ADD NewColumn1 INT NULL;

UPDATE [Sales].[NewCustomer] 
SET TerritoryID = 12 
WHERE CustomerID = 17;

DELETE FROM [Sales].[NewCustomer] 
WHERE CustomerID = 199;

REVERT;
GO

-- Simulate User03 database events

EXECUTE AS USER = 'User03';

INSERT INTO [Sales].[NewCustomer] 
 (
  CustomerID,
  PersonID,
  StoreID,
  TerritoryID,
  AccountNumber
 )
SELECT 
  CustomerID,
  PersonID,
  StoreID,
  TerritoryID,
  AccountNumber
FROM Sales.Customer WHERE CustomerID > 200 AND CustomerID < 300
GO

SELECT * FROM Sales.NewCustomer;

ALTER TABLE [Sales].[NewCustomer] ADD NewColumn2 INT NULL;

DELETE FROM [Sales].[NewCustomer] 
WHERE CustomerID = 1;

REVERT;
GO
