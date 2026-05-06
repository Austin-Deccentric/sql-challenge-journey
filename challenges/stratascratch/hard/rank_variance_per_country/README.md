# 🧩 Rank Variance Per Country

- **Platform:** StrataScratch  
- **Difficulty:** Hard  
- **Date Solved:** 2026-05-06  

**Concepts:** Aggregation, Ranking, Window Functions, Time-Series Analysis  

---

## 📄 Problem Summary
Identify countries whose ranking based on total comments improved from December 2019 to January 2020.

---

## 💡 Initial Approach (LEAD-Based)
- Join comments data with user country data  
- Filter only relevant months (Dec 2019 and Jan 2020)  
- Aggregate total comments per country per month  
- Rank countries monthly using `DENSE_RANK()`  
- Use `LEAD()` to compare ranks between months  

📄 File: `solution.sql`

---

## 🏆 Optimized Approach (Recommended)
- Use conditional aggregation to compute both months in one pass  
- Rank directly on aggregated results  
- Compare January vs December ranks  

📄 File: `solution_optimized.sql`

### ✅ Why this is preferred:
- More efficient (single aggregation pass)  
- No dependency on row ordering  
- Cleaner and production-ready  

---

## 🧾 Solution Evolution
This problem demonstrates multiple valid SQL approaches:

1. **Window-based comparison (`LEAD`)** → simple but less robust   
2. **Conditional aggregation (final)** → most efficient and practical  

---

## 🔍 Key Learnings
- Multiple strategies exist for time-based comparisons  
- Tradeoffs between readability, robustness, and performance  
- Conditional aggregation is a powerful optimization technique  
- Writing production-ready SQL requires evaluating different approaches  

---
