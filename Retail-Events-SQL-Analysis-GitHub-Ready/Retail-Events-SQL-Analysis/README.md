# Retail Events SQL Analysis

## 📌 Project Overview

This project contains my solutions to a **20-question SQL practice assignment** based on a retail promotional events dataset.

The project focuses on analyzing the impact of promotions on product sales, revenue, stores, categories, campaigns, and promotion types.

The questions progress from **basic SQL concepts to advanced analytical techniques**, providing practical experience with SQL for business and data analysis.

---

## 🗄️ Dataset

The analysis uses the `retail_events_db` database.

### Main Tables

#### `fact_events`
Contains product-level promotional event information.

Key columns:

- `event_id`
- `store_id`
- `campaign_id`
- `product_code`
- `base_price`
- `promo_type`
- `quantity_sold(before_promo)`
- `quantity_sold(after_promo)`

#### `dim_products`

- `product_code`
- `product_name`
- `category`

#### `dim_stores`

- `store_id`
- `city`

#### `dim_campaigns`

- `campaign_id`
- `campaign_name`
- `start_date`
- `end_date`

---

## 🎯 Objectives

The project demonstrates how SQL can be used to:

- Analyze sales before and after promotions
- Measure promotional uplift
- Compare promotion types
- Analyze product performance
- Compare product categories
- Analyze store and city performance
- Analyze campaign performance
- Calculate revenue before and after promotions
- Rank products within categories
- Rank stores within cities
- Analyze product performance within campaigns

---

## 📚 SQL Concepts Covered

### Fundamentals

- `SELECT`
- `WHERE`
- `DISTINCT`
- `ORDER BY`

### Aggregation

- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `HAVING`

### Joins

- `LEFT JOIN`
- Multiple-table joins

### Calculations

- Quantity change
- Percentage change
- Revenue calculations

### Conditional Logic

- `CASE`

### Advanced SQL

- Common Table Expressions (`CTE`)
- Window functions
- `RANK()`
- `DENSE_RANK()`
- `ROW_NUMBER()`
- `PARTITION BY`
- Ranking and filtering analytical results

---

## 📊 Questions Covered

| Question | Topic | Main Concepts |
|---|---|---|
| Q1 | High-Value Products | `SELECT`, `WHERE` |
| Q2 | Sorting Promotional Events | `WHERE`, `ORDER BY` |
| Q3 | Promotion Types | `DISTINCT` |
| Q4 | Basic Aggregation | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` |
| Q5 | Sales Volume by Promotion Type | `GROUP BY`, aggregation |
| Q6 | Promotion Uplift | aggregation, arithmetic |
| Q7 | Product Performance | `JOIN`, `GROUP BY`, `SUM` |
| Q8 | Category-Level Performance | `JOIN`, aggregation |
| Q9 | Store Performance | `JOIN`, `GROUP BY` |
| Q10 | Campaign Performance | `JOIN`, dates, aggregation |
| Q11 | Category Analysis | `HAVING`, `AVG`, `SUM` |
| Q12 | Store + Category Analysis | multiple `JOIN`s |
| Q13 | Product Promotion Effectiveness | percentage calculations |
| Q14 | Campaign + Promotion Type | multiple grouping columns |
| Q15 | Product Revenue Analysis | revenue calculations |
| Q16 | Promotion Classification | `CASE` |
| Q17 | Top Products by Category | CTE, `DENSE_RANK()` |
| Q18 | Top Stores by City | CTE, `RANK()` |
| Q19 | Campaign Product Ranking | CTE, `ROW_NUMBER()` |
| Q20 | Complete Product Analysis | CTE, revenue, ranking |

---

## 🔍 Key Business Metrics

### Quantity Change

```text
Quantity Change = After Promotion - Before Promotion
```

### Percentage Change

```text
Percentage Change =
((After Promotion - Before Promotion) / Before Promotion) × 100
```

### Revenue Before Promotion

```text
Revenue Before =
Base Price × Quantity Before Promotion
```

### Revenue After Promotion

```text
Revenue After =
Base Price × Quantity After Promotion
```

### Revenue Change

```text
Revenue Change =
Revenue After - Revenue Before
```

---

## 🧠 Advanced SQL Analysis

The final four questions demonstrate progressively more advanced SQL techniques.

### Q17 — Top Products Within Each Category

Uses a CTE and `DENSE_RANK()` to rank products within each category and return the top two.

### Q18 — Best-Performing Stores Within Each City

Uses a CTE and `RANK()` to rank stores within each city and return the top two.

### Q19 — Campaign-Level Product Performance

Uses CTEs and `ROW_NUMBER()` to rank products within each campaign and return the top three.

### Q20 — Complete Promotional Performance Analysis

Combines:

- Product-level aggregation
- Quantity analysis
- Percentage calculations
- Revenue calculations
- Average base price
- `DENSE_RANK()`
- `PARTITION BY`

The final result returns the top two products within each category based on revenue change.

---

## 📂 Repository Structure

```text
Retail-Events-SQL-Analysis/
│
├── README.md
│
├── SQL/
│   └── Retail_Events_SQL_Analysis.sql
│
└── Questions/
    └── Retail_Events_SQL_Practice_20_Questions.txt
```

---

## ▶️ How to Run

### 1. Clone the repository

```bash
git clone <your-repository-url>
```

### 2. Open the SQL file

Open:

```text
SQL/Retail_Events_SQL_Analysis.sql
```

using a MySQL-compatible SQL editor.

### 3. Select the database

Make sure the `retail_events_db` database is available.

### 4. Execute the queries

Run the queries individually to reproduce the analysis for Questions 1–20.

---

## 🛠️ Technologies Used

- **SQL**
- **MySQL**
- **Git**
- **GitHub**

---

## 📈 Learning Outcomes

Through this assignment, I practiced:

- Translating business questions into SQL queries
- Filtering and sorting data
- Aggregating data
- Joining fact and dimension tables
- Calculating business metrics
- Measuring promotional uplift
- Calculating percentage changes
- Performing revenue analysis
- Using `HAVING`
- Writing CTEs
- Applying window functions
- Ranking data within groups
- Performing product, store, category, and campaign analysis

---

## 🚀 Future Improvements

Possible extensions to this project include:

- Adding query result screenshots
- Creating SQL views for frequently used analysis
- Building a Power BI or Tableau dashboard
- Adding additional KPIs
- Comparing campaign profitability
- Performing time-based promotional analysis

---

## 👤 Author

**Kshitij Chhabariya**

GitHub: `<your-github-username>`

---

⭐ This repository demonstrates practical SQL skills through a retail promotion analytics case study.
