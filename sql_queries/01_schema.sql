-- SCHEMA SETUP

-- DATATYPE MODIFICATION
alter table pizzas
	modify column pizza_id varchar(50);
alter table pizza_types
	modify column pizza_type_id varchar(50); 
alter table order_details
	modify column pizza_id varchar(50); 
-- ----------------------------------------------------------------------------------------------    
-- ADDING CONSTRAINTS
alter table pizzas
	add constraint pizza_pk primary key (pizza_id);
alter table pizzas
	modify column pizza_type_id varchar(50),
    add constraint pizza_type_id_fk foreign key(pizza_type_id)
    references pizza_types(pizza_type_id);
        alter table pizza_types
	add constraint pizza_types_pk primary key (pizza_type_id);
alter table customers
	add constraint customers_pk primary key (custid);
alter table order_details
	add constraint pizza_id_fk foreign key (pizza_id) 
		references pizzas(pizza_id),
	add constraint order_id_fk foreign key (order_id) 
		references orders(order_id);
alter table orders
	add constraint order_pk primary key (order_id),
    add constraint order_cust_id foreign key (custid)
    references customers(custid);
-- ---------------------------------------------------------------------------------------------
