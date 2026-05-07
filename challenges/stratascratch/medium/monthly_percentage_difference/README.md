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
- Use `LAG()` to access the previous month's total within a CTE
- Apply the percentage change formula: `(current - previous) / previous * 100`
- Round to 2 decimal places

---

## 🧾 Solution Explanation

Monthly totals are pre-computed in a CTE to avoid repeating the `LAG()` call. The window function orders by the formatted date string (`YYYY-MM`) to ensure correct chronological sequencing. The first month returns NULL as there is no prior period to compare.

---

## 🔍 Key Learnings

- LAG() for row-to-row time-series comparison
- Aggregating before applying window functions via CTE
- `DATE_FORMAT` (MySQL) vs `TO_CHAR` (PostgreSQL) for month formatting
- Always alias computed columns and round percentage outputs

---

## 🏷️ Patterns

`LAG/LEAD` · `Time Comparison` · `Aggregation` · `CTE`
