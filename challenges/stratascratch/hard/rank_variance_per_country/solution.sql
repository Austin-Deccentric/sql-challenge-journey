/* 
   PURPOSE: Find countries whose comment rank improved from Dec 2019 to Jan 2020.
*/

WITH MonthlyStats AS (
    SELECT 
        AU.country,
        YEAR(C.created_at) AS year_val,
        MONTH(C.created_at) AS month_val,
        SUM(C.number_of_comments) AS total_comments
    FROM fb_comments_count AS C 
    INNER JOIN fb_active_users AU 
        ON AU.user_id = C.user_id
    WHERE (C.created_at >= '2019-12-01' AND C.created_at < '2020-02-01')
    GROUP BY 1, 2, 3
),

RankedStats AS (
    SELECT 
        country,
        year_val,
        month_val,
        DENSE_RANK() OVER(
            PARTITION BY year_val, month_val 
            ORDER BY total_comments DESC
        ) AS comment_rank
    FROM MonthlyStats
),

Comparison AS (
    SELECT 
        country,
        comment_rank,
        LEAD(comment_rank) OVER(
            PARTITION BY country 
            ORDER BY year_val, month_val
        ) AS next_month_rank
    FROM RankedStats
)

SELECT DISTINCT country
FROM Comparison
WHERE comment_rank > next_month_rank 
  AND next_month_rank IS NOT NULL;
