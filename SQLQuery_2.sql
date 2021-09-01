-- PK Unique  va k co gia tri nULL
-- FK ONN CASCASDE DELETE IGNORE
/*
https://onedrive.live.com/?cid=c6cb1fed4e11a01b&id=C6CB1FED4E11A01B%2118900&authkey=%21AFNZiKAOi2nf4wo
*/
-- SLECT will use to choose the dataset 
-- FROM will use to export the database to our action 
-- WHERE 
-- GROUP BY
select brand_id
from production.brands;
-- char,varchar,nvchar save data as string or text
-- small database is ok however with large datasize we will face the time for cost increasing


select 
    order_id as 'Ma_don_hang' --alias
from sales.orders;
--ALIASSS
select 
    first_name + ' ' + last_name as [Fullname],
    concat (first_name, ' ', last_name) as [Fullname]
from sales.staffs;
--disticn 
select 
    order_status, staff_id
from sales.orders;
--SELECT LIMIT STAMENT
select top 10 * from sales.orders;
select * from sales.orders;

select * from production.brands;
select * from sales.order_items;
select * from sales.staffs;
--NOTE THAT: 
-- CHAR and varchar VVARCHAR du lieu sang string tex
-- Integer (int) 1,2,3
--> Currency : VND/USD -->CHAR(3) for example 
select * from production.brands;
-->When we use slect * all database will be load therefore we have to load with defined dataset where will loads
--> Athena/Spectrum : Pls tell the team of Database to know more for that DepOps
select * from sales.orders;
select
    order_id as "Madonhang",
    customer_id "MaKhachHang",
    *
from sales.orders;
select * from sales.orders;

select 
    first_name + '' + last_name + cast(staff_id as varchar) as [Full Name]
from sales.staffs;

--> Seach more information about concat and concat_ws 
select
    -- Tên đầy đủ của nhân viên
    first_name + ' ' + last_name as [Full Name],
    concat(first_name, ' ', last_name) as [Full Name], -- concatenate
    concat_ws(' ', first_name, last_name) as [Full Name]
from "sales"."staffs";

select distinct * from sales.orders;

select order_status,staff_id from sales.orders;
--> Syntax: select columns from table 
-->SELECT LIMIT STAMENT 
-- * syntaxt: SELECT TOP N [percent]  [columns]  FROM table_name
/*
•TOP N: Trả về kết quả N dòng đầu tiên•TOP N Percent: Trả về kết quả N% dòng đầu tiên
*/
SELECT TOP 20 order_id,order_status FROM sales.orders;

select 
    order_id, order_date, order_status, store_id 
from 
    sales.orders
ORDER BY 
    order_id, order_date, order_status,store_id
OFFSETS 10 ROWS;
--SELECT LIMIT STATEMENT
SELECT TOP  10 * FROM sales.order_items;
--SAME as dataset.head()
-- Hãy viết câu truy vấn trả về 20 dòng đầu tiên của bảng gồm các cột
-- order_id, order_date, order_status, store_id từ bảng Orders.
--20%
SELECT TOP  20 PERCENT  order_id,  order_date
from sales.orders;
--FILTER USING WHERE
SELECT * FROM sales.order_items;
SELECT order_id,item_id FROM sales.order_items  WHERE  order_id =1;
SELECT order_id,item_id FROM sales.order_items  WHERE  order_id in (1,2,3);
--  Lọccác kết quả theo điều kiện null
SELECT * FROM sales.order_items where order_id is null;
SELECT * FROM sales.order_items where order_id is not null;


--TASK 7: MINMAX value  SELECT MIN(column_name)FROM table_name WHEREcondition;
-- VD1:Lấy giá trị nhỏ nhất của cột profit từ bảng Orders|SELECT MIN(profit)FROM Orders
-- VD2: Lấy giá trị lớn nhất của cột Order_quantity từ bảng Orders|SELECT MAX(Order_quantity)FROM Orders
select min(list_price) from sales.order_items;
select max(list_price) from sales.order_items;
select min(list_price) from sales.order_items where order_id =1;
select min(list_price) as Minvalue from sales.order_items;

-- TASK8 COUNT and AVG and SUM function 
-- SELECT COUNT ( [DISTINCT]column_name) FROM table_name WHERE condition;
-- VD1:Đếm số dòng cột order_priority từ bảng Orders|SELECT COUNT(Order_priority)FROM Orders
-- VD2: Tính giá trị trung bình profit từ bảng Orders|SELECT AVG(Profit)FROM Orders
-- VD3:Tính tổng profit từ bảng Orders|SELECT SUM(Profit)FROM Orders
select count(list_price) from sales.order_items;
select avg(list_price) from sales.order_items;
select sum(list_price) from sales.order_items;

--TASK9:GROUPBY 
-- 1->Tách:Các nhóm  khác nhau được chia theo giá trị của chúng.
-- 2->Áp dụng:Hàm tổng hợp được áp dụng  cho các giá trị của các nhóm  này.
-- 3->Kết hợp: Các giá trị được kết hợp trong một hàng.
-- SELECT column_1, function_name (column_2)--bao gồmcộttạomớibằnghàmtổnghợp
-- FROMtable_nameGROUP BYcolumn_name--nhóm các hàng đề áp dụng hàm tổng hợp
-- ORDER BYcolumn_name; asc/desc--sắp xếp tăng/giảm nếu có

select
	order_id,
    item_id,
	sum(quantity) as totol_quantity,
	sum(list_price * quantity) as Revenue,
	sum(list_price*discount) as discount,
	sum(list_price*quantity*(1-discount)) as net_revenue
from sales.order_items
group by order_id,item_id
order by Revenue asc;

--TASK11: LỌC KẾT QUẢ VỚI HAVING
-- SELECT <column_1,function_name(column_2),...>--Trong  select chứahàmtổnghợp
-- FROM<table>
-- WHERE<condition>--Điềukiệnápdụngvớicộtcósẵn
-- GROUPBY<column(s)>--Nhómcáchàngđểápdụnghàmtổnghợp
-- HAVING<condition>--Hàmtổnghợptrongđiềukiện
-- ORDERBY<column(s)>;--Xácđịnhthứtựtănggiảm(Tùychọn)
select * from sales.order_items where order_id in (1,2,3); --GROUP
select
	order_id,
    item_id,
	sum(quantity) as totol_quantity,
	sum(list_price * quantity) as Revenue,
	sum(list_price*discount) as discount,
	sum(list_price*quantity*(1-discount)) as net_revenue
from sales.order_items
group by order_id,item_id

select
	order_id,
	sum(quantity) as totol_quantity
from sales.order_items
group by order_id;

--HAVING danh cho GROUPBY con WHere danh cho cot 
--Having di kem voi min max sum count avg
--where =, in(a,b,c) is inull or is not null 
--NOTE tHat grouby matching some uinque variable in each columns

--------- WHERE: CONDITION
--   Equal: = 
--   NotEqual: <>, !=, >, <, >=, <=

----------BETWEEN
--          between a and b: x >=a and x<=b
--          between (x> a ) and (x<c)
--          between (x>a) or (....)
--TRUE and TRUE -->TRUE 
--TRUE and FALSE -->FALSE
--FLASE and FALSE -->FALSE
 --TRUE or FALSE -> TRUE
 --FALSE or FALSE -->FALSE
 -- NOT TRUE -->FALSE
 -- NOT FALSE -->TRUE
 -- WHERE a in [...]
 -- WHERE IS null/True/False 
 --LIKE sundung cho chuỗi 
 --operator: % 1 hoặc nhiều kí tự, _: 1 kí tự bất kì 
select * from sales.staffs where staff_id > 1;
select * from sales.staffs 
where staff_id between 6 and 9
    and (store_id = 2 
    or manager_id =1);
select first_name from sales.staffs where first_name = 'Fabiola';

--Cặp điều kiện sử lý theo hàng 
select * from sales.staffs 
where 
    staff_id between 6 and 9
    and (store_id = 2 
            or manager_id =1);

select * from sales.staffs 
where (staff_id between 6 and 9) and (store_id = 2 or manager_id =1);
-- tóm lại select columns from tables where conditions
-- SYNTAX: select columns from tables where conditions
select * from sales.staffs where (manager_id is null);

-- Tìm những thằng trong product bắt đầu bằng T
-- Clollation ->Macdinh k pha biet in hoa in thuong trong SQLSever
select * from production.products where (product_name like 'T%');
-- Tìm những thằng trong product T đâu đó ở giữa
select * from production.products where (product_name like '%T%');
-- Tìm những thằng trong product có list price gồm 3 chữ số trở lên 
select * from production.products where (list_price like '___.__');
select * from production.products where (list_price like '___.%');


select * from production.products where (product_name like '%E%M%');
--Casting use CAStT/COVERT
select product_id,cast(product_id as varchar(20)) as product_id_vchar from production.products;
-- syntax: cast(value as typevalue) as new_value
--LINK:https://www.w3schools.com/sql/func_sqlserver_cast.asp
-- SQLTurorials: https://www.w3schools.com/sql/default.asp

--BTVN
-- Hãy sử dụng bảng sales.orders để thực hiện các yêu cầu sau:


























-- 1. Hiển thị các cột trong bảng sales.orders bằng Tiếng Việt
select
    order_id as [Mã đơn hàng]
    , customer_id as "Mã khách hàng"
    , order_status as "Trạng thái đơn hàng"
    , order_date as "Ngày đặt đơn hàng"
    , required_date as "Ngày hẹn giao đơn hàng"
    , shipped_date as "Ngày hoàn tất giao đơn hàng"
from sales.orders;

-- 2. Các cột order_date, required_date, shipped_date có data trong khoảng thời gian nào?
select
    min(order_date) as order_date_min
    , max(order_date) as order_date_max
    , min(required_date) as required_date_min
    , max(required_date) as required_date_max
    , min(shipped_date) as shipped_date_min
    , max(shipped_date) as shipped_date_max
from sales.orders;


-- 3. Tìm customer_id của top 10 tính theo số lượng đơn hàng từ cao xuống thấp? Từ thấp đến cao?
select top 10
    customer_id, 
        count(order_id) as no_orders
from sales.orders
group by customer_id
order by count(order_id) desc;

-- Từ thấp đến cao
select top 10
    customer_id, 
        count(order_id) as no_orders
from sales.orders
group by customer_id
order by count(order_id); -- Ascending --> default


-- 4. Tìm customer_id của top 10% tính theo số lượng đơn hàng từ cao xuống thấp? Từ thấp đến cao?
select top 10 percent
    customer_id, 
        count(order_id) as no_orders
from sales.orders
group by customer_id
order by count(order_id) desc;

-- Từ thấp đến cao
select top 10 percent
    customer_id, 
        count(order_id) as no_orders
from sales.orders
group by customer_id
order by count(order_id); -- Ascending --> default

-- 5. Tìm customer_id của top 10% tính theo doanh thu thuần của đơn hàng từ cao xuống thấp? Từ thấp đến cao?
select top 10 percent
    customer_id,
    sum((quantity * list_price)* (1 - discount)) as net_revenue
from sales.order_items o
join sales.orders t2 on o.order_id = t2.order_id
group by customer_id;

-- Credit to Oanh Kieu
--> Cross join
select
	top 10 percent
	customer_id
	, LearnSQL2.sales.order_items.order_id
	,sum(quantity*List_price*(1-discount)) as revenue
from LearnSQL2.sales.order_items, LearnSQL2.sales.orders 
where LearnSQL2.sales.order_items.order_id = LearnSQL2.sales.orders.order_id
group by LearnSQL2.sales.order_items.order_id, customer_id;

-- 6. Cột order_status chứa những giá trị nào?
select distinct order_status
from sales.orders;

-- 7. Có bao nhiêu store trong bảng?
select 
    count(distinct store_id) as no_stores
from sales.orders;

-- 8. Có bao nhiêu staff trong bảng?
select 
    count(distinct staff_id) as no_staff
from sales.orders;

-- 9. Staff nào có số lượng đơn hàng cao nhất?
select top 1
    staff_id,
    count(order_id) as no_orders
from sales.orders
group by staff_id
order by count(order_id) desc;

-- 10. Thời gian trung bình từ order_date đến shipped_date là bao lâu?
-- Avg([shipped_date] - [order_date])
select 
    -- datediff(interval, from_date, to_date)
    avg(datediff(day, order_date, shipped_date)) as avg_ship_time_in_day
from sales.orders;

-- 11. Thời gian trung bình từ order_date đến shipped_date theo từng order_status là bao lâu?
select 
    order_status,
    -- datediff(interval, from_date, to_date)
    avg(datediff(day, order_date, coalesce(shipped_date, getdate()))) as avg_ship_time_in_day
from sales.orders
group by order_status;

-- 12. Đơn hàng có thời gian từ order_date đến shipped_date ngắn nhất/ lâu nhất là bao lâu? Là đơn hàng nào?
select top 1
    order_id,
    -- datediff(interval, from_date, to_date)
    datediff(day, order_date, coalesce(shipped_date, getdate())) as ship_time_in_day
from sales.orders
where shipped_date is not null
order by datediff(day, order_date, coalesce(shipped_date, getdate())) desc
;

-- "2021-08-25" - "2018-12-28"

-- Extra

-- 13. Tính số lượng đơn hàng theo từng tháng
select 
    format(order_date, 'yyyyMM') as month,
    count(order_id) as no_orders 
from sales.orders
group by format(order_date, 'yyyyMM')
order by format(order_date, 'yyyyMM') desc;

-- 14. Tính số lượng đơn hàng theo từng tháng của từng cửa hàng & nhân viên
select 
    format(order_date, 'yyyyMM') as month,
    store_id, 
    staff_id,
    count(order_id) as no_orders 
from sales.orders
group by format(order_date, 'yyyyMM'), store_id, staff_id
order by format(order_date, 'yyyyMM') desc;

-- select * from sales.orders
-- select 
--     store_id, 
--     staff_id
-- from sales.orders
-- group by format(order_date, 'yyyyMM'), store_id, staff_id
-- order by format(order_date, 'yyyyMM') desc;

-- 15. Tính số lượng đơn hàng theo từng tháng của từng cửa hàng & nhân viên & theo trạng thái đơn hàng.
select 
    format(order_date, 'yyyyMM') as month,
    store_id, staff_id, order_status as new,
    count(order_id) as no_orders 
from sales.orders
group by format(order_date, 'yyyyMM'), store_id, staff_id, order_status
order by format(order_date, 'yyyyMM') desc;

-- Bạn thể hiện trạng thái đơn hàng theo cột ntn?
-- order_status:
-- 1 - Đã đặt
-- 2 - Đang xử lý
-- 3 - Đã xuất kho
-- 4 - Đã giao

select 
    format(order_date, 'yyyyMM') as month,
    store_id, staff_id
    , count(case when order_status = 1 then order_id end) as "Đã đặt"
    , count(case when order_status = 2 then order_id end) as "Đang xử lý"
    , count(case when order_status = 3 then order_id end) as "Đã xuất kho"
    , count(case when order_status = 4 then order_id end) as "Đã giao"
    -- , sum ((quantity * list_price)) as 'DoanhThu'
from sales.orders
group by format(order_date, 'yyyyMM'), store_id, staff_id, order_status
order by format(order_date, 'yyyyMM') desc;
--ascending asc