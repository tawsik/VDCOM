DROP DATABASE IF EXISTS IceCream;
CREATE DATABASE IceCream;
USE IceCream;

DROP TABLE IF EXISTS Locations;
CREATE TABLE Locations(
Location_ID INT NOT NULL IDENTITY(1,1)
CONSTRAINT [PK_Locations_LocationID] PRIMARY KEY, --????????? ???? ? ???????? ??????????????
Country NVARCHAR(30) NOT NULL,
City NVARCHAR(30) NOT NULL,
District NVARCHAR(30) NOT NULL,
Street NVARCHAR(30) NOT NULL,
Building NVARCHAR(30) NOT NULL,
InsertDT DATETIME NOT NULL
CONSTRAINT [Loc_InsertDT_DF] DEFAULT GETDATE(), --?? ????????? ???? = ???? ?????????? ???????
UpdateDT DATETIME);


DROP TABLE IF EXISTS Shops;
CREATE TABLE Shops(
Shop_ID INT NOT NULL IDENTITY(1,1)
CONSTRAINT [PK_Shops_ShopID] PRIMARY KEY,
ShopName NVARCHAR(30) NOT NULL,
Location_ID INT NOT NULL,
ShopPhone NVARCHAR(30) NOT NULL,
InsertDT DATETIME NOT NULL
CONSTRAINT [Shp_InsertDT_DF] DEFAULT GETDATE(),
UpdateDT DATETIME,
CONSTRAINT [FK_Shops_LocationID] FOREIGN KEY(Location_ID) --?????? ?? ??????? ????
REFERENCES [Locations](Location_ID)
);


DROP TABLE IF EXISTS Suppliers;
CREATE TABLE Suppliers(
Supplier_ID INT NOT NULL IDENTITY(1,1)
CONSTRAINT [PK_Supplr_SuppID] PRIMARY KEY,
SupplierName NVARCHAR(30) NOT NULL,
Location_ID INT NOT NULL,
ShopPhone NVARCHAR(30) NOT NULL,
InsertDT DATETIME NOT NULL
CONSTRAINT [Supplr_InsertDT_DF] DEFAULT GETDATE(),
UpdateDT DATETIME,
CONSTRAINT [FK_Supplr_LocationID] FOREIGN KEY(Location_ID)
REFERENCES [Locations](Location_ID)
);

DROP TABLE IF EXISTS Products;
CREATE TABLE Products(
Product_ID INT NOT NULL IDENTITY(1,1)
CONSTRAINT [PK_Product_ProductID] PRIMARY KEY,
ProductName NVARCHAR(30) NOT NULL,
UnitPrice REAL NOT NULL
CONSTRAINT [Product_UnitPrice_DF] DEFAULT 0, --?? ?????????, ???? ?????? = 0
ProductDescription NVARCHAR(100) NOT NULL
CONSTRAINT [Product_ProductDescription_DF] DEFAULT N'N/A', --?? ????????? ???????? ?????? = N/A
Supplier_ID INT NOT NULL,
InsertDT DATETIME NOT NULL
CONSTRAINT [Product_InsertDT_DF] DEFAULT GETDATE(),
UpdateDT DATETIME,
CONSTRAINT [FK_Products_SupplierID] FOREIGN KEY(Supplier_ID)
REFERENCES [Suppliers](Supplier_ID)
);

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients(
Client_ID INT NOT NULL IDENTITY(1,1)
CONSTRAINT [PK_Clients_ClientID] PRIMARY KEY,
FullName NVARCHAR(50) NOT NULL,
BirthDay DATE,
MobilePhone NVARCHAR(30),
InsertDT DATETIME NOT NULL
CONSTRAINT [Clients_InsertDT_DF] DEFAULT GETDATE(),
UpdateDT DATETIME,
CONSTRAINT [UQ_Clients_MobPhone] UNIQUE(MobilePhone)
);

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales(
Sale_ID INT NOT NULL IDENTITY(1,1)
CONSTRAINT [PK_Sales_SaleID] PRIMARY KEY,
SaleDate DATETIME NOT NULL,
Shop_ID INT NOT NULL,
Client_ID INT NOT NULL,
Product_ID INT NOT NULL,
UnitsSold INT NOT NULL,
Amount REAL NOT NULL,
InsertDT DATETIME NOT NULL
CONSTRAINT [Sales_InsertDT_DF] DEFAULT GETDATE(),
UpdateDT DATETIME,
CONSTRAINT [FK_Sales_ShopID] FOREIGN KEY(Shop_ID)
REFERENCES [Shops](Shop_ID),
CONSTRAINT [FK_Sales_ClientID] FOREIGN KEY(Client_ID)
REFERENCES [Clients](Client_ID),
CONSTRAINT [FK_Sales_ProductID] FOREIGN KEY(Product_ID)
REFERENCES [Products](Product_ID)
);