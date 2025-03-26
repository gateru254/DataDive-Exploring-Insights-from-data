## Analyzing-global-debt-trends-per-Countries (1970-2015) 💰
This project aims to analyze the debt trends of developing countries from 1970 to 2015 using world bank 🏦 debt data.

## Files 📁
- `Debt-query.sql`: SQL queries for analysis.
- `international_debt.csv`: Dataset of global debt statistics.
  
 ##  Steps to Analyze 🪜
1. Import the dataset into your database.
2. Run the queries provided in `Debt-query.sql`. 

## Overview 🫀
1. Connect PostgreSql database using a string provided to analyze the dataset.
2. By utilizing SQL queries in Postgresql, the relationship between debt accumulation and economnic growth is well illustrated.The queries identifies which countries are most indebted.For instance the total debt accross all countries is **$3079735.08 millions M**.
   
a). The international debt table consists of the following columns:

| country_name | country_code | indicator_name | indicator_code | debt |
|--------------|--------------|----------------|----------------|------|

---

### Project objective 
- Explore **regional debt trends**, including identifying which regions or continents have the most accumulated debt.
- Compute **country** which accumulated highest  debts from (1970 -2015)
- Identify which countries have repaid the highest amount of principal debt and assess their repayment trends.
- Analyze countries with the highest amount of principal repayments.
---

### Key Questions 🔑
:one: What is the total amount in (millions) of debt owed by all countries in the dataset? 
``` sql
     select (Sum(debt)/1000000)::numeric(20,2) as TOTAL_debt from international_debt.
```
>**findings** 📌

The total debt owed by all countries retrieved by aggregate function **sum** : 3,079,735.08M

:two: How many distinct countries are recorded in the dataset? -  **124**
```sql
    select count (distinct country_name) as Countries from international_debt
```
>**findings** 📌

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

:five: Identify any other key debt trends and summarize your findings.
- 🇰🇪
  ``` sql
     select sum(debt)as total_debt from international_debt 
     where country_name = 'Kenya';
   ```
>**findings** 📌
- The total_debt for kenya is about 226.2 billion USD.
  
:six: What are the distinct types of debt indicators, and what do they represent?
 ```sql
    select  distinct indicator_code as debt_indicators,indicator_name from international_debt
    group by indicator_code,indicator_name
 ```
>**Output**

| Indicator Code        | Indicator Name                                                                                  |
|------------------------|------------------------------------------------------------------------------------------------|
| DT.INT.PRVT.CD        | PPG, private creditors (INT, current US$)                                                      |
| DT.AMT.PBND.CD        | PPG, bonds (AMT, current US$)                                                                  |
| DT.INT.DLXF.CD        | Interest payments on external debt, long-term (INT, current US$)                               |
| DT.AMT.OFFT.CD        | PPG, official creditors (AMT, current US$)                                                    |

>**findings** 📌

- PPG, private creditors (INT, current US$): This reflects the interest payments made to private creditor

- PPG, official creditors (AMT, current US$): principal repayments made to official creditors, showcasing the role of governments or institutions in international financing.

- PPG, bonds (AMT, current US$) and PPG, commercial banks (DIS, current US$) provide details about debt obligations specific to bonds and commercial banks.

:seven:What is the most common debt indicator across all countries? 
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

> **findings** 📌

The most common debt indicator across all countries is PPG, multilateral (INT, current US$) which had a count 124 .

---

### Technology used 🧰
**SQL**: Language used to extract,retrieve and analyze data.

**PostgreSql**: Database used to analyze the data.

**Data Visualization Tools** : (optional):Power BI.

**Dataset**🗺️World bank debt data



  



