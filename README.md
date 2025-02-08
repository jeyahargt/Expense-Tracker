# Expense-Tracker

Expense Tracker Project Documentation

INTRODUCTION

The Expense Tracker project is a comprehensive solution to simulate, store, analyze, and visualize personal expense data. It incorporates various technologies such as Python, SQL, and Streamlit to provide a robust platform for managing and analyzing expenses effectively. The application allows users to view insights into their spending patterns through interactive dashboards.

Key Components

Data Simulation:

Purpose: Generate realistic expense data for each month of the year 2024.

Libraries Used: Faker, random, pandas.

Details:

Categories like Groceries, Rent, Food, etc., were assigned realistic ranges for expense amounts.

Random data for payment modes and cashback were generated.

The data was structured into monthly tables.

Database Integration:

Technology Used: MySQL (via pymysql library).

Structure:

Monthly tables were created in the expense_tracker database.

Data insertion was automated with Python scripts.

Visualization:

Framework: Streamlit for interactive dashboards.

Charts:

Bar charts for monthly and category-wise expenses.

Pie chart for payment mode distribution.

Metrics:

Cashback earned across all payments.

Queries and Analysis:

SQL queries were crafted for various insights, such as:

Total expenses.

Monthly and category-wise breakdowns.

Specific patterns:

"Total Amount Spent in Each Category",
"Total Amount Spent Using Each Payment Mode",
"Total Cashback Received Across All Transactions",
"Top 5 Most Expensive Categories",
"Amount Spent on Transportation Using Different Payment Modes",
"Transactions Resulted in Cashback",
"Total Spending in Each Month of the Year",
"Month Having Highest Spending in Transportation & Entertainment",
"Recurring Expenses in Specific Months",
"Cashback Earned in Each Month",
"Overall Spending Changed Over Time",
"Typical Costs Associated with Types of Travel",
"Patterns in Grocery Spending",
"High and Low Priority Categories",
"Category Contributing the Highest % of the Total Spending",


STREAMLIT APPLICATION

Features:

A sidebar with query options for users to select and view different expense insights with Bar charts, line charts, pie charts and dataframes to access their multiple type of expenses and months in the year.

( i.e,..Dynamic visualizations and tables for presenting results.)

UI Components:

Metrics for total expenses and cashback.

Charts for visualizing trends and distributions.

CHALLENGES FACED

Data Integrity:

Problem: Ensuring the simulated data aligns with real-world scenarios.

Solution: Careful design of category ranges and randomization logic.

Database Handling:

Problem: Managing multiple monthly tables and ensuring seamless data insertion.

Solution: Iterative queries and parameterized inserts.

Query Optimization:

Problem: Efficiently handling queries on large datasets.

Solution: Use of aggregate functions and indexing.

Streamlit Visualization:

Simple and useful insights provided to get a meaningful knowledge of their expenses with a better user experience.

Conclusion :
This will provide the better realistic problem statement understanding and vision of the expense tracker or analyzing personal expenses for a family or a particular person.
This will conclude providing all SQL scripts for all 20 queries.
Documentation explaining the methodology, analysis, and insights.
Screenshots of the Streamlit app with key visualizations and outputs.


