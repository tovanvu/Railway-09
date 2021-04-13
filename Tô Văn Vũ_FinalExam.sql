-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 3 bản ghi vào table
DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;
DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien (
	magv 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hoten	VARCHAR(50) NOT NULL,
    luong	INT UNSIGNED NOT NULL
);
DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	masv 	MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hoten	VARCHAR(50) NOT NULL,
    namsinh	DATETIME NOT NULL,
    quequan VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS DeTai ;
CREATE TABLE DeTai (
	madt 		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tendt		VARCHAR(50) NOT NULL UNIQUE KEY,
    kinhphi		INT UNSIGNED NOT NULL,
    NoiThucTap 	VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS HuongDan ;
CREATE TABLE HuongDan (
	id 		MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    masv	MEDIUMINT UNSIGNED NOT NULL,
    madt	MEDIUMINT UNSIGNED NOT NULL,
    magv 	TINYINT UNSIGNED NOT NULL,
    ketqua 	ENUM('Dat','KhongDat') NOT NULL,
CONSTRAINT fk_HuongDan_SinhVien FOREIGN KEY (masv) REFERENCES SinhVien(masv),
CONSTRAINT fk_HuongDan_GiangVien FOREIGN KEY (magv) REFERENCES GiangVien(magv),
CONSTRAINT fk_HuongDan_DeTai FOREIGN KEY (madt) REFERENCES DeTai(madt)
);
INSERT INTO `thuctap`.`giangvien` (`hoten`, `luong`) VALUES ('giangvien1', '1000');
INSERT INTO `thuctap`.`giangvien` (`hoten`, `luong`) VALUES ('giangvien2', '1100');
INSERT INTO `thuctap`.`giangvien` (`hoten`, `luong`) VALUES ('giangvien3', '1200');
INSERT INTO `thuctap`.`sinhvien` (`hoten`, `namsinh`, `quequan`) VALUES ('sinhvien1', '2000-02-01 00:00:00', 'HaNoi');
INSERT INTO `thuctap`.`sinhvien` (`hoten`, `namsinh`, `quequan`) VALUES ('sinhvien2', '2002-03-01 00:00:00', 'LangSon');
INSERT INTO `thuctap`.`sinhvien` (`hoten`, `namsinh`, `quequan`) VALUES ('sinhvien3', '2001-02-02 00:00:00', 'HaiPhong');
INSERT INTO `thuctap`.`detai` (`tendt`, `kinhphi`, `NoiThucTap`) VALUES ('tendt1', '100', 'HaNoi');
INSERT INTO `thuctap`.`detai` (`tendt`, `kinhphi`, `NoiThucTap`) VALUES ('CONG NGHE SINH HOC', '200', 'SaiGon');
INSERT INTO `thuctap`.`detai` (`tendt`, `kinhphi`, `NoiThucTap`) VALUES ('tendt3', '300', 'DaNang');
INSERT INTO `thuctap`.`huongdan` (`masv`, `madt`, `magv`, `ketqua`) VALUES ('1', '3', '2', 'Dat');
INSERT INTO `thuctap`.`huongdan` (`masv`, `madt`, `magv`, `ketqua`) VALUES ('1', '3', '2', 'KhongDat');
INSERT INTO `thuctap`.`huongdan` (`masv`, `madt`, `magv`, `ketqua`) VALUES ('2', '2', '3', 'Dat');

-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’
SELECT s.masv, s.hoten FROM sinhvien s 
LEFT JOIN huongdan h ON s.masv = h.masv
WHERE h.masv IS NULL;

SELECT d.tendt, count(h.madt) AS SoSinhVien
FROM detai d 
INNER JOIN huongdan h ON h.madt = d.madt
WHERE d.tendt = 'CONG NGHE SINH HOC';

-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
CREATE OR REPLACE VIEW v_SinhVienInfo AS
SELECT s.masv, s.hoten, d.tendt
FROM sinhvien s 
JOIN huongdan h ON h.masv = s.masv
JOIN detai d ON d.madt = h.madt
GROUP BY s.masv
UNION
SELECT s.masv, s.hoten, 'chua co' AS tendt
FROM sinhvien s
LEFT JOIN huongdan h ON s.masv = h.masv
WHERE h.masv IS NULL;
SELECT * FROM v_SinhVienInfo;

-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900
-- thì hiện ra thông báo "năm sinh phải > 1900"
DROP TRIGGER IF EXISTS Trig_InserNamSinh;
Delimiter $$
CREATE TRIGGER Trig_InserNamSinh
BEFORE INSERT ON sinhvien
FOR EACH ROW 
BEGIN 
		IF (year(NEW.namsinh) <= 1900) THEN 
		SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'năm sinh phải > 1900';
		END IF;
END $$
Delimiter ;
INSERT INTO `thuctap`.`sinhvien` (`hoten`, `namsinh`, `quequan`) VALUES (1, '1890-02-01 00:00:00', 1);

-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi
ALTER TABLE huongdan DROP CONSTRAINT fk_HuongDan_SinhVien;
ALTER TABLE huongdan ADD  CONSTRAINT fk_HuongDan_SinhVien FOREIGN KEY (masv) REFERENCES SinhVien(masv) ON DELETE CASCADE;
DELETE FROM `thuctap`.`sinhvien` WHERE (`masv` = '2');
