SELECT LEN('MAGIC  CODE INSTITUTE') ASchar_length
SELECT CHARINDEX('M',  'MAGIC  CODE INSTITUTE')  AS char_index
SELECT LTRIM('  MCI') AS Left_Trimmed
SELECT RTRIM('MCI  ') AS Right_Trimmed

-- Trảvềvịtrícủamộtmẫutrong mộtchuỗiPATINDEX(%pattern%, string)
SELECT PATINDEX('%D%',  'MAGIC  CODE INSTITUTE')
--Return an index 

-- REVERSE()ĐảongượcchuỗiREVERSE(string)
SELECT REVERSE('MCI')

-- TríchxuấtmộtsốkýtựtừmộtchuỗiSUBSTRING(string, start,length)
SELECT SUBSTRING('MAGIC  CODE INSTITUTE',  1, 5) AS extract_string
--FROM rannge

-- LOWER()ChuyểnđổichuỗithànhchữthườngLOWER(string)
SELECT LOWER('MAGIC CODE INSTITUTE  ')
SELECT UPPER('magic andc ')

------------------------------------------------------------------------------------------------------------
--SchoolToLearnAndPractices
--https://www.hackerrank.com/
--https://www.sqlshack.com/t-sql-regex-commands-in-sql-server/ 
--TIMEFUCTION
select * from sales.staffs
where staff_id in (1,2,3,4,5);
SELECT CURRENT_TIMESTAMP 

SELECT CURRENT_TIMEZONE();  
select getdate() at time zone 'North Asia Standard Time';

-- https://docs.microsoft.com/en-us/sql/t-sql/language-reference?view=sql-server-ver15

SELECT * FROM sys.time_zone_info
WHERE name LIKE '%Asia%';
------------------------------------------------------------------------------------------------------------
--MệnhđềCase When
select
company.company_code,
company.founder,

count (distinct lead_manager.lead_manager_code) as total_leader_manager,
count (distinct senior_manager.senior_manager_code) as total_senior_manager,
count (distinct manager.manager_code) as total_manager,
count (distinct employee.employee_code) as total_employee

from company
join lead_manager on company.company_code = lead_manager.company_code
join senior_manager on lead_manager.lead_manager_code = senior_manager.lead_manager_code
join manager on senior_manager.senior_manager_code = manager.senior_manager_code
join employee on manager.manager_code = employee.manager_code

order by company_code asc