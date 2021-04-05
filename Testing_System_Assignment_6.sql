-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS P_department_Account;
Delimiter $$
CREATE PROCEDURE P_department_Account( IN In_DepID TINYINT )
BEGIN
SELECT * FROM `account`
WHERE DepartmentID = In_DepID ;
END $$
Delimiter ;
CALL P_department_Account(5);

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS P_So_Luong_Account;
Delimiter $$
CREATE PROCEDURE P_So_Luong_Account()
BEGIN
SELECT GroupID, count(GroupID) AS SL_tai_khoan FROM groupaccount
GROUP BY GroupID;
END $$
Delimiter ;
CALL P_So_Luong_Account();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS P_TypeQuestion_Of_Month;
Delimiter $$
CREATE PROCEDURE P_TypeQuestion_Of_Month()
BEGIN
SELECT count(TypeID) AS SL_Question FROM question
WHERE month(CreateDate) = month(now());
END $$
Delimiter ;
CALL P_TypeQuestion_Of_Month();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS P_TypeID_MaxQuestion;
Delimiter $$
CREATE PROCEDURE P_TypeID_MaxQuestion()
BEGIN
WITH CTE_MaxQuestion AS (SELECT COUNT(q.TypeID) AS SL 
						 FROM question q
						 JOIN typequestion tq ON tq.TypeID = q.TypeID
                         GROUP BY q.TypeID)
SELECT tq.TypeID, COUNT(q.TypeID) AS SoCauHoi
FROM question q
JOIN typequestion tq ON tq.TypeID = q.TypeID
GROUP BY q.TypeID
HAVING COUNT(q.TypeID) = (SELECT MAX(SL) FROM CTE_MaxQuestion);
END $$
Delimiter ;
CALL P_TypeID_MaxQuestion;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
SELECT TypeName 
FROM typequestion 
WHERE TypeID = 1;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS P_GroupName;
Delimiter $$
CREATE PROCEDURE P_GroupName(IN In_GroupName VARCHAR(50))
BEGIN
SELECT GroupName
FROM `group`
WHERE GroupName = In_GroupName; 
END $$
Delimiter ;
CALL P_GroupName('Testing System');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS P_Length_Contnet_TypeQuestion;
Delimiter $$
CREATE PROCEDURE P_Length_Contnet_TypeQuestion( IN In_TypeQuestion VARCHAR(50) )
BEGIN
WITH CTE_MaxContent AS (SELECT length(q.Content) AS CD 
						FROM question q
						JOIN typequestion tq ON tq.TypeID = q.TypeID)
SELECT DISTINCT tq.TypeName, length(q.Content) AS Do_dai_Content FROM question q
JOIN typequestion tq ON tq.TypeID = q.TypeID
WHERE tq.TypeName = In_TypeQuestion
AND length(q.Content) = (SELECT MAX(CD) FROM CTE_MaxContent);
END $$
Delimiter ;
CALL P_Length_Contnet_TypeQuestion('Multiple-Choice');
CALL P_Length_Contnet_TypeQuestion('Essay');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS P_Delete_Exam;
Delimiter $$
CREATE PROCEDURE P_Delete_Exam(IN In_ExamID TINYINT)
BEGIN
DELETE FROM exam
WHERE ExamID = In_ExamID; 
END $$
Delimiter ;
CALL P_Delete_Exam(10) ;

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
SELECT * FROM exam WHERE (year(now()) - year(CreateDate)) >3;
CALL P_Delete_Exam();

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS P_Delete_Department;
Delimiter $$
CREATE PROCEDURE P_Delete_Department(IN In_DepName VARCHAR(50))
BEGIN
DELETE FROM department
WHERE DepartmentName = In_DepName;
UPDATE `account`
SET DepartmentID = 10
WHERE DepartmentID = (SELECT DepartmentID FROM department WHERE DepartmentName = In_DepName);
END $$
Delimiter ;
CALL P_Delete_Department('Legal');

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
