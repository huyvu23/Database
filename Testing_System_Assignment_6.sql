-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS get_account_from_department;
DELIMITER $$
CREATE PROCEDURE get_account_from_department(IN in_DepartmentName NVARCHAR(100))
	BEGIN
		
        SELECT A.AccountID,A.FullName,D.DepartmentName 
        FROM `account` A
        INNER JOIN department D USING(DepartmentID)
        WHERE D.DepartmentName = in_DepartmentName;
        
      
    END$$
DELIMITER ;

CALL get_account_from_department ('Bán hàng');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS number_account_of_group;
DELIMITER $$
CREATE PROCEDURE number_of_group (IN in_group_name NVARCHAR(50))
BEGIN
	SELECT g.GroupID,g.GroupName,count(ga.AccountID) AS SL
    FROM `group` g 
    INNER JOIN groupaccount ga USING (GroupID)
    WHERE g.GroupName = in_group_name;
    

END$$
DELIMITER ;
CALL number_account_of_group ('Management');

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS count_question_of_typequestion;
DELIMITER $$
CREATE PROCEDURE count_question_of_typequestion()
BEGIN
	SELECT q.QuestionID,q.Content,count(q.TypeID) AS SL
    FROM question q
    INNER JOIN typequestion tq USING (TypeID)
    WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
	GROUP BY q.TypeID;


END$$
DELIMITER ;

CALL count_question_of_typequestion();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS get_typequestion_payid;
DELIMITER $$
CREATE PROCEDURE get_typequestion_payid (OUT out_TypeID MEDIUMINT UNSIGNED )
BEGIN 
	-- CTE chạy xong sẽ mất
    WITH max_count_typeid AS (
		SELECT COUNT(TypeID)
		FROM question
		GROUP BY TypeID
        ORDER BY COUNT(TypeID) DESC
        LIMIT 1
        )
        SELECT TypeID INTO out_TypeID
        FROM question
        GROUP BY TypeID
        HAVING COUNT(TypeID)  = (SELECT * FROM max_count_typeid);
    
    
END$$
DELIMITER ;
 
 SET @v_out_TypeID = 0; -- khai báo biến
 CALL get_typequestion_payid(@v_out_TypeID);
 SELECT @v_out_TypeID;
 
 -- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
 SELECT TypeName
 FROM typequestion
 WHERE TypeID =  @v_out_TypeID;
 
 
 -- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
 -- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
 DROP PROCEDURE IF EXISTS get_groupof_string;
DELIMITER $$
CREATE PROCEDURE get_groupof_string (IN var_String VARCHAR(50))
BEGIN
	
			SELECT g.GroupName 
			FROM `group` g
			WHERE g.GroupName LIKE concat("%",var_String,"%");
    
	
			SELECT a.Username
			FROM `account` a
			WHERE a.Username LIKE concat("%",var_String,"%");
	 
 
END$$
DELIMITER ;
Call get_groupof_string('g');
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
 -- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS get_information_in_fullname_email;
DELIMITER $$
CREATE PROCEDURE  get_information_in_fullname_email (IN in_fullName varchar(50),IN in_email varchar(50))
BEGIN 
		DECLARE v_username varchar(50);
		DECLARE v_positionID SMALLINT UNSIGNED;
        DECLARE v_departmentID TINYINT UNSIGNED ;
        DECLARE v_CreateDate DATETIME DEFAULT now();
        
        SELECT substring_index(in_email,'@', 1) INTO v_username;
 
		SELECT positionID INTO v_positionID 
        FROM position
        WHERE PositionName = 'Dev';
        
        SELECT departmentID INTO v_departmentID
        FROM department
        WHERE DepartmentName = 'Phong Cho';
        
        INSERT  INTO 	`account`		( Email,	 Username, 		FullName, 		DepartmentID, 		PositionID, CreateDate)
        VALUES							(in_email,	v_username , 	in_fullName,	v_departmentID , 	v_positionID,v_CreateDate);
        
        SELECT N'tạo thành công';
END $$
DELIMITER ;

CALL get_information_in_fullname_email('Vu Quang Huy', 'huyv3216@gmail.com');

-- Question Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS get_typeName_of_content;
DELIMITER $$
CREATE PROCEDURE get_typeName_of_content (IN in_varchar VARCHAR(50))
BEGIN
	DECLARE v_TypeID MEDIUMINT UNSIGNED;
    
		SELECT tq.TypeID INTO v_TypeID
		FROM typequestion tq
		WHERE TypeName = in_varchar;
        
    IF in_varchar = 'Essay' THEN
		WITH CTE_LENGTH_CONTENT AS (
			SELECT length(q.Content) AS leng 
            FROM question q
			WHERE TypeID = v_TypeID)
			SELECT q.Content,q.TypeID FROM question q
			WHERE TypeID = v_TypeID 
			AND length(q.Content) = (SELECT MAX(leng) FROM CTE_LENGTH_CONTENT);
            
     ELSEIF  in_varchar = 'Multiple-Choice' THEN
		WITH CTE_LENGTH_CONTENT AS (
			SELECT length(q.Content) AS leng 
            FROM question q
			WHERE TypeID = v_TypeID)
			SELECT q.Content,q.TypeID FROM question q
			WHERE TypeID = v_TypeID 
			AND length(q.Content) = (SELECT MAX(leng) FROM CTE_LENGTH_CONTENT);
		END IF;
END $$
DELIMITER ;

CALL get_typeName_of_content ('Essay');
SELECT content,max(length(content))
from question
WHERE TypeID = 1;

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
-- Bảng Exam có liên kết khóa ngoại đến bảng examquestion vì vậy trước khi xóa dữ liệu trong bảng exam cần xóa dữ liệu trong bảng examquestion trước

DROP PROCEDURE IF EXISTS delete_exam_withid;
DELIMITER $$
CREATE PROCEDURE delete_exam_withid(IN in_examid SMALLINT UNSIGNED)
BEGIN
	DELETE FROM examquestion 
    WHERE ExamID = in_examid;
    
    DELETE FROM Exam
    WHERE ExamID = in_examid;

END$$
DELIMITER ;

CALL delete_exam_withid();

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử 
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing








