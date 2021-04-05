-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW v_list_sale AS
SELECT A.AccountID, A.Email, A.FullName, D.DepartmentName 
FROM `account` A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale';

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW v_list_group AS
WITH CTE_GetMaxGroup AS (SELECT COUNT(GA.AccountID) AS CountAcc
										FROM `account` A
										INNER JOIN groupaccount GA ON A.AccountID = GA.AccountID
										GROUP BY GA.AccountID)
SELECT A.AccountID, A.Email, A.FullName, COUNT(GA.AccountID) AS So_Group
FROM `account` A
INNER JOIN groupaccount GA ON A.AccountID = GA.AccountID
GROUP BY GA.AccountID 
HAVING COUNT(GA.AccountID) = ( SELECT MAX(CountAcc) FROM CTE_GetMaxGroup);

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
CREATE OR REPLACE VIEW v_list_content AS
SELECT QuestionID, Content, length(Content) AS ChieuDaiCauHoi
FROM question 
WHERE length(Content) > 300;
DROP VIEW v_list_content;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE OR REPLACE VIEW v_list_department AS
WITH CTE_GetMaxAccount AS ( SELECT COUNT(a.DepartmentID) AS SNV FROM `account` a
														 INNER JOIN department d
                                                         ON a.DepartmentID = d.DepartmentID
                                                         GROUP BY a.DepartmentID)
SELECT d.DepartmentName, COUNT(a.DepartmentID) AS SoNhanVien
FROM `account` a
INNER JOIN department d
ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(a.DepartmentID) = ( SELECT MAX(SNV) FROM CTE_GetMaxAccount);

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW v_content AS
SELECT q.Content, a.Username, q.QuestionID
FROM `account` a
INNER JOIN question q ON a.AccountID = q.CreatorID
WHERE a.Username LIKE ('Nguyễn%');