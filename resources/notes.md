# 🧠 SQL Patterns (Quick Reference)

---

## 📌 Gaps & Islands (Consecutive Data)

* Use `ROW_NUMBER()`
* Normalize sequence → group

```sql
record_date - INTERVAL '1 day' * ROW_NUMBER()
```

**Use:** streaks, consecutive activity

---

## 📌 Ranking

* `ROW_NUMBER()` → no ties
* `RANK()` → gaps
* `DENSE_RANK()` → no gaps

```sql
DENSE_RANK() OVER (PARTITION BY col ORDER BY metric DESC)
```

**Use:** top-N, leaderboards

---

## 📌 Time Comparison

**1. Window (quick)**

```sql
LEAD(value) OVER (PARTITION BY id ORDER BY date)
```

**2. Pivot (clear)**

```sql
MAX(CASE WHEN month = 'Dec' THEN value END)
```

**3. Conditional Agg (best)**

```sql
SUM(CASE WHEN condition THEN value END)
```

👉 Prefer:

* Performance → Conditional
* Clarity → Pivot
* Sequence → Window

---

## 📌 Conditional Aggregation

```sql
SUM(CASE WHEN condition THEN value END)
```

**Use:** multi-metrics, comparisons

---

## 📌 Filtering (Performance)

```sql
WHERE date >= 'YYYY-MM-DD'
```

* Filter early
* Reduce data scanned

---

## 📌 Window Functions

* `ROW_NUMBER()`
* `RANK()` / `DENSE_RANK()`
* `LEAD()` / `LAG()`

**Use:** ranking, trends, comparisons

---

## 📌 SQL Principles

* Filter early
* Keep queries readable (CTEs)
* Handle edge cases
* Optimize only when needed

---
