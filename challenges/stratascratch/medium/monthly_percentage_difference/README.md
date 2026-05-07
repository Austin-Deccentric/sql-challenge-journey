# 🧩 Monthly Percentage Difference

- **Platform:** StrataScratch
- **Difficulty:** Medium
- **Date Solved:** 2026-05-07
- **Challenge Link:** [Monthly Percentage Difference](https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=3)

---

## 📄 Problem Summary

Given a transactions table, compute the month-over-month percentage change in total revenue for each month. Output the month and the percentage difference rounded to 2 decimal places.

---

## 💡 Approach

- Aggregate total revenue per month using `SUM(value)` grouped by year and month
- Use `LAG()` to access the previous month's total in the previous period
- Apply the percentage change formula: `(current - previous) / previous * 100`
- Round to 2 decimal places

---

## 🔄 Solution Evolution

### 1. Initial Solution (`solution.sql`)

Aggregation in CTE, `LAG()` applied in outer query. Works correctly but calls `LAG()` twice — once for subtraction, once for division.

```sql
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
```

### 2. Optimized Solution (`solution_optimized.sql`) ⭐

`LAG()` computed once inside the CTE alongside the aggregation. Previous and current month values are named columns — math in the outer query is clean and debuggable.

```sql
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
```

**Why it’s better:**
- Single `LAG()` call
- Self-documenting column names
- Intermediate values visible for debugging
- Cleaner separation of aggregation and presentation logic

> ⚠️ `GROUP BY month_id` (alias) works in MySQL but not PostgreSQL — use `GROUP BY DATE_FORMAT(created_at, '%Y-%m')` for cross-dialect compatibility.

---

## 🔍 Key Learnings

- `LAG()` for row-to-row time-series comparison
- Computing window functions inside CTEs to avoid repetition
- `DATE_FORMAT` (MySQL) vs `TO_CHAR` (PostgreSQL) for month formatting
- Named intermediate columns improve debuggability and readability

---

## 🏷️ Patterns

`LAG/LEAD` · `Time Comparison` · `Aggregation` · `CTE`
