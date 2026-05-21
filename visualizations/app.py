import streamlit as st
import pandas as pd
import sqlite3
import os

# Configure page
st.set_page_config(page_title="SQL Analytics Dashboard", page_icon="📊", layout="wide")

st.title("📊 SQL Data Analytics Dashboard")
st.markdown("This sample dashboard visualizes insights from the mock database, replicating the SQL analysis.")

# Establish connection to the SQLite mock DB
@st.cache_resource
def get_connection():
    # Connects to the mock.db located in the root of the repository
    # Determine the directory where this script is located
    current_dir = os.path.dirname(os.path.abspath(__file__))
    # Assuming app.py is in /visualizations, root is one level up
    db_path = os.path.join(current_dir, '..', 'mock.db')

    try:
        conn = sqlite3.connect(db_path, check_same_thread=False)
        return conn
    except Exception as e:
        st.error(f"Failed to connect to database: {e}")
        return None

conn = get_connection()

if conn is not None:

    # 1. Top Countries by Invoice Count
    st.subheader("🌍 Top Countries by Invoice Count")
    query_invoices = """
        SELECT billing_country, COUNT(invoice_id) AS total_invoice
        FROM invoice
        GROUP BY billing_country
        ORDER BY total_invoice DESC
        LIMIT 10;
    """
    try:
        df_invoices = pd.read_sql(query_invoices, conn)
        if not df_invoices.empty:
            st.bar_chart(data=df_invoices, x="billing_country", y="total_invoice", use_container_width=True)
        else:
            st.info("No data available for invoices.")
    except Exception as e:
        st.error(f"Error querying invoices: {e}")

    # 2. Top Spending Customers
    st.subheader("💰 Top Spending Customers")
    query_customers = """
        SELECT c.first_name || ' ' || c.last_name AS customer_name, SUM(i.total) AS total_spent
        FROM customer c
        JOIN invoice i ON c.customer_id = i.customer_id
        GROUP BY c.customer_id, c.first_name, c.last_name
        ORDER BY total_spent DESC
        LIMIT 5;
    """
    try:
        df_customers = pd.read_sql(query_customers, conn)
        if not df_customers.empty:
            col1, col2 = st.columns(2)
            with col1:
                st.dataframe(df_customers)
            with col2:
                st.bar_chart(data=df_customers, x="customer_name", y="total_spent", use_container_width=True)
        else:
            st.info("No data available for customers.")
    except Exception as e:
        st.error(f"Error querying customers: {e}")

else:
    st.warning("Database connection could not be established. Ensure `mock.db` exists in the repository root.")
