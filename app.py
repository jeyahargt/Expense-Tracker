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

if connection:
    st.sidebar.title("Query Selector")
    query_options = [
        "Total Expenses",
        "Monthly Expenses",
        "Spending By Category",
        "Payment Mode Distribution",
        "Cashback Earned",
        "Daily Average Expense",
        "Highest Spending Day in a Month",
        "Expenses on Food",
        "Monthly Breakdown - Shopping",
        "Monthly Breakdown - Entertainment",
        "Monthly Spending Trends"
    ]
    selected_query = st.sidebar.selectbox("Select a Query", query_options)

    if selected_query == "Total Expenses":
        st.write("### Total Expenses")
        query = "SELECT SUM(Amount_paid) AS Total_expenses FROM all_expenses;"
        df = execute_query(query, connection)
        if df is not None:
            st.metric("Total Expenses", f"${df.iloc[0]['Total_expenses']:.2f}")

    elif selected_query == "Monthly Expenses":
        st.write("### Monthly Expenses")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Amount_paid) AS Monthly_expenses
        FROM all_expenses
        GROUP BY MONTH(Date);
        """
        df = execute_query(query, connection)
        if df is not None:
            df['Month'] = df['Month'].apply(lambda x: pd.to_datetime(f'2024-{x:02d}-01').strftime('%b'))
            df = df.sort_values('Month')
            st.bar_chart(df.set_index('Month'))

    elif selected_query == "Spending By Category":
        st.write("### Spending By Category")
        query = """
        SELECT Category, SUM(Amount_paid) AS Total_spent
        FROM all_expenses
        GROUP BY Category
        ORDER BY Total_spent DESC;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Payment Mode Distribution":
        st.write("### Payment Mode Distribution")
        query = """
        SELECT Payment_mode, COUNT(*) AS Frequency
        FROM all_expenses
        GROUP BY Payment_mode
        ORDER BY Frequency DESC;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.bar_chart(df.set_index('Payment_mode'))

    elif selected_query == "Cashback Earned":
        st.write("### Cashback Earned")
        query = "SELECT SUM(Cashback) AS Total_cashback FROM all_expenses;"
        df = execute_query(query, connection)
        if df is not None:
            st.metric("Total Cashback Earned", f"${df.iloc[0]['Total_cashback']:.2f}")

    elif selected_query == "Daily Average Expense":
        st.write("### Daily Average Expense")
        query = """
        SELECT Date, AVG(Amount_paid) AS Daily_average
        FROM all_expenses
        GROUP BY Date;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Highest Spending Day in a Month":
        st.write("### Highest Spending Day in a Month")
        query = """
        SELECT MONTH(Date) AS Month, Date, SUM(Amount_paid) AS Daily_spending
        FROM all_expenses
        GROUP BY Date
        ORDER BY Daily_spending DESC
        LIMIT 1;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Expenses on Food":
        st.write("### Expenses on Food")
        query = 'SELECT * FROM all_expenses WHERE Category = "Food";'
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Monthly Breakdown - Shopping":
        st.write("### Monthly Breakdown - Shopping")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Amount_paid) AS Shopping_expenses
        FROM all_expenses
        WHERE Category = "Shopping"
        GROUP BY MONTH(Date);
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Monthly Breakdown - Entertainment":
        st.write("### Monthly Breakdown - Entertainment")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Amount_paid) AS Entertainment_expenses
        FROM all_expenses
        WHERE Category = "Entertainment"
        GROUP BY MONTH(Date);
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    elif selected_query == "Monthly Spending Trends":
        st.write("### Monthly Spending Trends")
        query = """
        SELECT MONTH(Date) AS Month, SUM(Amount_paid) AS Monthly_spending
        FROM all_expenses
        GROUP BY MONTH(Date)
        ORDER BY Month;
        """
        df = execute_query(query, connection)
        if df is not None:
            st.dataframe(df)

    connection.close()
    st.write("Database connection closed.")
else:
    st.error("Failed to connect to the database.")

