with data as (
    select 
        o.customer_id,
        max(o.order_date) as last_order_date,
        datediff("D",max(o.order_date), 2018-12-31') as recency,
        sum(o.list_price+)
)

