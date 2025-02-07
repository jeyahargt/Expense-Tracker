import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import pymysql
import streamlit as st

# Database Connection Function
def create_connection():
    try:
        connection = pymysql.connect(
            host="localhost",
            user="root",
            password="Saran@123",
            database="expense_tracker"
        )
        return connection
    except pymysql.MySQLError as err:
        st.error(f"Failed to connect to the database: {err}")
        return None

# Execute Query Function
def execute_query(query, connection):
    try:
        return pd.read_sql(query, con=connection)
    except Exception as e:
        st.error(f"Error executing query: {e}")
        return None

# Streamlit App
st.title("Expense Tracker Dashboard")
connection = create_connection()

import streamlit as st
import pandas as pd

st.title("Expense Tracker Dashboard")

connection = create_connection()

if connection:
    st.sidebar.title("Query Selector")
    query_options = [
        "Total Amount Spent in Each Category",
        "Total Amount Spent Using Each Payment Mode",
        "Total Cashback Received Across All Transactions",
        "Top 5 Most Expensive Categories",
        "Amount Spent on Transportation Using Different Payment Modes",
        "Transactions Resulted in Cashback",
        "Total Spending in Each Month of the Year",
        "Month Having Highest Spending in Travel & Entertainment",
        "Recurring Expenses in Specific Months",
        "Cashback Earned in Each Month",
        "Overall Spending Changed Over Time",
        "Typical Costs Associated with Types of Travel",
        "Patterns in Grocery Spending",
        "High and Low Priority Categories",
        "Category Contributing the Highest % of the Total Spending",
        "Top Payment Mode",
        "Highest Spending Month in the Year",
        "Lowest Spending Month in the Year",
        "Monthly Spending Trends (Cash Payment)",
        "Monthly Spending Trends (Credit Card Payment)"
    ]
    
    selected_query = st.sidebar.selectbox("Select a Query", query_options)

    if selected_query == "Total Amount Spent in Each Category":
        st.write("### Total Amount Spent in Each Category")
        query = """
        SELECT Category, SUM(Amount_paid) AS Total_expenses 
        FROM all_expenses
        GROUP BY Category;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index("Category"))

    elif selected_query == "Total Amount Spent Using Each Payment Mode":
        st.write("### Total Amount Spent Using Each Payment Mode")
        query = """
        SELECT Payment_mode, SUM(Amount_paid) AS Total_expenses
        FROM all_expenses
        GROUP BY Payment_mode;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index("Payment_mode"))

    elif selected_query == "Total Cashback Received Across All Transactions":
        st.write("### Total Cashback Received Across All Transactions")
        query = "SELECT SUM(Cashback) AS Total_cashback FROM all_expenses;"
        df = execute_query(query, connection)
        if df is not None:
            st.metric("Total Cashback Earned", f"${df.iloc[0]['Total_cashback']:.2f}")

    elif selected_query == "Top 5 Most Expensive Categories":
        st.write("### Top 5 Most Expensive Categories")
        query = """
        SELECT Category, SUM(Amount_paid) AS Total_spent
        FROM all_expenses
        GROUP BY Category
        ORDER BY Total_spent DESC
        LIMIT 5;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index("Category"))

    elif selected_query == "Amount Spent on Transportation Using Different Payment Modes":
        st.write("### Amount Spent on Transportation Using Different Payment Modes")
        query = """
        SELECT Payment_mode, SUM(Amount_paid) AS Total_spent
        FROM all_expenses
        WHERE Category = "Transportation"
        GROUP BY Payment_mode;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Transactions Resulted in Cashback":
        st.write("### Transactions Resulted in Cashback")
        query = """
        SELECT Payment_mode, AVG(Cashback) AS Avg_cashback
        FROM all_expenses
        GROUP BY Payment_mode;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Total Spending in Each Month of the Year":
        st.write("### Total Spending in Each Month of the Year")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Amount_paid) AS Monthly_expenses
        FROM all_expenses
        GROUP BY MONTH(Date)
        ORDER BY Month;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.line_chart(df.set_index("Month"))

    elif selected_query == "Overall Spending Changed Over Time":
        st.write("### Overall Spending Changed Over Time")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Amount_paid) AS Monthly_expenses
        FROM all_expenses
        GROUP BY MONTH(Date)
        ORDER BY Month;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.line_chart(df.set_index("Month"))

    elif selected_query == "Cashback Earned in Each Month":
        st.write("### Cashback Earned in Each Month")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Cashback) AS Total_cashback
        FROM all_expenses
        GROUP BY MONTH(Date);
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index("Month"))

    elif selected_query == "Recurring Expenses in Specific Months":
        st.write("### Recurring Expenses in Specific Months")
        query = """
        SELECT Category, Description, Payment_mode, COUNT(DISTINCT MONTH(Date)) AS Distinct_Months
        FROM all_expenses
        GROUP BY Category, Description, Payment_mode
        HAVING COUNT(DISTINCT MONTH(Date)) > 1
        ORDER BY Distinct_Months DESC;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Category Contributing the Highest % of the Total Spending":
        st.write("### Category Contributing the Highest % of the Total Spending")
        query = """
        SELECT Category, AVG(Amount_paid) AS Avg_spent
        FROM all_expenses
        GROUP BY Category
        ORDER BY Avg_spent DESC
        LIMIT 1;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index("Category"))

    elif selected_query == "Top Payment Mode":
        st.write("### Top Payment Mode")
        query = """
        SELECT Payment_mode, COUNT(*) AS Frequency
        FROM all_expenses
        GROUP BY Payment_mode
        ORDER BY Frequency DESC;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index("Payment_mode"))

    connection.close()
    st.write("Database connection closed.")
else:
    st.error("Failed to connect to the database.")


