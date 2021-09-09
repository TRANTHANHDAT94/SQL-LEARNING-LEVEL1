select customer_id from sales.orders where customer_id >300;
select COUNT(customer_id) as newtable from sales.orders;
select * from  sales.orders;
-- -- Thống kê số lượng đơn hàng theo orderstatus
-- SELECT
-- <non-pivoted column>, ---> Cột không xoay chuyển
-- [first pivoted column] AS <column name>, ---> Giá trị đầu tiên được xoay chuyển thành cột
-- [second pivoted column] AS <column name>, ---> Giá trị thứ hai được xoay chuyển thành cột
-- [last pivoted column] AS <column name> ---> Giá trị cuối được xoay chuyển thành cột
-- FROM
-- (<SELECT query that produces the data>) AS PivotData
-- PIVOT
-- ( <Hàm tổng hợp>
-- FOR [<Cột chứa các giá trị sẽ trở thành tiêu đề cột>]
-- IN ( [first pivoted column], [second pivoted column], ... [last pivoted column]) ) AS PivotTable
-- ;
-- Phần 1 phần cột hiển thị 
-- Phần 2 phần data dành cho pivot 
-- Phần 3 pivot clause
select * 
from (
    select order_id
        ,order_status
    from sales.orders as table1
) as pivot_data
pivot(
    count(order_id)
    for order_status in ("1","2","3","4")
) as pivot_table
----------------------------------------------------------------------
-- Ad the dimension store_id 
select * 
from (
    select store_id 
        ,order_id
        ,order_status
    from sales.orders as table1
) as pivot_data
pivot(
    count(order_id)
    for order_status in ("1","2","3","4")
) as pivot_table
----------------------------------------------------------------------
-- Thống kê số lượng đơn hàng và số lượng khách hàng 
select * 
from (
    select store_id 
        ,order_id
        ,order_status
        ,customer_id
    from sales.orders as table1
) as pivot_data
pivot(
    count(order_id)
    for order_status in ("1","2","3","4")
) as pivot_table

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

-- Chủ đề XẾP HẠNG (RANKING TOPIC)
-- Sử dụng hàm ROW_NUMBER (), RANK() và DENSE_RANK()
-- Phân biệt ROW_NUMBER, RANK và DENSE_RANK
-- Đầu tiên, bạn nhìn ví dụ sau: