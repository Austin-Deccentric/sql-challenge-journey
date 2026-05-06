/* 
   Optimized Approach:
   Single-pass aggregation + ranking
*/

WITH MonthlyComments AS (
    SELECT 
        country,
        SUM(CASE 
            WHEN created_at >= '2019-12-01' 
             AND created_at < '2020-01-01' 
            THEN number_of_comments 
        END) AS dec_total,
        SUM(CASE 
            WHEN created_at >= '2020-01-01' 
             AND created_at < '2020-02-01' 
            THEN number_of_comments 
        END) AS jan_total
    FROM fb_comments_count AS C
    JOIN fb_active_users AS AU 
        ON C.user_id = AU.user_id
    GROUP BY country
),

RankedCountries AS (
    SELECT 
        country,
        DENSE_RANK() OVER (ORDER BY dec_total DESC) AS dec_rank,
        DENSE_RANK() OVER (ORDER BY jan_total DESC) AS jan_rank
    FROM MonthlyComments
)

SELECT country
FROM RankedCountries
WHERE jan_rank < dec_rank;
