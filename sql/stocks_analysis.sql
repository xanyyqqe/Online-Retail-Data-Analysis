SELECT StockCode, MAX(UnitPrice) as unit_price, SUM(Quantity),
    SUM(Quantity) * MAX(UnitPrice) as stock_revenue -- using max because the price within
FROM orders                                         -- the group doesn't change
JOIN stocks USING(StockCode)
WHERE substr(invoiceno, 1, 1) BETWEEN '0' AND '9'
GROUP BY StockCode
ORDER BY stock_revenue DESC;