WITH customer_month_revenue AS (
    SELECT
        o.MonthNumber,
        o.customerid,
        SUM(o.quantity * s.unitprice) AS revenue
    FROM orders o
    JOIN stocks s USING (stockcode)
    WHERE o.is_anonymous = 'no'
      AND substr(o.invoiceno, 1, 1) BETWEEN '0' AND '9'
    GROUP BY o.MonthNumber, o.customerid
)

SELECT
    MonthNumber,
    AVG(revenue) AS ARPU
FROM customer_month_revenue
GROUP BY MonthNumber
ORDER BY MonthNumber;
