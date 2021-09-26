use LearnSQL;
select * from Managers;
select * from Orders;
select * from Profiles;
select * from Returns;

------------------------------------------------------------------------------------------------------
use hocsql;
select top 5 * from Managers;
select top 5 * from Orders;
select top 5 * from Profiles;
select top 5 * from [Returns];
--1. Có bao nhiêu đơn hàng có mức độ ưu tiên (order_priority) = 'Low' 
select count(*) from Orders where Orders.order_priority = 'Low';
--2. Lấy danh sách top 5 tỉnh có nhiều đơn hàng nhất
select TOP 5 province from Orders 
order by order_quantity desc;
--3. Lấy danh sách 3 nhà quiản lý có nhiều đơn hàng nhất
-- select TOP 3 region from Orders 
-- order by order_quantity desc;
select distinct(manager) from Profiles where region in (
    select TOP 3 region from Orders 
    order by order_quantity desc
);
-- 4. Hãy đưa ra danh sách các Loại sản phẩm (Product_category) có lợi nhuận trung bình lớn hơn lợi nhuận trung bình của tất cả cácđơn hàng
SELECT distinct(product_category) from Orders WHERE profit > (SELECT AVG(profit) FROM Orders);

--cácđơn hàng5. Hãy đưa ra danh sách top 5 sản phẩm (product_name) có total_value lớn nhất của mỗi khu vực (region). Gợi ý sử dụng: row_number()
select top 5 region, product_name, sum(order_quantity*[value]) as total_value from Orders
group by region, product_name order by sum(order_quantity*[value]) desc;

--6. Hãy đưa ra danh sách các sản phẩm (product_name) có total_value bị xếp hạng xếp hạng thấp nhất theo từng tỉnh (province). Gợiý sửdụng dense_rank()
select top 5 province, product_name, sum(order_quantity*[value]) as total_value from Orders
group by province, product_name order by sum(order_quantity*[value]) asc;
-- 7.7. Hãy tạo bảng gồm các cột: year, month, total_revenue, total_revenue_returned,  acc_revenue, group_revenue
select 
    order_quantity* unit_price*(1-discount) as Revenue 
    -- , total_revenue - total_revenue_returned as acc_revenue
    from Orders



--https://timoday.edu.vn/xay-dung-chuong-trinh-quan-ly-ban-hang-bang-c/
--https://onedrive.live.com/?authkey=%21AHATBkbhUxlMews&cid=C6CB1FED4E11A01B&id=C6CB1FED4E11A01B%2125303&parId=C6CB1FED4E11A01B%2123316&o=OneUp

create database QuanLyBanHang;
use QuanLyBanHang;

