-- REVENUE GENERATED VIA SUCCES/DELIVERED ORDERS
-- VIEW -> DELIVERED_ORDER CONSIST OF ORDER DETAILS FOR SUCCESFULL DELIVERIES
create view delivered_order as 
select ord.order_id,pizza_id,quantity,order_date,order_time,custid
from order_details ord_dtl
join orders ord
on ord.order_id = ord_dtl.order_id
where lower(status) in ("success","delivered");
select * from delivered_order ;

-- VIEW -> PIZZA_DELIVERY_DETAIL CONSISTS OF DETAILS OF PIZZA SUCCESSFULLY DELIVERED
create view pizza_delivery_detail as
select d.order_id, d.pizza_id,d.quantity, price 
from pizzas p 
join delivered_order d
on d.pizza_id = p.pizza_id;
select * from pizza_delivery_detail;

-- VIEW -> TOTAL REVENUE GENERATED
create view total_revenue_generated as
select round(sum(quantity * price),2) as total_revenue 
from pizza_delivery_detail;
select * from total_revenue_generated;

-- BEST REVENUE GENERATING PIZZA FROM SUCCESSFULL DELIVERIES 
-- (FAILED OR CANCELLED ORDER NOT INCLUDED)
-- VIEEW -> REVENUE_PER_PIZZA CONSIST OF REVENUE GENRATED VIA ALL THE SUCCESSFULL DELIVERIES 
create view revenue_per_pizza as
(
select pizza_id,count(distinct order_id) as successfull_delieveries ,
round(sum(quantity*price),2) as revenue_generated 
from pizza_delivery_detail 
group by pizza_id  
order by revenue_generated desc
);
-- TOP 5 MOST REVENUE GENRATING PIZZAS
with top5_pizza as (select *
from(
select * ,
dense_rank() over(order by revenue_generated desc ) as pizza_rank
from revenue_per_pizza
) as pr
where pizza_rank <=5)
select 
round((
(select sum(revenue_generated) as top_5_pizza_revenue 
from top5_pizza) / (select total_revenue from total_revenue_generated)
)*100,2) as top5_revnue_perecentage ;
