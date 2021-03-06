-- Là 1 số function apply lên rules nào đó 
drop table tmp;
select * from sales.orders;
create table tmp (
    week_num int,
    date date,
    profit int
);
insert into tmp s
values
(37, '2021-09-08', 10)
, (37, '2021-09-09', 15)
, (37, '2021-09-10', 20)
, (37, '2021-09-11', 25)
, (38, '2021-09-12', 30)
, (38, '2021-09-13', 35)
, (38, '2021-09-14', 40)
, (38, '2021-09-15', 45)
, (38, '2021-09-16', 50)
, (38, '2021-09-17', 55)
, (38, '2021-09-18', 60)
, (39, '2021-09-19', 65);

select * from tmp;


-- Tính acccurmulated profit 
-- Thống kê số lượng đơn hàng theo order_status

-- Phần 1: các cột cần hiển thị
-- Phần 2: data dùng cho pivot
-- Phần 3: pivot clause

select * 
from (
    select
        store_id,
        staff_id,
        order_id,
        order_status
    from sales.orders
) as pivot_data
pivot (
    count(order_id)
    for order_status in ([1], "2", "3", "4")
) as pivot_table;

-- Dynamic SQL: variables


-- Thống kê số lượng đơn hàng + số lượng khách hàng theo order_status

with no_orders_stats as (
    select * 
    from (
        select
            store_id,
            staff_id,
            order_id,
            order_status
        from sales.orders
    ) as pivot_data
    pivot (
        count(order_id)
        for order_status in ([1], "2", "3", "4")
    ) as pivot_table    
)
, no_customers as (
    select
        [store_id],
        staff_id,
        [1] as no_customers_1, 
        "2" as no_customers_2
        , "3" as no_customers_3
        , "4" as no_customers_4
    from (
        select distinct
            store_id,
            staff_id,
            customer_id,
            order_status
        from sales.orders
    ) as pivot_data
    pivot (
        count(customer_id)
        for order_status in ([1], "2", "3", "4")
    ) as pivot_table
)
select t1.*,
    t2.no_customers_1,
    t2.no_customers_2,
    t2.no_customers_3,
    t2.no_customers_4
from no_orders_stats t1 
left join no_customers t2 
    on t1.store_id = t2.store_id
    and t1.staff_id = t2.staff_id;
------------------------------------------------------------------------------------------------------------
drop table tmp
------------------------------------------------------------------------------------------------------------
create table tmp (
    week_num int,
    date date,
    profit int
);
insert into tmp 
values
(37, '2021-09-08', 10)
, (37, '2021-09-09', 15)
, (37, '2021-09-10', 20)
, (37, '2021-09-11', 25)
, (38, '2021-09-12', 30)
, (38, '2021-09-13', 35)
, (38, '2021-09-14', 40)
, (38, '2021-09-15', 45)
, (38, '2021-09-16', 50)
, (38, '2021-09-17', 55)
, (38, '2021-09-18', 60)
, (39, '2021-09-19', 65);









-- Question: ãy tìm các đơn hàng có số lượng product cao nhất từ cao đến thấp và xếp hạng 5 - 10
with data as (
    select
        order_id,
        sum(quantity) as no_products
    from sales.order_items
    group by order_id
)
, tmp as (
    
    select
        order_id,
        ROW_NUMBER() over(order by no_products desc) as row_num,
        rank() over(order by no_products desc) as rank,
        DENSE_RANK() over(order by no_products desc) as dense_rank
    from data
)

select *
from tmp
where dense_rank between 5 and 10
-- Hãy tính % phân bổ revenue theo từng product, brand, store, staff


