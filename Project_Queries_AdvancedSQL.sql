-------Q1--------
/*select * , ( (a.YearlyLinearIncome/LAG(a.YearlyLinearIncome) over(order by a.year)) -1 ) * 100  as Growth_Rate         
from
(select year(OrderDate) as [year],sum(Quantity*UnitPrice) as IncomePerYear,count(distinct month(OrderDate)) as NumberOfDistinctMonths,
sum(Quantity*UnitPrice)/count(distinct month(OrderDate))*12 as YearlyLinearIncome
from [Sales].[Orders] O inner join [Sales].[Invoices] I on O.OrderID=I.OrderID
inner join [Sales].[InvoiceLines] IL ON I.InvoiceID=IL.InvoiceID
group by year(OrderDate) ) a */

-------Q2--------
/*select * from(
 select * , DENSE_RANK() over(partition by Year_OrderDate,YearQuarter order by Income desc ) as DR
from (
select YEAR([OrderDate]) as Year_OrderDate,CustomerName,DATEPART(Q,[OrderDate]) as YearQuarter,sum([Quantity]*[UnitPrice]) as Income
from [Sales].[Orders] O inner join [Sales].[OrderLines] OL on O.OrderID=OL.OrderID
inner join [Sales].[Customers] C on O.CustomerID=C.CustomerID
group by YEAR([OrderDate]),CustomerName,DATEPART(Q,[OrderDate])  ) a) b
where DR<=5*/

-------Q3--------
/*select  StockItemID, StockItemName, TotalProfit from (
select  StockItemID, StockItemName,TotalProfit, DENSE_RANK() over( partition by null order by TotalProfit desc)  as DR from (
select SI.StockItemID, StockItemName, sum(ExtendedPrice-TaxAmount) as TotalProfit
from [Warehouse].[StockItems] SI
inner join [Sales].[InvoiceLines] IL ON SI.[StockItemID] = IL.[StockItemID]
group by  SI.StockItemID,StockItemName) a) b
where b.DR <= 10*/

-------Q4--------
/*select ROW_NUMBER() over(order by NominalProductProfit desc) as RN , * , DENSE_RANK() over(order by NominalProductProfit desc) as DR
from (select StockItemID,StockItemName,UnitPrice,RecommendedRetailPrice,RecommendedRetailPrice-UnitPrice as NominalProductProfit
from [Warehouse].[StockItems]
where getdate()<ValidTo) a*/

-------Q5--------

/*select  distinct cast(SupplierID as VARCHAR)+' - '+SupplierName as SupplierDetails,ProductDetails,SupplierID from( 
select S.SupplierID, SupplierName,
stuff((select '/, '+ cast(StockItemID as VARCHAR) +' '+StockItemName from [Warehouse].[StockItems] STI where STI.SupplierID= SI.SupplierID FOR XML PATH('')),1,3,'') ProductDetails
from [Purchasing].[Suppliers] S inner join [Warehouse].[StockItems] SI on S.SupplierID=SI.SupplierID) a
order by a.SupplierID*/


-------Q6--------
/*select TOP 5 C.CustomerID,CityName,CountryName,Continent,Region,sum([ExtendedPrice]) as TotalExtendedPrice
from [Sales].[Customers] C inner join [Sales].[Invoices] I on C.CustomerID=I.CustomerID
inner join [Application].[Cities] CI on C.PostalCityID=CI.CityID
inner join [Application].[StateProvinces] SP on CI.StateProvinceID=SP.StateProvinceID
inner join [Application].[Countries] CO on Sp.CountryID=CO.CountryID
inner join [Sales].[InvoiceLines] IL on I.InvoiceID=IL.InvoiceID 
group by C.CustomerID,CityName,CountryName,Continent,Region
ORDER BY TotalExtendedPrice DESC*/


-------Q7--------
/*with cte as(
select distinct OrderYear,OrderMonth,sum(Quantity*UnitPrice) over(partition by OrderYear,OrderMonth) MontlyTotal,
sum(Quantity*UnitPrice) over( order by OrderYear,OrderMonth) as CumulativeTotal
from (select year(OrderDate) as OrderYear,Month(Orderdate) as OrderMonth,Quantity,OL.UnitPrice
from [Sales].[Orders] O 
inner join [Sales].[Invoices] I on I.OrderID = o.OrderID
inner join [Sales].[OrderLines] OL ON OL.OrderID = o.OrderID )a


UNION ALL 

select year(OrderDate),null,sum(Quantity*UnitPrice),sum(Quantity*UnitPrice)
from [Sales].[Orders] O 
inner join [Sales].[Invoices] I on I.OrderID = o.OrderID
inner join [Sales].[OrderLines] OL ON OL.OrderID = o.OrderID
group by year(OrderDate) ) 

select OrderYear,
case when OrderMonth is null then 'GrandTotal' 
else cast(OrderMonth as VARCHAR) end OrderMonth,
MontlyTotal,CumulativeTotal
from cte order by OrderYear, isnull(OrderMonth,13) */

-------Q8--------
/*select OrderMonth,
ISNULL([2013], 0) as [2013], 
ISNULL([2014], 0) as [2014], 
ISNULL([2015], 0) as [2015], 
ISNULL([2016], 0) as [2016]
from (select Year(OrderDate) as OrderYear,Month(OrderDate) as OrderMonth,count(OrderId) as OrdersCount
from [Sales].[Orders]
Group by Year(OrderDate),Month(OrderDate) ) a
pivot(sum(OrdersCount) for OrderYear in([2013],[2014],[2015],[2016])) b*/

-------Q9--------
/*with cte as(
select *,Avg(DaysSincePreviousCustomerOrder) over (partition by CustomerID ) as AvgDaysBetweenOrders
from(
select *,datediff(day,PreviousOrderDate,OrderDate) as DaysSincePreviousCustomerOrder,
datediff(day,LastCustomerOrder,LastOrderOfAllOrders) as DaysSinceLastOfAllOrders
from(select C.CustomerId,CustomerName,OrderDate,lag(OrderDate) over(partition by C.CustomerId order by OrderDate) PreviousOrderDate,
Max(OrderDate) over(partition by C.CustomerId) as LastCustomerOrder ,
Max(OrderDate) over() as LastOrderOfAllOrders
from [Sales].[Customers] C inner join [Sales].[Orders] O on C.CustomerID=O.CustomerID)a ) b )

select CustomerID,CustomerName,OrderDate,PreviousOrderDate,DaysSinceLastOfAllOrders,AvgDaysBetweenOrders,
case when DaysSinceLastOfAllOrders>2*AvgDaysBetweenOrders then 'Potential for abandonment'  
else 'active' end as CustomerStatus
from cte*/

-------Q10--------
/*with cte as(
select *,sum(CustomerCount) over() as TotalCustCount
from (select CustomerCategoryName,  count(CustomerName) as CustomerCount 
from(select distinct CustomerCategoryName,case when CustomerName like 'Wingtip%' then 'Wingtip'
when CustomerName like 'Tailspin%' then 'Tailspin' 
else CustomerName end as CustomerName
from [Sales].[Customers] C inner join [Sales].[CustomerCategories]  CC on CC.CustomerCategoryID=C.CustomerCategoryID
Group by CustomerCategoryName,CustomerName) a
Group by CustomerCategoryName ) b ) 

select *,cast( ( cast( (cast(CustomerCount AS DECIMAL(10, 2)) / TotalCustCount) * 100 AS DECIMAL(10, 2) ) ) as VARCHAR) +'%' as DistrIbutionFactor
from cte*/






 












 

