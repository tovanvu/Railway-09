DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE testingSystem;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    Department_ID    INT,
    Department_name  VARCHAR(50)
);
DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
    Position_ID    INT,
    Position_name  VARCHAR(50)
);
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    Account_ID 	   INT,
    Email 		   VARCHAR(50),
    Use_name       VARCHAR(50),
    Full_name      VARCHAR(50),
    Department_ID  INT,
    Position_ID    INT,
    Create_date    DATE
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
    Group_ID       INT,
    Group_name     VARCHAR(50),
    Creator_ID     INT,
    Create_date    DATE
);
DROP TABLE IF EXISTS Group_Account;
CREATE TABLE Group_Accont (
    Group_ID      INT,
    Account_ID    INT,
    Join_date     DATE
);
DROP TABLE IF EXISTS Type_question;
CREATE TABLE Type_question (
    Type_ID      INT,
    Type_name    VARCHAR(50)
);
DROP TABLE IF EXISTS Category_Question;
CREATE TABLE Category_Question (
    Category_ID   INT,
    Category_Name VARCHAR(50)
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    Question_ID   INT,
    Content       VARCHAR(50),
    Category_ID   INT,
    Type_ID       INT,
    Creator_ID    INT,
    Create_Date   DATE
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    Answer_ID    INT,
    Content      VARCHAR(50),
    Question_ID  INT,
    is_Correct   BIT
);
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    Exam_ID      INT,
    `Code`       INT,
    Title        VARCHAR(50),
    Category_ID  INT,
    Duration     INT,
    Creator_ID   INT,
    Create_Date  DATE
);
DROP TABLE IF EXISTS Exam_Question;
CREATE TABLE Exam_Question (
    Exam_ID     INT,
    Question_ID INT
);