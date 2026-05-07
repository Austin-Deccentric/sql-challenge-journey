-- Monthly Percentage Difference
-- Platform: StrataScratch | Difficulty: Medium
-- https://platform.stratascratch.com/coding/10319-monthly-percentage-difference

WITH monthly AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') AS date_of_purchase,
        SUM(value) AS total
    FROM sf_transactions
    GROUP BY YEAR(created_at), MONTH(created_at)
)
SELECT
    date_of_purchase,
    ROUND(
        (total - LAG(total) OVER (ORDER BY date_of_purchase)) /
        LAG(total) OVER (ORDER BY date_of_purchase) * 100,
        2
    ) AS revenue_diff_pct
FROM monthly
ORDER BY date_of_purchase;
