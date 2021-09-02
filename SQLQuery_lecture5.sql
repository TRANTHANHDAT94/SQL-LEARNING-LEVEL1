-- use LearnSQL2
select * from sales.orders;
select * from sales.customers;
-- Truy vấn con trong SQL (subquery) là gì?
-- Trong SQL Server, truy vấn con là một truy vấn nằm trong một truy vấn khác. Bạn có thể tạo các truy vấn trong
-- lệnh SQL. Các truy vấn con này nằm trong mệnh đề WHERE, FROM hoặc SELEC
select * from sales.orders;
select store_id,staff_id,order_id
from sales.orders
where order_id > (select AVG(order_id) from sales.orders);


--When we use where or select ->subqueqry wwill back 1 value (1 columns)
--Exampple: where order_id > (select AVG(order_id),max(...) from sales.orders);
--Export all data about store_id and staff_id also order_id 
--Bitmap(datastructure):scan all value
select store_id,staff_id,order_id
from sales.orders o
where exists(
    select 1, 2 from sales.customers c 
    where c.customer_id = o.customer_id and c.first_name = 'Charolette'
);


select * from sales.orders as o join(select * from sales.customers where first_name='Charolette') c on c.customer_id = o.customer_id;
select * from sales.orders o where o.customer_id =1;


select sales.customers.first_name+ ' ' +sales.customers.last_name as full_name,sales.orders.* from sales.orders join sales.customers on sales.orders.customer_id = sales.customers.customer_id;
--Neusubquery nam trong so sanh where/select return only on value
--Subquery at From/join will return many values



--Performances 
--Tangperformance: subquery help to decrease database which computer have to process: from/join/where: join sẽ giới hạn data vào trước khi data vào join nên giảm (crossjoin)
--Giamperformance;subquery will affect to insrease the database which computer have to process: select;




-- Phương pháp sử dụng CTE-Common Table Expression (Bảng tạm)
-- Mục đích của CTE
-- - Tạo truy vấn đệ quy (recursive query).
-- - Thay thế View trong một số trường hợp.
-- - Sử dụng được nhiều CTE trong một truy vấn duy nhất
-- Ưu điểm của CTE
-- CTE có nhiều ưu điểm như khả năng đọc dữ liệu được cải thiện và dễ dàng bảo trì các truy vấn phức tạp. Các truy vấn có thể
-- được phân thành các khối nhỏ, đơn giản. Những khối này được sử dụng để xây dựng các CTE phức tạp hơn cho đến khi tập
-- hợp kết quả cuối cùng được tạo ra.

--NOTE:
--1.Phương pháp tổ chức query 
--2.Nó có thể truy vấn chính nó hoặc truy vấn nhiều lần trong 1 câu query 
--C1: from b join a,c,d
--C2:subquery 
--C2.a: from/join/where: B+ subquery(a)+C+Subquery(A)+S+...
--C2.B:Select -->bị chậm performances 
--C3:CTE
-- with sub_A as (select from ...)-->CTE


select * from production.brands;
select * from sales.orders;
select * from sales.customers;
--Tim 3 custormer mua hang nhieu nhat cua branch Electra trong time tu T10/2018
-- Tìm top 3 customer mua hàng nhiều nhất của brand Ritchey trong thời gian từ tháng 10/2018 - 12/2018
with no_orders as (
    select customer_id, count(order_id) as no_order
    from sales.orders o
    where 
        o.order_date between '2018-10-01' and '2018-12-30'
        and 
        exists (
            select 1
            from production.products p 
            join sales.order_items i on p.product_id = i.item_id
            where 
                p.brand_id = (select brand_id from production.brands where brand_name = 'Ritchey')
            and 
            i.order_id = o.order_id
        )
    group by customer_id
)

select top 3
    customer_id as "Mã số khách hàng",
    no_order as "Số đơn hàng"
    , ROW_NUMBER() over(order by customer_id) as "Rank"
from no_orders
order by no_order desc, customer_id
;

--Recusive CTEs dùng nhiều trong hirrachy (phân cấp phân tầm level)







-- Phương pháp sử dụng BẢNG TẠM-TEMP TABLE
-- • Sẽ rất có lợi khi lưu trữ dữ liệu trong các bảng tạm thời của SQL Server thay vì thao tác hoặc làmviệc với
-- các bảng cố định.
-- • Khi bạn muốn có đầy đủ quyền truy cập vào các bảng trong Database, nhưng bạn lại không có. Bạn có thể
-- sử dụng quyền truy cập đọc hiện có của mình để kéo dữ liệu vào bảng tạm thời của SQL-Server và thực hiện
-- các điều chỉnh từ đó.
-- • Hoặc bạn không có quyền để tạo bảng trong cơ sở dữ liệu hiện có, bạn có thể tạo bảng tạm thời SQL Server
-- mà bạn có thể thao tác.
-- • Cuối cùng, bạn có thể rơi vào tình huống chỉ cần hiển thị dữ liệu trong phiên hiện tại, và muốn update
-- insert data trước khi hiển thị.
--Lâu hơn CTE
--1Chỗ lưu Data tam
--Giảm memory khi sử lý query --> tăng performance của query+database 
---A: 1M (CTE)
---B,C,D query to A với CTE phải 3 lần query 
---với TEMP table chỉ 1 lần để query save RAM 
---2 Loại:
-- * Local (#TableA): Tồn tại trong 1 section 
-- * Global (##TableB): Tồn tại đến khi section cuối disconnect 
DROP TABLE if exists #TableA;
select 
* INTO #TableA 
from sales.customers;

DROP TABLE if exists #TableA1;

select top 0
    *
INTO #TableA1
from sales.customers;

select * from #TableA
select * from #TableA1


use LearnSQL2
select 
* INTO ##TableB 
from sales.customers;
select * from ##TableB;--Can you as global validation





