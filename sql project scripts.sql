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

#ANALYSIS QUERIES

#TOTAL AMOUNT SPENT IN EACH CATEGORY
select Category, sum(Amount_paid) as Total_expenses 
from all_expenses
group by Category;

#TOTAL AMOUNT SPENT USING EACH PAYMENT MODE
select Payment_mode, sum(Amount_paid) as Total_expenses
from all_expenses
group by Payment_mode;

#TOTAL CASHBACK RECEIVED ACROSS ALL TRANSACTIONS 
select sum(Cashback) as Total_cashback from all_expenses;

#TOP 5 MOST EXPENSIVE CATEGORIES IN TERMS OF SPENDING
select Category, sum(Amount_paid) as Total_spent
from all_expenses
group by Category
order by Total_spent desc
LIMIT 5;
#AMOUNT SPENT ON TRANSPORTATION USING DIFFERENT PAYMENT MODES
select Category,Payment_mode, sum(Amount_paid) as Total_spent
from all_expenses
where Category = "Transportation"
group by Payment_mode;

#TRANSACTIONS RESULTED IN CASHBACK
Select Payment_mode,avg(Cashback) as Avg_cashback
from all_expenses
group by Payment_mode ;

#TOTAL SPENDING IN EACH MONTH OF THE YEAR
select MONTH(Date), sum(Amount_paid)
from all_expenses
GROUP BY MONTH(Date);

#MONTH HAVING HIGHEST SPENDING IN TRAVEL & ENTERTAINMENT
select Month,Category, Total_spent
FROM(
select MONTH(Date) as Month, Category, sum(Amount_paid) as Total_spent
from all_expenses
where Category In ('Travel', 'Entertainment')
group by MONTH(Date), Category
) as subquery
where Total_spent = (select max(Total_spent) from (
select MONTH(Date) as Month, sum(Amount_paid) as Total_spent
from all_expenses
where Category in ('Travel', 'Entertainment')
group by Month(Date)
) as max_spent);
#ANOTHER WAY
SELECT MONTH(Date) AS Month, Category, SUM(Amount_paid) AS Total_spent
FROM all_expenses
WHERE Category IN ('Travel', 'Entertainment')
GROUP BY MONTH(Date), Category
ORDER BY Total_spent desc
LIMIT 1;

#RECURRING EXPENSES OCCUR DURING SPECIFIC MONTHS OF THE YEAR
SELECT 
    Category, 
    Description, 
    Payment_mode, 
    COUNT(DISTINCT MONTH(Date)) AS Distinct_Months
FROM all_expenses
GROUP BY Category, Description, Payment_mode
HAVING COUNT(DISTINCT MONTH(Date)) > 1  -- Shows only expenses spanning multiple months
ORDER BY Distinct_Months DESC;

#CASHBACK EARNED IN EACH MONTH
select MONTH(Date) as Month, sum(Cashback) as Total_cashback
from all_expenses
group by Month;

#OVERALL SPENDING CHANGED OVER TIME
select MONTH(Date), sum(Amount_paid)
from all_expenses
GROUP BY MONTH(Date);

#TYPICAL COSTS ASSOCIATED WITH TYPES OF TRAVEL(FLIGHTS,ACCOMODATION,TRANSPORTATION)
SELECT Category, Description, SUM(Amount_paid) AS Total_Spent, AVG(Amount_paid) AS Avg_Cost
FROM all_expenses
WHERE Category IN ('Flights', 'Accommodation', 'Transportation')
GROUP BY Category, Description
ORDER BY Category, Total_Spent DESC;

#PATTERNS IN GROCERY SPENDING
SELECT 
    DAYOFWEEK(Date) AS Day_number,
    DAYNAME(Date) AS Day_week,  
    Category,  
    SUM(Amount_paid) AS Total_spent,  
    AVG(Amount_paid) AS Avg_spent  
FROM all_expenses  
WHERE Category = 'Groceries'  
GROUP BY DAYOFWEEK(Date), DAYNAME(Date), Category  
ORDER BY Day_number;

#HIGH AND LOW PRIORITY CATEGORIES
select Category, sum(Amount_paid) as Total_spent,
CASE
when Category in ('Groceries', 'Rent', 'Health', 'Transportation', 'Food', 'Education')
then 'High Priority'
else 'Low Priority'
End as Priority
from all_expenses
group by Category, Priority
order by Priority desc, Total_spent desc;

#CATEGORY CONTRIBUTING THE HIGHEST % OF THE TOTAL SPENDING
select Category, Avg(Amount_Paid) as Avg_spent
from all_expenses
group by Category
order by Avg_spent Desc
limit 1;

#TOP PAYMENT MODE
select Payment_mode, count(*) as Frequency
from all_expenses
group by Payment_mode
order by Frequency desc;
 
#HIGHEST SPENDING MONTH IN THE YEAR
select MONTH(Date), sum(Amount_paid) as total_spent
from all_expenses
group by MONTH(Date)
ORDER BY total_spent desc
limit 1;

#HIGHEST SPENDING MONTH IN THE YEAR
select MONTH(Date), sum(Amount_paid) as total_spent
from all_expenses
group by MONTH(Date)
ORDER BY total_spent asc
limit 1;

#MONTHLY SPENDING TRENDS ONLY ON CASH PAYMENT
select MONTH(Date) as Month, sum(Amount_paid) as Monthly_spending
from all_expenses
where Payment_mode = "Cash"
group by MONTH(Date)
ORDER BY Month;

#MONTHLY SPENDING TRENDS ONLY ON CREDIT CARD PAYMENT
select MONTH(Date) as Month, sum(Amount_paid) as Monthly_spending
from all_expenses
where Payment_mode = "Credit card"
group by MONTH(Date)
ORDER BY Month;

