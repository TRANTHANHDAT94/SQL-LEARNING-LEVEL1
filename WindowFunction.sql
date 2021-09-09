-- Là 1 số function apply lên rules nào đó 
drop table tmp;
select * from sales.orders;
create table tmp (
    week_num int,
    date date,
    profit int
);
insert into tmp s
values
(37, '2021-09-08', 10)
, (37, '2021-09-09', 15)
, (37, '2021-09-10', 20)
, (37, '2021-09-11', 25)
, (38, '2021-09-12', 30)
, (38, '2021-09-13', 35)
, (38, '2021-09-14', 40)
, (38, '2021-09-15', 45)
, (38, '2021-09-16', 50)
, (38, '2021-09-17', 55)
, (38, '2021-09-18', 60)
, (39, '2021-09-19', 65);

select * from tmp;


-- Tính acccurmulated profit 










-- Question: ãy tìm các đơn hàng có số lượng product cao nhất từ cao đến thấp và xếp hạng 5 - 10
with data as (
    select
        order_id,
        sum(quantity) as no_products
    from sales.order_items
    group by order_id
)
, tmp as (
    
    select
        order_id,
        ROW_NUMBER() over(order by no_products desc) as row_num,
        rank() over(order by no_products desc) as rank,
        DENSE_RANK() over(order by no_products desc) as dense_rank
    from data
)

select *
from tmp
where dense_rank between 5 and 10
-- Hãy tính % phân bổ revenue theo từng product, brand, store, staff


