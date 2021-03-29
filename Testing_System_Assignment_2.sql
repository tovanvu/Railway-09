DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    Department_ID    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Department_name  NVARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
    Position_ID    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Position_name  ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    Account_ID 	   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email 		   VARCHAR(50) NOT NULL UNIQUE KEY,
    User_name      VARCHAR(50) NOT NULL UNIQUE KEY,
    Full_name      NVARCHAR(50) NOT NULL,
    Department_ID  TINYINT UNSIGNED NOT NULL,
    Position_ID    TINYINT UNSIGNED NOT NULL,
    Create_date    DATETIME DEFAULT NOW(),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Position_ID)   REFERENCES `Position`(Position_ID)
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
    Group_ID       TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Group_name     VARCHAR(50) NOT NULL UNIQUE KEY,
    Creator_ID     TINYINT UNSIGNED,
    Create_date    DATETIME DEFAULT NOW(),
    FOREIGN KEY (Creator_ID) REFERENCES `Account`(Account_ID)
);
DROP TABLE IF EXISTS Group_Account;
CREATE TABLE Group_Account (
    Group_ID      TINYINT UNSIGNED NOT NULL,
    Account_ID    TINYINT UNSIGNED NOT NULL,
    Join_date     DATETIME DEFAULT NOW(),
    PRIMARY KEY (Group_ID, Account_ID),
	FOREIGN KEY (Group_ID)   REFERENCES `Group`(Group_ID),
    FOREIGN KEY (Account_ID) REFERENCES `Account`(Account_ID)
);
DROP TABLE IF EXISTS Type_question;
CREATE TABLE Type_question (
    Type_ID      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Type_name    ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Category_Question;
CREATE TABLE Category_Question (
    Category_ID   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(50) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    Question_ID   TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content       NVARCHAR(50) NOT NULL,
    Category_ID   TINYINT UNSIGNED NOT NULL,
    Type_ID       TINYINT UNSIGNED NOT NULL,
    Creator_ID    TINYINT UNSIGNED NOT NULL,
    Create_Date   DATETIME DEFAULT NOW(),
    FOREIGN KEY (Category_ID) REFERENCES Category_Question(Category_ID),
    FOREIGN KEY (Type_ID)     REFERENCES Type_question(Type_ID),
    FOREIGN KEY (Creator_ID)  REFERENCES `Account`(Account_ID)
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    Answer_ID    TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content      VARCHAR(50) NOT NULL,
    Question_ID  TINYINT UNSIGNED NOT NULL,
    is_Correct   BIT DEFAULT 1,
    FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID)
);
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    Exam_ID      TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`       CHAR(10) NOT NULL,
    Title        NVARCHAR(50) NOT NULL,
    Category_ID  TINYINT UNSIGNED NOT NULL,
    Duration     TINYINT UNSIGNED NOT NULL,
    Creator_ID   TINYINT UNSIGNED NOT NULL,
    Create_Date  DATETIME DEFAULT NOW(),
    FOREIGN KEY (Category_ID) REFERENCES Category_Question(Category_ID),
	FOREIGN KEY (Creator_ID)  REFERENCES `Account`(Account_ID)
);
DROP TABLE IF EXISTS Exam_Question;
CREATE TABLE Exam_Question (
    Exam_ID     TINYINT UNSIGNED NOT NULL,
    Question_ID TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (Exam_ID, Question_ID),
    FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID),
    FOREIGN KEY (Exam_ID)     REFERENCES Exam(Exam_ID)
);
INSERT INTO Department (Department_Name)
VALUE ('Marketing'),
      ('Bảo vệ'),
      ('Nhân sự'),
      ('Sale'),
      ('Kỹ thuật');
INSERT INTO `Position` (Position_name)
VALUE ('Dev'),
      ('Test'),
      ('Scrum Master'),
      ('PM');
INSERT INTO `Account` (Email, User_name, Full_name, Department_ID, Position_ID, Create_date)
VALUE ('email1@gmail,com', 'Username1', 'Fullname1', '1', '1', '2020-03-01'),
      ('email2@gmail,com', 'Username2', 'Fullname2', '2', '2', '2020-03-02'),
      ('email3@gmail,com', 'Username3', 'Fullname3', '3', '3', '2020-03-03'),
      ('email4@gmail,com', 'Username4', 'Fullname4', '4', '4', '2020-03-04'),
      ('email5@gmail,com', 'Username5', 'Fullname5', '5', '4', '2020-03-05');
INSERT INTO `Group` (Group_name, Creator_ID, Create_date)
VALUE ( 'Group_name11', '6', '2020-04-01'),
      ( 'Group_name12', '7', '2020-04-02'),
      ( 'Group_name13', '8', '2020-04-03'),
      ( 'Group_name14', '9', '2020-04-04'),
      ( 'Group_name15', '10', '2020-04-05');
INSERT INTO Group_Account (Group_ID, Account_ID, Join_date)
VALUE ('6', '6', '2020-05-01'),
      ('7', '7', '2020-05-02'),
      ('8', '8', '2020-05-08'),
      ('9', '9', '2020-05-09'),
      ('10', '10', '2020-05-04');
INSERT INTO Type_question (Type_name)
VALUE ('Essay'),
      ('Multiple-Choice');
INSERT INTO Category_Question (Category_Name)
VALUE ('Category_Name1'),
      ('Category_Name2'),
      ('Category_Name3'),
      ('Category_Name4'),
      ('Category_Name5');
INSERT INTO Question (Content, Category_ID, Type_ID, Creator_ID)
VALUE ('Content1', '1', '1', '6'),
      ('Content2', '2', '2', '7'),
      ('Content3', '3', '1', '8'),
      ('Content4', '4', '2', '9'),
      ('Content5', '5', '1', '10');
INSERT INTO Answer (Content, Question_ID)
VALUE ('Content7', '1'),
      ('Content8', '2'),
      ('Content9', '3'),
      ('Content10', '4'),
      ('Content11', '5');
INSERT INTO Exam (`Code`, Title, Category_ID, Duration, Creator_ID)
VALUE ('CODE01', 'Title1', '1', '60', '6'),
	  ('CODE02', 'Title2', '2', '90', '7'),
      ('CODE03', 'Title3', '3', '90', '8'),
      ('CODE04', 'Title4', '4', '60', '9'),
      ('CODE05', 'Title5', '5', '90', '10');
INSERT INTO Exam_Question (Exam_ID, Question_ID)
VALUE ('1', '2'),
      ('2', '1'),
      ('3', '4'),
      ('4', '5'),
      ('5', '3');