/*CREATE DATABASE Sales*/

-- [SalesOrderDetail] --

/*CREATE TABLE [SalesOrderDetail] (
	[SalesOrderID] [int] NOT NULL,
	[SalesOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[OrderQty] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SpecialOfferID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[UnitPriceDiscount] [money] DEFAULT ((0.0)) NOT NULL,
	[LineTotal]  AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
	[rowguid] [uniqueidentifier]  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL)*/

/*ALTER TABLE [SalesOrderDetail]
ADD CONSTRAINT PK_SalesOrderDetail PRIMARY KEY (SalesOrderID, SalesOrderDetailID)*/

/*INSERT INTO [SalesOrderDetail] ([SalesOrderID],[CarrierTrackingNumber],[OrderQty],[ProductID],[SpecialOfferID],[UnitPrice],
[UnitPriceDiscount],[rowguid],[ModifiedDate])
SELECT  [SalesOrderID],[CarrierTrackingNumber],[OrderQty],[ProductID],[SpecialOfferID],[UnitPrice],
[UnitPriceDiscount],[rowguid],[ModifiedDate] from [AdventureWorks2022].[Sales].[SalesOrderDetail]*/ 

-- [SalesOrderHeader] --

/*CREATE TABLE [SalesOrderHeader] (
[SalesOrderID] [int] IDENTITY(1,1) NOT NULL,
	[RevisionNumber] [tinyint] DEFAULT ((0)) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[OnlineOrderFlag] [bit] NOT NULL,
	[SalesOrderNumber]  AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***')),
	[PurchaseOrderNumber] [nvarchar](25) NULL,
	[AccountNumber] [nvarchar](15) NULL,
	[CustomerID] [int] NOT NULL,
	[SalesPersonID] [int] NULL,
	[TerritoryID] [int] NULL,
	[BillToAddressID] [int] NOT NULL,
	[ShipToAddressID] [int] NOT NULL,
	[ShipMethodID] [int] NOT NULL,
	[CreditCardID] [int] NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[CurrencyRateID] [int] NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL)*/

/*ALTER TABLE [SalesOrderHeader]
ADD CONSTRAINT PK_SalesOrderHeader PRIMARY KEY (SalesOrderID)*/

/*INSERT INTO [SalesOrderHeader] ([RevisionNumber],[OrderDate],[DueDate],[ShipDate],[Status],[OnlineOrderFlag],[PurchaseOrderNumber],[AccountNumber],
[CustomerID],[SalesPersonID],[TerritoryID],[BillToAddressID],[ShipToAddressID],[ShipMethodID],[CreditCardID],[CreditCardApprovalCode],
[CurrencyRateID],[SubTotal],[TaxAmt],[Freight])
SELECT [RevisionNumber],[OrderDate],[DueDate],[ShipDate],[Status],[OnlineOrderFlag],[PurchaseOrderNumber],[AccountNumber],
[CustomerID],[SalesPersonID],[TerritoryID],[BillToAddressID],[ShipToAddressID],[ShipMethodID],[CreditCardID],[CreditCardApprovalCode],
[CurrencyRateID],[SubTotal],[TaxAmt],[Freight] FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]*/ 

--[Address]--

/*CREATE TABLE [Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[SpatialLocation] [geography] NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [Address]
ADD CONSTRAINT PK_Address PRIMARY KEY (AddressID)*/

/*INSERT INTO [Address] ([AddressLine1],[AddressLine2],[City],[StateProvinceID],[PostalCode],[SpatialLocation],[rowguid],[ModifiedDate])
SELECT [AddressLine1],[AddressLine2],[City],[StateProvinceID],[PostalCode],[SpatialLocation],[rowguid],[ModifiedDate]
FROM [AdventureWorks2022].[Person].[Address]*/

--[ShipMethod]--

/*CREATE TABLE [ShipMethod](
	[ShipMethodID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ShipBase] [money] NOT NULL,
	[ShipRate] [money] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [ShipMethod]
ADD CONSTRAINT PK_ShipMethod PRIMARY KEY (ShipMethodID)*/

/*INSERT INTO [ShipMethod] ([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
SELECT [Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate] FROM [AdventureWorks2022].[Purchasing].[ShipMethod]*/

--[CurrencyRate]--

/*CREATE TABLE [CurrencyRate](
	[CurrencyRateID] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyRateDate] [datetime] NOT NULL,
	[FromCurrencyCode] [nchar](3) NOT NULL,
	[ToCurrencyCode] [nchar](3) NOT NULL,
	[AverageRate] [money] NOT NULL,
	[EndOfDayRate] [money] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [ShipMethod]
ADD CONSTRAINT PK_CurrencyRate PRIMARY KEY (CurrencyRateID)*/

/*INSERT INTO [CurrencyRate] ([CurrencyRateDate],[FromCurrencyCode],[ToCurrencyCode],[AverageRate],[EndOfDayRate],[ModifiedDate])
SELECT [CurrencyRateDate],[FromCurrencyCode],[ToCurrencyCode],[AverageRate],[EndOfDayRate],[ModifiedDate] FROM [AdventureWorks2022].[Sales].[CurrencyRate]*/

--[SpecialOfferProduct]--

/*CREATE TABLE [SpecialOfferProduct](
	[SpecialOfferID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [SpecialOfferProduct]
ADD CONSTRAINT PK_SpecialOfferProduct PRIMARY KEY (SpecialOfferID, ProductID)*/

/*INSERT INTO [SpecialOfferProduct] ([SpecialOfferID],[ProductID],[rowguid],[ModifiedDate])
SELECT [SpecialOfferID],[ProductID],[rowguid],[ModifiedDate] FROM [AdventureWorks2022].[Sales].[SpecialOfferProduct]*/

--[CreditCard]--

/*CREATE TABLE [CreditCard](
	[CreditCardID] [int] IDENTITY(1,1) NOT NULL,
	[CardType] [nvarchar](50) NOT NULL,
	[CardNumber] [nvarchar](25) NOT NULL,
	[ExpMonth] [tinyint] NOT NULL,
	[ExpYear] [smallint] NOT NULL,
	[ModifiedDate] [datetime]  DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [CreditCard]
ADD CONSTRAINT PK_CreditCard PRIMARY KEY (CreditCardID)*/

/*INSERT INTO [CreditCard]([CardType],[CardNumber],[ExpMonth],[ExpYear],[ModifiedDate])
SELECT [CardType],[CardNumber],[ExpMonth],[ExpYear],[ModifiedDate] FROM [AdventureWorks2022].[Sales].[CreditCard]*/

--[SalesPerson]--

/*CREATE TABLE [SalesPerson](
	[BusinessEntityID] [int] NOT NULL,
	[TerritoryID] [int] NULL,
	[SalesQuota] [money] NULL,
	[Bonus] [money] NOT NULL,
	[CommissionPct] [smallmoney] NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [SalesPerson]
ADD CONSTRAINT PK_SalesPerson PRIMARY KEY (BusinessEntityID)*/

/*INSERT INTO [SalesPerson] ([BusinessEntityID],[TerritoryID],[SalesQuota],[Bonus],[CommissionPct],[SalesYTD],[SalesLastYear],[rowguid],[ModifiedDate])
SELECT [BusinessEntityID],[TerritoryID],[SalesQuota],[Bonus],[CommissionPct],[SalesYTD],[SalesLastYear],[rowguid],[ModifiedDate] 
FROM [AdventureWorks2022].[Sales].[SalesPerson]*/

--[SalesTerritory]--

/*CREATE TABLE [SalesTerritory](
	[TerritoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[Group] [nvarchar](50) NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[CostYTD] [money] NOT NULL,
	[CostLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [SalesTerritory]
ADD CONSTRAINT PK_SalesTerritory PRIMARY KEY (TerritoryID)*/

/*INSERT INTO [SalesTerritory]([Name],[CountryRegionCode],[Group],[SalesYTD],[SalesLastYear],[CostYTD],[CostLastYear],[rowguid],[ModifiedDate])
SELECT [Name],[CountryRegionCode],[Group],[SalesYTD],[SalesLastYear],[CostYTD],[CostLastYear],[rowguid],[ModifiedDate] 
FROM [AdventureWorks2022].[Sales].[SalesTerritory]*/

--[Customer]--

/*   /****** Object:  UserDefinedFunction [dbo].[ufnLeadingZeros]    Script Date: 15/12/2024 13:57:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[ufnLeadingZeros](
    @Value int
) 
RETURNS varchar(8) 
WITH SCHEMABINDING 
AS 
BEGIN
    DECLARE @ReturnValue varchar(8);

    SET @ReturnValue = CONVERT(varchar(8), @Value);
    SET @ReturnValue = REPLICATE('0', 8 - DATALENGTH(@ReturnValue)) + @ReturnValue;

    RETURN (@ReturnValue);
END;
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the scalar function ufnLeadingZeros. Enter a valid integer.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'ufnLeadingZeros', @level2type=N'PARAMETER',@level2name=N'@Value'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scalar function used by the Sales.Customer table to help set the account number.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'ufnLeadingZeros'
GO
*/


/*CREATE TABLE [Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[PersonID] [int] NULL,
	[StoreID] [int] NULL,
	[TerritoryID] [int] NULL,
	[AccountNumber]  AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')),
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE  [Customer]
ADD CONSTRAINT PK_Customer PRIMARY KEY (CustomerID)*/

/*SET IDENTITY_INSERT [Customer] ON*/

/*INSERT INTO [Customer] ([CustomerID],[PersonID],[StoreID],[TerritoryID],[rowguid],[ModifiedDate])
SELECT [CustomerID], [PersonID],[StoreID],[TerritoryID],[rowguid],[ModifiedDate] FROM [AdventureWorks2022].[Sales].[Customer]*/

/*SET IDENTITY_INSERT [Customer] OFF*/


--[Product]--

/*CREATE TABLE [Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[MakeFlag] [bit] NOT NULL,
	[FinishedGoodsFlag] [bit] NOT NULL,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] NOT NULL,
	[ReorderPoint] [smallint] NOT NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int] NOT NULL,
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [Product]
ADD CONSTRAINT PK_Product PRIMARY KEY (ProductID)*/

/*SET IDENTITY_INSERT [Product] ON*/

/*INSERT INTO [Product] ([ProductID],[Name],[ProductNumber],[MakeFlag],[FinishedGoodsFlag],[Color],[SafetyStockLevel],[ReorderPoint],[StandardCost],
[ListPrice],[Size],[SizeUnitMeasureCode],[WeightUnitMeasureCode],[Weight],[DaysToManufacture],[ProductLine],[Class],[Style],
[ProductSubcategoryID],[ProductModelID],[SellStartDate],[SellEndDate],[DiscontinuedDate],[rowguid],[ModifiedDate])
SELECT [ProductID],[Name],[ProductNumber],[MakeFlag],[FinishedGoodsFlag],[Color],[SafetyStockLevel],[ReorderPoint],[StandardCost],
[ListPrice],[Size],[SizeUnitMeasureCode],[WeightUnitMeasureCode],[Weight],[DaysToManufacture],[ProductLine],[Class],[Style],
[ProductSubcategoryID],[ProductModelID],[SellStartDate],[SellEndDate],[DiscontinuedDate],[rowguid],[ModifiedDate] 
FROM [AdventureWorks2022].[Production].[Product]*/

/*SET IDENTITY_INSERT [Product] OFF*/

--[ProductCategory]--

/*CREATE TABLE [ProductCategory](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [ProductCategory]
ADD CONSTRAINT PK_ProductCategory PRIMARY KEY (ProductCategoryID)*/

/*INSERT INTO [ProductCategory] ([Name],[rowguid],[ModifiedDate])
SELECT [Name],[rowguid],[ModifiedDate] FROM [AdventureWorks2022].[Production].[ProductCategory]*/


--[ProductSubcategory]--

/*CREATE TABLE [ProductSubcategory](
	[ProductSubcategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[Name] [nvarchar](50)  NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [ProductSubcategory]
ADD CONSTRAINT PK_ProductSubcategory PRIMARY KEY (ProductSubcategoryID)*/

/*INSERT INTO [ProductSubcategory]( [ProductCategoryID],[Name],[rowguid],[ModifiedDate])
SELECT [ProductCategoryID],[Name],[rowguid],[ModifiedDate] FROM [AdventureWorks2022].[Production].[ProductSubcategory]*/

--[Person]--

/*CREATE TABLE [Person](
	[BusinessEntityID] [int] NOT NULL,
	[PersonType] [nchar](2) NOT NULL,
	[NameStyle] [bit] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50)  NOT NULL,
	[MiddleName] [nvarchar](50)  NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Suffix] [nvarchar](10) NULL,
	[EmailPromotion] [int] NOT NULL,
	[AdditionalContactInfo] [nvarchar](max)  NULL,
	[Demographics] [nvarchar](max) NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [Person]
ADD CONSTRAINT PK_Person PRIMARY KEY (BusinessEntityID)*/

/*INSERT INTO [Person] ([BusinessEntityID],[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],
[LastName],[Suffix],[EmailPromotion],[AdditionalContactInfo],[Demographics],[rowguid],[ModifiedDate])
SELECT [BusinessEntityID],[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],
[LastName],[Suffix],[EmailPromotion],CAST([AdditionalContactInfo] AS [nvarchar](max)),CAST([Demographics] AS [nvarchar](max)),[rowguid],[ModifiedDate]
FROM [AdventureWorks2022].[Person].[Person]*/

--[HumanResourcesDepartment]--

/*CREATE TABLE [HumanResourcesDepartment](
	[DepartmentID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](50) NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [HumanResourcesDepartment]
ADD CONSTRAINT PK_HumanResourcesDepartment PRIMARY KEY (DepartmentID)*/

/*INSERT INTO [HumanResourcesDepartment]([Name],[GroupName],[ModifiedDate])
SELECT [Name],[GroupName],[ModifiedDate] FROM [AdventureWorks2022].[HumanResources].[Department]*/

--[HumanResourcesEmployee]--

/*CREATE TABLE [HumanResourcesEmployee](
	[BusinessEntityID] [int] NOT NULL,
	[NationalIDNumber] [nvarchar](15) NOT NULL,
	[LoginID] [nvarchar](256) NOT NULL,
	[OrganizationNode] [hierarchyid] NULL,
	[OrganizationLevel]  AS ([OrganizationNode].[GetLevel]()),
	[JobTitle] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[MaritalStatus] [nchar](1) NOT NULL,
	[Gender] [nchar](1) NOT NULL,
	[HireDate] [date] NOT NULL,
	[SalariedFlag] [bit] NOT NULL,
	[VacationHours] [smallint] NOT NULL,
	[SickLeaveHours] [smallint] NOT NULL,
	[CurrentFlag] [bit] NOT NULL,
	[rowguid] [uniqueidentifier] NOT NULL,
	[ModifiedDate] [datetime]  DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [HumanResourcesEmployee]
ADD CONSTRAINT PK_HumanResourcesEmployee PRIMARY KEY (BusinessEntityID)*/

/*INSERT INTO [HumanResourcesEmployee]([BusinessEntityID],[NationalIDNumber],[LoginID],[OrganizationNode],[JobTitle],
[BirthDate],[MaritalStatus],[Gender],[HireDate],[SalariedFlag],[VacationHours],[SickLeaveHours],[CurrentFlag],
[rowguid],[ModifiedDate]) 
SELECT [BusinessEntityID],[NationalIDNumber],[LoginID],[OrganizationNode],[JobTitle],
[BirthDate],[MaritalStatus],[Gender],[HireDate],[SalariedFlag],[VacationHours],[SickLeaveHours],[CurrentFlag],
[rowguid],[ModifiedDate]
FROM [AdventureWorks2022].[HumanResources].[Employee]*/

--[HumanResourcesEmployeeDepartmentHistory]--

/*CREATE TABLE [HumanResourcesEmployeeDepartmentHistory](
	[BusinessEntityID] [int] NOT NULL,
	[DepartmentID] [smallint] NOT NULL,
	[ShiftID] [tinyint] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate())  NOT NULL)*/

/*ALTER TABLE [HumanResourcesEmployeeDepartmentHistory]
ADD CONSTRAINT PK_HumanResourcesEmployeeDepartmentHistory PRIMARY KEY (BusinessEntityID, DepartmentID,ShiftID,StartDate)*/

/*INSERT INTO [HumanResourcesEmployeeDepartmentHistory]([BusinessEntityID],[DepartmentID],[ShiftID],[StartDate],
[EndDate],[ModifiedDate])
SELECT [BusinessEntityID],[DepartmentID],[ShiftID],[StartDate],
[EndDate],[ModifiedDate] FROM [AdventureWorks2022].[HumanResources].[EmployeeDepartmentHistory]*/

--[HumanResourcesShift]--

/*CREATE TABLE [HumanResourcesShift](
	[ShiftID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[ModifiedDate] [datetime] DEFAULT (getdate()) NOT NULL)*/

/*ALTER TABLE [HumanResourcesShift]
ADD CONSTRAINT PK_HumanResourcesShift PRIMARY KEY (ShiftID)*/

/*INSERT INTO [HumanResourcesShift]([Name],[StartTime],[EndTime],[ModifiedDate])
SELECT [Name],[StartTime],[EndTime],[ModifiedDate] FROM [AdventureWorks2022].[HumanResources].[Shift]*/





