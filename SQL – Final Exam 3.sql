DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

CREATE TABLE Country (
Country_id  	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Country_name 	NVARCHAR(50) NOT NULL 
);


CREATE TABLE Location (
Location_id 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
street_address  NVARCHAR(50) NOT NULL,
postal_code     INT UNSIGNED NOT NULL,
Country_id  	TINYINT UNSIGNED,
FOREIGN KEY (Country_id) REFERENCES Country (Country_id )
);

CREATE TABLE Employee (
Employee_id 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
full_name 		NVARCHAR(50) NOT NULL,
email			VARCHAR(50) NOT NULL UNIQUE KEY,
Location_id 	TINYINT UNSIGNED,
CONSTRAINT fk_Employee_Location FOREIGN KEY (Location_id) REFERENCES Location (Location_id)
);

INSERT INTO Country 		(Country_id,    Country_name)
VALUES						(	1,			'Việt Nam'   ),
							(	2,			'Russia'	 ),
                            ( 	3,			'English'	 );
                            
INSERT INTO Location 		(Location_id,	street_address,		postal_code,		Country_id)
VALUES						(1			,			'Hà Nội',		78945,					1),
							(2			,			'Moskva',		87451,					2),
                            (3			,			'London',		12345,					3);
                            
                            
INSERT INTO Employee 		(Employee_id ,			full_name,			email, 					Location_id)
VALUES						(1			,			'Vũ Quang Huy',		'vti123@gmail.com',					1),
							(2			,			'putin',			'nn03@gmail.com',				    2),
                            (3			,			'John',				'vti8973@gmail.com',				3);
                            
                            
                            
-- Lấy tất cả các nhân viên thuộc Việt nam
SELECT C.Country_id,C.Country_name,E.full_name
FROM Location L 
INNER JOIN Country C USING(Country_id)
INNER JOIN Employee E USING (Location_id)
WHERE C.Country_id = 1	;

-- Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
SELECT C.Country_id,C.Country_name,E.email
FROM Location L 
 JOIN Country C USING(Country_id)
 JOIN Employee E USING (Location_id)
WHERE E.email = 'nn03@gmail.com';

-- Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.
SELECT C.Country_id,C.Country_name,L.street_address,COUNT(E.Employee_id) AS SL
FROM Location L 
INNER JOIN Country C USING(Country_id)
INNER JOIN Employee E USING (Location_id)
GROUP BY L.Location_id;

-- Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employee
DROP TRIGGER IF EXISTS Trg_insert_Employee;
DELIMITER $$
CREATE TRIGGER Trg_insert_Employee    
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
		DECLARE v_Employee_ID TINYINT UNSIGNED;
			SELECT COUNT(E.Employee_id) INTO v_Employee_ID
			FROM  Employee e;
          
		IF (v_Employee_ID >= 10) THEN
			SIGNAL SQLSTATE '78965'
			SET MESSAGE_TEXT = 'KHONG THE INSERT THÊM';
	END IF;
        
END $$
DELIMITER ;



-- Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở location đó sẽ có location_id = null
ALTER TABLE Employee DROP FOREIGN KEY fk_Employee_Location;
ALTER TABLE Employee ADD CONSTRAINT fk_Employee_Location FOREIGN KEY (Location_id) REFERENCES Location (Location_id) ON DELETE SET NULL;
