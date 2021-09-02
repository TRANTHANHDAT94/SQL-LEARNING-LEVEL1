-- Có 2 loai query 
-- DLL DataDefineLanguage
-- DML DataManiPulationLanguage
-- How to iport database to sever
-- 1. INSERT INTO 
-- 2. Dung tool of SSMS to import scv excel, access --> import/export wizad ssms
-- 3. Dung lecnh COPY -->copy file txt/csv into the database
-- 4. Dung SELECT INTO to mearge data into DATABASE
-- Table load into database
-- HOW TO Create a table saving the database information of SQ
-- INT PRIMARY KEY
CREATE TABLE sql_class(
    id INT PRIMARY KEY,
    name NVARCHAR(35),
    age int
)
select * from sql_class;
--Contrains(điều kiện ràng buộc)
--KEY:primary and foreign key 
--ConditionL UNIQUE KEY
--INDEXS: 
--PrimaryKey -> makesure unique inside table
--UniqueKey  -->Đảm bảo tối đa có 1 giá trị NULL
--Foreign Tham chiếu reference tới 1 column của 1 bảng khác primary key 

--3Nhóm relation giữa các bảng với nhau 
-- 1-1 record in table A having only one record in Table B
-- 1-many: 1 record in table A having many record in TableB
-- many-many: many recoard in table A and many recoard in table B


--BTVN
--Chọn ngành chọn CTy muốn apply 
--Project: di thu thâp data+phân tích đưa ra recommandation
-- Thực hành database riêng and thử import & tạo sẵn bảng and then input data to tables 
--SQL query is similar to the following:
--#SET TERMINATOR @ DATAVBASE
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE (IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
  LANGUAGE SQL
  	BEGIN 
	END@




--QUESTION 3
--SQL query is similar to the following:
--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE (IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
  LANGUAGE SQL
	BEGIN 
		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Score" = in_Leader_Score
			WHERE "School_ID" = in_School_ID;	
	END@

CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE (IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
  LANGUAGE SQL
  
	BEGIN 

		UPDATE CHICAGO_PUBLIC_SCHOOLS
		SET "Leaders_Score" = in_Leader_Score
			WHERE "School_ID" = in_School_ID;
			
		IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
	      	UPDATE CHICAGO_PUBLIC_SCHOOLS
				SET "Leaders_Icon" = 'Very Weak';
	    ELSEIF in_Leader_Score < 40 THEN
	       	UPDATE CHICAGO_PUBLIC_SCHOOLS
				SET "Leaders_Icon" = 'Weak';	
	    ELSEIF in_Leader_Score < 60 THEN
	       	UPDATE CHICAGO_PUBLIC_SCHOOLS
				SET "Leaders_Icon" = 'Average';
	    ELSEIF in_Leader_Score < 80 THEN
	       	UPDATE CHICAGO_PUBLIC_SCHOOLS
				SET "Leaders_Icon" = 'Strong';
	    ELSEIF in_Leader_Score < 100 THEN
	       	UPDATE CHICAGO_PUBLIC_SCHOOLS
				SET "Leaders_Icon" = 'Very Strong';
	   	END IF;
		
	END@