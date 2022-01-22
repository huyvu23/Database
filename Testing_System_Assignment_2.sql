DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

-- TẠO BẢNG 1--
CREATE TABLE Department (
	DepartmentID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,		
	DepartmentName 		NVARCHAR(100) UNIQUE KEY
);

-- TẠO BẢNG 2--
CREATE TABLE `Position` (
	PositionID			SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PositionName		ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);

-- TẠO BẢNG 3--
CREATE TABLE `Account`(
	AccountID           SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
	Email				NVARCHAR(50) UNIQUE KEY NOT NULL,		
    Username			NVARCHAR(50) NOT NULL,
    FullName			NVARCHAR(50) NOT NULL,	
    DepartmentID 		TINYINT UNSIGNED ,
    PositionID			SMALLINT UNSIGNED ,
    CreateDate			DATE NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

-- TẠO BẢNG 4 --
CREATE TABLE `Group`(
	GroupID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,	
	GroupName			NVARCHAR(50) NOT NULL,
	CreatorID			SMALLINT UNSIGNED,	
	CreateDate			DATE NOT NULL,
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)

);

-- TẠO BẢNG 5 --
CREATE TABLE GroupAccount(
	GroupID				TINYINT UNSIGNED ,		
	AccountID			SMALLINT UNSIGNED ,	
	JoinDate			DATE NOT NULL,
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE,
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
    );

-- TẠO BẢNG 6--
CREATE TABLE TypeQuestion(
    TypeID 				MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    TypeName 			ENUM  ('Essay', 'Multiple-Choice')
);

-- TẠO BẢNG 7 --
CREATE TABLE CategoryQuestion(
    CategoryID			MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CategoryName		NVARCHAR (50)
);

-- TẠO BẢNG 8 --
CREATE TABLE Question(
	QuestionID			MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Content				NVARCHAR(50) NOT NULL,	
	CategoryID			MEDIUMINT UNSIGNED,
	CreatorID      		SMALLINT UNSIGNED,
	TypeID				MEDIUMINT UNSIGNED,	
	CreateDate			DATE NOT NULL,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) 
);

-- TẠO BẢNG 9 --
CREATE TABLE Answer(
    AnswerID			SMALLINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,		
    Content				NVARCHAR(50) NOT NULL,	
    QuestionID			MEDIUMINT UNSIGNED NOT NULL ,	
	isCorrect			TINYINT NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
 ); 

 -- TẠO BẢNG 10--
CREATE TABLE Exam(
	ExamID 				SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	`Code`  			NVARCHAR(50),
	Title				NVARCHAR(50),
	CategoryID 			MEDIUMINT UNSIGNED UNIQUE KEY ,
	Duration 			TINYINT UNSIGNED NOT NULL,
	CreatorID			INT,
	CreateDate			DATE NOT NULL
);
 
 -- TẠO BẢNG 11 --
 CREATE TABLE ExamQuestion(
    ExamID				SMALLINT UNSIGNED ,	
	QuestionID			MEDIUMINT UNSIGNED,
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
    );

 /*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/

INSERT INTO Department(DepartmentName) 
VALUES
						(		N'Marketing'	),
						(		N'Sale'			),
						(		N'Bảo vệ'		),
						(		N'Nhân sự'		),
						(		N'Kỹ thuật'		),
						(		N'Tài chính'	),
						(		N'Phó giám đốc' ),
						(		N'Giám đốc'		),
						(		N'Thư kí'		),
						(		N'Bán hàng'		),
                        (		N'Phòng chờ'	);
                       
                        
                        
INSERT INTO Position	(PositionName	) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 
                        
                        
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyễn hải Đăng'		,   '5'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'Nguyen Chien Thang2'	,   '1'			,   '2'		,'2020-03-05'),
                    ('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   '2'			,   '3'		,'2020-03-07'),
                    ('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '3'			,   '4'		,'2020-03-08'),
                    ('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang1'	,   '4'			,   '4'		,'2020-03-10'),
                    ('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		,'2020-07-02'),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');                 


INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2019-03-05'),
					(N'Development'			,   1			,'2020-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (N'VTI Creator'			,   6			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2020-04-08'),
                    (N'Chat with love'		,   9			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   10			,'2020-04-10');
                    
                    
 INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');
                            
                            
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 
                            
                            
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
                                    
                                    
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Java ',	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	1		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	2		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	2		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	1		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');
                        
                        
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   3			,	1		),
                    (N'Trả lời 07'	,   4			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   9			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);
                    
                    
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2018-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
 
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		);  





