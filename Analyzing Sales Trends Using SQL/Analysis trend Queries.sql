--Sales_Analysis

-- retrieve all the information from table customer_info
select*from customer_info
-- retrieve all the data from the sales_transactions
select*from sales_transactions

---                            *QUESTIONS*

-- 1 Find the total number of transactions per city.

select count(transaction_id) as transactions,city,country
from customer_info
join sales_transactions
using(customer_id)
group by city,country 
order by transactions desc
limit 7;

--2 Retrieve the top 5 most purchased products based on total quantity sold.
select sum(quantity)as total_products,city,country,product_name
from customer_info 
join sales_transactions
on customer_info.customer_id=sales_transactions.customer_id
group by  country,city,product_name
order by  total_products desc
limit 5;

-- 3 Find the average transaction amount per category in each country
select avg(total_amount)as total_amount_transactions,country,category
from sales_transactions
join customer_info 
using (customer_id)
group by category,country
order by total_amount_transactions desc 
limit 10


--- 4 Find the average transaction amount per category
select avg(total_amount)::numeric(20,2) as Total_Transaction,category
from sales_transactions 
group by category
order by Total_Transaction desc

--- 5 Identify the payment method that has the highest total sales.
select sum(total_amount) as Total_Sales_Amount,payment_method
from sales_transactions 
group by  payment_method 
order by Total_Sales_Amount  desc

--- 6 Find customers who have made at least 5 transactions. 
select email,city,first_name,last_name,count(transaction_id) as transactions
from sales_transactions
join customer_info 
on customer_info.customer_id=sales_transactions.customer_id
group by city,email,first_name,last_name
having count(transaction_id) >=5
order by transactions 
limit 5;

---7 Retrieve all customers who registered in the last 6 months but have not made any transactions.
--key first_name,last_name,
select first_name,last_name,email,count(transaction_id) as total_Transactions,city,registration_date
from customer_info 
join sales_transactions
on customer_info.customer_id =sales_transactions.customer_id
where Date(registration_date) >= current_date - interval '6 months'
group by first_name,last_name,email,city,registration_date
having count(transaction_id)<1
order by total_Transactions

--SELECT current_date - INTERVAL '6 months' AS six_months_ago;

---8 Find the total revenue generated in each year from sales transactions.
select extract(year from  transaction_date)::char(10) as transaction_year,sum(total_amount) as total_revenue 
from sales_transactions 
group by transaction_year
order by total_revenue Desc
--- checking the datatype
select column_name,data_type
from information_schema.columns
where table_name='sales_transactions'
and table_schema='project_phase_two'
and column_name= 'transaction_date';

---9 List the number of unique products sold in each category
--product,category
select count(distinct product_name) as unique_products,category
from sales_transactions
group by category
order by unique_products desc

-- 10 Find all customers who have made purchases across at least 3 different product categories.
--city,last_name,first_name,phone,product_name,category
select count(category) as product_category,first_name,last_name
from sales_transactions
join customer_info
using(customer_id)
group by first_name,last_name
having count(category) >= 3
order by product_category desc

--- 11  Identify the most popular purchase day of the week based on transaction count.
---- where 0 is sunday and 6 saturday the extract function works perfectly
 select extract(DOW  from transaction_date) as day_of_transactions,count(transaction_id) as transactions_count
 from sales_transactions
 group by day_of_transactions
 order by transactions_count desc
 limit 2; 

 ---12 Find the top 3 customers who have spent the most in the last 12 months.
select first_name,last_name,city,email,sum(total_amount) as total_spending,transaction_date
from customer_info
join sales_transactions
on customer_info.customer_id=sales_transactions.customer_id
where transaction_date >= current_date -  interval '12 months'
group by  first_name,last_name,city,email,transaction_date
order by total_spending desc
limit 3;

---13 Determine the percentage of total revenue contributed by each product category.
SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM sales_transactions).as 
-- 
select category,
       sum (total_amount) as total_revenue,
      round (SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM sales_transactions),2) as total_revenue_percentage
from sales_transactions
group by category
order by total_revenue_percentage desc

--- another way  
select category,((sum(total_amount)/ (select sum(total_amount)from sales_transactions))*100)::numeric(20,2) as revenue_percent
from sales_transactions
group by category
order by revenue_percent desc

--14 Find the first purchase date for each customer 
-- transaction_date,price,first_name,last_name,
select first_name,last_name ,min(sales_transactions.transaction_date) as first_purchase
from sales_transactions
join customer_info
on  customer_info.customer_id = sales_transactions.customer_id 
group by first_name,last_name 



















