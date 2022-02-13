--  Trigger là một thủ tục SQL được thực thi ở phía server khi có
-- một sự kiện như Insert, Delete, hay Update. Trigger là một loại stored procedure đặc biệt
-- (không có tham số) được thực thi (execute) một cách tự động khi có một sự kiện thay đổi
-- dữ liệu (data modification).



-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS before_insert_group;
DELIMITER $$
CREATE TRIGGER before_insert_group
BEFORE INSERT ON `group` 
FOR EACH ROW
BEGIN
		DECLARE v_CreateDate DATETIME;
		SET v_CreateDate = DATE_SUB(NOW(), interval 1 year);
	IF 	(NEW.CreateDate <= v_CreateDate) THEN
		SIGNAL SQLSTATE '45678'
		SET MESSAGE_TEXT = 'KHÔNG THỂ NHẬP VÀO BẢNG GROUP';
    END IF;
END $$
DELIMITER ;

INSERT INTO `group` (`GroupName`, `CreatorID`, `CreateDate`) 
VALUES 				('2', '1', '2018-04-10 00:00:00');

--  Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào 
 -- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
 -- "Sale" cannot add more user"
 DROP TRIGGER IF EXISTS before_insert_account;
DELIMITER $$
CREATE TRIGGER before_insert_account
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
		DECLARE v_DepartmentID TINYINT;
		SELECT d.DepartmentID INTO v_DepartmentID
        FROM department d
        WHERE d.DepartmentName = 'Sale';
	IF 	(NEW.DepartmentID = v_DepartmentID) THEN
		SIGNAL SQLSTATE '45678'
		SET MESSAGE_TEXT = '"Department"Sale" cannot add more user"';
    END IF;
END $$
DELIMITER ;

INSERT INTO `testingsystem`.`account` (`Email`, `Username`, `FullName`, `DepartmentID`, `PositionID`, `CreateDate`)
VALUES 									('sfjhbfh@gamil.com', 'fdsfdsfd', 'sfjsdhjfjh', '2', '1', '2020-11-13 00:00:00');


-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS before_insert_groupaccount;
DELIMITER $$
CREATE TRIGGER before_insert_groupaccount
BEFORE INSERT ON `GroupAccount`
FOR EACH ROW
BEGIN
	DECLARE v_countGroupID TINYINT;
			SELECT COUNT(gr.GroupID) INTO v_countGroupID
			FROM `GroupAccount` AS gr 
            -- GROUP BY gr.AccountID;
             WHERE gr.GroupID = NEW.GroupID;
            
	IF v_countGroupID >= 4 THEN
			SIGNAL SQLSTATE '12365'
            SET MESSAGE_TEXT = 'KHÔNG THỂ INSERT THÊM';
	END IF ;
    
		
END $$
DELIMITER ;
INSERT INTO `GroupAccount` (`GroupID`, `AccountID`, `JoinDate`) 
VALUES 						(1, 10, '2020-05-11 00:00:00'); 


-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question

DROP TRIGGER IF EXISTS before_insert_examquestion;
DELIMITER $$
CREATE TRIGGER before_insert_examquestion
BEFORE INSERT ON ExamQuestion
FOR EACH ROW
BEGIN
	DECLARE v_countquestionID MEDIUMINT;
		SELECT COUNT(e.ExamID) INTO v_countquestionID
		FROM ExamQuestion e
		WHERE e.ExamID =  NEW.ExamID;
    IF v_countquestionID >= 2 THEN
		SIGNAL SQLSTATE '78965'
		SET MESSAGE_TEXT = 'KHONG THE INSERT THÊM';
	END IF;
END $$
DELIMITER ;

INSERT INTO ExamQuestion(`ExamID`, `QuestionID`) 
VALUES 						(8, 6);

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), 
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông 
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS not_delete_admin;
DELIMITER $$
CREATE TRIGGER not_delete_admin
BEFORE DELETE ON `account`
FOR EACH ROW 
BEGIN
    DECLARE v_email VARCHAR(50);
    SET v_email = 'account4@gmail.com';
    IF OLD.Email = v_email  THEN
		SIGNAL SQLSTATE '57894'
        SET MESSAGE_TEXT = 'KHONG THE XOA ADMIN';
	END IF;
END $$ 
DELIMITER ;

DELETE FROM `account`
WHERE Email = 'account4@gmail.com';

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table 
 -- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền 
 -- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
 DROP TRIGGER IF EXISTS before_insert_Account;
DELIMITER $$
CREATE TRIGGER before_insert_Account
BEFORE INSERT ON `account`
FOR EACH ROW 
BEGIN
	DECLARE v_departmentID TINYINT;
    SELECT d.DepartmentID INTO v_departmentID 
    FROM  department d
    WHERE d.DepartmentName = N'Phòng chờ';
    IF (NEW.DepartmentID IS NULL) THEN
		SET NEW.DepartmentID = v_departmentID ;
	END IF ;
    
END $$
DELIMITER ;
INSERT INTO `testingsystem`.`account` (`Email`, `Username`, `FullName`, `PositionID`, 
`CreateDate`) 
VALUES ('1','1', '1', '1', '2019-07-15 00:00:00');

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi 
 -- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS before_insert_answer;
DELIMITER $$
CREATE TRIGGER before_insert_answer
BEFORE INSERT ON Answer
FOR EACH ROW 
BEGIN
	DECLARE v_questionID MEDIUMINT;
    DECLARE v_CountAnsIsCorrects TINYINT;
		SELECT COUNT(a.questionID) INTO v_questionID
		FROM Answer a 
		WHERE a.questionID = NEW.questionID;
		SELECT COUNT(a.isCorrect) INTO v_CountAnsIsCorrects
		FROM Answer a 
		WHERE a.QuestionID = NEW.QuestionID AND a.isCorrect = NEW.isCorrect;
    IF v_questionID > 4 OR v_CountAnsIsCorrects > 2 THEN
		SIGNAL SQLSTATE '56478'
		SET MESSAGE_TEXT = 'BAN KHONG THE INSERT THEM';
    END IF;
END $$
DELIMITER ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS before_DELETE_exam;
DELIMITER $$
CREATE TRIGGER before_DELETE_exam
BEFORE DELETE ON exam
FOR EACH ROW 
BEGIN
		DECLARE v_CreateDate DATE ;
        SET v_CreateDate = DATE_SUB(NOW(), INTERVAL 2 DAY );
        IF (OLD.CreateDate > v_CreateDate) THEN
			SIGNAL SQLSTATE '47895'
			SET MESSAGE_TEXT ='KHONG THE XOA BAN GHI MOI TAO 2 NGAY';
		END IF;
END $$
DELIMITER ;


-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các 
 -- question khi question đó chưa nằm trong exam nào
 DROP TRIGGER IF EXISTS before_DELETE_question;
DELIMITER $$
CREATE TRIGGER before_DELETE_AND_UPDATE_question
BEFORE DELETE ON exam
FOR EACH ROW 
BEGIN



END $$
DELIMITER ;
