SELECT is_anonymous, COUNT(InvoiceNo)
FROM orders
GROUP BY is_anonymous;