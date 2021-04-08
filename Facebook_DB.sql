DROP DATABASE IF EXISTS Facebook_DB;
CREATE DATABASE Facebook_DB;
USE Facebook_DB;
DROP TABLE IF EXISTS `National`;
CREATE TABLE `National` (
	  National_id    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      National_Name  NVARCHAR(50) NOT NULL UNIQUE KEY,
      Language_Main  VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS Office;
CREATE TABLE Office (
      Office_id       TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      Street_Address  NVARCHAR(50) NOT NULL,
      National_id     TINYINT UNSIGNED NOT NULL,
	  FOREIGN KEY (National_id) REFERENCES `National`(National_id)
);
DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
      Staff_id 	 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      First_Name NVARCHAR(50) NOT NULL,
      Last_Name  NVARCHAR(50) NOT NULL,
      Email		 VARCHAR(50) NOT NULL UNIQUE KEY,
      Office_id  TINYINT UNSIGNED NOT NULL,
      FOREIGN KEY (Office_id) REFERENCES Office(Office_id)      
);

-- Ques2: Thêm 10 bản ghi vào các table.
INSERT INTO `National` (National_Name, Language_Main)
VALUE                  ('Việt Nam'   , 'Vietnamese'),
					   ('Trung Quốc' , 'Chinese'   ),
                       ('Hàn Quốc '  , 'Korean'    ),
                       ('Nhật Bản'   , 'Japanese'  ),
					   ('Hoa Kỳ'     , 'EngLish'   ),
                       ('Anh'        , 'EngLish'   ),
                       ('Nga'        , 'Tiếng Nga' ),
                       ('Úc'         , 'EngLish'   ),
                       ('Thái Lan'   , 'Tiếng Thái'),
					   ('Lào'        , 'Tiếng Lào' );
INSERT INTO Office (Street_Address, National_id)
VALUE              ('Hà Nội'      , 1          ),
                   ('Thượng hải'  , 2          ),
                   ('Seoul'       , 3          ),
                   ('Tokyo'       , 4          ),
                   ('Califorlia'  , 5          ),
                   ('Luân Đôn'    , 6          ),
                   ('Matxcova'    , 7          ),
                   ('Sydney'      , 8          ),
                   ('Băng Cốc'    , 9          ),
                   ('Viêng Chăn'  , 10         );
INSERT INTO Staff (First_Name, Last_Name   , Email                  , Office_id)
VALUE             ('A'       ,'Nguyễn Văn' , 'nguyenvana@gmail.com' , 1        ),
                  ('B'       ,'Trần Văn'   , 'tranvanb@gmail.com'   , 2        ),
                  ('C'       ,'Nguyễn Thị' , 'nguyenthic@gmail.com' , 3        ),
                  ('D'       ,'Nguyễn Văn' , 'nguyenvand@gmail.com' , 4        ),
                  ('E'       ,'Trương Văn' , 'truongvane@gmail.com' , 5        ),
                  ('F'       ,'Nguyễn Thị' , 'nguyenthif@gmail.com' , 6        ),
                  ('G'       ,'Nguyễn Ngọc', 'nguyenngocg@gmail.com', 7        ),
                  ('H'       ,'Phan Văn'   , 'phanvanh@gmail.com'   , 8        ),
                  ('I'       ,'Phạm Thanh' , 'phamthanhi@gmail.com' , 9        ),
                  ('J'       ,'Nguyễn Văn' , 'nguyenvanj@gmail.com' , 10       );

-- Ques3: Bạn hãy lấy dữ liệu của tất cả nhân viên đang làm việc tại Vietnam.
SELECT s.* FROM staff s 
INNER JOIN Office o ON s.Office_id = o.Office_id
INNER JOIN `National` n ON o.National_id = n.National_id
WHERE n.National_Name = 'Việt Nam';

-- Ques4: Lấy ra ID, FullName, Email, National của mỗi nhân viên.
SELECT s.*, n.National_Name FROM staff s 
INNER JOIN Office o ON s.Office_id = o.Office_id
INNER JOIN `National` n ON o.National_id = n.National_id;

-- Ques5: Lấy ra tên nước mà nhân viên có Email: "daonq@viettel.com.vn" đang làm việc.
SELECT n.National_Name FROM staff s 
INNER JOIN Office o ON s.Office_id = o.Office_id
INNER JOIN `National` n ON o.National_id = n.National_id
WHERE s.Email = 'daonq@viettel.com.vn';

-- Ques6: Bạn hãy tìm xem trên hệ thống có quốc gia nào có thông tin trên hệ thống nhưng không có nhân viên nào đang làm việc.
SELECT n.National_Name FROM `national` n 
LEFT JOIN office o ON n.National_id = o.National_id 
INNER JOIN staff s ON o.Office_id = s.Office_id
WHERE n.National_id IS NULL;

-- Ques7: Thống kê xem trên thế giới có bao nhiêu quốc gia mà FB đang hoạt động sử dụng tiếng Anh làm ngôn ngữ chính.
SELECT COUNT(Language_Main) AS SoQuocGia 
FROM `national` 
WHERE Language_Main = 'EngLish';

-- Ques8: Viết lệnh để lấy ra thông tin nhân viên có tên (First_Name) có 10 ký tự, bắt đầu bằng chữ N và kết thúc bằng chữ C.
SELECT First_Name FROM staff
WHERE length(First_Name) = 10
AND First_Name LIKE ('N$C');

-- Ques9: Bạn hãy tìm trên hệ thống xem có nhân viên nào đang làm việc nhưng do nhập khi
-- nhập liệu bị lỗi mà nhân viên đó vẫn chưa cho thông tin về trụ sở làm việc(Office).
SELECT s.* FROM staff s 
LEFT JOIN office o ON s.Office_id = o.Office_id
WHERE s.Office_id IS NULL;

-- Ques10: Nhân viên có mã ID =9 hiện tại đã nghỉ việc, bạn hãy xóa thông tin của nhân viên này trên hệ thống.
DELETE FROM staff WHERE Staff_id = 9;

-- Ques11: FB vì 1 lý do nào đó không còn muốn hoạt động tại Australia nữa, và Mark Zuckerberg
-- muốn bạn xóa tất cả các thông tin trên hệ thống liên quan đến quốc gia này. 
-- Hãy tạo 1 Procedure có đầu vào là tên quốc gia cần xóa thông tin để làm việc này và gửi lại cho anh ấy.
DROP PROCEDURE IF EXISTS p_delete_national;
Delimiter $$
CREATE PROCEDURE p_delete_national ( IN In_National NVARCHAR(50) )
BEGIN
DELETE FROM `national` WHERE National_Name = In_National;
END $$
Delimiter ;
CALL p_delete_national('Úc');

-- Ques12: Mark muốn biết xem hiện tại đang có bao nhiêu nhân viên trên toàn thế giới đang
-- làm việc cho anh ấy, hãy viết cho anh ấy 1 Function để a ấy có thể lấy dữ liệu này 1 cách nhanh chóng.
DROP FUNCTION IF EXISTS f_SoNhanVien;
Delimiter $$
CREATE FUNCTION f_SoNhanVien() RETURNS TINYINT
BEGIN
DECLARE v_max_staff TINYINT;
SELECT count(Staff_id) INTO v_max_staff
FROM staff;
RETURN v_max_staff;
END $$
Delimiter ;
SELECT f_SoNhanVien();
# chưa chạy đc funtion

-- Ques13: Để thuận tiện cho việc quản trị Mark muốn số lượng nhân viên tại mỗi quốc gia chỉ
-- tối đa 10.000 người. Bạn hãy tạo trigger cho table Staff chỉ cho phép insert mỗi quốc gia có
-- tối đa 10.000 nhân viên giúp anh ấy (có thể cấu hình số lượng nhân viên nhỏ hơn vd 11 nhân
-- viên để Test).
DROP TRIGGER IF EXISTS trig_Check_Insert_Staff;
Delimiter $$
CREATE TRIGGER trig_Check_Insert_Staff
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
DECLARE v_national_ID TINYINT;
DECLARE v_max_staff TINYINT;
SELECT o.National_id INTO v_national_ID FROM office o WHERE o.Office_id = NEW.Office_id;	
SELECT count(s.Staff_id) INTO v_max_staff FROM staff s
INNER JOIN office o ON o.Office_id = s.Office_id
INNER JOIN `national` n ON n.National_id = o.National_id
WHERE n.National_id = v_national_ID;
IF ( v_max_staff >= 10 ) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = ' cant add more staff ';
END IF;
END $$
Delimiter ;
INSERT INTO staff (First_Name  , Last_Name  , Email  , Office_id) 
VALUES		      ('First_Name1', 'Last_Name', 'Email1', 	'1'     ),
				   ('First_Name2', 'Last_Name', 'Email2', 	'1'     ),
                   ('First_Name3', 'Last_Name', 'Email3', 	'1'     ),
                   ('First_Name4', 'Last_Name', 'Email4', 	'1'     ),
                   ('First_Name5', 'Last_Name', 'Email5', 	'1'     ),
                   ('First_Name6', 'Last_Name', 'Email6', 	'1'     ),
                   ('First_Name7', 'Last_Name', 'Email7', 	'1'     ),
                   ('First_Name8', 'Last_Name', 'Email8', 	'1'     ),
                   ('First_Name9', 'Last_Name', 'Email9', 	'1'     ),
                   ('First_Name10', 'Last_Name', 'Email10', 	'1' ),
                   ('First_Name11', 'Last_Name', 'Email11', 	'1'  );
                   
-- Ques14: Bạn hãy viết 1 Procedure để lấy ra tên trụ sở mà có số lượng nhân viên đang làm việc nhiều nhất. 
DROP PROCEDURE IF EXISTS p_max_staff;
Delimiter $$
CREATE PROCEDURE p_max_staff()
BEGIN
WITH CTE_MaxStaff AS ( SELECT count(s.Office_id) AS SL 
                       FROM office o 
                       INNER JOIN staff s ON o.Office_id = s.Office_id
                       GROUP BY s.Office_id )
SELECT o.Street_Address, count(s.Office_id) AS SNV FROM office o 
INNER JOIN staff s ON o.Office_id = s.Office_id
GROUP BY s.Office_id
HAVING count(s.Office_id) = ( SELECT MAX(SL) FROM CTE_MaxStaff ); 
END $$
Delimiter ;
CALL p_max_staff();

-- Ques15: Bạn hãy viết 1 Function để khi nhập vào thông tin Email của nhân viên thì sẽ trả ra thông tin đầy đủ của nhân viên đó. 
DROP FUNCTION IF EXISTS f_Infor_staff;
Delimiter $$
CREATE FUNCTION f_Infor_staff (f_Email VARCHAR(50)) RETURNS NVARCHAR(50)
BEGIN
DECLARE v_First_Name NVARCHAR(50);
DECLARE v_Last_Name NVARCHAR(50);
SELECT First_Name INTO v_First_Name
FROM staff
WHERE Email = f_Email;
RETURN v_First_Name;
SELECT Last_name INTO v_Last_Name
FROM staff
WHERE Email = f_Email;
RETURN v_Last_Name;
END $$
Delimiter ;
SELECT f_SoNhanVien('nguyenthic@gmail.com');
# chưa chạy đc funtion

-- Ques16: Bạn hãy viết 1 Trigger để khi thực hiện cập nhật thông tin về trụ sở làm việc của nhân viên đó thì 
-- hệ thống sẽ tự động lưu lại trụ sở cũ của nhân viên vào 1 bảng khác có tên Log_Office để Mark có thể xem lại khi cần thiết. 

-- Ques17: FB đang vướng vào 1 đạo luật hạn chế hoạt động, FB chỉ có thể hoạt động tối đa trên 100 quốc gia trên thế giới,
-- hãy tạo Trigger để ngăn người nhập liệu nhập vào quốc gia thứ 101 (bạn có thể sử dụng số nước nhỏ hơn để Test VD 11 nước). 
DROP TRIGGER IF EXISTS trig_Check_Insert_National;
Delimiter $$
CREATE TRIGGER trig_Check_Insert_National
BEFORE INSERT ON `national`
FOR EACH ROW
BEGIN
DECLARE v_max_national TINYINT;
SELECT count(National_id) INTO v_max_national
FROM `national`;
IF (v_max_national >= 10) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'cant add more national';
END IF;
END $$
Delimiter ;
INSERT INTO `national` (National_Name  , Language_Main) 
VALUES		            ('National_Name1', 'Language_Main1');

-- Ques18, Ques23: Thống kê mỗi xem mỗi nước(National) đang có bao nhiêu nhân viên đang làm việc. 
SELECT n.National_Name, count(s.Office_id) AS SNV
FROM office o
INNER JOIN staff s ON o.Office_id = s.Office_id
INNER JOIN `national` n ON n.National_id = o.National_id
GROUP BY s.Office_id;

-- Ques19: Viết Procedure để thống kê mỗi xem mỗi nước(National) đang có bao nhiêu nhân viên đang làm việc, với đầu vào là tên nước. 
DROP PROCEDURE IF EXISTS p_count_staff;
Delimiter $$
CREATE PROCEDURE p_count_staff( IN In_Naltiona_name NVARCHAR(50) )
BEGIN
SELECT count(s.Staff_id) AS SNV
FROM office o
INNER JOIN staff s ON o.Office_id = s.Office_id
INNER JOIN `national` n ON n.National_id = o.National_id
WHERE n.National_Name = In_Naltiona_name;
END $$
Delimiter ;
CALL p_count_staff('Việt nam');

-- Ques20: Thống kê mỗi xem trong cùng 1 trụ sở (Office) đang có bao nhiêu employee đang làm việc. 
SELECT s.Office_id, o.Street_Address, count(s.Office_id) AS SNV
FROM staff s 
JOIN office o ON s.Office_id = o.Office_id
GROUP BY s.Office_id;

-- Ques21: Viết Procedure để thống kê mỗi xem trong cùng 1 trụ sở (Office) đang có bao nhiêu employee đang làm việc đầu vào là ID của trụ sở. 
DROP PROCEDURE IF EXISTS p_count_staff_of_office;
Delimiter $$
CREATE PROCEDURE p_count_staff_of_office( IN In_Office_ID TINYINT )
BEGIN
SELECT count(s.Staff_id) AS SNV
FROM office o
INNER JOIN staff s ON o.Office_id = s.Office_id
WHERE s.Office_id = In_Office_ID;
END $$
Delimiter ;
CALL p_count_staff_of_office('1');

-- Ques22: Viết Procedure để lấy ra tên quốc gia đang có nhiều nhân viên nhất. 
DROP PROCEDURE IF EXISTS p_max_staff_of_national;
Delimiter $$
CREATE PROCEDURE p_max_staff_of_national ()
BEGIN
WITH CTE_MaxStaff AS ( SELECT count(s.Staff_id) AS SL
					   FROM office o
                       INNER JOIN staff s ON o.Office_id = s.Office_id
                       INNER JOIN `national` n ON n.National_id = o.National_id
                       GROUP BY s.Office_id)
SELECT n.National_Name, count(s.Staff_id) AS SNV
FROM office o
INNER JOIN staff s ON o.Office_id = s.Office_id
INNER JOIN `national` n ON n.National_id = o.National_id
GROUP BY s.Office_id
HAVING count(s.Staff_id) = (SELECT MAX(SL) FROM CTE_MaxStaff);
END $$
Delimiter ;
CALL p_max_staff_of_national();

-- Ques24: Bạn hãy cấu hình lại các bảng và ràng buộc giữ liệu sao cho khi xóa 1 trụ sở làm việc (Office)
-- thì tất cả dữ liệu liên quan đến trụ sở này sẽ chuyển về Null 
DROP DATABASE IF EXISTS Facebook_DB;
CREATE DATABASE Facebook_DB;
USE Facebook_DB;
DROP TABLE IF EXISTS `National`;
CREATE TABLE `National` (
	  National_id    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      National_Name  NVARCHAR(50) NOT NULL UNIQUE KEY,
      Language_Main  VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS Office;
CREATE TABLE Office (
      Office_id       TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      Street_Address  NVARCHAR(50) ,
      National_id     TINYINT UNSIGNED ,
	  FOREIGN KEY (National_id) REFERENCES `National`(National_id) ON DELETE SET NULL    
);
DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
      Staff_id 	 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      First_Name NVARCHAR(50) NOT NULL,
      Last_Name  NVARCHAR(50) NOT NULL,
      Email		 VARCHAR(50) NOT NULL UNIQUE KEY,
      Office_id  TINYINT UNSIGNED ,
      FOREIGN KEY (Office_id) REFERENCES Office(Office_id) ON DELETE SET NULL     
);

-- Ques25: Bạn hãy cấu hình lại các bảng và ràng buộc giữ liệu sao cho khi xóa 1 trụ sở làm việc (Office)
-- thì tất cả dữ liệu liên quan đến trụ sở này sẽ bị xóa hết. 
DROP DATABASE IF EXISTS Facebook_DB;
CREATE DATABASE Facebook_DB;
USE Facebook_DB;
DROP TABLE IF EXISTS `National`;
CREATE TABLE `National` (
	  National_id    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      National_Name  NVARCHAR(50) NOT NULL UNIQUE KEY,
      Language_Main  VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS Office;
CREATE TABLE Office (
      Office_id       TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      Street_Address  NVARCHAR(50) NOT NULL,
      National_id     TINYINT UNSIGNED NOT NULL,
	  FOREIGN KEY (National_id) REFERENCES `National`(National_id) ON DELETE CASCADE
);
DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
      Staff_id 	 TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
      First_Name NVARCHAR(50) NOT NULL,
      Last_Name  NVARCHAR(50) NOT NULL,
      Email		 VARCHAR(50) NOT NULL UNIQUE KEY,
      Office_id  TINYINT UNSIGNED NOT NULL,
      FOREIGN KEY (Office_id) REFERENCES Office(Office_id) ON DELETE CASCADE     
);