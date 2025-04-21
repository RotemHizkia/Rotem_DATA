/*SELECT TOP 5 P.Name,P.ProductID,SUM(SOD.LineTotal) AS TOTAL_SALES
FROM [Product] P INNER JOIN [SalesOrderDetail]  SOD ON P.ProductID=SOD.ProductID
GROUP BY P.Name, P.ProductID
ORDER BY TOTAL_SALES DESC*/


/*SELECT PC.Name, AVG(UNITPRICE) AS AVG_UNIT_PRICE
FROM [SalesOrderDetail] SOD INNER JOIN [Product] P ON SOD.ProductID=P.ProductID
INNER JOIN [ProductSubcategory] PSC ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
INNER JOIN [ProductCategory] PC ON PC.ProductCategoryID=PSC.ProductCategoryID
WHERE PC.Name IN ('Components','Bikes')
GROUP BY PC.Name*/

/*SELECT PC.Name,SUM(SOD.OrderQty) AS ORDERQTY_SUM
FROM [SalesOrderDetail] SOD INNER JOIN [Product] P ON SOD.ProductID=P.ProductID
INNER JOIN [ProductSubcategory] PSC ON P.ProductSubcategoryID=PSC.ProductSubcategoryID
INNER JOIN [ProductCategory] PC ON PC.ProductCategoryID=PSC.ProductCategoryID
WHERE PC.Name NOT IN ('Clothing','Components')
GROUP BY PC.Name */

/*SELECT TOP 3 ST.Name,SUM(SOH.SubTotal) AS SALES_AMOUNT
FROM [SalesTerritory] ST INNER JOIN [SalesOrderHeader] SOH ON  ST.TerritoryID=SOH.TerritoryID
GROUP BY ST.Name
ORDER BY SALES_AMOUNT DESC*/

/* On the folowing query we used left join between customer and person becuasue thier are several customers without personid (null) so we didnt want to lose these customers*/
/*SELECT C.CustomerID, P.FirstName + '' + P.LastName AS FULL_NAME
FROM [Customer] C LEFT JOIN [Person] P ON C.PersonID=P.BusinessEntityID
LEFT JOIN [SalesOrderHeader] SOH ON C.CustomerID=SOH.CustomerID
WHERE C.CustomerID NOT IN (SELECT distinct CustomerID FROM [SalesOrderHeader])*/ 


/*DELETE ST
FROM [SalesTerritory] ST LEFT JOIN [SalesPerson] SP ON ST.TerritoryID=SP.TerritoryID
WHERE ST.TerritoryID NOT IN (SELECT TerritoryID FROM [SalesPerson])*/


/*INSERT INTO [SalesTerritory]([Name],[CountryRegionCode],[Group],[SalesYTD],[SalesLastYear],[CostYTD],[CostLastYear],[rowguid],[ModifiedDate])
SELECT [Name],[CountryRegionCode],[Group],ST.[SalesYTD],ST.[SalesLastYear],[CostYTD],[CostLastYear],ST.[rowguid],ST.[ModifiedDate]
FROM [AdventureWorks2022].[Sales].[SalesTerritory] ST LEFT JOIN [AdventureWorks2022].[Sales].[SalesPerson] SP ON ST.TerritoryID=SP.TerritoryID
WHERE ST.TerritoryID NOT IN (SELECT TerritoryID FROM [SalesPerson])*/

/* On the folowing query we used right join between person and customer becuasue thier are several customers without personid (null) so we didnt want to lose these customers*/
/*SELECT FirstName+' ' + LastName AS FULL_NAME, COUNT(SOH.CustomerID) AS ORDER_COUNT
FROM [Person] P RIGHT JOIN [Customer] C ON P.BusinessEntityID=C.PersonID
INNER JOIN [SalesOrderHeader] SOH ON C.CustomerID=SOH.CustomerID
GROUP BY FirstName+' ' + LastName
HAVING COUNT(SOH.CustomerID)>20*/   


/*SELECT GroupName, COUNT(NAME) AS DEPARTMENT_NUM
FROM [HumanResourcesDepartment]
GROUP BY GroupName
HAVING COUNT(NAME)>2*/

/*SELECT FirstName+' ' +LastName AS FULL_NAME,HRD.Name AS DEPARTMENT_NAME ,HRS.Name SHIFT_NAME
FROM [Person] P INNER JOIN [HumanResourcesEmployee] HRE ON P.BusinessEntityID=HRE.BusinessEntityID
INNER JOIN [HumanResourcesEmployeeDepartmentHistory] HREDH ON HRE.BusinessEntityID=HREDH.BusinessEntityID
INNER JOIN [HumanResourcesDepartment] HRD ON HREDH.DepartmentID=HRD.DepartmentID 
INNER JOIN [HumanResourcesShift] HRS ON HREDH.ShiftID=HRS.ShiftID
WHERE  YEAR(HRE.HireDate)>2010 AND HRD.GroupName IN('Manufactoring','quality assurance')*/





















