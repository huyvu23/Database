DROP DATABASE IF EXISTS Database_Facebook_management;
CREATE DATABASE Database_Facebook_management;
USE Database_Facebook_management;
 
CREATE TABLE `National`(
	National_id  TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	National_Name NVARCHAR(100) UNIQUE KEY,
	Language_Main VARCHAR (50)
);




CREATE TABLE Office (
	Office_id SMALLINT UNSIGNED PRIMARY KEY,
	Street_Address VARCHAR(100),
	National_id TINYINT UNSIGNED UNIQUE KEY,
	
    FOREIGN KEY (National_id) REFERENCES `National`(National_id)
);


CREATE TABLE Staff (
	Staff_id MEDIUMINT UNSIGNED PRIMARY KEY  AUTO_INCREMENT ,
	full_Name NVARCHAR(100),
	Email VARCHAR(100) UNIQUE KEY,
	Office_id SMALLINT UNSIGNED,

	CONSTRAINT fk_staff_office FOREIGN KEY (Office_id) REFERENCES Office (Office_id) 
);


 /*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/

INSERT INTO `National` 		(National_id,			National_Name, 					Language_Main)
VALUES 						(1,						'MỸ',							'ENGLISH'	),
							(2,						'PHÁP',							'ENGLISH'	),
                            (3,						'BỈ',							'ENGLISH'	),
                            (4,						'ANH',							'ENGLISH'	),
                            (5,						'ĐỨC',							'ENGLISH'	),
                            (6,						'BỒ ĐÀO NHA',					'ENGLISH'	),
                            (7,						'THỤY SĨ',						'ENGLISH'	),
                            (8,						'THỤY ĐIỂN',					'ENGLISH'	),
                            (9,						'Ý',							'ENGLISH'	),
                            (10,					'Vietnam',						'viet'		);
                            
                            
INSERT INTO Office 			(Office_id,				Street_Address,						National_id)
VALUES						(1,						'abc'					,				1			),
							(2,						'xyz'					,				2			),
                            (3,						'vbn'					,				3			),
                            (4,						'qưe'					,				4			),
                            (5,						'poi'					,				5			),
                            (6,						'dfg23'					,				6			),
                            (7,						'cdsfg98'				,				7			),
                            (8,						'khongbiet'				,				8			),
                            (9,						'taochiu'				,				9			),
                            (10,						'abc'				,				10			);
                            
INSERT INTO Staff			(Staff_id,				full_Name,							Email,									Office_id)
VALUES						(1,					'Nguyễn hải Đăng',					'haidang29productions@gmail.com',			1	),
							(2,					'Nguyen Chien Thang2',				'account1@gmail.com',						2	),
                            (3,					'Nguyen Van Chien',					'account2@gmail.com',						3	),
                            (4,					'Duong Do',							'account3@gmail.com',						3	),
                            (5,					'Nguyen Chien Thang1',				'account4@gmail.com',						5	),
                            (6,					'Ngo Ba Kha',						'dapphatchetngay@gmail.com',				6	),
                            (7,					'Bui Xuan Huan'	,					'songcodaoly@gmail.com',					7	),
                            (8,					'Nguyen Thanh Tung',				'sontungmtp@gmail.com'	,					8	),
                            (9,					'Duong Van Huu',					'duongghuu@gmail.com',						9	),
                            (10,					'Vi Ti Ai'	,						'daonq@viettel.com.vn',					10	);
                            
                            
                            
-- Ques3: Bạn hãy lấy dữ liệu của tất cả nhân viên đang làm việc tại Vietnam.
SELECT *
FROM Office o
INNER JOIN  `National` n USING (National_id)
INNER JOIN  Staff s USING (Office_id)
WHERE n.National_Name = 'Vietnam';    

-- Ques4: Lấy ra ID, FullName, Email, National của mỗi nhân viên.
SELECT s.Staff_id,s.full_Name,s.Email,o.National_id,n.National_Name
FROM Office o 
INNER JOIN `National` n USING (National_id)
INNER JOIN Staff s USING (Office_id)
ORDER BY s.Staff_id ASC;

-- Ques5: Lấy ra tên nước mà nhân viên có Email: "daonq@viettel.com.vn" đang làm việc.
SELECT s.Staff_id,s.Email,o.National_id,n.National_Name
FROM Office o
JOIN `National` n USING (National_id)
JOIN Staff s USING (Office_id)
WHERE s.Email = 'daonq@viettel.com.vn';

-- Ques6: Bạn hãy tìm xem trên hệ thống có quốc gia nào có thông tin trên hệ thống nhưng 
-- không có nhân viên nào đang làm việc.
WITH CTE_country_already_Staff AS (
SELECT o.National_id
FROM Office o 
INNER JOIN (SELECT s.Office_id FROM Staff s) t USING (Office_id)
)

SELECT *
FROM CTE_country_already_Staff c 
RIGHT JOIN `National` USING (National_id)
WHERE c.National_id IS NULL;

-- Ques7: Thống kê xem trên thế giới có bao nhiêu quốc gia mà FB đang hoạt động sử dụng tiếng Anh làm ngôn ngữ chính.
SELECT COUNT(National_Name)
FROM `National` 
WHERE Language_Main = 'ENGLISH';

-- Ques8: Viết lệnh để lấy ra thông tin nhân viên có tên (First_Name) có 10 ký tự, bắt đầu bằng 
-- chữ N và kết thúc bằng chữ C.
SELECT full_Name
FROM Staff
WHERE full_Name LIKE 'V%i';

-- Ques9: Bạn hãy tìm trên hệ thống xem có nhân viên nào đang làm việc nhưng do nhập khi 
-- nhập liệu bị lỗi mà nhân viên đó vẫn chưa cho thông tin về trụ sở làm việc(Office).
SELECT * 
FROM staff s 
WHERE s.Office_id IS NULL;

-- Ques10: Nhân viên có mã ID =10 hiện tại đã nghỉ việc, bạn hãy xóa thông tin của nhân viên 
-- này trên hệ thống.

DELETE FROM Staff
WHERE Staff_id = 10;

-- Ques11: FB vì 1 lý do nào đó không còn muốn hoạt động tại Australia nữa, và Mark 
-- Zuckerberg muốn bạn xóa tất cả các thông tin trên hệ thống liên quan đến quốc gia này. Hãy 
-- tạo 1 Procedure có đầu vào là tên quốc gia cần xóa thông tin để làm việc này và gửi lại cho anh ấy.

DROP PROCEDURE IF EXISTS SP_DelNation;
DELIMITER $$
CREATE PROCEDURE SP_DelNation(IN natonal_name VARCHAR(100))
BEGIN
DECLARE v_nation_id TINYINT;
 SELECT n.National_id INTO v_nation_id 
 FROM `national` n 
 WHERE n.National_Name = natonal_name;
 DELETE FROM staff s 
 WHERE s.Office_id IN (SELECT o.Office_id FROM office o WHERE o.National_id = v_nation_id);
 DELETE FROM office o 
 WHERE o.National_id = v_nation_id;
 DELETE FROM `national` n 
 WHERE n.National_id = v_nation_id;
END $$
CALL SP_DelNation('');

-- Ques12: Mark muốn biết xem hiện tại đang có bao nhiêu nhân viên trên toàn thế giới đang
-- làm việc cho anh ấy, hãy viết cho anh ấy 1 Function để a ấy có thể lấy dữ liệu này 1 cách 
-- nhanh chóng.
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS count_staff;
DELIMITER $$
CREATE FUNCTION count_staff () 
RETURNS MEDIUMINT UNSIGNED
BEGIN
	DECLARE sum MEDIUMINT;
	SELECT COUNT(1) into sum
    FROM staff;
    RETURN sum;

END $$
SELECT count_staff () as sum;

-- Ques13: Để thuận tiện cho việc quản trị Mark muốn số lượng nhân viên tại mỗi quốc gia chỉ
-- tối đa 10.000 người. Bạn hãy tạo trigger cho table Staff chỉ cho phép insert mỗi quốc gia có 
-- tối đa 10.000 nhân viên giúp anh ấy (có thể cấu hình số lượng nhân viên nhỏ hơn vd 11 nhân viên để Test).

DROP TRIGGER IF EXISTS check_count_staff;
DELIMITER $$
CREATE TRIGGER check_count_staff
BEFORE INSERT ON Staff
FOR EACH ROW 

BEGIN
	DECLARE SL_Staff_id TINYINT;
	SELECT COUNT(Staff_id)  INTO SL_Staff_id
    FROM	Staff ;
	IF SL_Staff_id >= 9 THEN
		SIGNAL SQLSTATE '23456'
		SET MESSAGE_TEXT = 'KHONG THE INSERT THEM';
    END IF ;
END $$
DELIMITER ;

INSERT INTO Staff (Staff_id)
VALUES 				(16);

-- Ques14: Bạn hãy viết 1 Procedure để lấy ra tên trụ sở mà có số lượng nhân viên đang làm việc nhiều nhất.
DROP PROCEDURE IF EXISTS quantiny_staff;
DELIMITER $$
CREATE PROCEDURE quantiny_staff ()
BEGIN
	WITH CTE_count_max_staff AS (
    SELECT s.Office_id,count(s.Staff_id) AS soluong
    FROM `Staff` s 
    GROUP BY s.Office_id
    )
    SELECT o.Office_id,o.Street_Address,o.National_id,count(s.Staff_id) AS soluong
    FROM `Staff` s 
    INNER JOIN `Office` o USING (Office_id)
    GROUP BY s.Office_id
    HAVING count(Staff_id) = (SELECT MAX(soluong )FROM CTE_count_max_staff);
     
      

END $$
DELIMITER ;

CALL quantiny_staff ();

-- Ques15: Bạn hãy viết 1 Function để khi nhập vào thông tin Email của nhân viên thì sẽ trả ra 
-- thông tin đầy đủ của nhân viên đó.
DROP FUNCTION IF EXISTS in_email_out_information;
DELIMITER $$
CREATE FUNCTION in_email_out_information ( in_email VARCHAR(100))
RETURNS VARCHAR(100)
BEGIN
	DECLARE v_full_Name VARCHAR(100);
    SELECT full_Name INTO v_full_Name
    FROM `Staff`  s
    WHERE s.Email = in_email;
    RETURN v_full_Name;
END $$
DELIMITER ;

SELECT in_email_out_information ('haidang29productions@gmail.com') ;

-- Ques16: Bạn hãy viết 1 Trigger để khi thực hiện cập nhật thông tin về trụ sở làm việc của 
-- nhân viên đó thì hệ thống sẽ tự động lưu lại trụ sở cũ của nhân viên vào 1 bảng khác có tên 
-- Log_Office để Mark có thể xem lại khi cần thiết.

DROP TABLE IF EXISTS Log_Office;
CREATE TABLE Log_Office (
Office_id SMALLINT UNSIGNED ,
Street_Address VARCHAR(100),
National_id TINYINT UNSIGNED,
ChangeDate DATETIME
);

DROP TRIGGER IF EXISTS update_office;
DELIMITER $$
CREATE TRIGGER update_office
AFTER UPDATE ON Office
FOR EACH ROW
BEGIN
	INSERT INTO Log_Office			(Office_id,				Street_Address,				National_id,		ChangeDate		)
	VALUES							(OLD.Office_id,			OLD.Street_Address ,	OLD.National_id,		now()			);
END $$
DELIMITER ;

-- Ques17: FB đang vướng vào 1 đạo luật hạn chế hoạt động, FB chỉ có thể hoạt động tối đa 
-- trên 100 quốc gia trên thế giới, hãy tạo Trigger để ngăn người nhập liệu nhập vào quốc gia 
-- thứ 101 (bạn có thể sử dụng số nước nhỏ hơn để Test VD 11 nước).

DROP TRIGGER IF EXISTS before_insert_national;
DELIMITER $$
CREATE TRIGGER before_insert_national
BEFORE INSERT ON `National`
FOR EACH ROW
BEGIN
	DECLARE v_countNationalid TINYINT UNSIGNED;
    SELECT COUNT(National_id) INTO v_countNationalid
    FROM `National`;
    
    IF v_countNationalid >= 10 THEN
		SIGNAL SQLSTATE '45698'
		SET MESSAGE_TEXT = 'KHONG THE INSERT THEM';
	END IF ;

END $$
DELIMITER ;

INSERT INTO `National` 		(National_id,			National_Name, 					Language_Main)
VALUES						(11         ,			'IRAQ',								'ENGLISH');

-- Ques18: Thống kê mỗi xem mỗi nước(National) đang có bao nhiêu nhân viên đang làm việc.
SELECT count(s.Staff_id) as SL,n.National_Name,o.Street_Address
FROM Office o
INNER JOIN `National` n USING (National_id)
INNER JOIN Staff s USING (Office_id)
GROUP BY Office_id;

-- Ques19: Viết Procedure để thống kê mỗi xem mỗi nước(National) đang có bao nhiêu nhân 
-- viên đang làm việc, với đầu vào là tên nước.
DROP PROCEDURE IF EXISTS count_staff_of_National;
DELIMITER $$
CREATE PROCEDURE count_staff_of_National (IN in_national_name NVARCHAR(100))
BEGIN
	
	SELECT count(s.Staff_id) AS SL
	FROM Office o
	INNER JOIN `National` n USING (National_id)
	INNER JOIN Staff s USING (Office_id)
    WHERE n.National_Name = in_national_name 
    GROUP BY Office_id;
	
END $$
DELIMITER ;

CALL count_staff_of_National('THỤY ĐIỂN');

-- Ques20: Thống kê mỗi xem trong cùng 1 trụ sở (Office) đang có bao nhiêu employee đang làm việc.
SELECT o.Street_Address,count(s.Staff_id) as SL
FROM Office o
INNER JOIN Staff s USING (Office_id)
GROUP BY Office_id;

-- Ques21: Viết Procedure để thống kê mỗi xem trong cùng 1 trụ sở (Office) đang có bao nhiêu 
-- employee đang làm việc đầu vào là ID của trụ sở.
DROP PROCEDURE IF EXISTS count_staff_of_office;
DELIMITER $$
CREATE PROCEDURE count_staff_of_office (IN in_Office_id SMALLINT UNSIGNED )
BEGIN
	SELECT count(s.Staff_id) AS SL,o.Street_Address, o.Office_id
	FROM Staff s
	INNER JOIN  Office o USING (Office_id)
    WHERE Office_id = in_Office_id;
 
END $$
DELIMITER ;

CALL count_staff_of_office(5);

-- Ques22: Viết Procedure để lấy ra tên quốc gia đang có nhiều nhân viên nhất.
DROP PROCEDURE IF EXISTS count_staff_of_national;
DELIMITER $$
CREATE PROCEDURE count_staff_of_national()
BEGIN
	SELECT n.National_Name,o.Street_Address,COUNT(s.Staff_id) AS SL
    FROM Office o 
	INNER JOIN `National` n USING (National_id)
	INNER JOIN Staff s USING (Office_id)
    GROUP BY s.Office_id
    HAVING COUNT(s.Staff_id) = (SELECT MAX(SL)FROM (SELECT count(s.Staff_id) AS SL
													FROM Staff s
                                                    GROUP BY s.Office_id) AS temp);
END $$
DELIMITER ;
CALL count_staff_of_national();

-- Ques23: Thống kê mỗi country có bao nhiêu employee đang làm việc.
DROP PROCEDURE IF EXISTS count_staff_of_country;
DELIMITER $$
CREATE PROCEDURE count_staff_of_country()
BEGIN
	SELECT n.National_Name,o.Street_Address,COUNT(s.Staff_id) AS SL
    FROM Office o 
	INNER JOIN `National` n USING (National_id)
	INNER JOIN Staff s USING (Office_id)
    GROUP BY s.Office_id;
END $$
DELIMITER ;
CALL count_staff_of_country();

-- Ques24: Bạn hãy cấu hình lại các bảng và ràng buộc giữ liệu sao cho khi xóa 1 trụ sở làm 
-- việc (Office) thì tất cả dữ liệu liên quan đến trụ sở này sẽ chuyển về Null
ALTER TABLE Staff DROP FOREIGN KEY fk_staff_office;
ALTER TABLE Staff MODIFY COLUMN Office_id SMALLINT UNSIGNED;
ALTER TABLE Staff ADD CONSTRAINT fk_staff_office FOREIGN KEY (Office_id) REFERENCES Office (Office_id) ON DELETE SET NULL;

-- Ques25: Bạn hãy cấu hình lại các bảng và ràng buộc giữ liệu sao cho khi xóa 1 trụ sở làm
-- việc (Office) thì tất cả dữ liệu liên quan đến trụ sở này sẽ bị xóa hết.
ALTER TABLE Staff DROP FOREIGN KEY fk_staff_office;
ALTER TABLE Staff ADD CONSTRAINT fk_staff_office FOREIGN KEY (Office_id) REFERENCES Office (Office_id) ON DELETE CASCADE;



