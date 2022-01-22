DROP DATABASE IF EXISTS TestingSystem_EX2_BT;
CREATE DATABASE TestingSystem_EX2_BT;
USE TestingSystem_EX2_BT;
-- create table: User
DROP TABLE IF EXISTS 	`account`;
CREATE TABLE IF NOT EXISTS `account` ( 	
	accountid 				SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`email` 		CHAR(50) NOT NULL UNIQUE CHECK (LENGTH(`email`) >= 6 AND LENGTH(`email`) <= 50),
	`password` 		VARCHAR(800) NOT NULL,
	`fullName` 		NVARCHAR(50) NOT NULL
);

-- create table: Manager
DROP TABLE IF EXISTS 	`Manager`;
CREATE TABLE IF NOT EXISTS `Manager` ( 	
	accountid 				SMALLINT UNSIGNED NOT NULL,
	`expInYear` 	SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (accountid) REFERENCES `account`(accountid)
);

-- create table: Employee
DROP TABLE IF EXISTS 	`Employee`;
CREATE TABLE IF NOT EXISTS `Employee` ( 	
	accountid				SMALLINT UNSIGNED NOT NULL,
    proSkill 		ENUM('DEV', 'TEST', 'JAVA', 'SQL') NOT NULL,
    FOREIGN KEY (accountid ) REFERENCES `account`(accountid )
);

-- create table: Project
DROP TABLE IF EXISTS 	`Project`;
CREATE TABLE IF NOT EXISTS `Project` ( 	
	projectId			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    projectName 	VARCHAR(100) NOT NULL,
	`teamSize`	 	SMALLINT UNSIGNED 
);

-- create table: Project & User
DROP TABLE IF EXISTS 	`ProjectAndaccount`;
CREATE TABLE IF NOT EXISTS `ProjectAndaccount` ( 	
	projectId 		SMALLINT UNSIGNED NOT NULL,
	accountid 	 		SMALLINT UNSIGNED NOT NULL,
    `Role`			ENUM ('MANAGER', 'EMPLOYEE'),
    FOREIGN KEY (projectId) REFERENCES `Project`(projectId),
    FOREIGN KEY (accountid ) REFERENCES `account`(accountid ),
    PRIMARY KEY (projectId, accountid )
);

-- Note: Manager của Project không liên quan gì tới Project Manager

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Add data User
INSERT INTO `account` 	(`email`,						`password`,		`fullName`			)
VALUE				('hanhhanoi1999@gmail.com',		'123456A',		'Hà Văn Hanh'		), 
					('hung122112@gmail.com',		'123456A',		'Nguyễn Thanh Hưng'	), 
					('cananh.tuan12@vti.com',		'123456A',		'Cấn Tuấn Anh'		), 
					('toananh123@vti.com',			'123456A',		'Nguyễn Anh Toàn'	), 
					('duynguyen123@vti.com',		'123456A',		'Nguyễn Duy'		), 
					('manhhung123@vti.com',			'123456A',		'Nguyễn Mạnh Hùng'	),
					('maianhng@gmail.com', 			'123456A',		'Nguyễn Mai Anh'	),
					('tuan1234@gmail.com', 			'123456A',		'Nguyễn Văn Tuấn'	),
					('thuyhanoi@gmail.com', 		'123456A',		'Nguyễn Thị Thủy'	),
					('quanganh@gmail.com', 			'123456A',		'Nguyễn Quang Anh'	),
					('hunghoang@gmail.com', 		'123456A',  	'Vũ Hoàng Hưng'		),
					('quocanh12@gmail.com', 		'123456A',		'Nguyễn Quốc Anh'	),
					('vananhb1@gmail.com', 			'123456A',		'Nguyễn Vân Anh'	),
					('trinh123@gmail.com', 			'123456A',		'Nguyễn Thị Trinh'	),
					('tuanhung@gmail.com', 			'123456A',		'Vũ Tuấn Hưng'		),
					('xuanmai12@gmail.com', 		'123456A',		'Nguyễn Xuân Mai'	),
					('hungnguyen@gmail.com', 		'123456A',		'Phạm Quang Hưng'	);

-- Add data Manager
INSERT INTO Manager (accountid,	`expInYear`	)
VALUE				(1,			5		), 
					(3,			1		), 
					(5,			2		), 
					(7,			3		), 
					(9,			5		), 
					(11,		7		), 
					(13,		8		), 
					(15,		9		), 
					(17,		10		);

-- Add data Employee
INSERT INTO Employee 	(accountid,	`proSkill`	)
VALUE					(2,			'DEV'	), 
						(4,			'DEV'	), 
						(6,			'TEST'	), 
						(8,			'TEST'	), 
						(10,		'JAVA'	), 
						(12,		'DEV'	), 
						(14,		'JAVA'	), 
						(16,		'SQL'	);
                        
-- Add data Project
INSERT INTO `Project` 	(projectName, `teamSize`)
VALUE					(	'Project_Name_1',			2		), 
						(	'Project_Name_2',				4		), 
						(	'Project_Name_3',			6		), 
						(	'Project_Name_4',			8		), 
						(	'Project_Name_5',			10		), 
						(	'Project_Name_6',			12		), 
						(	'Project_Name_7',			14		), 
						(	'Project_Name_8',			16		), 
						(	'Project_Name_9',							18		);
                            
-- Add data `ProjectAndUser`
INSERT INTO `ProjectAndaccount` (projectId	,	accountid,		`Role`	)
VALUE							(1			,		1	,	'MANAGER'	), 
								(1			,		2	,	'EMPLOYEE'	), 
								(1			,		3	,	'EMPLOYEE'	), 
								(2			,		4	,	'EMPLOYEE'	), 
								(2			,		5	,	'MANAGER'	), 
								(2			,		6	,	'EMPLOYEE'	), 
								(3			,		7	,	'EMPLOYEE'	), 
								(3			,		8	,	'MANAGER'	);