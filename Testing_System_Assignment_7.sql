-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS trig_CheckInsertGroup;
Delimiter $$
CREATE TRIGGER trig_CheckInsertGroup
BEFORE INSERT ON `group`
FOR EACH ROW
BEGIN
IF (NEW.CreateDate <= date_sub(now(), interval 1 year)) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Cant create this group';
END IF;
END $$
Delimiter ;
INSERT INTO `group` (GroupName   , CreatorID   , CreateDate   )
VALUE               ('GroupName1', 10          , '2018-01-01' );   

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department "Sale" cannot add more user"
DROP TRIGGER IF EXISTS trig_Not_add_Dep_Sale;
Delimiter $$
CREATE TRIGGER trig_Not_add_Dep_Sale
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
IF NEW.DepartmentID = 8 THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = "Department 'Sale' cannot add more user";
END IF;
END $$
Delimiter ;
INSERT INTO `account` (Email             , Username   , FullName   , DepartmentID, PositionID  , CreateDate   )
VALUE                 ('Email1@gmail.com', 'Username1', 'FullName' , 8           ,  10         , '2021-07-01' );

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS trig_Max5UserInGroup;
Delimiter $$
CREATE TRIGGER trig_Max5UserInGroup
BEFORE INSERT ON groupaccount
FOR EACH ROW
BEGIN
DECLARE v_max_user TINYINT;
SELECT count(GroupID) INTO v_max_user
FROM groupaccount
WHERE GroupID = NEW.GroupID;
IF (v_max_user > 5) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Cant add more user';
END IF;
END $$
Delimiter ;
INSERT INTO groupaccount (GroupID, AccountID, JoinDate   )
VALUES                   (1      , 1        ,'2021-07-04');

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS trig_Max10QuestionInExam;
Delimiter $$
CREATE TRIGGER trig_Max10QuestionInExam
BEFORE INSERT ON examquestion
FOR EACH ROW
BEGIN
DECLARE v_max_question TINYINT;
SELECT count(ExamID) INTO v_max_question
FROM examquestion
WHERE ExamID = NEW.ExamID;
IF (v_max_question > 10) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Cant add more question';
END IF;
END $$
Delimiter ;
INSERT INTO examquestion (ExamID, QuestionID)
VALUES                   (1      , 1        );

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông  tin liên quan tới user đó
DROP TRIGGER IF EXISTS trig_DeleteAcc;
Delimiter $$
CREATE TRIGGER trig_DeleteAcc
BEFORE DELETE ON `account`
FOR EACH ROW
BEGIN
IF OLD.Email = 'admin@gmail.com' THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'đây là tài khoản admin, không cho phép user xóa';
END IF;
END $$
Delimiter ;
DELETE FROM `account` WHERE Email = 'admin@gmail.com';

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table Account, 
-- hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
DROP TRIGGER IF EXISTS trig_WaitingDepartment;
Delimiter $$
CREATE TRIGGER trig_WaitingDepartment
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
DECLARE v_waiting_dep TINYINT;
SELECT DepartmentID INTO v_waiting_dep
FROM department
WHERE DepartmentName = 'waiting Department';
IF (NEW.DepartmentID IS NULL) THEN
SET NEW.DepartmentID = v_waiting_dep;
END IF;
END $$
Delimiter ;
INSERT INTO `account` (Email  , Username , FullName  , PositionID, CreateDate          )
VALUES                ('Email','Username', 'FullName',1         , '2019-07-15 00:00:00');

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS trig_answer;
Delimiter $$
CREATE TRIGGER trig_answer
BEFORE INSERT ON answer
FOR EACH ROW
BEGIN
DECLARE v_max_answer TINYINT;
DECLARE v_max_is_correct TINYINT;
SELECT count(QuestionID) INTO v_max_answer FROM answer
WHERE NEW.QuestionID = QuestionID;
SELECT count(isCorrect) INTO v_max_is_correct FROM answer
WHERE NEW.QuestionID = QuestionID;
IF (v_max_answer >= 4) OR (v_max_is_correct >= 2 ) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = ' cant add more anwser ';
END IF;
END $$
Delimiter ;
INSERT INTO answer (Content  , QuestionID , isCorrect )
VALUES             ('Content',3           , 1         );

-- Question 8: Viết trigger sửa lại dữ liệu cho đúng: Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
DROP TRIGGER IF EXISTS trig_add_gender;
Delimiter $$
CREATE TRIGGER trig_add_gender
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
IF NEW.Gender = 'Nam' THEN SET NEW.Gender = 'M';
ELSEIF NEW.Gender = 'Nữ' THEN SET NEW.Gender = 'F';
ELSEIF NEW.Gender = 'Chưa Xác Định' THEN SET NEW.Gender = 'U';
END IF;
END $$
Delimiter ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS trig_Not_Delete_exam;
Delimiter $$
CREATE TRIGGER trig_Not_Delete_exam
BEFORE DELETE ON exam
FOR EACH ROW
BEGIN
IF (OLD.CreateDate >= date_sub(now(), interval 2 day)) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = ' Cant delete exam ';
END IF;
END $$
Delimiter ;
DELETE FROM exam WHERE ExamID = 11;

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS trig_Not_Delete_ExamQues;
Delimiter $$
CREATE TRIGGER trig_Not_Delete_ExamQues
BEFORE DELETE ON question
FOR EACH ROW
BEGIN
DECLARE v_QuestionID TINYINT;
SELECT q.QuestionID INTO v_QuestionID
FROM question q 
JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;
IF OLD.QuestionID = v_QuestionID THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = ' Cant delete question ';
END IF;
END $$
Delimiter ;
DELETE FROM question WHERE QuestionID = 2;

DROP TRIGGER IF EXISTS trig_Not_Update_ExamQues;
Delimiter $$
CREATE TRIGGER trig_Not_Update_ExamQues
BEFORE UPDATE ON question
FOR EACH ROW
BEGIN
DECLARE v_QuestionID TINYINT;
SELECT q.QuestionID INTO v_QuestionID
FROM question q 
JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;
IF OLD.QuestionID = v_QuestionID THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = ' Cant delete question ';
END IF;
END $$
Delimiter ;
UPDATE question SET Content = 'Test' WHERE QuestionID = 4;

-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT *,
CASE
WHEN Duration <= 30 THEN 'Short time'
WHEN Duration <= 60 THEN 'Medium time'
ELSE 'Longtime'
END AS Duration_Time
FROM exam ;

-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT GroupID, COUNT(GroupID) AS SoAcc,
CASE
WHEN COUNT(GroupID) <= 5 THEN 'few'
WHEN COUNT(GroupID) <= 20 THEN 'normal'
ELSE 'higher'
END AS the_number_user_amount
FROM groupaccount
GROUP BY GroupID;

-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT d.DepartmentName,
CASE WHEN COUNT(a.DepartmentID) = 0 THEN 'Không có User'
ELSE COUNT(a.DepartmentID)
END AS So_User
FROM `account` a 
RIGHT JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID


