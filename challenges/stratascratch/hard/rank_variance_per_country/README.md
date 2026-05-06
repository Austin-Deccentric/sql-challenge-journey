# 🧩 Rank Variance Per Country

- **Platform:** StrataScratch  
- **Difficulty:** Hard  
- **Date Solved:** 2026-05-05  

---

## 📄 Problem Summary
Identify countries whose ranking based on total comments improved from December 2019 to January 2020.

---

## 💡 Approach
- Join comments data with user country data  
- Filter only relevant months (Dec 2019 and Jan 2020)  
- Aggregate total comments per country per month  
- Rank countries monthly using `DENSE_RANK()`  
- Use `LEAD()` to compare ranks between months  
- Select countries where rank improved  

---

## 🧾 Solution Explanation
The query first aggregates comment counts by country and month.  
Then it ranks countries within each month based on total comments.  

Using `LEAD()`, it compares each country’s December rank to its January rank.  
If the January rank is smaller (better), the country is considered to have improved.

---

## 🔍 Key Learnings
- Time-based comparisons using window functions  
- Using `LEAD()` for forward comparison  
- Ranking with `DENSE_RANK()`  
- Importance of filtering early for performance  

---
