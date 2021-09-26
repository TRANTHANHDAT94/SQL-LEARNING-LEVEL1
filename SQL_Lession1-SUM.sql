-- create database Lession1SUM;
-- use Lession1SUM;
-- drop schema production;
-- drop schema sales; 
-- CREATE SCHEMA production;
-- CREATE SCHEMA sales;
use Lession1SUM;
select * from sales.orders;
select * from Lession1SUM.sales.customers;
--DATABASE.SCHEMA.CUSTOMERS(database.schema.table)
select * from sales.orders where order_status = 4;

select * from sales.customers;

with t as (
    select 
        1 as "TranThanh",
        2 as "DAT"
)

create table sql_class(
    id INT PRIMARY KEY,
    name NVARCHAR (35),
    age int
);

select * from sql_class;





------------------------------------------------------------------------
-- Có 2 loại QUERY
--DDL: Data Defination Language: create, drop,...
--DML" SUM, AVG, COUNT....
------------------------------------------------------------------------
-- CÓ 4 cách import data to database 
-- 1: INSERT INTO 
-- 2: import từ api 
-- 3: COPY
-- 4: SELECT INTO 
--VIDU:
create table sqlclass(
    id INT PRIMARY KEY, --id có PRIMARY key
    name NVARCHAR(35),  -- name has maximum length is 35 and nvarchar 
    age INT             -- age has int type 
)
select * from sqlclass;

---------------------------------------------------------------------------------------------
-- Contrains in SQL 
-- KEY: primirykey o foreginKEY
-- DieuKien: Unique KEY?
-- Indexes 

--PRIMARY dam bao cho 1 records laf unique trong bang  & cột đó không có giá trị NULL
--UNIQUEKEY dam bao moi record la duy nhay trong bang & cot đó có tối đa 1 giá trị NULL
--FOREIGNKEY tham chiếu tới 1 columns của 1 bảng khác (primarykey)
-- Mối quan hệ giữa các databses là RDMS (khóa chính tạo lên RDMS)
-- 3RDMS
-- 1: 1-1 recoard bảng A có duy nhất 1 record ở bảng B
--2: 1-nhiều-> Record bảng A có nhiều record bảng B 
--:3 nhiều-nhiều-> Nhiều record ở bảng A có có nhiều record ở bảng B
-- LINK: https://elemental-gull-b19.notion.site/ERD-diagram-851761e7dd5c4e25b2381417f1758a4b
-- TOOL: https://dbdiagram.io/d
select * 
from sales.stores;

select *
from production.stocks;

