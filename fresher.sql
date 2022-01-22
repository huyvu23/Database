DROP DATABASE IF EXISTS manage_fresher;
CREATE DATABASE manage_fresher;
USE manage_fresher;

CREATE TABLE Trainee (
	TraineeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Full_Name 			NVARCHAR(50) NOT NULL,
    Birth_Date 			DATE NOT NULL,
    Gender 				ENUM('MALE', 'FEMALE', 'UNKNOWN') NOT NULL,
    ET_IQ 				TINYINT UNSIGNED NOT NULL CHECK (ET_IQ <= 20),
    ET_Gmath 			TINYINT UNSIGNED NOT NULL CHECK (ET_Gmath <= 20),
    ET_English 			TINYINT UNSIGNED NOT NULL CHECK (ET_English <= 50),
    Training_Class 		CHAR(6) NOT NULL,
    Evaluation_Notes 	NVARCHAR(50) NOT NULL

);

INSERT INTO `Trainee`(Full_Name		, Birth_Date, 		Gender, 	ET_IQ	, 	ET_Gmath, 	ET_English,		Training_Class, 	Evaluation_Notes )
VALUES 				('FullName1'	, '1995-01-01',		'MALE',		20,		   15,				35,			'VTI001',				'HVBCVT'),
					('FullName2'	, '1995-03-05',		'MALE',		10,		   20,				19,			'VTI003',				'DHQGHN'),
					('FullName3'	, '1993-02-25',		'MALE',		15,		   15,				10,			'VTI002',				'HVBCVT'),
					('NguyenVanA'	, '1993-08-10',		'MALE',		20,		   20,				40,			'VTI002',				'DHBKHN'),
					('FullName5'	, '1988-04-11',		'MALE',		12,		   20,				20,			'VTI001',				'DHBKHN'),
					('FullName6'	, '1988-04-25',		'FEMALE',	15,		   15,				10,			'VTI001',				'DHBKHN'),
					('FullName7'	, '1988-02-10',		'FEMALE',	20,		   12,				22,			'VTI003',				'DHQGHN'),
					('fffffffffC'	, '1995-04-25',		'MALE',		10,		   10,				30,			'VTI003',				'DHBKHN'),
					('FullName9'	, '1988-04-25',		'MALE',		2,		   2,				25,			'VTI003',				'DHBKHN'),
					('NguyenVanAB'	, '1995-12-25',		'MALE',		15,		   20,				30,			'VTI002',				'HVBCVT'),
					('FullName11'	, '1993-12-28',		'MALE',		9,		   15,				12,			'VTI001',				'HVBCVT'),
					('FullName12'	, '1988-12-26',		'UNKNOWN',	8,		   2,				10,			'VTI002',				'DHQGHN'),
					('NguyenVanABC'	, '1988-01-11',		'MALE',		9,		   1,				20,			'VTI003',				'DHBKHN');
                    
-- Question 3: Insert 1 bản ghi mà có điểm ET_IQ =30. Sau đó xem kết quả.
 INSERT INTO `Trainee`	(Full_Name		, Birth_Date, 		Gender, 	ET_IQ	, 	ET_Gmath, 	ET_English,		Training_Class, 	Evaluation_Notes )
 VALUES					('huyvu'		,'2002-06-23'			,'MALE',		30,		   15,				35,			'VTI001',				'HVBCVT');
 
 -- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,
-- và sắp xếp theo ngày sinh. Điểm ET_IQ >=12, ET_Gmath>=12, ET_English>=20
SELECT *
FROM `Trainee`
WHERE ET_IQ >= 12 AND ET_Gmath >= 12 AND ET_English >= 20;

-- Question 5: Viết lệnh để lấy ra thông tin thực tập sinh có tên bắt đầu bằng chữ N và kết thúc bằng chữ C
SELECT Full_Name	
FROM `Trainee`
WHERE Full_Name LIKE 'N%C';
-- Question 6: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có ký thự thứ 2 là chữ G
SELECT Full_Name	
FROM `Trainee`
WHERE Full_Name LIKE 'G%';

-- Question 7: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có 10 ký tự và ký tự cuối cùng là C
SELECT Full_Name	
FROM `Trainee`
WHERE length(Full_Name)= 10 AND Full_Name LIKE '%C';

-- Question 8: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, lọc bỏ các tên trùng nhau.
SELECT DISTINCT Full_Name
FROM `Trainee`;

-- Question 9: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, sắp xếp các tên này theo thứ tự từ A-Z.
SELECT Full_Name
FROM `Trainee`
ORDER BY Full_Name ASC;

-- Question 10: Viết lệnh để lấy ra thông tin thực tập sinh có tên dài nhất
SELECT tr.Full_Name
FROM `Trainee` tr
WHERE length(tr.Full_Name) = (SELECT max(length(t.Full_Name)) FROM `Trainee` t);

-- Question 11: Viết lệnh để lấy ra ID, Fullname và Ngày sinh thực tập sinh có tên dài nhất
SELECT tr.TraineeID,tr.Full_Name,tr.Birth_Date
FROM `Trainee` tr
WHERE length(tr.Full_Name) = (SELECT max(length(t.Full_Name)) FROM `Trainee` t);

-- Question 12: Viết lệnh để lấy ra Tên, và điểm IQ, Gmath, English thực tập sinh có tên dài nhất
SELECT tr.Full_Name, tr.ET_IQ, tr.ET_Gmath,tr.ET_English
FROM `Trainee` tr
WHERE length(tr.Full_Name) = (SELECT max(length(t.Full_Name)) FROM `Trainee` t);

-- Question 13 Lấy ra 5 thực tập sinh có tuổi nhỏ nhất
SELECT tr.Full_Name, tr.Birth_Date
FROM `Trainee` tr
ORDER BY Birth_Date DESC
LIMIT 5;

-- Question 14: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là
-- những người thỏa mãn số điểm như sau:
-- ET_IQ + ET_Gmath>=20
-- ET_IQ>=8
-- ET_Gmath>=8
-- ET_English>=18
SELECT *
FROM `Trainee` tr
WHERE (ET_IQ + ET_Gmath>=20)  AND ET_IQ>=8 AND ET_Gmath>=8 AND ET_English>=18;

-- Question 15: Xóa thực tập sinh có TraineeID = 5
DELETE FROM `Trainee`
WHERE TraineeID = 5;

-- Question 16: Xóa thực tập sinh có tổng điểm ET_IQ, ET_Gmath <=15
DELETE FROM `Trainee`
WHERE ET_IQ + ET_Gmath <= 15;

-- Question 17: Xóa thực tập sinh quá 30 tuổi.
DELETE FROM `Trainee`
WHERE Birth_Date >= '1991-01-01';

-- Question 18: Thực tập sinh có TraineeID = 3 được chuyển sang lớp " VTI003". Hãy cập nhật
-- thông tin vào database.
UPDATE `Trainee` tr
SET Training_Class = 'VTI003'
WHERE tr.TraineeID = 3 ;

-- Question 19: Do có sự nhầm lẫn khi nhập liệu nên thông tin của học sinh số 10 đang bị sai, hãy cập nhật lại tên thành “LeVanA”, điểm ET_IQ =10, điểm ET_Gmath =15, điểm ET_English = 30.
UPDATE `Trainee` tr
SET Full_Name = 'LeVanA' AND ET_IQ =10 AND ET_Gmath =15 AND ET_English = 30
WHERE tr.TraineeID = 10;

-- Question 20: Đếm xem trong lớp VTI001  có bao nhiêu thực tập sinh
SELECT COUNT(tr.TraineeID)
FROM `Trainee` tr
WHERE Training_Class = 'VTI001';

-- Question 22: Đếm tổng số thực tập sinh trong lớp VTI001 và VTI003 có bao nhiêu thực tập sinh.
SELECT COUNT(tr.TraineeID) AS SL
FROM `Trainee` tr
WHERE Training_Class = 'VTI001' + 'VTI003' ;

-- Question 23: Lấy ra số lượng các thực tập sinh theo giới tính: Male, Female, Unknown
SELECT COUNT(tr.TraineeID) AS SL,tr.Gender
FROM `Trainee` tr
GROUP BY Gender;

-- Question 24: Lấy ra lớp có lớn hơn 5 thực tập viên
SELECT COUNT(tr.TraineeID),tr.Training_Class
FROM `Trainee` tr
WHERE tr.TraineeID > 5;

-- Question 26: Lấy ra trường có ít hơn 4 thực tập viên tham gia khóa học
SELECT COUNT(tr.TraineeID) AS SL,tr.Training_Class
FROM `Trainee` tr
WHERE tr.TraineeID  < 4;

-- Question 27: Bước 1: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI001'
SELECT tr.TraineeID,tr.Full_Name
FROM `Trainee` tr
WHERE Training_Class = 'VTI001'










                    

