SELECT * FROM department;

SELECT DepartmentID FROM department WHERE DepartmentName = 'Sale';

SELECT 
    *
FROM
    `Account`
WHERE
    LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`);

SELECT 
    *
FROM
    `Account`
WHERE
    LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account` WHERE DepartmentID = 3) AND DepartmentID = 3;

SELECT GroupName FROM `group` WHERE CreateDate < '2019-12-20';

SELECT 
    QuestionID, COUNT(Content)
FROM
    answer
GROUP BY QuestionID
HAVING COUNT(Content) >= 4;

SELECT ExamID FROM exam WHERE Duration > 60 AND CreateDate < '2019-12-20';

SELECT * FROM `group` ORDER BY CreateDate DESC LIMIT 5;

SELECT DepartmentID, COUNT(AccountID) AS SoNhanVien FROM `account` WHERE DepartmentID = 2;

SELECT FullName FROM `account` WHERE FullName LIKE 'D$o';

DELETE FROM exam WHERE CreateDate < 2019-12-20;

DELETE FROM question WHERE Content like 'Question$';

UPDATE `account` SET FullName = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn' WHERE AccountID = 5;

UPDATE groupaccount SET AccountID = 5 WHERE GroupID = 4;


