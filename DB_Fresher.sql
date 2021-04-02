DROP DATABASE IF EXISTS Fresher;
CREATE DATABASE Fresher;
USE Fresher;
DROP TABLE IF EXISTS Trainee;
CREATE TABLE Trainee ( 
    Trainee_ID        TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Full_name         VARCHAR(50) NOT NULL,
    Birth_Date        DATE NOT NULL,
    Gender            ENUM ('Male', 'Female', 'Unknown') NOT NULL,
    ET_IQ             INT UNSIGNED NOT NULL CHECK ( ET_IQ <= 20),
    ET_Gmath          INT UNSIGNED NOT NULL CHECK ( ET_Gmath <= 20),
    ET_English        INT UNSIGNED NOT NULL CHECK ( ET_English <= 50),
    Training_Class    VARCHAR(50) NOT NULL,
    Evaluation_Notes  VARCHAR(50) NOT NULL
);    
INSERT INTO Trainee ( Full_name   , Birth_Date, Gender   , ET_IQ, ET_Gmath, ET_English, Training_Class, Evaluation_Notes)
VALUE               ( 'Full_name1', '2021-3-1', 'Male'   , 10   , 10      , 20        , 'VTI001'      , 'DHBKHN'        ),
                    ( 'Full_name2', '2021-3-2', 'Female' , 11   , 11      , 21        , 'VTI002'      , 'DHBKHNA'       ),
                    ( 'Full_name3', '2021-3-3', 'Female' , 13   , 13      , 23        , 'VTI003'      , 'DHBKHNS'       ),
					( 'Full_name4', '2021-3-4', 'Male'   , 14   , 14      , 24        , 'VTI004'      , 'DHBKHND'       ),
                    ( 'Full_name5', '2021-3-5', 'Unknown', 15   , 15      , 25        , 'VTI005'      , 'DHBKHNF'       ),
					( 'Full_name6', '2021-3-6', 'Unknown', 16   , 16      , 26        , 'VTI006'      , 'DHBKHNG'       ),
					( 'Full_name7', '2021-3-7', 'Male'   , 17   , 17      , 27        , 'VTI007'      , 'DHBKHNH'       ),
				    ( 'Full_name8', '2021-3-8', 'Male'   , 18   , 18      , 28        , 'VTI008'      , 'DHBKHNJ'       ),
                    ( 'Full_name9', '2021-3-9', 'Female' , 19   , 19      , 29        , 'VTI009'      , 'DHBKHNK'       ),
                    ( 'Full_name10','2021-4-9', 'Male'   , 12   , 12      , 22        , 'VTI010'      , 'DHBKHNL'       );

-- Question 3: Insert 1 bản ghi mà có điểm ET_IQ =30. Sau đó xem kết quả.
INSERT INTO Trainee (ET_IQ) VALUE ( '30' );

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào và sắp xếp theo ngày sinh. Điểm ET_IQ >=12, ET_Gmath>=12, ET_English>=20
SELECT  Full_name, Birth_Date
FROM    Trainee
WHERE   ET_IQ >= 12 AND ET_Gmath >= 12 AND ET_English >= 20
ORDER BY Birth_Date;

-- Question 5: Viết lệnh để lấy ra thông tin thực tập sinh có tên bắt đầu bằng chữ N và kết thúc bằng chữ C
SELECT *
FROM  Trainee
WHERE Full_name LIKE ('N%C');

-- Question 6: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có ký thự thứ 2 là chữ G
SELECT *
FROM   Trainee
WHERE  Full_name LIKE ('_G%');

-- Question 7: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có 10 ký tự và ký tự cuối cùng là C
SELECT  *
FROM    Trainee
WHERE   Full_name LIKE ('_________C');

-- Question 8: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, lọc bỏ các tên trùng nhau.
SELECT Full_name FROM Trainee GROUP BY Full_name;

-- Question 9: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, sắp xếp các tên này theo thứ tự từ A-Z.
SELECT Full_name FROM Trainee ORDER BY Full_name;

-- Question 10: Viết lệnh để lấy ra thông tin thực tập sinh có tên dài nhất
SELECT *, LENGTH(Full_name) AS DoDaiTen
FROM   Trainee
WHERE  LENGTH(Full_name) = (SELECT MAX(LENGTH(Full_name)) FROM Trainee);

-- Question 11: Viết lệnh để lấy ra ID, Fullname và Ngày sinh thực tập sinh có tên dài nhất
SELECT 	Trainee_ID,
		Full_name,
		Birth_Date,
		LENGTH(Full_name) AS DoDaiTen
FROM	Trainee
WHERE 	LENGTH(Full_name) = (SELECT MAX(LENGTH(Full_name)) FROM Trainee);

-- Question 12: Viết lệnh để lấy ra Tên, và điểm IQ, Gmath, English thực tập sinh có tên dài nhất
SELECT Full_name, ET_IQ, ET_Gmath, ET_English, LENGTH(Full_name) AS DoDaiTen
FROM   Trainee
WHERE  LENGTH(Full_name) = (SELECT MAX(LENGTH(Full_name)) FROM Trainee); 

-- Question 13 Lấy ra 5 thực tập sinh có tuổi nhỏ nhất
SELECT   Full_name, Birth_Date
FROM     Trainee
ORDER BY Birth_Date DESC
LIMIT 5;

-- Question 14: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người thỏa mãn số điểm như sau:
-- • ET_IQ + ET_Gmath>=20
-- • ET_IQ>=8
-- • ET_Gmath>=8
-- • ET_English>=18
SELECT  Full_name
FROM    Trainee
WHERE   (ET_IQ + ET_Gmath) >= 20 
		AND ET_IQ >= 8
		AND ET_Gmath >= 8
        AND ET_English >= 18;
        
-- Question 15: Xóa thực tập sinh có TraineeID = 5 
DELETE FROM Trainee WHERE Trainee_ID = 5;

-- Question 16: Xóa thực tập sinh có tổng điểm ET_IQ, ET_Gmath <=15
DELETE FROM Trainee WHERE (ET_IQ + ET_Gmath) <= 15;

-- Question 17: Xóa thực tập sinh quá 30 tuổi.
DELETE FROM Trainee WHERE (year(now()) - year(Birth_Date)) > 30;

-- Question 18: Thực tập sinh có TraineeID = 3 được chuyển sang lớp " VTI003". Hãy cập nhật thông tin vào database.
UPDATE Trainee SET Trainee_ID = 3 WHERE Training_Class = 'VTI003';

-- Question 19: Do có sự nhầm lẫn khi nhập liệu nên thông tin của học sinh số 10 đang bị sai,
-- hãy cập nhật lại tên thành “LeVanA”, điểm ET_IQ =10, điểm ET_Gmath =15, điểm ET_English = 30.
UPDATE Trainee 
SET 
    Full_name = 'LeVanA',
    ET_IQ = 10,
    ET_Gmath = 15,
    ET_English = 30
WHERE Trainee_ID = 10;

-- Question 20, 21: Đếm xem trong lớp VTI001 có bao nhiêu thực tập sinh.
SELECT COUNT(Trainee_ID) AS SoThucTapSinh FROM Trainee WHERE Training_Class = 'VTI001';

-- Question 22: Đếm tổng số thực tập sinh trong lớp VTI001 và VTI003 có bao nhiêu thực tập sinh.
SELECT COUNT(Trainee_ID) AS SoThucTapSinh, Training_Class
FROM Trainee
WHERE Training_Class = 'VTI001' 
UNION 
SELECT COUNT(Trainee_ID) AS SoThucTapSinh, Training_Class
FROM Trainee
WHERE Training_Class = 'VTI003';

-- Question 23 :Lấy ra số lượng các thực tập sinh theo giới tính: Male, Female, Unknown.
SELECT Gender, COUNT(Trainee_ID) AS SL FROM Trainee GROUP BY Gender;

-- Question 24, 25: Lấy ra lớp có lớn hơn 5 thực tập viên
SELECT Training_Class, COUNT(Trainee_ID) AS SoThucTapSinh 
FROM Trainee 
GROUP BY Training_Class 
HAVING COUNT(Trainee_ID) > 5;

-- Question 26: Lấy ra trường có ít hơn 4 thực tập viên tham gia khóa học
SELECT Evaluation_Notes, COUNT(Trainee_ID) AS SoThucTapSinh 
FROM Trainee 
GROUP BY Evaluation_Notes 
HAVING COUNT(Trainee_ID) < 4;

-- Question 27: Bước 1: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI001'
--              Bước 2: Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI002'
-- 				Bước 3: Sử dụng UNION để nối 2 kết quả ở bước 1 và 2
SELECT Trainee_ID, Full_name, Training_Class FROM Trainee WHERE Training_Class = 'VTI001'
UNION 
SELECT Trainee_ID, Full_name, Training_Class FROM Trainee WHERE Training_Class = 'VTI002';