# 🧠 SQL Patterns (Quick Reference)

---

## 📌 Gaps & Islands

```sql
record_date - INTERVAL '1 day' * ROW_NUMBER() OVER (PARTITION BY account_id user_id ORDER BY record_date)
```
**Use:** streaks, consecutive activity detection

---

## 📌 Ranking

- `ROW_NUMBER()` → unique, no ties
- `RANK()` → ties allowed, gaps in sequence
- `DENSE_RANK()` → ties allowed, no gaps

```sql
DENSE_RANK() OVER (PARTITION BY col ORDER BY metric DESC)
```
**Use:** top-N per group, leaderboards

---

## 📌 LEAD / LAG

```sql
LEAD(value, 1) OVER (PARTITION BY id ORDER BY date)
LAG(value, 1)  OVER (PARTITION BY id ORDER BY date)
```
**Use:** row-to-row comparisons, month-over-month, next/previous event

---

## 📌 Time Comparison Strategies

| Approach | Pattern | Best When |
|----------|---------|-----------|
| Window | `LEAD() / LAG()` | Sequential comparison |
| Pivot | `MAX(CASE WHEN month = 'Dec' THEN value END)` | Readability matters |
| Conditional Agg | `SUM(CASE WHEN condition THEN value END)` | Performance + multi-metric |

👉 Default to **Conditional Aggregation** in production.

---

## 📌 Conditional Aggregation

```sql
SUM(CASE WHEN condition THEN value END) AS metric
```
**Use:** compute multiple metrics in one pass, pivot-style comparisons

---

## 📌 SQL Principles

- Filter early — reduces data scanned (`WHERE` before `JOIN` where possible)
- Use CTEs for readability over nested subqueries
- Handle edge cases (NULLs, ties, empty groups)
- Optimize only when needed; clarity first
