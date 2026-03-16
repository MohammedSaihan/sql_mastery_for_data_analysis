# 🚀 SQL + Power BI 30 Day Data Analyst Challenge

<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL-blue?style=for-the-badge&logo=mysql" />
  <img src="https://img.shields.io/badge/PowerBI-Dashboard-yellow?style=for-the-badge&logo=powerbi" />
  <img src="https://img.shields.io/badge/Python-Data%20Cleaning-green?style=for-the-badge&logo=python" />
  <img src="https://img.shields.io/badge/Status-In%20Progress-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Challenge-30%20Days-red?style=for-the-badge" />
</p>

---

# 📊 Project Overview

This repository documents my **30 Day SQL + Power BI Challenge** where I practice real-world **Data Analyst workflows** using a retail sales dataset with **100K+ rows**.

The goal is to simulate the work of a **real business data analyst**:

• Query data using SQL
• Clean and transform data using Python
• Build a star schema data model
• Create executive dashboards in Power BI
• Generate business insights

---

# 🧠 Tech Stack

<p align="center">

<img src="https://skillicons.dev/icons?i=python,mysql" />

</p>

| Tool     | Purpose                       |
| -------- | ----------------------------- |
| Python   | Data cleaning & preprocessing |
| MySQL    | Data querying & analysis      |
| Power BI | Data visualization            |
| Pandas   | Data manipulation             |

---

# 🗂 Project Structure

```
project
│
├── raw_data
│   └── original dataset
│
├── cleaned_data
│   └── processed dataset ready for analysis
│
├── sql
│   └── analysis_queries.sql
│
├── notebook
│   └── data_cleaning.ipynb
│
├── PowerBi-dashboard
│   └── retail_dashboard.pbix
│
└── README.md
```

---

# 🧩 Data Model (Star Schema)

This project follows a **Fact + Dimension modeling approach** used in real analytics teams.

Fact Table

• `sales_transactions_clean`

Dimension Tables

• `customers`
• `products_categorized`
• `cities_clean`

### Data Model Preview

![Data Model](images/data_model.png)

---

# 📈 Executive Dashboard

The dashboard answers real business questions:

• What is the total revenue?
• How many orders were placed?
• What is the monthly trend?
• Which products generate the most revenue?
• Which cities contribute the most sales?

### Dashboard Preview

![Dashboard](C:/Users/skill/Play-code/sql_mastery_for_data_analysis/saudi_al_kabeer/PowerBi-dashboard/screen-shots/total_order.png)

---

# 🎥 Dashboard Demo

<p align="center">
  <img src="images/dashboard_demo.gif" width="800" />
</p>

*(GIF preview of the Power BI dashboard interaction)*

---

# 📊 Key Metrics

| Metric         | Value       |
| -------------- | ----------- |
| Total Revenue  | 555.83M SAR |
| Total Orders   | 500K        |
| Monthly Growth | 1.4%        |
| Yearly Growth  | 89%         |

---

# 🧮 Example SQL Analysis

```sql
SELECT 
    product_id,
    SUM(total_amount) AS revenue
FROM sales_transactions_clean
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 5;
```

Business Insight:

Top performing products contribute the largest portion of revenue. These products should receive priority in **marketing campaigns and inventory planning**.

---

# 📅 30 Day Progress Tracker

| Day    | Topic             | Status |
| ------ | ----------------- | ------ |
| Day 1  | Database Setup    | ✅      |
| Day 2  | Data Cleaning     | ✅      |
| Day 3  | SQL Aggregations  | ✅      |
| Day 4  | Joins             | ✅      |
| Day 5  | Revenue Analysis  | ⏳      |
| Day 6  | Customer Analysis | ⏳      |
| Day 7  | Product Insights  | ⏳      |
| Day 8  | City Revenue      | ⏳      |
| Day 9  | Monthly Trends    | ⏳      |
| Day 10 | MoM Growth        | ⏳      |
| ...    | ...               | ...    |
| Day 30 | Final Dashboard   | ⏳      |

---

# 🔎 Data Analysis Workflow

1️⃣ Raw dataset collection
2️⃣ Data cleaning using Python
3️⃣ Import cleaned data into MySQL
4️⃣ SQL queries for business analysis
5️⃣ Build star schema data model
6️⃣ Create Power BI dashboard
7️⃣ Generate insights for stakeholders

---

# 📢 LinkedIn Content Funnel

This project is also shared publicly on LinkedIn to document the learning journey.

Content Strategy:

1️⃣ Post SQL insights
2️⃣ Share Power BI dashboards
3️⃣ Explain business insights
4️⃣ Engage with analytics community

Goal:

Turn this challenge into **recruiter visibility + job opportunities.**

---

# 🤝 Connect With Me

If you're interested in **Data Analytics, SQL, or Power BI**, feel free to connect.

LinkedIn: *(add your link here)*

---

⭐ If this project helped you or inspired you, consider **starring the repository.**
