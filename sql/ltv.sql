WITH customer_revenue AS (
    SELECT
        o.customerid,
        SUM(o.quantity * s.unitprice) AS revenue
    FROM orders o
    JOIN stocks s USING (stockcode)
    WHERE o.is_anonymous = 'no'
      AND substr(o.invoiceno, 1, 1) BETWEEN '0' AND '9'
    GROUP BY o.customerid
)

SELECT 
    AVG(revenue) AS LTV
FROM customer_revenue;