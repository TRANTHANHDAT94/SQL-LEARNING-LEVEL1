--JOINJ: add more the columns
--UNION: add more the rows
--add more and more the dataset basing on our databse 
-- INNER JOIN as JOIN
-- LEFT JOIN as LEFT JOIN
--TASK 1
select  
    t1.customer_id,
    t2.list_price,
    t2.quantity,
    t2.discount
from sales.orders t1 --t1 is alias name thôi
join sales.order_items t2 --database>schemas>tables>columns
    on t1.order_id = t2.order_id;
--WITHOUT T1 and T2 we can: 
select  
    sales.orders.customer_id,
    sales.orders.order_date,
    sales.order_items.list_price,
    sales.order_items.quantity,
    sales.order_items.discount
from sales.orders
join sales.order_items
    on sales.orders.order_id = sales.order_items.order_id;


select  
    *
from sales.orders t1 --t1 is alias name thôi
join sales.order_items t2 --database>schemas>tables>columns
    on t1.order_id = t2.order_id;
----------------------------------------------------------------
select top 10 percent
    customer_id,
    sum((quantity * list_price)* (1 - discount)) as net_revenue
from sales.order_items o
join sales.orders t2 on o.order_id = t2.order_id
group by customer_id;



----------------------------------------------------------------
-- Khach hang tu thanh pho state nao chi tieu nhieu nhat
SELECT 
    [state],
    sum((quantity * list_price)* (1 - discount)) as net_revenue
FROM sales.orders t1
INNER JOIN sales.order_items t2
ON t1.order_id=t2.order_id
INNER JOIN sales.customers t3
ON t1.customer_id=t3.customer_id
GROUP BY [state]
ORDER BY sum((quantity * list_price)* (1 - discount)) DESC;



-- Branch_name nao chi tieu nhieu nhat
SELECT 
    brand_name,
    sum((quantity * t2.list_price)* (1 - discount)) as net_revenue --calculation
FROM sales.orders t1 -- what is table1
INNER JOIN sales.order_items t2 -- what it table 2
ON t1.order_id=t2.order_id --where we will joint them together
INNER JOIN production.products t3 
ON t2.product_id=t3.product_id
INNER JOIN production.brands t4
ON t3.brand_id=t4.brand_id
GROUP BY brand_name
ORDER BY sum((quantity * t2.list_price)* (1 - discount)) DESC;

-- branch_id nao chi tieu nhieu nhat
SELECT 
    brand_id,
    sum((quantity * t2.list_price)* (1 - discount)) as net_revenue
FROM sales.orders t1
INNER JOIN sales.order_items t2
ON t1.order_id=t2.order_id
INNER JOIN production.products t3
ON t2.product_id=t3.product_id
INNER JOIN production.brands t4
ON t3.brand_name=t4.brand_name
GROUP BY brand_id
ORDER BY sum((quantity * t2.list_price)* (1 - discount)) DESC;

-- Tim last name and firt name trong tung staff
select 
    first_name +' '+ last_name as fullname,
    manager_id
from sales.staffs;
-- Lafm sao ddeer tifm ra record co trong bang A nhung k co trong bang B
SELECT 
    t1.first_name +' '+ t1.last_name as emp_name,
    t2.first_name +' '+ t2.last_name as man_name
FROM sales.staffs t1
JOIN sales.staffs t2
ON t1.staff_id=t2.manager_id;

select t1.* --t1.* is mean that all **
from sales.staffs as t1 
-- from sales.staffs t1 SAME
left join sales.staffs as t2 on t1.manager_id = t2.staff_id
where t1.manager_id is not null;
-- Làm thế nào tìm các bạn là manager

--FULLOUTERJOIN
--coalesce
-- Full outer join
-- Coalesce 

select
    coalesce(t1.staff_id, t2.staff_id) as staff_id
    , coalesce(t1.first_name, t2.first_name) as first_name
    , coalesce(t1.last_name, t2.last_name) as last_name
    , coalesce(t1.email, t2.email) as email
    , coalesce(t1.phone, t2.phone) as phone
    , coalesce(t1.active, t2.active) as active
    , coalesce(t1.store_id, t2.store_id) as store_id
    , coalesce(t1.manager_id, t2.manager_id) as manager_id,
    CONCAT_WS(' ', t3.first_name, t3.last_name) as manager_name,
    t1.manager_id as t1_manager_id,
    t2.manager_id as t2_manager_id
from (select * from sales.staffs where staff_id <= 5 ) t1
full join (select * from sales.staffs where staff_id >= 4) t2 
    on t1.staff_id = t2.staff_id
left join sales.staffs t3 on t3.staff_id = coalesce(t1.manager_id, t2.manager_id)
order by coalesce(t1.staff_id, t2.staff_id);
-- UNION and UNION ALl số lượng cột = nhau 
-- Datatype giống nhau 
-- thứ tự cũng bằng nhau 
-- 1. ĐịnhnghĩaUnion vàUnion All làphépnốicácbảngcócấutrúcgiốngnhau. 
-- Union AllsẽlấytấtcảbảnghicủaphépnốicònUnionsẽchỉlấycácbảnghiduynhất
-- 2. Cấutrúcgiốngnhaulàgì?
-- • Cácbảngphảicócùngsốcột
-- • Cáccộtcũngphảicócácloạidữliệutươngtự
-- • Cáccộttrongmỗibảngphảitheothứtự
-- 3. Cấutrúccâulệnhmẫu:
-- SELECT column1, column2, column3 FROM table1 
-- UNION hoặcUNION ALLSELECT column1, column2, column3 
-- FROM tablle24. 
-- VídụS
-- ELECT t1.province, t1.region 
-- FROM Profiles t1UNION ALLSELECT t2.province, t2.regionFROM Orders t2

select 
    t1.*
from (select * from sales.staffs where staff_id <= 5) as t1 union all select * from sales.staffs where staff_id >=4 
;


select * from(
    select * from sales.staffs where staff_id <= 5
    union all
    select * from sales.staffs where staff_id >4) as t
order by t.staff_id;

select * from (
    select * from sales.staffs where staff_id <= 5
    union all
    select * from sales.staffs where staff_id >= 4) as t 
order by t.staff_id
;









-- BTVN

WITH order_brand_category AS (
    SELECT 
        ord.order_id,
        ord.store_id,
        ord.customer_id,
        ord.order_status,

        item.item_id,
        
        category.category_id,
        brand.brand_id,
        product.product_id,
        
        staff.staff_id,
        manager.staff_id as manager_staff_id

    FROM sales.orders ord
    INNER JOIN sales.order_items item
        ON ord.order_id = item.order_id
    INNER JOIN production.products product
        ON item.product_id = product.product_id
    INNER JOIN production.categories category
        ON product.category_id = category.category_id
    INNER JOIN production.brands brand
        ON product.brand_id = brand.brand_id
    INNER JOIN sales.staffs staff 
        ON ord.staff_id = staff.staff_id
    LEFT JOIN sales.staffs manager 
        ON staff.manager_id = manager.staff_id
    
)

SELECT
    store.store_id,
    store.store_name,

    manager.staff_id as manager_staff_id,
    manager.first_name + ' ' + manager.last_name as manager_name,

    staff.staff_id,
    staff.first_name + ' ' + staff.last_name as staff_name,

    brand.brand_id,
    brand.brand_name,
    
    category.category_id,
    category.category_name,

    COUNT(DISTINCT obc.customer_id) as no_customers,
    count(distinct obc.order_id) as no_orders,
    count(distinct case order_status when 1 then obc.order_id end) as "Đơn đã đặt",
    count(distinct case order_status when 2 then obc.order_id end) as "Đang xử lý",
    count(distinct case order_status when 3 then obc.order_id end) as "Đã xuất kho",
    count(distinct case order_status when 4 then obc.order_id end) as "Đã giao",

    format(sum(item.list_price * item.quantity ), '$ ###,###,###.##') as revenue,
    format(sum(item.list_price * item.quantity * item.discount ), '$ ###,###,###.##') as discount,
    format(sum(item.list_price * item.quantity * (1 - item.discount) ), '$ ###,###,###.##') as net_revenue

FROM order_brand_category obc
INNER JOIN sales.stores store ON store.store_id = obc.store_id
INNER JOIN sales.staffs staff ON obc.staff_id = staff.staff_id
LEFT JOIN sales.staffs manager ON obc.manager_staff_id = manager.staff_id
INNER JOIN production.brands brand ON obc.brand_id = brand.brand_id
INNER JOIN production.categories category ON obc.category_id = category.category_id
JOIN sales.order_items item on obc.order_id = item.order_id and obc.item_id = item.item_id
GROUP BY
    store.store_id,
    store.store_name,

    manager.staff_id,
    manager.first_name + ' ' + manager.last_name,

    staff.staff_id,
    staff.first_name + ' ' + staff.last_name,

    brand.brand_id,
    brand.brand_name,
    
    category.category_id,
    category.category_name
ORDER BY store.store_id;
