# Retail Sales & Customer Analytics

### End-to-End Data Analytics Project | PostgreSQL • Python • Tableau

An end-to-end retail analytics project using **PostgreSQL, Python (Pandas and NumPy), and Tableau** to analyze sales performance, profitability, customer segments, regional trends, and the impact of discounts on business performance.

The project demonstrates data preparation, SQL analysis, exploratory data analysis (EDA), KPI reporting, and interactive business intelligence dashboards.

## Live Dashboard

**[View Interactive Tableau Dashboard](https://public.tableau.com/app/profile/madhavareddy.erugula/viz/superstore_orders_17946099759940/RetailSalesCustomerAnalytics)**

## Project Overview

This project analyzes **10,194 retail transaction records** from the fictional Superstore dataset.

The objective is to transform raw sales data into actionable business insights that can help decision-makers:

- Monitor revenue and profitability.
- Identify high-performing product categories and regions.
- Understand customer purchasing patterns.
- Evaluate the relationship between discount levels and profit margins.
- Track sales performance over time.

## Technology Stack

| Technology | Application |
|---|---|
| PostgreSQL | Data querying, aggregation, CTEs, window functions |
| Python | Data cleaning and exploratory analysis |
| Pandas | Data manipulation and analysis |
| NumPy | Numerical operations |
| Google Colab | Python notebook development |
| Tableau | Interactive dashboards and KPI reporting |
| GitHub | Version control and project documentation |

## Dataset

**Dataset:** Superstore Retail Sales

**Records:** 10,194

The dataset contains information about:

- Orders and transaction dates
- Customers and customer segments
- Products and categories
- Sales, quantities, discounts, and profits
- Geographic regions
- Shipping information

*Note: The dataset represents fictional retail transactions and is used for analytical and educational purposes.*

## Project Workflow

### 1. Data Preparation

- Imported the retail dataset into PostgreSQL.
- Reviewed field types and converted date fields for time-based analysis.
- Prepared the data for SQL queries and Python analysis.
- Used a cleaned dataset for dashboard development.

### 2. SQL Analysis

Performed analytical queries using:

- Common Table Expressions (CTEs)
- `GROUP BY` and aggregate functions
- `DATE_TRUNC()` for time-based grouping
- `LAG()` for comparing consecutive periods
- Window functions
- Percentage and profitability calculations

The SQL analysis focused on sales trends, profitability, and business performance.

### 3. Python Exploratory Data Analysis

Used Python and Pandas in Google Colab to explore retail sales data and investigate business performance.

Analysis areas included:

- Sales and profit distributions
- Product category performance
- Regional comparisons
- Customer segments
- Discount and profitability patterns

### 4. Tableau Dashboard

Developed an interactive Tableau dashboard featuring:

- Total Sales KPI
- Total Profit KPI
- Overall Profit Margin KPI
- Monthly Sales Performance
- Regional Sales & Profitability
- Category Profitability
- Profit Margin by Discount Level
- Interactive Category and Region filters

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total Sales | 2,326,534 |
| Total Profit | 292,297 |
| Overall Profit Margin | 12.56% |
| Records Analyzed | 10,194 |

*Sales and profit figures are expressed in dataset units; no currency is assumed.*

## Key Business Insights

### 1. Regional Performance

The **West** region recorded the highest sales, approximately **739,814**, followed by the East region with approximately **691,828**.

This highlights differences in regional revenue contribution.

### 2. Product Category Profitability

**Technology** generated the highest category profit at approximately **146,543**, followed by Office Supplies at approximately **126,023**.

Furniture contributed a considerably smaller profit of approximately **19,730**.

### 3. Discount Impact

The dashboard revealed substantial differences in profitability across discount levels.

| Discount Band | Profit Margin |
|---|---:|
| No Discount | 29.56% |
| 0–20% | 11.86% |
| 20–40% | -15.29% |
| 40–60% | -40.78% |
| 60–100% | -122.64% |

Higher discount bands were associated with increasingly negative profit margins in this dataset.

These findings suggest that discount strategies deserve further review before being expanded.

## Business Recommendations

1. **Review high-discount transactions:** Investigate products and orders with consistently negative margins.
2. **Improve category profitability:** Examine cost, pricing, and discount patterns in lower-margin categories.
3. **Analyze regional differences:** Compare product mix and profitability across regions, not just total sales.
4. **Monitor monthly performance:** Use monthly trends to identify periods requiring further investigation.
5. **Track profitability alongside revenue:** Evaluate sales growth together with profit margins to support balanced business decisions.

## Repository Structure

```text
Retail-Sales-Customer-Analytics/
├── README.md
├── sql/
│   └── superstore_analysis.sql
├── python/
│   └── retail_sales_analysis.ipynb
├── tableau/
│   └── dashboard_link.txt
└── reports/
    └── business_insights.md
```

## Skills Demonstrated

**SQL:** Data extraction, aggregations, CTEs, window functions, date analysis, analytical queries.

**Python:** Pandas, NumPy, exploratory data analysis and data manipulation.

**Tableau:** KPI dashboards, calculated fields, data visualization, interactive filters and profitability analysis.

**Business Analytics:** Sales performance reporting, trend analysis, profitability assessment and data-driven recommendations.

## Project Outcome

Built an end-to-end retail analytics workflow combining SQL analysis, Python-based exploration, and an interactive Tableau dashboard to communicate business performance and profitability insights.

This project demonstrates practical analytical techniques applicable to entry-level Data Analyst and Business Intelligence roles.

## Author

**Madhavareddy Erugula**

[GitHub Profile](https://github.com/MadhavareddyErugula) | [Tableau Public Dashboard](https://public.tableau.com/app/profile/madhavareddy.erugula/viz/superstore_orders_17946099759940/RetailSalesCustomerAnalytics)
