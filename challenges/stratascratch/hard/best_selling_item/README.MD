# 🧩 Best Selling Item

- **Platform:** StrataScratch  
- **Difficulty:** Hard  
- **Date Solved:** 2026-05-05  

---

## 📄 Problem Summary
Find the best-selling item for each month based on total revenue, excluding cancelled orders.

---

## 💡 Approach
- Filter out cancelled orders (invoice numbers starting with 'C')  
- Calculate total revenue using `unitprice * quantity`  
- Aggregate by month and product description  
- Use `DENSE_RANK()` to rank products per month  
- Select the top-ranked item(s) for each month  

---

## 🧾 Solution Explanation
This solution groups sales data by month and product, then ranks each product within its month based on total revenue.  
The highest-ranked product (`sales_rank = 1`) is selected as the best-selling item for that month.

---

## 🔍 Key Learnings
- Filtering data before aggregation improves accuracy  
- Combining aggregation with window functions  
- Ranking within partitions using `ROW_NUMBER()`  
- Handling business logic like cancelled transactions  

---
