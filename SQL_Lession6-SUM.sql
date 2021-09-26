use Lession1SUM;
select * from sales.orders;
-- Thống kê số lượng đơn hàng theo order_status 
select * 
from (
    order
    select * from sales.orders
) as pivot_data 
pivot(
    count(order_id)
    ,count(customer_id)
    for order_id in 
)