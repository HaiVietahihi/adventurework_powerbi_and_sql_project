USE AdventureWorksDW2022;
GO

-- =============================================
-- Project  : Adventure Works Sales Intelligence
-- Author   : Nguyễn Việt Hải
-- Created  : 02/06/2026
-- Database : AdventureWorksDW2022
-- Description: Test database và tạo các views
-- =============================================



-- Xem 100 dòng đầu của bảng fact
SELECT TOP 100 * FROM FactInternetSales

-- Đếm tổng số đơn hàng
SELECT COUNT(*) AS TotalOrders FROM FactInternetSales

-- Xem range thời gian của data
SELECT 
    MIN(OrderDateKey) AS EarliestOrder,
    MAX(OrderDateKey) AS LatestOrder
FROM FactInternetSales

-- Xem doanh thu theo năm
SELECT 
    LEFT(CAST(OrderDateKey AS VARCHAR), 4) AS Year,
    SUM(SalesAmount) AS TotalRevenue
FROM FactInternetSales
GROUP BY LEFT(CAST(OrderDateKey AS VARCHAR), 4)
ORDER BY Year;

CREATE OR ALTER VIEW vw_FactSales AS
SELECT 
    fis.SalesOrderNumber,
    fis.OrderDateKey,
    fis.CustomerKey,
    fis.ProductKey,
    fis.SalesTerritoryKey,
    fis.SalesAmount,
    fis.TotalProductCost,
    fis.SalesAmount - fis.TotalProductCost AS GrossProfit,
    fis.OrderQuantity,
    fis.UnitPrice
FROM FactInternetSales fis;
GO


CREATE OR ALTER VIEW vw_DimProduct AS
SELECT 
    p.ProductKey,
    p.EnglishProductName AS ProductName,
    p.Color,
    p.ListPrice,
    p.StandardCost,
    ps.EnglishProductSubcategoryName AS Subcategory,
    pc.EnglishProductCategoryName AS Category
FROM DimProduct p
LEFT JOIN DimProductSubcategory ps 
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
LEFT JOIN DimProductCategory pc 
    ON ps.ProductCategoryKey = pc.ProductCategoryKey;
GO

CREATE OR ALTER VIEW vw_DimCustomer AS
SELECT 
    c.CustomerKey,
    c.FirstName + ' ' + c.LastName AS FullName,
    c.Gender,
    c.YearlyIncome,
    c.EnglishEducation AS Education,
    c.EnglishOccupation AS Occupation,
    c.CommuteDistance,
    g.City,
    g.StateProvinceName,
    g.EnglishCountryRegionName AS Country
FROM DimCustomer c
LEFT JOIN DimGeography g 
    ON c.GeographyKey = g.GeographyKey;
GO