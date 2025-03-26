SET search_path TO data_analytics;
select* from international_debt;

#QUESTION 1.
#What is the total amount of debt owed by all countries in the dataset?

select (Sum(debt)/1000000)::numeric(20,2) as TOTAL_debt from international_debt
 
QUESTION 2.
#How many distinct countries are recorded in the dataset?

select count (distinct country_name) as Countries from international_debt

QUESTION 3.
#What are the distinct types of debt indicators, and what do they represent?

select  distinct indicator_code as debt_indicators,indicator_name
from international_debt
group by indicator_code,indicator_name


QUESTION 4.
#calculate the total_debt per country 

select (sum(debt)/1000000)::numeric(20,2) as highest_debt_millions,country_name
from  international_debt
group by country_name
order by highest_debt_millions desc
limit 1;


#QUESTION 5
#What is the average debt across different debt indicators?

select (avg(debt)/1000000)::numeric(20,2)as average_debt_millions,indicator_code,indicator_name
from international_debt
group by indicator_code,indicator_name
order by average_debt_millions desc
limit 4;

#QUESTION 6
#Which country has made the highest amount of principal repayments?
select country_name,sum(debt)as total_debt
from international_debt 
where indicator_name like '%Principal repayments%'
group by country_name
order by total_debt  desc
limit 1

QUESTION 7
#What is the most common debt indicator across all countries?

select count(indicator_name) as indicator_counts,indicator_name,indicator_code
from international_debt
group by indicator_name, indicator_code
order by indicator_counts desc
limit by 5;




SELECT COUNT(indicator_name) AS indicator_counts,indicator_name, indicator_code
FROM international_debt
GROUP BY indicator_name, indicator_code
ORDER BY indicator_counts DESC
LIMIT 5;


#QUESTION
#Identify any other key debt trends and summarize your findings
#kenya debts
select sum(debt)as total_debt
from international_debt 
where country_name = 'Kenya';

select country_name,sum(debt) as total_principle_repayment
from international_debt
where indicator_code ='DT.AMT.DLXF.CD'
group by country_name
order by total_principle_repayment desc;

#disctinct indicator_name
select indicator_name,country_name,sum(debt) as total_debt_bilateral
from international_debt
where indicator_code in ('DT.INT.BLAT.CD','DT.AMT.BLAT.CD')
group by country_name,indicator_name 
order by total_debt_bilateral desc


#calculate the sum of debt per PPG (Public and Publicly Guaranteed Debt)  PNG (Private Non-Guaranteed Debt) 
 select indicator_code,indicator_name,(sum(debt)/1000000)::numeric(20,2)as total_Debts_millions
 from international_debt
 where indicator_code in('DT.INT.DLXF.CD', 'DT.INT.DPNG.CD')
 group by indicator_code,indicator_name 
 
 
#CALCULATE THE DISBURSMENTS PER month
select country_name,indicator_code,sum(debt)total_dis,indicator_name
from international_debt
where indicator_code in('DT.DIS.PCBK.CD','DT.DIS.MLAT.CD','DT.DIS.OFFT.CD','DT.DIS.BLAT.CD','DT.DIS.DLXF.CD')
group by country_name,indicator_code,indicator_name 
order by total_dis desc

question 4
#Which country has the highest total debt, and how much does it owe?
-- select max(debt) as highest_debt,country_name
-- from  international_debt
-- group by country_name
-- order by highest_debt desc
-- limit 1;
