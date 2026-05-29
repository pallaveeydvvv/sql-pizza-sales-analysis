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
select round(sum(quantity * price),2) as total_revenue from pizza_delivery_detail;

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
-- TOP 10 MOST REVENUE GENRATING PIZZAS
select *
from(
select * ,
dense_rank() over(order by revenue_generated desc ) as pizza_rank
from revenue_per_pizza
) as pr
where pizza_rank <=10;

select o.order_id , o.order_date , concat(c.first_name ," ",c.last_name)
from orders o
join customers c 
on c.custid = o.custid
where lower(o.status) in("success","delivered")
group by 

