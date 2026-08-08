# SQL Data Analytics Project

An end-to-end SQL data analytics project covering customer, invoice, and music genre analysis.

## Overview

This repository demonstrates practical SQL data analytics using a music store dataset. The queries analyze employee hierarchies, invoice distributions, customer spending behavior, and popular genres using various SQL techniques, from basic aggregations to advanced analytical window functions and Common Table Expressions (CTEs).

## Objectives

The analysis answers key business questions such as:
- Employee hierarchy: Identifying the most senior employee.
- Invoice and revenue analysis: Determining the distribution of invoices across countries and cities, and locating top invoices.
- Customer spending analysis: Discovering high-value customers and analyzing total expenditure on popular artists.
- Music and genre analysis: Identifying the top rock bands, analyzing track lengths, and calculating the most popular genre by country.

## SQL Concepts Used

The SQL files demonstrate proficiency in the following concepts:
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`
- `JOIN`s (INNER JOIN)
- Aggregate functions (`COUNT`, `SUM`, `AVG`, `ROUND`)
- Subqueries
- Common Table Expressions (CTEs)
- Window functions (`ROW_NUMBER()`)

## Project Structure

```text
.
├── Project 1.sql      # Contains all the SQL queries answering analytical questions
└── README.md          # Project documentation
```

## Analysis Covered

### Employee Analysis
Finds the most senior employee by evaluating job title levels.

### Invoice Analysis
Examines the geographic distribution of invoices and calculates top invoice values globally.

### Customer Analysis
Highlights the top spending customers overall and the top spender per country. It also targets specific demographics, like Rock music listeners.

### Advanced SQL Analysis
Uses CTEs and window functions to answer complex questions such as:
- Identifying the best-selling artists by revenue.
- Determining the most popular genre for each country based on purchases.
- Ranking top customers by country using window functions.

## Key SQL Techniques

- **CTEs (Common Table Expressions):** Break down complex logic (e.g., finding a popular genre before joining back to customer data).
- **ROW_NUMBER():** Ranks records within groups, specifically used to find the #1 genre or customer partitioned by country.
- **Aggregations with JOINs:** Seamlessly combines data from `customer`, `invoice`, `invoice_line`, `track`, `album`, and `genre` tables to generate actionable insights.

## Author

Sabir Naik
