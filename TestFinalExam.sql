DROP DATABASE IF EXISTS TestFinalExam;
CREATE DATABASE TestFinalExam;
USE TestFinalExam;
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
    Id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    FullName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    `PassWord` VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS `Manager`;
CREATE TABLE `Manager` (
	Id TINYINT UNSIGNED NOT NULL,
    ExpInYear VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id) REFERENCES `User`(Id)
);   
DROP TABLE IF EXISTS `Employee`;
CREATE TABLE `Employee` (
	Id TINYINT UNSIGNED NOT NULL,
    ProSkill ENUM( 'DEV', 'TEST', 'JAVA', 'SQL'),
    FOREIGN KEY (Id) REFERENCES `User`(Id)
);   
DROP TABLE IF EXISTS `Project`;
CREATE TABLE `Project` (
	ProjectId TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    ProjectName VARCHAR(50) NOT NULL,
    TeamSize TINYINT UNSIGNED NOT NULL
);   
DROP TABLE IF EXISTS `EmployeesInProject`;
CREATE TABLE `EmployeesInProject` (
	ProjectId TINYINT UNSIGNED NOT NULL,
    Id TINYINT UNSIGNED NOT NULL,
    `Role` ENUM( 'PM' , 'Employee'),
    FOREIGN KEY (Id) REFERENCES `User`(Id),
    FOREIGN KEY (ProjectId) REFERENCES `Project`(ProjectId)
);   
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName1', 'Email1', 'PassWord1');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName2', 'Email2', 'PassWord2');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName3', 'Email3', 'PassWord3');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName4', 'Email4', 'PassWord4');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName5', 'Email5', 'PassWord5');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName6', 'Email6', 'PassWord6');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName7', 'Email7', 'PassWord7');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName8', 'Email8', 'PassWord8');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName9', 'Email9', 'PassWord9');
INSERT INTO `testfinalexam`.`user` (`FullName`, `Email`, `PassWord`) VALUES ('FullName10', 'Email10', 'PassWord10');
INSERT INTO `testfinalexam`.`Employee` (`ID`, `ProSkill`) VALUES ( 1, 'DEV');
INSERT INTO `testfinalexam`.`Employee` (`ID`, `ProSkill`) VALUES ( 3, 'TEST');
INSERT INTO `testfinalexam`.`Employee` (`ID`, `ProSkill`) VALUES ( 5, 'SQL');
INSERT INTO `testfinalexam`.`Employee` (`ID`, `ProSkill`) VALUES ( 7, 'JAVA');
INSERT INTO `testfinalexam`.`Employee` (`ID`, `ProSkill`) VALUES ( 9, 'DEV');
INSERT INTO `testfinalexam`.`Manager` (`ID`, `ExpInYear`) VALUES ( 2, 6);
INSERT INTO `testfinalexam`.`Manager` (`ID`, `ExpInYear`) VALUES ( 4, 5);
INSERT INTO `testfinalexam`.`Manager` (`ID`, `ExpInYear`) VALUES ( 6, 4);
INSERT INTO `testfinalexam`.`Manager` (`ID`, `ExpInYear`) VALUES ( 8, 2);
INSERT INTO `testfinalexam`.`Manager` (`ID`, `ExpInYear`) VALUES ( 10, 3);
INSERT INTO `testfinalexam`.`project` (`ProjectName`, `TeamSize`) VALUES ('ProjectName1', '2');
INSERT INTO `testfinalexam`.`project` (`ProjectName`, `TeamSize`) VALUES ('ProjectName2', '3');
INSERT INTO `testfinalexam`.`project` (`ProjectName`, `TeamSize`) VALUES ('ProjectName3', '5');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (1, 1, 'PM');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (1, 2, 'Employee');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (2, 3, 'PM');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (2, 4, 'Employee');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (2, 5, 'PM');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (3, 6, 'PM');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (3, 7, 'Employee');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (3, 8, 'Employee');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (3, 9, 'PM');
INSERT INTO `testfinalexam`.`employeesinproject` (`ProjectId`, `Id`, `Role`) VALUES (3, 10, 'Employee');