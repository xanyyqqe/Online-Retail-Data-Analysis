SELECT MonthNumber,date(InvoiceDate) as date_day, 
    COUNT(DISTINCT CustomerID) AS dau
FROM orders
WHERE is_anonymous='no'
GROUP BY date_day
ORDER BY date_day;