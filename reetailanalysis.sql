
-- Project: Sales Uplift: Strategy Insights from Multi-Region Retail Data

-- 1. Total sales amount per region for the last quarter 
SELECT 
    Region, 
    SUM(TotalAmount) AS Total_Sales
FROM 
    RetailTransactions
WHERE 
    Date BETWEEN '2025-07-01' AND '2025-09-30'
GROUP BY 
    Region
ORDER BY 
    Total_Sales DESC;


-- 2. Top 5 best-selling products (by total revenue)
SELECT 
    ProductName, 
    Category,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(TotalAmount) AS Total_Revenue
FROM 
    RetailTransactions
GROUP BY 
    ProductName, 
    Category
ORDER BY 
    Total_Revenue DESC
LIMIT 5;


-- 3. Monthly sales trend across all regions
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Sales_Month, 
    SUM(TotalAmount) AS Monthly_Sales,
    COUNT(TransactionID) AS Total_Transactions
FROM 
    RetailTransactions
GROUP BY 
    Sales_Month
ORDER BY 
    Sales_Month ASC;


-- 4. Region-wise contribution to total sales (as a percentage)
SELECT 
    Region,
    SUM(TotalAmount) AS Region_Sales,
    ROUND((SUM(TotalAmount) / (SELECT SUM(TotalAmount) FROM RetailTransactions)) * 100, 2) AS Sales_Percentage
FROM 
    RetailTransactions
GROUP BY 
    Region
ORDER BY 
    Sales_Percentage DESC;


-- 5. Compare Online vs Offline sales across all months
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Sales_Month,
    SalesChannel,
    SUM(TotalAmount) AS Channel_Sales
FROM 
    RetailTransactions
GROUP BY 
    Sales_Month, 
    SalesChannel
ORDER BY 
    Sales_Month ASC, 
    SalesChannel ASC;


-- 6. Sales trend by Category
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Sales_Month,
    Category,
    SUM(TotalAmount) AS Category_Sales
FROM 
    RetailTransactions
GROUP BY 
    Sales_Month, 
    Category
ORDER BY 
    Sales_Month ASC, 
    Category_Sales DESC;


-- 7. List customers who purchased more than 10 times
SELECT 
    CustomerID,
    COUNT(TransactionID) AS Total_Transactions,
    SUM(TotalAmount) AS Total_Spent
FROM 
    RetailTransactions
GROUP BY 
    CustomerID
HAVING 
    COUNT(TransactionID) > 10
ORDER BY 
    Total_Transactions DESC;
