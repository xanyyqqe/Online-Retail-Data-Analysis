WITH user_orders AS (
    SELECT Country, CustomerID,
        COUNT(DISTINCT InvoiceNo) AS orders_cnt
    FROM online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY Country, CustomerID),

ranked AS (
    SELECT Country, CustomerID, orders_cnt,
        ROW_NUMBER() OVER (
            PARTITION BY Country
            ORDER BY orders_cnt
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY Country
        ) AS total_count
    FROM user_orders)

SELECT
    Country, COUNT(CustomerID) AS NonAnonymousUsers,
    AVG(orders_cnt) AS AvgOrders,
    AVG(
        CASE 
            WHEN rn IN ((total_count + 1) / 2, (total_count + 2) / 2)
            THEN orders_cnt
        END) AS MedianOrders
FROM ranked
GROUP BY Country
ORDER BY NonAnonymousUsers DESC;