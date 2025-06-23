
-- table of retail_sales
Drop table if exists retail_sales;
create table retail_sales(
transactions_id INT primary key	,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs	float,
total_sale float
);

-- To view Null values in table
select *from retail_sales
where 
	transactions_id is  null
or 
	sale_date is  null
or 
	sale_time is  null
or 
	customer_id is  null
or 
  	gender is  null
or 
	age is  null
or 
	sale_time is  null
or 
	category is  null
	 
or 
	quantiy	 is  null
or 
	price_per_unit is  null
or 
	cogs is  null
or 
	total_sale is  null


-- How many sales we have
select  count(*) as total_sales from retail_sales;

-- How many unique Customers we have
select  count(distinct customer_id) as total_customers from retail_sales;

-- How many unique category we have
select  count(distinct category) from retail_sales;

-- what are  unique categories we have
select distinct category  from retail_sales;

---Data Analysis & Bussiness key problem

--My Analysis & findings

--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

  select * from retail_sales
  where sale_date = '2022-11-05';

--Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022.
	select *  from retail_sales
  where category = 'Clothing' and quantiy > 3 and to_char(sale_date,'YYYY-MM')='2022-11' ;
		
--Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
	select category, sum(total_sale) ,count(*) as total_orders 
	from retail_sales
	group by 1;
	
--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
	select round (avg(age),2) as avg_age ,category ,count(*) as total 
	from retail_sales
	where category='Beauty'
	group by 2;
	
--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
	select * from retail_sales
	where total_sale >1000
	order by total_sale desc ;
--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	select category,gender,
	count(*) as total_transactions
	from retail_sales
	group by  category,gender;
	
--Q7. Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.
	
	select 
	year,
	month,
	avg_sales 
	from (
			select
			extract (year from sale_date) as year ,
			extract(month from sale_date) as month,
			avg(total_sale) as avg_sales,
			rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc )
			from retail_sales
			group by 1 , 2
	) as t1

	where rank=1;
	
	--order by 1,2;
	--order by 3 desc ;
--Q8. Write a SQL query to find the top 5 customers based on the highest total sales.
select customer_id ,
sum(total_sale) as total_sales 
from retail_sales
group by 1
order by  total_sales desc
limit 5;
		
--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
	select distinct  count(customer_id) ,Category 
	from retail_sales
	group by Category;
	
--Q10. Write a SQL query to create each shift and number of orders:

 with hours_Sale
 as
 (
Select *,
	case
	  When extract(hour from sale_time )<12 then 'morning'
	  When extract(hour from sale_time ) between 12 and  17 then 'afternoon'
	  else 'Evening'
	end as Shift
from retail_sales

)
--select * from hours_sale;

select Shift,
count(*) as total_orders
from hours_sale
group by shift
order by total_orders desc

	 

--End of Project
