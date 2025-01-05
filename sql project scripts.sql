use expense_tracker;
#Creating a single table for inserting 12 tables:
CREATE TABLE all_expenses(
id int auto_increment primary key,
Date DATE,
Category VARCHAR(255),
Payment_mode varchar(255),
Description text,
Amount_paid decimal(10,2),
Cashback decimal(10,2)
);
#inserting 12 different month tables into a single table query:
INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM January;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 101; -- Replace 101 with the value from @next_id

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM February;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 201; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM March;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 301; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM April;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 401; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM May;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 501; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM June;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 601; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM July;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 701; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM August;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 801; 

INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM September;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 901; 


INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM October;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 1001; 


INSERT INTO all_expenses (Date, Category, Payment_mode, Description, Amount_paid, Cashback)
SELECT Date, Category, Payment_mode, Description, Amount_paid, Cashback FROM November;
SET @next_id = (SELECT MAX(id) FROM all_expenses) + 1;
ALTER TABLE all_expenses AUTO_INCREMENT = 1101; 

#Total expense for the year
select sum(Amount_paid) as Total_expenses from all_expenses;

#Monthly Expenses
select MONTH(Date) as Month, sum(Amount_paid) as Monthly_expense
from all_expenses
group by MONTH(Date);

#Top 5 categories by spending
select Category, sum(Amount_paid) as Total_spent
from all_expenses
group by Category
order by Total_spent desc
LIMIT 5;

#Top Payment modes
select Payment_mode, count(*) as Frequency
from all_expenses
group by Payment_mode
order by Frequency desc;

#Cashback Earned for year 2024
select sum(Cashback) as Total_cashback from all_expenses;

#Expenses above threshold
select * from all_expenses where Amount_paid > 500;

#Time based queries
#Daily average Expense
select Date, avg(Amount_paid) as Daily_average
from all_expenses
group by Date; 

#Highest spending Day in a month
select MONTH(Date) as Month, Date, sum(Amount_paid) as Daily_spending
from all_expenses
group by Date 
order by Daily_spending desc
limit 1;

#Category specific queries
#Expenses on food
select * from all_expenses where Category = "Food";

#Monthly breakdown for Shopping and entertainment
#Shopping
Select MONTH(Date) as Month, sum(Amount_paid) as Shopping_expenses
from all_expenses
where Category = "Shopping"
group by MONTH(Date);

#Entertainment
select MONTH(Date) as Month, sum(Amount_paid) as Entertainment_expenses
from all_expenses
where Category = "Entertainment"
group by MONTH(Date);

#Trend Analysis
#Monthly spending trends
select MONTH(Date) as Month, sum(Amount_paid) as Monthly_spending
from all_expenses
group by MONTH(Date)
ORDER BY Month;

#Comparison of online and offlie payments
select Payment_mode, sum(Amount_paid) as Total_spent
from all_expenses
group by Payment_mode;

#only credit card spending
select Payment_mode, sum(Amount_paid) as Total_spent
from all_expenses
where Payment_mode = "Credit card";# This can reduce the Bills category of spending.

select * from all_expenses;
