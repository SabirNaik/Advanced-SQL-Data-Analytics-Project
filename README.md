# 🎵 Advanced SQL Data Analytics Project

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue.svg)
![Python](https://img.shields.io/badge/Python-Streamlit-orange.svg)
![Data Analytics](https://img.shields.io/badge/Domain-Data_Analytics-green.svg)

## 📌 Project Overview

This repository demonstrates a comprehensive SQL data analysis portfolio project using a music and invoice relational database. The core objective is to extract actionable business insights regarding employee hierarchies, customer purchasing behavior, and global invoice trends through efficient and optimized SQL queries.

This project has been engineered to showcase professional structuring, documentation, and the application of advanced SQL concepts to solve real-world analytics problems.

## 🗂️ Project Structure

The repository is modularly organized to separate logical concerns:

```text
├── docs/                           # Architecture and performance tuning documentation
│   ├── architecture.md             # ER Diagram and schema explanation
│   └── performance_tuning.md       # Strategies for optimizing SQL queries
├── queries/                        # SQL scripts segmented by analysis domain
│   ├── 01_employee_analysis.sql
│   ├── 02_invoice_analysis.sql
│   ├── 03_customer_insights.sql
│   ├── 04_advanced_cte_analysis.sql
│   └── 05_advanced_window_functions.sql
├── visualizations/                 # Python/Streamlit analytical dashboards
│   └── app.py
├── requirements.txt                # Python dependencies
└── README.md                       # Project documentation
```

## 🛠️ Skills and Technologies Demonstrated

* **Relational Database Management:** PostgreSQL / SQLite
* **Core SQL Constructs:** `JOIN`s, Subqueries, Aggregate Functions
* **Advanced SQL:** Common Table Expressions (CTEs), Window Functions (`LAG`, `NTILE`, `ROW_NUMBER`), Rolling Averages
* **Performance Optimization:** Understanding execution plans and proper indexing strategies.
* **Data Visualization:** Python, Pandas, and Streamlit for interactive dashboard creation.

## 📊 Key Business Questions Answered

* **Employee Analysis:** Who is the senior-most employee in the organization?
* **Financial Trends:** What are the month-over-month revenue growth and 3-month rolling averages?
* **Customer Behavior:** Who are the top-spending customers, and how can we segment them using Customer Lifetime Value (CLTV) quartiles?
* **Geographic Insights:** Which countries generate the highest number of invoices and total spending?

## 🚀 Setup Instructions

### 1. Running the SQL Queries
The SQL files in the `queries/` directory are written using standard ANSI SQL and are compatible with PostgreSQL and SQLite.
You can run these scripts against your target database using any SQL IDE (e.g., DBeaver, pgAdmin) or via CLI:
```bash
sqlite3 mock.db < queries/02_invoice_analysis.sql
```

### 2. Running the Interactive Dashboard
To visualize the data locally via the provided Streamlit app:

1. Clone the repository and navigate to the project root.
2. Install the necessary Python packages:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the Streamlit application:
   ```bash
   streamlit run visualizations/app.py
   ```

## 📖 Documentation
* [Database Architecture & ER Diagram](docs/architecture.md)
* [SQL Performance Tuning Guidelines](docs/performance_tuning.md)

## 📬 Contact
If you’d like to discuss this project, SQL optimization, or collaborate on data analytics initiatives, feel free to connect!
