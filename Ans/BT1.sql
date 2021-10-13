CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;
GO

-- Tên 1 table sẽ gồm 3 thành phần, cách nhau bằng dấu chấm (.) : <Database>.<Schema>.<Tên Table>
-- Tên database thì mặc định là tên database mng đang connect đến (trong TH dùng SQL Client như SSMS, Azure DataStudio, Datagrip, Navicat ...) nên sẽ không cần input
-- Schema mặc định của SQL Server là dbo, nên ở tên bảng nếu mng ko chỉ định Schema thì SQL Server mặc định là dbo nha
-- Trong các DB khác thì thường nó là schema public

CREATE TABLE VATTU (
	MaVTu char(4) PRIMARY KEY,
	TenVTu nvarchar(100),
	DvTinh nvarchar(10),
	PhanTram int
);

CREATE TABLE NHACC (
	MaNhaCC char(3) PRIMARY KEY,
	TenNhaCC nvarchar(100),
	DiaChi nvarchar(200),
	DienThoai nvarchar(20)

)

-- Phần này thì MaNhaCC có chỉnh lại là Char(3) để giống với data type ở bảng NHACC nha
-- Nếu 1 bên Char(3) 1 bên Char(4) (khác length) thì nó sẽ bị lỗi á
CREATE TABLE DONDH (
	SoDH char(4) PRIMARY KEY,
	NgayDH datetime,
	MaNhaCC char(3),
	FOREIGN KEY (MaNhaCC) REFERENCES dbo.NHACC (MaNhaCC) ON DELETE CASCADE ON UPDATE CASCADE
)