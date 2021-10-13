-- 1. Có bao nhiêu đơn hàng có mức độ ưu tiên (order_priority) = 'Low'
-- Bảng Orders này được chia theo nhiều dòng cho cùng 1 order_id (có nhiều sản phẩm)
-- mình lại cần tính số lượng đơn hàng thôi --> cần dùng distinct
select count(distinct order_id)
from dbo.Orders
where order_priority = 'Low';
-- 1124 orders

-- 2. Lấy danh sách top 5 tỉnh có nhiều đơn hàng nhất
select top 5 province
from dbo.Orders
group by province
order by count(distinct order_id) desc;

-- province
-- Ontario
-- British Columbia
-- Saskachewan
-- Alberta
-- Quebec


-- 3. Lấy danh sách 3 nhà quản lý có nhiều đơn hàng nhất
-- Phần này thì có 1 assumption là mỗi province & region sẽ do 1 quản lý phụ trách (regional manager á)
-- --> muốn lấy thông tin của manager thì mình sẽ join qua bảng trung gian là Profiles

select top 3 m.*
from dbo.Orders o
join dbo.Profiles p on o.province = p.province and o.region = p.region
join dbo.Managers m on p.manager = m.manager_name
group by m.manager_name, m.manager_id, m.manager_level, m.manager_phone
order by count(distinct order_id) desc;

-- manager_id,manager_name,manager_level,manager_phone
-- 112,William,3,807-555-0118
-- 113,Erin,3,306-555-0193
-- 114,Sam,4,709-555-0139

-- 4. Hãy đưa ra danh sách các Loại sản phẩm (Product_category) có lợi nhuận trung bình lớn hơn lợi nhuận trung bình của tất cả cácđơn hàng
-- Sau khi xác định dùng bảng Orders để tính thì mình có 1 so sánh sau:
-- Bảng này đang break theo nhiều product khác nhau trong mỗi đơn hàng, và mình cần tính tương quan giữa category và order, nhưng:
-- Lợi nhuận trung bình theo category thì có thể dùng avg trực tiếp trên các product khác nhau
-- Lợi nhuận trung bình theo đơn hàng thì lại cần phải tính sum(lợi nhuận) mỗi đơn hàng trước, nếu không thì sẽ ra là lợi nhuận trung bình theo các sản phẩm

--> cần tính tổng profit theo đơn hàng trước khi lấy average

-- Trong bảng này có profit rồi thì mình có thể dùng luôn, còn không thì mng có thể tính lại theo công thức nha
with orders_value as (
    select sum(profit) as total_profit
    from dbo.Orders
    group by order_id
)
select
    product_category,
       avg(profit) as total_profit
from dbo.Orders o
group by product_category
having avg(profit) > (select avg(total_profit) from orders_value);

-- product_category,total_profit
-- Technology,1369.370173801453

-- 5. Hãy đưa ra danh sách top 5 sản phẩm (product_name) có total_value lớn nhất của mỗi khu vực (region). Gợi ý sử dụng: row_number()
-- Vì trong data của mình thì các product name đang nằm theo nhiều order khác nhau, nên để so sánh theo khu vực (region)
-- thì mình cần tổng hợp data lại trước theo đúng dimensions là region và product_name trước rồi sau đó mới so sánh để chọn ra top

with product_region_sum as (
    select
        region, product_name, sum(value) as total_value
    from dbo.Orders o
    group by region, product_name
)
, product_ranks_by_region as (
    select
           *
         , row_number() over (partition by region order by total_value desc)
             as value_rank_desc -- -- đặt tên value_rank_desc cho dễ phân biệt, có dùng ở các model downstream (phía sau) hoặc sau này quay lại thì cũng dễ hiểu hơn, tránh bug
    from product_region_sum
)
select *
from product_ranks_by_region
where value_rank_desc <= 5;

-- Này nhiều dòng quá nên mình skip phần kết quả nha

-- 6. Hãy đưa ra danh sách các sản phẩm (product_name) có total_value bị xếp hạng xếp hạng thấp nhất theo từng tỉnh (province). Gợiý sửdụng dense_rank()
with product_region_sum as (
    select
        region, product_name, sum(value) as total_value
    from dbo.Orders o
    group by region, product_name
)
, product_ranks_by_region as (
    select
        *
         , dense_rank() over (partition by region order by total_value)
             as value_rank_asc -- đặt tên value_rank_asc cho dễ phân biệt, có dùng ở các model downstream (phía sau) hoặc sau này quay lại thì cũng dễ hiểu hơn, tránh bug
    from product_region_sum
)
select *
from product_ranks_by_region
where value_rank_asc = 1;

-- Này nhiều dòng quá nên mình skip phần kết quả nha

-- 7. Hãy tạo bảng gồm các cột: year, month, total_revenue, total_revenue_returned,  acc_revenue, group_revenue
-- Trong đó:
--     Revenue = order_quantity * unit_price * (1-discount)
--     acc_revenue=total_revenue - total_revenue_returned
--     Group_revenue là 'Thấp' khi
--         acc_revenue  < 10000
--         'Trung bình' khi acc_revenue <  20000
--         'Cao' khi acc_revenue >=20000

with aggr_data as (
    select datepart(year, o.order_date)                            as year
         , datepart(month, o.order_date)                           as month
         , sum(o.order_quantity * o.unit_price * (1 - o.discount)) as total_revenue
         , sum(
            IIF(r.order_id is null
                , 0
                , o.order_quantity * o.unit_price * (1 - o.discount))
        )                                                          as total_revenue_returned
        , sum(o.order_quantity * o.unit_price * (1 - o.discount))
            - sum(
                IIF(r.order_id is null
                    , 0
                    , o.order_quantity * o.unit_price * (1 - o.discount))
            ) as "acc_revenue"
    from dbo.Orders o
             left join dbo.Returns r on o.order_id = r.order_id
    group by datepart(year, o.order_date)
           , datepart(month, o.order_date)
)

select
    *
    , case
        -- Ở các value có thêm 'N' phía trước để biểu thị đây là chuỗi Unicode
        -- Lý do cần thêm là vì nếu không thêm thì SQL Server sẽ hiểu theo ASCII, thì mấy kí tự có dấu của Tiếng Việt sẽ không hiển thị được
        when acc_revenue < 10000 then N'Thấp'
        when acc_revenue < 20000 then N'Trung bình'
        when acc_revenue >= 20000 then N'Cao'
        else '' -- Chỗ này dùng 1 data invalid để sau nếu có lỗi trong model thì cũng dễ phát hiện hơn
    end as group_revenue
from aggr_data d

-- Này nhiều dòng quá nên mình skip phần kết quả nha