SELECT MonthNumber, COUNT(DISTINCT CustomerID) as mau 
FROM ORDERS
WHERE is_anonymous = 'no'
GROUP BY MonthNumber
ORDER BY MonthNumber

