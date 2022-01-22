-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW VW_Sale AS
SELECT a.*, d.DepartmentName 
FROM `account` a
INNER JOIN department d USING (DepartmentID)
WHERE d.DepartmentName = 'Sale';

SELECT * FROM VW_Sale;
-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW VW_account_JOIN_group AS
SELECT  a.AccountID,a.FullName, a.Username,COUNT(g.AccountID) AS SL
FROM `account` a
INNER JOIN groupaccount g USING (AccountID)
GROUP BY g.AccountID
HAVING COUNT(g.AccountID) = (SELECT MAX(SL) FROM (SELECT COUNT(g.AccountID) AS SL
												  FROM groupaccount g
                                                  GROUP BY g.AccountID) AS TEMP);
 
 SELECT * FROM VW_account_JOIN_group;
                                                  
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi  
   CREATE OR REPLACE VIEW content_so_long AS
   SELECT *
   FROM question
   WHERE length(Content ) > 18 ;
   
   DELETE FROM question
   WHERE QuestionID IN (1,2);
   
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

CREATE OR REPLACE VIEW department_has_the_most_employees AS
SELECT d.DepartmentName,count(a.DepartmentID) 
FROM `account` a
INNER JOIN department d USING (DepartmentID)
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID) = (SELECT MAX(SL) FROM (SELECT COUNT(a.DepartmentID) AS SL
												  FROM `account` a
                                                  GROUP BY a.DepartmentID) AS TEMP);
                                                  
 SELECT * FROM department_has_the_most_employees ;
 
 -- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW question_of_user_Nguyen AS
SELECT a.FullName ,q.Content
FROM `account` a
INNER JOIN question q ON q.CreatorID = a.AccountID
WHERE a.FullName LIKE 'Nguyen%';

SELECT * FROM question_of_user_Nguyen;



   
   
   
                                             



