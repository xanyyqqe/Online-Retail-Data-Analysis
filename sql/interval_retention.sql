WITH first_activity AS (
    SELECT 
        CustomerID,
        MIN(date(InvoiceDate)) AS first_date
    FROM orders
    WHERE is_anonymous = 'no'
    GROUP BY CustomerID),

returned_users AS (
    SELECT DISTINCT o.CustomerID
    FROM orders o
    JOIN first_activity f
        ON o.CustomerID = f.CustomerID
    WHERE date(o.InvoiceDate) 
          BETWEEN date(f.first_date, '+*7 day')
              AND date(f.first_date, '+*14 day'))
SELECT 
    COUNT(DISTINCT r.CustomerID) * 1.0 /
    COUNT(DISTINCT f.CustomerID) AS retention_*7_*14
FROM first_activity f
LEFT JOIN returned_users r
    ON f.CustomerID = r.CustomerID;