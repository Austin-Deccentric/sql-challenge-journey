-- Best Selling Item per Month

WITH DeliveredOrders AS (
    SELECT 
        *
    FROM online_retail
    WHERE invoiceno NOT LIKE 'C%'
),

SalesRanks AS (
    SELECT 
        MONTH(invoicedate) AS "month",
        description,
        SUM(unitprice * quantity) AS total_paid,
        DENSE_RANK() OVER (
            PARTITION BY MONTH(invoicedate) 
            ORDER BY SUM(unitprice * quantity) DESC
        ) AS sales_rank
    FROM DeliveredOrders
    GROUP BY 1, 2
)

SELECT
    month,
    description,
    total_paid
FROM SalesRanks
WHERE sales_rank = 1
ORDER BY month;
