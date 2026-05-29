
-- CLEANING THE GIVEN DATA
-- inspecting the data 
select * from customers;
-- CHECKING WHETHER ANY NULL VALUES EXIST
	select * from customers
    where (first_name is null) or
    (phone is null ) or
    (email is null) or
    (city is null);
-- CHECKING WHETHER DUPLICATES DO EXIST
    select custid , count(*) from customers
    group by custid 
    having count(*)>1;
select * from order_details;
	-- CHECKING WHETHER DUPLICATES DO EXIST
    select pizza_id , count(*)from order_details
    group by pizza_id;
