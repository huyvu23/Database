
-- Exam lesson 4
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.AccountID,a.Email,a.Username,a.FullName,d.DepartmentName
FROM `Account` a 
INNER JOIN department d USING(DepartmentID);

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM  `Account` a 
WHERE CreateDate > '2010/12/20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT a.AccountID,a.Email,a.Username,a.FullName,p.PositionName
FROM `Account` a 
INNER JOIN position p USING(PositionID)
WHERE p.PositionName = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT d.DepartmentName ,count(a.DepartmentID) as SL
FROM `Account` a 
INNER JOIN department d USING(DepartmentID)
GROUP BY a.DepartmentID
HAVING count(a.DepartmentID) >= 1;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT Q.Content,E.QuestionID
FROM examquestion E
INNER JOIN question Q USING (QuestionID)
GROUP BY E.QuestionID
HAVING COUNT(E.QuestionID) = (SELECT MAX(SL) FROM (SELECT COUNT(E.QuestionID) AS SL
												  FROM examquestion E
                                                  GROUP BY E.QuestionID) AS TEMP);
                                                  
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT q.CategoryID,c.CategoryName,count(q.CategoryID) AS SL
FROM categoryquestion AS c
INNER JOIN question AS q USING (CategoryID) 
GROUP BY q.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.QuestionID , q.Content , count(eq.QuestionID) AS SL
FROM question AS q
LEFT JOIN examquestion AS eq USING (QuestionID)
GROUP BY q.QuestionID ;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT a.QuestionID , q.Content, COUNT(a.QuestionID) AS SL	
FROM answer AS a
INNER JOIN question AS q USING (QuestionID)
GROUP BY a.QuestionID
HAVING COUNT(a.QuestionID) = (SELECT MAX(SL) FROM (SELECT COUNT(a.QuestionID) AS SL
												  FROM answer AS a
                                                  GROUP BY a.QuestionID) AS TEMP);
-- Question 9: Thống kê số lượng account trong mỗi group 
SELECT g.GroupID,g.GroupName,count(gr.AccountID) SL
FROM `group` AS g
INNER JOIN groupaccount AS gr USING (GroupID)
GROUP BY g.GroupID ;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT p.PositionName , count(a.PositionID)AS SL
FROM position AS p
INNER JOIN `account` AS a USING (PositionID)
GROUP BY a.PositionID
HAVING COUNT(a.PositionID) = (SELECT MIN(SL) FROM (SELECT COUNT(a.PositionID) AS SL
												  FROM `account` AS a
                                                  GROUP BY a.PositionID) AS TEMP);
                                                  
 -- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
	SELECT p.PositionID,d.DepartmentName, p.PositionName, count(p.PositionName) AS SL
	FROM `account` a
	INNER JOIN department d ON a.DepartmentID = d.DepartmentID
	INNER JOIN position p ON a.PositionID = p.PositionID
	GROUP BY d.DepartmentID, p.PositionID;
 
 
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT t.TypeName,a.FullName,ca.CategoryName,aw.Content
FROM  question q
INNER JOIN categoryquestion ca USING (CategoryID)
INNER JOIN `account` a ON q.CreatorID = a.AccountID
INNER JOIN typequestion t USING (TypeID)
INNER JOIN answer aw USING (QuestionID)
ORDER BY Q.QuestionID ASC;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT ty.TypeName,ty.TypeID,COUNT(q.TypeID) SL
FROM question q
INNER JOIN typequestion ty USING (TypeID)
GROUP BY q.TypeID;

-- Question 15: Lấy ra group không có account nào
SELECT *
FROM groupaccount AS gr
RIGHT JOIN `group` AS g USING (GroupID)
WHERE gr.GroupID IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT *
FROM answer a
RIGHT JOIN question q USING (QuestionID)
WHERE a.QuestionID IS NULL;