USE BlinkIT_DB;
GO

/* =====================================================
   1️⃣ Top 3 Item Types by Sales (Using RANK)
===================================================== */

WITH Item_Sales AS (
    SELECT 
        Item_Type,
        SUM(Total_Sales) AS Total_Sales
    FROM dbo.BlinkIT_Data
    GROUP BY Item_Type
)

SELECT *
FROM (
    SELECT *,
           RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
    FROM Item_Sales
) ranked
WHERE Sales_Rank <= 3;



/* =====================================================
   2️⃣ Year-over-Year Sales Growth
===================================================== */

WITH Yearly_Sales AS (
    SELECT 
        Outlet_Establishment_Year,
        SUM(Total_Sales) AS Total_Sales
    FROM dbo.BlinkIT_Data
    GROUP BY Outlet_Establishment_Year
)

SELECT 
    Outlet_Establishment_Year,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Outlet_Establishment_Year) AS Previous_Year_Sales,
    Total_Sales - LAG(Total_Sales) 
        OVER (ORDER BY Outlet_Establishment_Year) AS Sales_Growth
FROM Yearly_Sales
ORDER BY Outlet_Establishment_Year;



/* =====================================================
   3️⃣ Running Total of Sales by Year
===================================================== */

SELECT 
    Outlet_Establishment_Year,
    SUM(Total_Sales) AS Yearly_Sales,
    SUM(SUM(Total_Sales)) OVER (
        ORDER BY Outlet_Establishment_Year
    ) AS Running_Total_Sales
FROM dbo.BlinkIT_Data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;



/* =====================================================
   4️⃣ Contribution of Each Outlet Type to Total Sales
===================================================== */

SELECT 
    Outlet_Type,
    SUM(Total_Sales) AS Total_Sales,
    CAST(
        SUM(Total_Sales) * 100.0 /
        SUM(SUM(Total_Sales)) OVER ()
        AS DECIMAL(5,2)
    ) AS Contribution_Percentage
FROM dbo.BlinkIT_Data
GROUP BY Outlet_Type
ORDER BY Contribution_Percentage DESC;



/* =====================================================
   5️⃣ Identify High-Performing Items 
   (Sales Above Overall Average)
===================================================== */

SELECT *
FROM dbo.BlinkIT_Data
WHERE Total_Sales > (
    SELECT AVG(Total_Sales)
    FROM dbo.BlinkIT_Data
);
