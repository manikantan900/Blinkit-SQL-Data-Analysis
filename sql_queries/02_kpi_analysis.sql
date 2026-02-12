USE BlinkIT_DB;
GO

/* =====================================================
   KPI 1: Total Sales
===================================================== */

SELECT 
    FORMAT(SUM(Total_Sales), 'N0') AS Total_Sales
FROM dbo.BlinkIT_Data;



/* =====================================================
   KPI 2: Total Number of Items Sold
===================================================== */

SELECT 
    COUNT(*) AS Total_Items
FROM dbo.BlinkIT_Data;



/* =====================================================
   KPI 3: Average Sales per Item
===================================================== */

SELECT 
    ROUND(AVG(Total_Sales), 2) AS Avg_Sales
FROM dbo.BlinkIT_Data;



/* =====================================================
   KPI 4: Average Rating
===================================================== */

SELECT 
    ROUND(AVG(Rating), 2) AS Avg_Rating
FROM dbo.BlinkIT_Data;



/* =====================================================
   KPI 5: Sales by Item Fat Content
===================================================== */

SELECT 
    Item_Fat_Content,
    COUNT(*) AS Total_Items,
    FORMAT(SUM(Total_Sales)/1000000, 'N2') + ' M' AS Total_Sales_Million
FROM dbo.BlinkIT_Data
GROUP BY Item_Fat_Content
ORDER BY SUM(Total_Sales) DESC;



/* =====================================================
   KPI 6: Sales by Outlet Location Type
===================================================== */

SELECT 
    Outlet_Location_Type,
    FORMAT(SUM(Total_Sales)/1000000, 'N2') + ' M' AS Total_Sales_Million
FROM dbo.BlinkIT_Data
GROUP BY Outlet_Location_Type
ORDER BY SUM(Total_Sales) DESC;



/* =====================================================
   KPI 7: Top 5 Selling Item Types
===================================================== */

SELECT TOP 5
    Item_Type,
    FORMAT(SUM(Total_Sales)/1000000, 'N2') + ' M' AS Total_Sales_Million
FROM dbo.BlinkIT_Data
GROUP BY Item_Type
ORDER BY SUM(Total_Sales) DESC;
