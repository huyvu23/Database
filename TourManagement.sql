/*============================== CREATE DATABASE =======================================*/
/*============================== CREATE DATABASE =======================================*/
DROP DATABASE IF EXISTS TourManagement;
CREATE DATABASE TourManagement;
USE TourManagement;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/

DROP TABLE IF EXISTS GioiTinh;
CREATE TABLE GioiTinh (
	GioiTinhID          TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 	
    GioiTinh			ENUM('Male','Female') NOT NULL UNIQUE KEY
);


DROP TABLE IF EXISTS Khach;
CREATE TABLE Khach (
	MaKhachID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TenKhach			NVARCHAR(50) NOT NULL ,
    GioiTinhID 			TINYINT UNSIGNED NOT NULL,
    SoDienThoai			CHAR(11)  NOT NULL UNIQUE KEY ,
    DiaChi			    NVARCHAR(200) NOT NULL, 
    Email				VARCHAR(50) NOT NULL UNIQUE KEY,
    `Password`			VARCHAR(50) NOT NULL,
    FOREIGN KEY (GioiTinhID) REFERENCES GioiTinh (GioiTinhID)
);

 DROP TABLE IF EXISTS DiaDanh;
 CREATE TABLE DiaDanh (
    DiaDanhID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TenDiaDanh NVARCHAR(50) NOT NULL UNIQUE KEY
 );
 
DROP TABLE IF EXISTS Tour;
CREATE TABLE Tour(
	MaTourID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TenTour				NVARCHAR(50) NOT NULL  ,
	DiaDanhID			INT UNSIGNED NOT NULL,
    Gia				    INT UNSIGNED NOT NULL ,
    NgayBd				DATETIME NOT NULL,
	LichTrinh			NVARCHAR(50) NOT NULL,
    SoCho				TINYINT UNSIGNED NOT NULL,
    NoiDung				NVARCHAR(5000) NOT NULL,
    Anh					VARCHAR(500) ,
 	FOREIGN KEY (DiaDanhID) REFERENCES DiaDanh (DiaDanhID)
);



DROP TABLE IF EXISTS Khachsan;
CREATE TABLE Khachsan(
MaKsID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TenKs NVARCHAR(50) NOT NULL UNIQUE KEY,
DiaChiKs NVARCHAR(100) NOT NULL 
);



DROP TABLE IF EXISTS DatTour;
CREATE TABLE DatTour(
MaDatTourID	 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
MaTourID			TINYINT UNSIGNED ,
NgayDat 			DATETIME NOT NULL DEFAULT now(),
SoNguoi				TINYINT	UNSIGNED NOT NULL,
TrangThai			TINYINT DEFAULT 0 NOT NULL, -- 0: chua thanh toan , 1: da thanh toán
 FOREIGN KEY (MaTourID) REFERENCES Tour (MaTourID)
);

DROP TABLE IF EXISTS Ve;
CREATE TABLE Ve (
    MaVeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    MaDatTourID TINYINT UNSIGNED NOT NULL,
    MaKhachID TINYINT UNSIGNED NOT NULL,
FOREIGN KEY (MaDatTourID) REFERENCES DatTour (MaDatTourID),
FOREIGN KEY (MaKhachID) REFERENCES Khach (MaKhachID)
);

DROP TABLE IF EXISTS QuanLyAdmin;
CREATE TABLE QuanLyAdmin (
    AdminID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL UNIQUE KEY
);

INSERT INTO GioiTinh (GioiTinhID , GioiTinh )
vALUE				(1			, 'Male'	),
					(2			,'Female'	);

INSERT INTO Khach 	( TenKhach ,  GioiTinhID , SoDienThoai, DiaChi, `Email`, `Password`)
VALUE 				('TenKhach1' , '1', 		1234512351,'sdasdasd', 'Email1', 123456 ),
					('TenKhach2' , '1', 		1234512352,'sdasdasd', 'Email2', 123456 ),
					('TenKhach3' , '1', 		1234512353,'sdasdasd', 'Email3', 123456 );

INSERT INTO Khachsan ( `TenKs` , `DiaChiKs`)
VALUE 				('TenKs1' , 'DiaChiKs1'),
					('TenKs2' , 'DiaChiKs2'),
					('TenKs3' , 'DiaChiKs3');
                    
INSERT INTO DiaDanh ( `TenDiaDanh`)
VALUE 				('Hà Nội'),
					('Hồ Chí Minh'),
					('Hội An'),
					('Đà Nẵng'),
					('Đà Lạt'),
					('Sapa');

INSERT INTO QuanLyAdmin ( `UserName`)
VALUE 				('UserName1'),
					('UserName2'),
					('UserName3');								

INSERT INTO Tour 	( `TenTour` , `DiaDanhID`, `Gia`, 	`NgayBd`, 	`LichTrinh`,  `SoCho`,  `NoiDung`, `Anh`)
		VALUE 		('tour Hà Nội' , 1, 		1000000,'2022/02/22', '3 ngày 2 dêm',  30, 'tour du lịch 3 ngày 2 đêm tại Hà Lội',"https://dulichviet.com.vn/images/bandidau/NOI-DIA/Ha-Noi/du-lich-cat-ba-dip-le-30-4-gia-tot-du-lich-viet.jpg"),
					('tour Đà Lạt' , 2, 		2000000,'2022/02/12', '3 ngày 2 dêm',  30, 'tour du lịch 3 ngày 2 đêm tại Đà Lạt',"https://dulichviet.com.vn/images/bandidau/NOI-DIA/Ha-Noi/du-lich-quan-lan-dip-le-30-4-du-lich-viet(1).jpg"),
					('tour Sapa' , 	 3, 		3000000,'2022/02/02', '3 ngày 2 dêm',  30, 'tour du lịch 3 ngày 2 đêm tại Sapa',"https://dulichviet.com.vn/images/bandidau/NOI-DIA/Ha-Noi/du-lich-quan-lan-dip-le-30-4-tu-ha-noi-du-lich-viet.jpg");
                    
INSERT INTO DatTour 	( MaTourID , 		NgayDat, 		SoNguoi, 	TrangThai)
		VALUE 			(1, 					DEFAULT,	'5', 			0),
						(2, 					DEFAULT,	'5', 			0),
						(3, 					DEFAULT,	'5', 			0);

INSERT INTO Ve 	( `MaDatTourID` , `MaKhachID`)
		VALUE 	(1				, 			1),
				(2				, 			1),
				(3 	    		,			2);


