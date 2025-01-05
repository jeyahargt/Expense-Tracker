# %%
from faker import Faker
import pandas as pd
import random
import calendar
from datetime import datetime
import pymysql



# %%
fake = Faker()
categories = {
    'Groceries': {'range': (20, 300)},  
    'Stationary': {'range': (5, 100)},  
    'Bills': {'range': (30, 200)},      
    'Subscription': {'range': (5, 100)},  
    'Investment': {'range': (100, 1000)},  
    'Transportation': {'range': (10, 50)},  
    'Education': {'range': (50, 500)},   
    'Food': {'range': (10, 200)},    
    'Rent': {'range': (300, 2000)},     
    'Entertainment': {'range': (10, 200)},  
    'Shopping': {'range': (20, 500)},   
    'Health': {'range': (20, 300)},     
}
payments = ['Cash', 'Credit Card', 'Debit Card', 'Online']

# %%
# Generate sample data for each month
monthly_data = {}
for month in range(1,13): # Number of Months and Each month table
    month_name = calendar.month_name[month]
    monthly_data[month_name] = []
    for i in range(100): #For numbers of rows
        year = 2024
        # Ensure the date generated corresponds to the correct month
        date = fake.date_between_dates(
            date_start=datetime(year, month, 1), 
            date_end=datetime(year, month, calendar.monthrange(year, month)[1])
        )
        category = random.choice(list(categories.keys()))
        category_range = categories[category]['range']
        payment_mode = random.choice(payments)
        description = f"{category} at {fake.company()}"
        amount_paid = round(random.uniform(*category_range),2)
        cashback = round(random.uniform(0,amount_paid*0.1),2) if random.random() < 0.3 else 0
        
        monthly_data[month_name].append({
            'Date': date,
            'Category': category,
            'Payment_mode': payment_mode,
            'Description' : description,
            'Amount_paid': amount_paid,
            'Cashback': cashback
        })

# %%
df = pd.DataFrame(monthly_data)

# %%
df.head()

# %%
df = pd.DataFrame(monthly_data)


# %%

# Reconnect and use the 'expense_tracker' database
connection = pymysql.connect(
    host='localhost',
    user='root',
    password='Saran@123',
    database='expense_tracker'
)
cursor = connection.cursor()

# Insert the generated data into the corresponding month tables
for month, data in monthly_data.items():
    for expense in data:
        query = f"""
        INSERT INTO {month} (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (
            expense['Date'],
            expense['Category'],
            expense['Payment_mode'],
            expense['Description'],
            expense['Amount_paid'],
            expense['Cashback']
        ))

connection.commit()
cursor.close()
connection.close()

print("Data inserted successfully into the corresponding monthly tables")


