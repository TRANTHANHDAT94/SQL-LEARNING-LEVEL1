-- Hãy sử dụng bảng sales.orders để thực hiện các yêu cầu sau:

-- 1. Hiển thị các cột trong bảng sales.orders bằng Tiếng Việt

-- 2. Các cột order_date, required_date, shipped_date có data trong khoảng thời gian nào?

-- 3. Tìm customer_id của top 10 tính theo số lượng đơn hàng từ cao xuống thấp? Từ thấp đến cao?

-- 4. Tìm customer_id của top 10% tính theo số lượng đơn hàng từ cao xuống thấp? Từ thấp đến cao?

-- 5. Tìm customer_id của top 10% tính theo doanh thu thuần của đơn hàng từ cao xuống thấp? Từ thấp đến cao?
select top 10 percent 
customer_id, 
sum((quantity * list_price)*(1-discount)) as net_revenue
from sales.order_items o 
join sales.order_items t2 on order_id = t2.order_id
group by customer_id;
-->Crossjoint
-- 6. Cột order_status chứa những giá trị nào?
select distinct order_status  from sales.orders;
-- 7. Có bao nhiêu store trong bảng?
select count(store_id) as no_store from sales.orders;
-- 8. Có bao nhiêu staff trong bảng?
select count(distinct staff_id) as no_staff from sales.orders;
-- 9. Staff nào có số lượng đơn hàng cao nhất?
select staff_id, count(order_id) ass no_orders from sales.orders group by staff_id order by count(order_id) desc;
-- 10. Thời gian trung bình từ order_date đến shipped_date là bao lâu?
select 
    --order_date, 
    --shipped_date, 
    avg (datediff(day,order_date, shipped_date)) ass avg_ship_time_in_day
from sales.orders;
-- 11. Thời gian trung bình từ order_date đến shipped_date theo từng order_status là bao lâu?
select * from sales.orders;
-- 12. Đơn hàng có thời gian từ order_date đến shipped_date ngắn nhất/ lâu nhất là bao lâu? Là đơn hàng nào?

-- Extra

-- 13. Tính số lượng đơn hàng theo từng tháng

-- 14. Tính số lượng đơn hàng theo từng tháng của từng cửa hàng & nhân viên

-- 15. Tính số lượng đơn hàng theo từng tháng của từng cửa hàng & nhân viên & theo trạng thái đơn hàng.

-- Bạn thể hiện trạng thái đơn hàng theo cột ntn?




BTVN:

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