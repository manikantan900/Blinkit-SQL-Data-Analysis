/* =====================================================
   Blinkit Data Cleaning Script
   Author: Manikantan P
   Description: Cleaning and standardizing dataset 
   ===================================================== */

USE BlinkIT_DB;
GO

/* 1️⃣ Preview Raw Data */
SELECT TOP 10 *
FROM dbo.BlinkIT_Data;


/* 2️⃣ Check Distinct Fat Content Values Before Cleaning */
SELECT DISTINCT Item_Fat_Content
FROM dbo.BlinkIT_Data;


/* 3️⃣ Standardize Item_Fat_Content Values */
UPDATE dbo.BlinkIT_Data
SET Item_Fat_Content = 
    CASE
        WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;


/* 4️⃣ Verify Cleaning */
SELECT DISTINCT Item_Fat_Content
FROM dbo.BlinkIT_Data;


/* 5️⃣ Check for NULL Values */
SELECT *
FROM dbo.BlinkIT_Data
WHERE Item_Fat_Content IS NULL
   OR Total_Sales IS NULL
   OR Rating IS NULL;
