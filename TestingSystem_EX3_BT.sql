DROP DATABASE IF EXISTS TestingSystem_EX3_BT;
CREATE DATABASE TestingSystem_EX3_BT;
USE TestingSystem_EX3_BT;

-- create table: User
DROP TABLE IF EXISTS 	`account`;
CREATE TABLE IF NOT EXISTS `account` ( 	
	id 	SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`email` 		CHAR(50) NOT NULL UNIQUE CHECK (LENGTH(`email`) >= 6 AND LENGTH(`email`) <= 50),
	`password` 		VARCHAR(800) NOT NULL,
	`fullName` 		NVARCHAR(50) NOT NULL,
    `Role`			ENUM('USER', 'ADMIN')
);

-- create table: Manager
DROP TABLE IF EXISTS 	`Manager`;
CREATE TABLE IF NOT EXISTS `Manager` ( 	
	id 				SMALLINT UNSIGNED NOT NULL,
	`expInYear` 	SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (id) REFERENCES `account`(id)
);

-- create table: Employee
DROP TABLE IF EXISTS 	`Employee`;
CREATE TABLE IF NOT EXISTS `Employee` ( 	
	id 				SMALLINT UNSIGNED NOT NULL,
    proSkill 		ENUM('DEV', 'TEST', 'JAVA', 'SQL') NOT NULL,
    FOREIGN KEY (id) REFERENCES `account`(id)
);

-- create table: Project
DROP TABLE IF EXISTS 	`Project`;
CREATE TABLE IF NOT EXISTS `Project` ( 	
	id 				SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Project_Name 	VARCHAR(50) NOT NULL,
	`teamSize`	 	SMALLINT UNSIGNED # Trigger TODO...
);

-- create table: Project & Account
DROP TABLE IF EXISTS 	`ProjectAndAccount`;
CREATE TABLE IF NOT EXISTS `ProjectAndAccount` ( 	
	projectId 		SMALLINT UNSIGNED NOT NULL,
	id 		SMALLINT UNSIGNED NOT NULL,
    `Role`			ENUM ('MANAGER', 'EMPLOYEE'),
    FOREIGN KEY (projectId) REFERENCES `Project`(id),
    FOREIGN KEY (projectId ) REFERENCES `account`(id),
    PRIMARY KEY (projectId, id)
);

-- Note: Manager của Project không liên quan gì tới Project Manager

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Add data User
INSERT INTO `account` 	(`email`,						`password`,		`fullName`,					`Role`)
VALUE				('admin@gmail.com',				'admin',		'admin',					'ADMIN'), 
					('daonq@viettel.com.vn',		'admin',		'daonq',					'ADMIN'), 
					('cananh.tuan12@vti.com',		'123456A',		'Cấn Tuấn Anh',				'USER'), 
					('toananh123@vti.com',			'123456A',		'Nguyễn Anh Toàn',			'USER'), 
					('duynguyen123@vti.com',		'123456A',		'Nguyễn Duy',				'USER'), 
					('manhhung123@vti.com',			'123456A',		'Nguyễn Mạnh Hùng',			'USER'),
					('maianhng@gmail.com', 			'123456A',		'Nguyễn Mai Anh',			'USER'),
					('tuan1234@gmail.com', 			'123456A',		'Nguyễn Văn Tuấn',			'USER'),
					('thuyhanoi@gmail.com', 		'123456A',		'Nguyễn Thị Thủy',			'USER'),
					('quanganh@gmail.com', 			'123456A',		'Nguyễn Quang Anh',			'USER'),
					('hunghoang@gmail.com', 		'123456A',  	'Vũ Hoàng Hưng',			'USER'),
					('quocanh12@gmail.com', 		'123456A',		'Nguyễn Quốc Anh',			'USER'),
					('vananhb1@gmail.com', 			'123456A',		'Nguyễn Vân Anh',			'USER'),
					('trinh123@gmail.com', 			'123456A',		'Nguyễn Thị Trinh',			'USER'),
					('tuanhung@gmail.com', 			'123456A',		'Vũ Tuấn Hưng',				'USER'),
					('xuanmai12@gmail.com', 		'123456A',		'Nguyễn Xuân Mai',			'USER'),
					('hungnguyen@gmail.com', 		'123456A',		'Phạm Quang Hưng',			'USER');

-- Add data Manager
INSERT INTO Manager (id,	`expInYear`	)
VALUE				(3,			1		), 
					(5,			2		), 
					(7,			3		), 
					(9,			5		), 
					(11,		7		), 
					(13,		8		), 
					(15,		9		), 
					(17,		10		);

-- Add data Employee
INSERT INTO Employee 	(id,	`proSkill`	)
VALUE					(2,			'DEV'	), 
						(4,			'DEV'	), 
						(6,			'TEST'	), 
						(8,			'TEST'	), 
						(10,		'JAVA'	), 
						(12,		'DEV'	), 
						(14,		'JAVA'	), 
						(16,		'SQL'	);
                        
-- Add data Project
INSERT INTO Project 	(`Project_Name`,	 `teamSize`	)
VALUE					('Project_Name_1',			3		), 
						('Project_Name_2',			3		), 
                        ('Project_Name_3',			2		), 
                        ('Project_Name_4',			4		), 
                        ('Project_Name_5',			8		);
                        
-- Add data `ProjectAndAccount`
INSERT INTO `ProjectAndAccount` 	(projectId	,	id,	`Role`		)
VALUE							(1			,		1	,	'MANAGER'	), 
								(1			,		2	,	'EMPLOYEE'	), 
								(1			,		3	,	'EMPLOYEE'	), 
								(2			,		4	,	'EMPLOYEE'	), 
								(2			,		5	,	'MANAGER'	), 
								(2			,		6	,	'EMPLOYEE'	), 
								(3			,		7	,	'EMPLOYEE'	), 
								(3			,		8	,	'MANAGER'	);