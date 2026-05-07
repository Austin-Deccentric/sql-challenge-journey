-- Monthly Percentage Difference — Optimized
-- Platform: StrataScratch | Difficulty: Medium
-- https://platform.stratascratch.com/coding/10319-monthly-percentage-difference

WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS month_id,
        SUM(value) AS current_month_value,
        LAG(SUM(value)) OVER (ORDER BY DATE_FORMAT(created_at, '%Y-%m')) AS prev_month_value
    FROM sf_transactions
    GROUP BY month_id
)
SELECT
    month_id,
    current_month_value,
    prev_month_value,
    ROUND(
        (current_month_value - prev_month_value) / prev_month_value * 100,
        2
    ) AS percentage_growth
FROM MonthlySales
ORDER BY month_id;
