SELECT a.*, d.DepartmentName FROM `account` a JOIN department d ON a.DepartmentID = d.DepartmentID;

SELECT * FROM `account` WHERE CreateDate > '2010-12-20';

SELECT 
    a.*, p.PositionName
FROM
    `account` a
        JOIN
    position p ON a.PositionID = p.PositionID
WHERE
    PositionName = 'Dev'; 
    
SELECT 
    COUNT(a.DepartmentID) AS SNV, d.DepartmentName
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) > 3;

SELECT 
    q.Content, COUNT(eq.QuestionID) AS SL
FROM
    question q
        JOIN
    examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID
ORDER BY SL DESC
LIMIT 1;

SELECT
    cq.CategoryName, cq.CategoryID, COUNT(q.CategoryID) AS SL
FROM
    question q
        JOIN
    categoryquestion cq ON q.CategoryID = cq.CategoryID
GROUP BY cq.CategoryID;

SELECT 
    q.Content, COUNT(eq.QuestionID) AS SL
FROM
    question q
        JOIN
    examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;

SELECT 
  q.QuestionID, q.Content, COUNT(a.QuestionID) AS SL
FROM
    question q
        JOIN
    answer a ON q.QuestionID = a.QuestionID
GROUP BY q.QuestionID
ORDER BY SL DESC
LIMIT 1;

SELECT 
    ga.GroupID, COUNT(ga.AccountID) AS SL
FROM
    `account` a
        JOIN
    groupaccount ga ON a.AccountID = ga.AccountID
GROUP BY ga.GroupID;

SELECT 
    p.PositionID,
    P.PositionName,
    COUNT(a.PositionID) AS SL
FROM
    Position p
        INNER JOIN
    `Account` a ON p.PositionID = a.PositionID
GROUP BY P.PositionID
ORDER BY COUNT(a.PositionID)
LIMIT 1;

SELECT 
    p.PositionName, COUNT(a.PositionID) AS SL
FROM
    `account` a
        JOIN
    `position` p ON a.PositionID = p.PositionID
GROUP BY p.PositionName ;

SELECT 
    q.Content AS CauHoi, tq.TypeName AS LoaiCauHoi, ac.FullName AS NguoiTao, an.Content AS CauTraLoi, ac.CreateDate AS NgayTao
FROM
    question q
        JOIN
    typequestion tq ON q.TypeID = tq.TypeID
        JOIN
    `account` ac ON ac.AccountID = q.CreatorID
        JOIN
    answer an ON q.QuestionID = an.QuestionID;
    
SELECT 
    tq.TypeName, COUNT(q.TypeID) AS SL
FROM
    question q
        JOIN
    typequestion tq ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;

SELECT 
    g.GroupName
FROM
    `group` g
        LEFT JOIN
    groupaccount ga ON g.GroupID = ga.GroupID
WHERE
    ga.AccountID IS NULL
GROUP BY g.GroupName;

SELECT 
    q.Content
FROM
    question q
        LEFT JOIN
    answer a ON q.QuestionID = a.QuestionID
WHERE a.Content IS NULL;

SELECT 
    a.AccountID, a.FullName, ga.GroupID
FROM
    `account` a
        JOIN
    groupaccount ga ON a.AccountID = ga.AccountID
WHERE
    ga.GroupID = 1
UNION SELECT
    a.AccountID, a.FullName, ga.GroupID
FROM
    `account` a
        JOIN
    groupaccount ga ON a.AccountID = ga.AccountID
WHERE
    ga.GroupID = 2;
    
SELECT 
    g.GroupName, COUNT(ga.GroupID) AS SoNhanVien
FROM
    groupaccount ga
        JOIN
    `group` g ON ga.GroupID = g.GroupID
GROUP BY ga.GroupID
HAVING COUNT(ga.GroupID) < 5 
UNION SELECT 
    g.GroupName, COUNT(ga.GroupID) AS SoNhanVien
FROM
    groupaccount ga
        JOIN
    `group` g ON ga.GroupID = g.GroupID
GROUP BY ga.GroupID
HAVING COUNT(ga.GroupID) > 7;