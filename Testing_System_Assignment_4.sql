-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.*, d.DepartmentName FROM `account` a JOIN department d ON a.DepartmentID = d.DepartmentID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * FROM `account` WHERE CreateDate > '2010-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT  a.*, p.PositionName
FROM   `account` a JOIN position p ON a.PositionID = p.PositionID
WHERE   PositionName = 'Dev'; 
 
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT COUNT(a.DepartmentID) AS SNV, d.DepartmentName
FROM  `account` a JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất									
SELECT 		q.Content, Count(q.QuestionID) AS SL
FROM		Question q 
JOIN 	    ExamQuestion eq ON q.QuestionID = eq.QuestionID
GROUP BY	q.QuestionID
HAVING		COUNT(q.QuestionID) = (SELECT MAX(CountQ)  FROM 
									   (SELECT 		COUNT(q.QuestionID) AS CountQ
										FROM		ExamQuestion eq 
										JOIN 	    Question q ON eq.QuestionID = q.QuestionID
										GROUP BY	q.QuestionID) AS Max_Content);

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT cq.CategoryName, cq.CategoryID, COUNT(q.CategoryID) AS SL
FROM   question q
JOIN   categoryquestion cq ON q.CategoryID = cq.CategoryID
GROUP BY cq.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.Content, COUNT(eq.QuestionID) AS SL
FROM   question q
JOIN   examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT q.QuestionID, q.Content, COUNT(a.QuestionID) AS SL
FROM   question q
JOIN   answer a ON q.QuestionID = a.QuestionID
GROUP BY q.QuestionID
HAVING COUNT(a.QuestionID) = ( SELECT MAX(CountA) FROM (SELECT COUNT(a.QuestionID) AS CountA
														FROM   question q
														JOIN   answer a ON q.QuestionID = a.QuestionID
														GROUP BY q.QuestionID) AS MAX_Answer);

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT ga.GroupID, COUNT(ga.AccountID) AS SL
FROM `account` a
JOIN groupaccount ga ON a.AccountID = ga.AccountID
GROUP BY ga.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT 	p.PositionID,
		P.PositionName,
		COUNT(a.PositionID) AS SL
FROM	Position p
JOIN	`Account` a ON p.PositionID = a.PositionID
GROUP BY P.PositionID
HAVING COUNT(a.PositionID) = (SELECT MIN(CountP) FROM ( SELECT COUNT(a.PositionID) AS CountP
														FROM	Position p
														JOIN	`Account` a ON p.PositionID = a.PositionID
														GROUP BY P.PositionID) AS MIN_Poisition);
                                                        
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT  p.PositionName, COUNT(a.PositionID) AS SL
FROM 	`account` a
JOIN    `position` p ON a.PositionID = p.PositionID
GROUP BY p.PositionName ;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT  q.Content AS CauHoi, tq.TypeName AS LoaiCauHoi, ac.FullName AS NguoiTao, an.Content AS CauTraLoi, ac.CreateDate AS NgayTao
FROM    question q
JOIN    typequestion tq ON q.TypeID = tq.TypeID
JOIN    `account` ac ON ac.AccountID = q.CreatorID
JOIN    answer an ON q.QuestionID = an.QuestionID;
 
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT  tq.TypeName, COUNT(q.TypeID) AS SL
FROM    question q
JOIN    typequestion tq ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;

-- Question 14, 15:Lấy ra group không có account nào
SELECT    g.GroupName
FROM     `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE     ga.AccountID IS NULL
GROUP BY  g.GroupName;

-- Question 16: Lấy ra question không có answer nào
SELECT    q.Content
FROM      question q
LEFT JOIN answer a ON q.QuestionID = a.QuestionID
WHERE     a.Content IS NULL;

-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.AccountID, a.FullName, ga.GroupID
FROM   `account` a
JOIN   groupaccount ga ON a.AccountID = ga.AccountID
WHERE  ga.GroupID = 1
UNION 
SELECT a.AccountID, a.FullName, ga.GroupID
FROM   `account` a
JOIN   groupaccount ga ON a.AccountID = ga.AccountID
WHERE  ga.GroupID = 2;
 
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT	 g.GroupName, COUNT(ga.GroupID) AS SoNhanVien
FROM  	 groupaccount ga
JOIN   	`group` g ON ga.GroupID = g.GroupID
GROUP BY ga.GroupID
HAVING 	 COUNT(ga.GroupID) > 5 
UNION 
SELECT 	g.GroupName, COUNT(ga.GroupID) AS SoNhanVien
FROM	groupaccount ga
JOIN	`group` g ON ga.GroupID = g.GroupID
GROUP BY ga.GroupID
HAVING COUNT(ga.GroupID) < 7;