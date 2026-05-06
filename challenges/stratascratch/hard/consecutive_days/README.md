# 🧩 Consecutive Days

- **Platform:** StrataScratch  
- **Difficulty:** Hard  
- **Date Solved:** 2026-05-06  

---

## 📄 Problem Summary
Find consecutive days of user activity and group them into streaks.

---

## 💡 Approach
- Remove duplicates using DISTINCT  
- Use ROW_NUMBER() to create sequence  
- Normalize dates to detect consecutive streaks  
- Group and aggregate  

---

## 🧾 Solution Explanation
This solution uses the "gaps and islands" technique by shifting dates with row numbers to identify continuous sequences.

---

## 🔍 Key Learnings
- Gaps and islands pattern  
- Window functions (`ROW_NUMBER`)  
- SQL dialect differences  

---
