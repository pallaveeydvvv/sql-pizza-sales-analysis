
select * from order_details;
-- SAME TYPE OF PIZZA MAX QUANTITY ORDERD TOGETHER 
	select  max(quantity) from order_details; 
-- DIFFERENT TYPES OF PIZZAS ORDERED TOGETHER
	select order_id , count(*) as total_pizza_variety_ordered from order_details 	
	group by order_id; 
select * from orders;
	 -- TOTAL AMOUNT OF DELIVERED,FAILED,SUCCESSS AND CANCELLED ORDERS
	select status , count(*) as total_order from orders
	group by status;
-- joined table between customers and orders
select concat(c.first_name," ",last_name) as full_name,o.order_date,c.city , o.status 
from orders o
join customers c
on c.custid = o.custid;
select * from customer_order_info;
-- find it for the city like city wise/based status

-- TOTAL SUCCESSFULL ORDERS PER CUSTOMER
select  concat(c.first_name," ",c.last_name) as full_name ,count(*) as success_per_person 
from orders o
join customers c
on c.custid = o.custid
where lower(status) in( "success" , "delivered")
group by first_name , last_name 
order by success_per_person desc;

select first_name , last_name ,count(*) as failed_per_person from orders
join customers
on customers.custid = orders.custid
where lower(status) in ("failed" , "cancelled")
group by first_name , last_name 
order by failed_per_person desc;
-- total orders
select first_name , last_name ,count(*) as total_per_person from orders
join customers
on customers.custid = orders.custid
group by first_name , last_name
order by  total_per_person desc ; 
select * from order_details;
-- most ordered
    select pizza_id as most_ordered , count(*) as times_ordered from order_details
    group by pizza_id
    order by count(*) desc
    limit 5;
-- 2nd highest ordered
    select pizza_id , count(*) as pizza_reordered from order_details
    group by pizza_id
    order by count(*) desc
    limit 1 offset 1;
-- TOP 3 PIZZAS WHICH ARE ORDERED WITH MAXIMUM QUANTITY
    select pizza_id , sum(quantity) as total_quantity
    from order_details
    group by pizza_id
    order by total_quantity desc
    limit 3;
select * from orders;
-- total orders per day inclduing failed and successfull delievery
    select order_date , count(*) as order_per_day 
    from orders
    group by order_date;
-- succesful delivery per day
    select order_date , count(*) as succesful_order_pd from orders
    where lower(status) in( "delivered" , "success")
    group by order_date;
-- top 3 dates with most succesful delivery on a day
    select order_date , count(*) from orders
    where lower(status) in( "delivered" , "success")
    group by order_date
    order by count(*) desc
    limit 3;
	
select * from pizza_types;
select * from pizzas;
-- highest priced
select * from pizzas
where price = (
	select max(price) from pizzas
);
