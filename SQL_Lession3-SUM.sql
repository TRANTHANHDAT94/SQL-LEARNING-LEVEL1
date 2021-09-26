select top 3 * from sales.order_items;

select *
from sales.orders as t1
join sales.order_items as t2
    on t1.order_id= t2.order_id;

select top 10 * from sales.orders;
select top 10 * from sales.customers;
--- Khasch hafng cos thafnh boso satate nao tieu tien nhieu nhat
select top 10
    customer_id,
    sum(quantity * list_price*(1-discount)) as revenue
from sales.order_items as t1
join sales.orders as t2 on t1.order_id = t2.order_id
group by customer_id
order by revenue;

select top 10 customer_id, sum(quantity * list_price*(1-discount)) as revenue
from sales.order_items as t1 join sales.orders as t2 on t1.order_id = t2.order_id
group by customer_id order by sum(quantity * list_price*(1-discount)) desc;
--- tinsh khach hang tu thanh pho nao co nhieu chi tieu nhat

select top 10 city, sum(quantity * list_price*(1-discount)) as revenue
from sales.orders as t1 
join sales.order_items as t2 on t1.order_id = t2.order_id
join sales.customers as t3 on t1.customer_id = t3.customer_id
group by city order by revenue desc;
--Bang nao chi tieu nhieu nhat 
select top 10 state, sum(quantity * list_price*(1-discount)) as revenue
from sales.orders as t1 
join sales.order_items as t2 on t1.order_id = t2.order_id
join sales.customers as t3 on t1.customer_id = t3.customer_id
group by state order by revenue desc;

--Brand_name nao duoc chi tieu nhieu nhat 
select top 10 brand_name, sum(quantity * list_price*(1-discount)) as revenue
from sales.orders as t1 
inner join sales.order_items as t2 on t1.order_id = t2.order_id
inner join production.products as t3 on t2.product_id = t3.product_id
inner join production.brands as t4 on t3.brand_id = t4.brand_id
group by brand_name order by revenue desc;
-- from table1 join table 2 on key

