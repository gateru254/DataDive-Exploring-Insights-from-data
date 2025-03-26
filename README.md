# Project 1: Analyzing-Sales-Trends_using_SQL
- This repository contains SQL projects focused on analyzing real-world datasets. Each project includes SQL queries, datasets, and insights derived from the analysis.
- **Description:** Analyzes sales transactions and customer behavior per city,country and products too 
- 📂**Files:**  
  - `Analysis trend Queries.sql` – SQL queries for sales trends.  
  - `customer_info_table.sql` – Customer data.  
  - `sales_transactions.sql` – Sales transaction records.
### 🔎 Findings
  
:one:.Customers who made at least 5 transactions
```sql
      select email,city,first_name,last_name,count(transaction_id) as transactions from sales_transactions
      join customer_info 
      on customer_info.customer_id=sales_transactions.customer_id
      group by city,email,first_name,last_name
      having count(transaction_id) >=5
      order by transactions 
      limit 5;
```
> **0utput**
- It was an empty table no customers had made at least 5 transactions.

:two:. Identify the payment method that has the highest total sales ?
```sql
    select sum(total_amount) as Total_Sales_Amount,payment_method
    from sales_transactions 
    group by  payment_method 
    order by Total_Sales_Amount  desc
```
>**Output** 💳 Paypal was the most used payment method thus have the highest total_sales

| Payment_Method |
|----------------|
| PayPal         |
| Bank Transfer  |
| Credit Card    |
| Cash           |
| Debit Card     |

:three:. List the number of unique products sold in each category ?
```sql
   select count(distinct product_name) as unique_products,category
   from sales_transactions
   group by category
   order by unique_products desc
```
>**Output** 📋  Electronics top the list with highest sales

| Category          | Count |
|-------------------|-------|
| Electronics       | 3     |
| Home Appliances   | 2     |
| Furniture         | 1     |
| Accessories       | 1     |
| Footwear          | 1     |

---

# 💰 Project 2: Analyzing-debt-trends-per-Country (1970-2015) 

- This project aims to analyze the debt trends of developing countries from 1970 to 2015 using world bank 🏦 debt data.

## 📍 Overview 
- connected  to PostgreSql database using a string provided to analyze the dataset.
- By utilizing SQL queries in Postgresql, the relationship between debt accumulation and economnic growth is well illustrated.The queries identifies which countries are most indebted.For instance the total debt accross all countries is **$3079735.08 millions M**.
- The table consists of the following columns:

| country_name | country_code | indicator_name | indicator_code | debt |
|--------------|--------------|----------------|----------------|------|

- 📂**files** 
  - `Debt query.sql` – SQL queries for debt analysis.  
  - `global_debt_trends(Readme).md` – Project documentation.  
  - `international_debt.csv` – Global debt dataset.  


### 🎯 Project objective 
- Explore **regional debt trends**, including identifying which regions or continents have the most accumulated debt.
- Compute **country** which accumulated highest  debts from (1970 -2015)
- Identify which countries have repaid the highest amount of principal debt and assess their repayment trends.
- Analyze countries with the highest amount of principal repayments.

### 🔑 Key Questions
:one: What is the total amount in (millions) of debt owed by all countries in the dataset? 
``` sql
     select (Sum(debt)/1000000)::numeric(20,2) as TOTAL_debt from international_debt.
```
>**findings** 🔎

The total debt owed by all countries retrieved by aggregate function **sum** : 3,079,735.08M

:two: How many distinct countries are recorded in the dataset? -  **124**
```sql
    select count (distinct country_name) as Countries from international_debt
```
>**findings** 🔎

The dataset records a total of 124 distinct countries.

:three: Which country has the **highest total debt**, and how much does it owe?
```sql
     select (sum(debt)/1000000)::numeric(20,2) as highest_debt,country_name from  international_debt
     group by country_name
     order by highest_debt desc
     limit 1;
````
> **output**
   
| Highest_debt_millions | country_name |
|------------------------|--------------|
| 285,793.52            | China        |

:four: What is the average debt across different debt indicators?
```sql
      select (avg(debt)/1000000)::numeric(20,2)as average_debt_millions,indicator_code  from international_debt
      group by indicator_code 
      order by average_debt_millions Desc
      limit 4;
```
> **Output**

| average_debt_Millions | Indicator_Code        | indicator_name |
|----------------------|----------------------|------------------------------------------------------------|
| **5904.87**         | DT.AMT.DLXF.CD       | Principal repayments on external debt, long-term |
| **5161.19**         | DT.AMT.DPNG.CD       | Principal repayments on external debt, private nonguaranteed (PNG) |
| **2152.04**         | DT.DIS.DLXF.CD       | Disbursements on external debt, long-term |
| **1958.98**         | DT.DIS.OFFT.CD       | PPG (Public and Publicly Guaranteed) disbursements from official creditors |

:five:What is the most common debt indicator across all countries? 
```sql
select count(indicator_name) AS indicator_counts,indicator_name, indicator_code
from international_debt
group by indicator_name, indicator_code
order by indicator_counts DESC
limit 5;
```
> **Output**

| indicator_Counts | Indicator Name                                              | Indicator Code       |
|-------|-------------------------------------------------------------|----------------------|
| 124   | PPG, multilateral (AMT, current US$)                       | DT.AMT.MLAT.CD      |
| 124   | PPG, official creditors (AMT, current US$)                 | DT.AMT.OFFT.CD      |
| 124   | PPG, official creditors (INT, current US$)                 | DT.INT.OFFT.CD      |
| 124   | PPG, multilateral (INT, current US$)                       | DT.INT.MLAT.CD      |
| 124   | Principal repayments on external debt, long-term (AMT, current US$) | DT.AMT.DLXF.CD |

> **findings** 🔎

The most common debt indicator across all countries is PPG, multilateral (INT, current US$) which had a count 124 .

---


### Technology used 🧰
**SQL**: Language used to extract,retrieve and analyze data.

**PostgreSql**: Database used to analyze the data.

**Data Visualization Tools** : (optional):Power BI.

**Dataset**🗺️World bank debt data



  



    
    
