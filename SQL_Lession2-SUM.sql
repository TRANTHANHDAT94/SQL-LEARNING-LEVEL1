use Lession1SUM;
select * from sales.customers;
-- select columns as alias from tables
select customer_id as ThanhDat from sales.customers;
--cutomer->columns name 
--Thanhdat->Alias
--sales.customers->Table
--sales-->Schema 
select * 
from production.brands;

select discount
from sales.order_items;
select 
    *
from sales.order_items;

select 
    order_id as "Mã Đơn Hàng",
    item_id as "Chỉ số đơn hàng"
from sales.order_items;

select 
    --Fullname
    first_name + ' ' + last_name as [FULNAME],
    CONCAT_WS(' ',first_name,last_name) as [Fullname] --same as add 
    , *
from sales.staffs;
-- pandas.value_counts()
select distinct 
    order_id, staff_id
from sales.orders;
--SELECT LIMIT STATMENTS
select TOP 10 order_date from sales.orders;
select TOP 10 PERCENT order_date from sales.orders;

-- where: is not, = >=, <=, <>, !=
select TOP 10 * from sales.order_items 
where product_id > 10;

--acs dec

select TOP 20 order_id as ABC from sales.order_items;
--pandas.head(10)
select TOP 10 
    order_id,
    quantity,
    list_price * quantity as revenue,
    list_price * (1-discount) as discount
from sales.order_items;

-- group by order_id 
select 
    quantity,
    -- sum(quantity) as total_quantity,
    sum(list_price * quantity) as revenue
from sales.order_items 
group by quantity;

select 
    order_id,
    sum(quantity) as total_quantity,
    sum(list_price * quantity) as revenue
from sales.order_items 
group by order_id;


select *  from sales.order_items order by order_id OFFSET 20 ROWS; --show dữ liệu từ 20 trở đi 
select TOP 10 * from sales.order_items order by order_id; -- show pandas.sort_values().head(10)
-- WHERE
select * from sales.staffs where staff_id >5;
select * from sales.staffs where staff_id between 5 and 10;
select 
    * 
from sales.staffs 
where staff_id 
    between 5 and 10
    and store_id = 2;

select 
    * 
from sales.staffs 
where staff_id 
    between 5 and 10
    and (store_id = 2 or manager_id =1;






select * from production.products
where product_name like 'T%';


select * from production.products -- có chứa M trong tên 
where product_name like '%M%';

select * from production.products -- bắt đầu bằng E
where product_name like 'E%';

select * from production.products
where product_name like 'E%M%'; -- bắt đầu bằng E và có M inside
--Casting 
select 
    product_id,
    cast(product_id as varchar(2)) as product_id_as_varchar
from production.products;

select 
    product_id,
    cast(product_id as varchar(3)) as product_id_as_varchar
from production.products;
select 
    product_id
from production.products
    group by product_id;


-----------------------------------
-- WHERE

-- Các toán tử: 
-- General:
-- Equal: = 
-- Not equal: != / <>
-- > < >= <=
select *
from sales.staffs
where staff_id >= 5;


-- <X> BETWEEN A and B: --> ( <X> >= A ) AND (<X> <= B)
select *
from sales.staffs
where staff_id between 6 and 9;

-- AND/ OR: dùng cho các cặp điều kiện:
-- True/ False -->
-- True AND True --> True
-- True AND False --> False
-- True1 OR True2 --> nếu thỏa ĐK 1 hoặc ĐK 2 thì True

select *
from sales.staffs
where 
    staff_id between 5 and 10
    and (store_id = 2
        or manager_id = 1)
;

-- NOT:
-- NOT True = False
-- NOT False = True
-- Venn diagram
select *
from sales.staffs
where 
    staff_id not between 5 and 10
    and not (store_id = 2
        or manager_id = 1)
;

-- Step 1
select *
from sales.staffs
where 
    staff_id not (TRUE / FALSE)
    and not (TRUE/FAlSE
        or TRUE/FAlSE)
;
-- Step 2
select *
from sales.staffs
where 
    staff_id not (TRUE / FALSE)
    and not (TRUE/FAlSE)
;

-- Step 3: handle NOT
select *
from sales.staffs
where 
    staff_id (FALSE / TRUE)
    and (FALSE / TRUE)
;


-- IN --> trong 1 mảng giá trị
-- <X> IN (1,2,3,4,5) --> (<X> = 1) OR (<X> = 2) ... 
select *
from sales.staffs
where store_id in (1,2);

-- IS: null / true/ false [boolean data types]
select *
from sales.staffs
where manager_id is null;

-- LIKE: sử dụng cho chuỗi
-- 2 operators:
-- %: 1 hoặc nhiều kí tự
-- _: 1 kí tự bất kì
select
    *
from production.products;

-- Collation của SQL Server --> mặc định là không phân biệt hoa thường

-- Tìm những sản phẩm bắt đầu bằng T
select
    *
from production.products
where product_name like 'T%';

-- Tìm những sản phẩm có tên chứa chữ T
select
    *
from production.products
where product_name like '%T%';

-- Tìm những sản phẩm có list_price gồm 3 chữ số trước dấu thập phân
select
    *
from production.products
where list_price like '___.__';

select
    *
from production.products
where list_price like '___.%';

-- Tìm những sản phẩm có tên bắt đầu bằng E và có chứa kí tự M
select
    *
from production.products
where product_name like 'E%M%';


-- Cast / Convert data type
select
    product_id,
    cast(product_id as varchar(2)) as product_id_vchar,
       convert(varchar(2), product_id) as product_id_convert
from production.products
where product_name like 'E%M%';



