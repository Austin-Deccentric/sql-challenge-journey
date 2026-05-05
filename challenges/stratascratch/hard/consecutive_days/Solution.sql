-- Consecutive Days (PostgreSQL version)

WITH UniqueActivity AS (
    SELECT DISTINCT 
        record_date,
        account_id,
        user_id
    FROM sf_events
),

DateGroups AS (
    SELECT
        account_id,
        user_id,
        record_date,
        record_date - INTERVAL '1 day' * ROW_NUMBER() OVER(
            PARTITION BY account_id, user_id 
            ORDER BY record_date
        ) AS daygroup
    FROM UniqueActivity
)

SELECT 
    account_id,
    user_id,
    MIN(record_date) AS start_date,
    MAX(record_date) AS end_date,
    COUNT(*) AS streak_length
FROM DateGroups
GROUP BY account_id, user_id, daygroup
ORDER BY streak_length DESC;
