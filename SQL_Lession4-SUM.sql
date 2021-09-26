use Lession1SUM;
select GETDATE() at time ZONE 'SE Asia Standard Time' as DATE;

select avg(order_id) from sales.order_items;
select max(order_id) from sales.order_items;
select min(order_id) from sales.order_items;

select * from sales.order_items where order_id>(select avg(order_id) from sales.order_items);
select  from sales.order_items
---Check all name colums
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'Orders'
select top 3 1,2,3 from sales.order_items;
----
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
-----
select * from sales.customers;
select * from production.categories;

SHOW KEYS FROM tablename WHERE Key_name = 'PRIMARY'
select * 
from production.brands as table1 
join production.products as table2
on table1.brand_id = table2.brand_id

select * 
from sales.orders as table1
JOIN (select * from sales.customers where first_name = 'Charolette') as table2 
on table1.customer_id=table2.customer_id;

select 
    table2.first_name + ' '+ table2.last_name as fullname 
    , table1.* 
from sales.orders as table1 
join sales.customers as table2 on table2.customer_id=table1.customer_id;


select 
    table2.first_name + ' '+ table2.last_name as fullname
from sales.orders as table1 join sales.customers as table2 on table2.customer_id=table1.customer_id;



select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE;
select * from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE;




-- số lượng query sub based on eginequery 
select * from sales.customers where customer_id = 1
select table2.first_name+ ' ' +table2.last_name as fullname 
    , table1.*
from sales.orders as table1 
join sales.customers as table2 on table2.customer_id=table1.customer_id 
where table1.order_date >= '2021-01-01';


select table2.first_name+ ' ' +table2.last_name as fullname 
    , table1.*
from (select * from sales.orders where order_date >= '2016-01-01') as table1 
join sales.customers as table2 on table2.customer_id=table1.customer_id 
--subquere phải được đặt trong ()
--Phải bỏ ordeby trong subquery 


--CTE comman Table expression bảng tạm: Tổ chức câu query dễ hơn 
-- syntax: with engineer as (select * from sales.customers)
-- Phương pháp tổ chức: Nó có thể truy vấn chính nó hay truy vấn nheiefu lần trong 1 câu query 
with abc as(
    select * from sales.customers
)

select * from abc where first_name like 'D%'

--# bảng tam luôn đi kèm với subquery với tạo bảng 

with no_orders as(
    select customer_id, count(order_id) as no_oder 
    from sales.orders as table1
    where 
        exists (
            select 1
            from production.products as table2
            join sales.order_items as table3 on table2.brand_id = t3.brand_id
            where table3.order_id = table1.order_id
        )
    group by customer_id  
)
select * from no_orders



with engineer as(
    select * from sales.customers)