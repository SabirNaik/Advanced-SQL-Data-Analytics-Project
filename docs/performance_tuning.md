# SQL Performance Tuning Guidelines

This document outlines best practices and strategies for optimizing the queries in this repository.

## 1. Using Indexes
Proper indexing is critical for query performance, especially when filtering or joining large tables.
* **Primary Keys:** Automatically indexed in most SQL engines. Ensure all tables (`employee`, `invoice`, `customer`, etc.) have appropriate primary keys defined.
* **Foreign Keys:** Create indexes on foreign key columns (e.g., `customer_id` in the `invoice` table) to drastically speed up `JOIN` operations.
* **Filtering Columns:** Columns frequently used in `WHERE` clauses (e.g., `billing_country` in `invoice`, `name` in `genre`) are good candidates for secondary indexes.

## 2. Analyzing Execution Plans (`EXPLAIN`)
Before deploying a complex query, use `EXPLAIN` or `EXPLAIN ANALYZE` to view the query execution plan.
* Look for **Sequential Scans (Seq Scan)** on large tables, which indicates an index might be missing.
* Ensure that the engine is choosing efficient join algorithms (e.g., Hash Join vs. Nested Loop) depending on table sizes.

## 3. Optimizing Window Functions and CTEs
* **Common Table Expressions (CTEs):** While CTEs improve readability, in some engines (like older versions of PostgreSQL), they act as optimization fences. Ensure CTEs are not doing unnecessary work by filtering early inside the CTE.
* **Window Functions:** Operations like `ROW_NUMBER()` or `NTILE()` can be memory-intensive. Reduce the partition size or index the columns used in the `PARTITION BY` and `ORDER BY` clauses of the window function.

## 4. Query Restructuring
* Avoid `SELECT *`. Explicitly name the columns you need to reduce memory and network overhead.
* Be cautious with functions on indexed columns in `WHERE` clauses (e.g., `WHERE ROUND(total) = 10`), as this typically prevents the database from using the index (leading to a full table scan).
* Replace `IN` subqueries with `EXISTS` or `JOIN` where appropriate if performance degrades with large sets.
