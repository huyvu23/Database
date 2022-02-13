/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS Tourmanagement;
CREATE DATABASE Tourmanagement;
USE Tourmanagement;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/
DROP TABLE IF EXISTS Khach;
CREATE TABLE Khach (
	MaKhachID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TenKhach			NVARCHAR(50) NOT NULL UNIQUE KEY,
    GioiTinh			ENUM('Male','Female') NOT NULL,
    SoDienThoai			TINYINT UNSIGNED NOT NULL CHECK (length(SoDienThoai) =11),
    DiaChi			    NVARCHAR(200) NOT NULL, 
    Email				VARCHAR(50) NOT NULL UNIQUE KEY,
    `Password`			VARCHAR(50) NOT NULL
    
);
DROP TABLE IF EXISTS Khachsan;
CREATE TABLE Khachsan(
MaKsID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TenKs NVARCHAR(50) NOT NULL UNIQUE KEY,
DiaChiKs NVARCHAR(100) NOT NULL 
);
DROP TABLE IF EXISTS DiaDanh;
CREATE TABLE DiaDanh (
    DiaDanhID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TenDiaDanh NVARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS QuanLyAdmin;
CREATE TABLE QuanLyAdmin (
    AdminID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL UNIQUE KEY
);
-- create table  TOUR
DROP TABLE IF EXISTS Tour;
CREATE TABLE Tour(
	MaTourID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TenTour				NVARCHAR(50) NOT NULL  ,
    DiaDanhID				INT UNSIGNED NOT NULL,
    Gia				    INT UNSIGNED NOT NULL ,
    NgayBd				DATETIME NOT NULL,
    NgayKt 				DATETIME NOT NULL,
	SoNgay				TINYINT UNSIGNED NOT NULL,
    SoCho				TINYINT UNSIGNED NOT NULL,
    NoiDung				NVARCHAR(5000) NOT NULL,  
    -- HinhAnh				VARCHAR(500) NOT NULL  
     FOREIGN KEY (DiaDanhID) REFERENCES DiaDanh (DiaDanhID)
);
DROP TABLE IF EXISTS DatTour;
CREATE TABLE DatTour(
MaDatTourID	 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
MaTourID			TINYINT UNSIGNED ,
NgayDat 			DATETIME NOT NULL DEFAULT now(),
SoNguoi				TINYINT	UNSIGNED NOT NULL,
TrangThai			TINYINT DEFAULT 0 NOT NULL -- 0: chua thanh toan 1: da thanh t
);

DROP TABLE IF EXISTS Ve;
CREATE TABLE Ve (
    MaVeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    MaDatTourID TINYINT UNSIGNED NOT NULL,
    MaKhachID TINYINT UNSIGNED NOT NULL
    /*,FOREIGN KEY (MaDatTour) REFERENCES DatTour (MaDatTour)*/
   /*,FOREIGN KEY (MaKhach) REFERENCES Khach (MaKhach)*/
);

INSERT INTO DiaDanh ( `TenDiaDanh`)
VALUES				('Hà Nội'),
					('Hồ Chí Minh'),
					('Hội An'),
					('Đà Nẵng'),
					('Đà Lạt'),
					('Sapa');



INSERT INTO Tour ( `TenTour` , `DiaDanhID`, `Gia`, `NgayBd`, `NgayKt`, `SoNgay`, `SoCho`,  `NoiDung`)
VALUES 			('tour Hà Nội' , 1, 1000000,'2022/02/22', '2022/02/25', 3, 30, 'tour du lịch 3 ngày 2 đêm tại Hà Lội'),
				('tour Đà Lạt' , 5, 2000000,'2022/02/12', '2022/02/15', 3, 30, 'tour du lịch 3 ngày 2 đêm tại Đà Lạt'),
				('tour Sapa' , 6, 3000000,'2022/02/02', '2022/02/05', 3, 30, 'tour du lịch 3 ngày 2 đêm tại Sapa');


