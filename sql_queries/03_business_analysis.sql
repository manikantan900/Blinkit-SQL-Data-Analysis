USE BlinkIT_DB;
GO

/* =====================================================
   1️⃣ Sales Trend by Outlet Establishment Year
===================================================== */

SELECT 
    Outlet_Establishment_Year,
    SUM(Total_Sales) AS Total_Sales
FROM dbo.BlinkIT_Data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;



/* =====================================================
   2️⃣ Which Outlet Size Generates Highest Revenue?
===================================================== */

SELECT 
    Outlet_Size,
    SUM(Total_Sales) AS Total_Sales,
    COUNT(*) AS Total_Items
FROM dbo.BlinkIT_Data
GROUP BY Outlet_Size
ORDER BY SUM(Total_Sales) DESC;



/* =====================================================
   3️⃣ Impact of Rating on Sales
===================================================== */

SELECT 
    Rating,
    COUNT(*) AS Total_Items,
    SUM(Total_Sales) AS Total_Sales
FROM dbo.BlinkIT_Data
GROUP BY Rating
ORDER BY Rating DESC;



/* =====================================================
   4️⃣ Top Performing Outlet Type
===================================================== */

SELECT 
    Outlet_Type,
    SUM(Total_Sales) AS Total_Sales,
    AVG(Rating) AS Avg_Rating
FROM dbo.BlinkIT_Data
GROUP BY Outlet_Type
ORDER BY SUM(Total_Sales) DESC;



/* =====================================================
   5️⃣ Which Item Type Has Highest Average Sales?
===================================================== */

SELECT 
    Item_Type,
    AVG(Total_Sales) AS Avg_Sales
FROM dbo.BlinkIT_Data
GROUP BY Item_Type
ORDER BY AVG(Total_Sales) DESC;



/* =====================================================
   6️⃣ Sales Contribution % by Fat Content
===================================================== */

SELECT 
    Item_Fat_Content,
    SUM(Total_Sales) AS Total_Sales,
    CAST(
        SUM(Total_Sales) * 100.0 /
        (SELECT SUM(Total_Sales) FROM dbo.BlinkIT_Data)
        AS DECIMAL(5,2)
    ) AS Sales_Percentage
FROM dbo.BlinkIT_Data
GROUP BY Item_Fat_Content
ORDER BY Sales_Percentage DESC;
