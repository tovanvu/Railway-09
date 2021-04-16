package com.vti.frontend;

import java.time.LocalDate;

import com.vti.entity.Account;
import com.vti.entity.Answer;
import com.vti.entity.CategoryQuestion;
import com.vti.entity.Department;
import com.vti.entity.Exam;
import com.vti.entity.Exam.Duration;
import com.vti.entity.Group;
import com.vti.entity.Position;
import com.vti.entity.Position.PositionName;
import com.vti.entity.Question;
import com.vti.entity.TypeQuestion.TypeName;
import com.vti.entity.TypeQuestion;

public class DemoProgram {
	public static void main(String[] args) {
		System.out.println("HELLO VTI");
//		create department
		Department dep1 = new Department();
		dep1.id = 1;
		dep1.name = "Marketing";
		Department dep2 = new Department();
		dep2.id = 2;
		dep2.name = "Sale";
		Department dep3 = new Department();
		dep3.id = 3;
		dep3.name = "Accounting";

//		create Position 		
		Position pos1 = new Position();
		pos1.id = 1;
		pos1.name = PositionName.DEV;
		Position pos2 = new Position();
		pos2.id = 2;
		pos2.name = PositionName.PM;
		Position pos3 = new Position();
		pos3.id = 1;
		pos3.name = PositionName.SCRUM_MASTER;

// 		create Account
		Account acc1 = new Account();
		acc1.id = 1;
		acc1.email = "acc1@gmail.com";
		acc1.fullName = "FullName1";
		acc1.userName = "username1";
		acc1.createDate = LocalDate.of(2021, 04, 15);
		acc1.dep = dep1;
		acc1.positon = pos1;
		Account acc2 = new Account();
		acc2.id = 2;
		acc2.email = "acc2@gmail.com";
		acc2.fullName = "FullName2";
		acc2.userName = "username2";
		acc2.createDate = LocalDate.of(2021, 02, 15);
		acc2.dep = dep3;
		acc2.positon = pos2;
		Account acc3 = new Account();
		acc3.id = 3;
		acc3.email = "acc3@gmail.com";
		acc3.fullName = "FullName3";
		acc3.userName = "username3";
		acc3.createDate = LocalDate.of(2021, 05, 15);
		acc3.dep = dep2;
		acc3.positon = pos3;

//		crete group
		Group group1 = new Group();
		group1.id = 1;
		group1.name = "GroupName1";
		group1.createDate = LocalDate.of(2000, 2, 10);
		group1.creatorId = acc1;
		group1.accounts = new Account[] { acc3, acc2 };
		Group group2 = new Group();
		group2.id = 2;
		group2.name = "GroupName2";
		group2.createDate = LocalDate.of(2021, 2, 10);
		group2.creatorId = acc2;
		group2.accounts = new Account[] { acc3, acc2 };
		Group group3 = new Group();
		group3.id = 3;
		group3.name = "GroupName3";
		group3.createDate = LocalDate.of(2009, 5, 25);
		group3.creatorId = acc3;
		group3.accounts = new Account[] { acc1, acc2 };

//		create TypeQuestion
		TypeQuestion typeQues1 = new TypeQuestion();
		typeQues1.id = 1;
		typeQues1.name = TypeName.ESSAY;
		TypeQuestion typeQues2 = new TypeQuestion();
		typeQues2.id = 2;
		typeQues2.name = TypeName.MULTIPLE_CHOISE;
		TypeQuestion typeQues3 = new TypeQuestion();
		typeQues3.id = 3;
		typeQues3.name = TypeName.ESSAY;

//		create TypeQuestion
		CategoryQuestion categoryQues1 = new CategoryQuestion();
		categoryQues1.id = 1;
		categoryQues1.name = "name1";
		CategoryQuestion categoryQues2 = new CategoryQuestion();
		categoryQues2.id = 2;
		categoryQues2.name = "name2";
		CategoryQuestion categoryQues3 = new CategoryQuestion();
		categoryQues3.id = 3;
		categoryQues3.name = "name3";

//		create Question	
		Question Ques1 = new Question();
		Ques1.id = 1;
		Ques1.content = "content1";
		Ques1.categoryQues = categoryQues2;
		Ques1.typeQuestion = typeQues3;
		Ques1.creatorID = acc1;
		Ques1.createDate = LocalDate.of(1997, 8, 10);
		Question Ques2 = new Question();
		Ques2.id = 2;
		Ques2.content = "content2";
		Ques2.categoryQues = categoryQues1;
		Ques2.typeQuestion = typeQues2;
		Ques2.creatorID = acc3;
		Ques2.createDate = LocalDate.of(1997, 8, 04);
		Question Ques3 = new Question();
		Ques3.id = 3;
		Ques3.content = "content3";
		Ques3.categoryQues = categoryQues1;
		Ques3.typeQuestion = typeQues3;
		Ques3.creatorID = acc2;
		Ques3.createDate = LocalDate.of(1997, 8, 07);

//		create Answer
		Answer answer1 = new Answer();
		answer1.id = 1;
		answer1.content = "contentAnswer1";
		answer1.question = Ques3;
		answer1.creatorID = acc1;
		answer1.isCorrect = true;
		Answer answer2 = new Answer();
		answer2.id = 2;
		answer2.content = "contentAnswer2";
		answer2.question = Ques2;
		answer2.creatorID = acc3;
		answer2.isCorrect = true;
		Answer answer3 = new Answer();
		answer3.id = 3;
		answer3.content = "contentAnswer3";
		answer3.question = Ques2;
		answer3.creatorID = acc1;
		answer3.isCorrect = false;

//		create Exam
		Exam exam1 = new Exam();
		exam1.id = 1;
		exam1.code = 1234;
		exam1.title = "title1";
		exam1.category = categoryQues1;
		exam1.duration = Duration.minute_60;
		exam1.creatorID = acc2;
		exam1.createDate = LocalDate.of(2006, 9, 7);
		exam1.questions = new Question[] { Ques1, Ques3 };
		Exam exam2 = new Exam();
		exam2.id = 2;
		exam2.code = 5136;
		exam2.title = "title2";
		exam2.category = categoryQues2;
		exam2.duration = Duration.minute_90;
		exam2.creatorID = acc3;
		exam2.createDate = LocalDate.of(2006, 4, 7);
		exam2.questions = new Question[] { Ques2, Ques3 };
		Exam exam3 = new Exam();
		exam3.id = 3;
		exam3.code = 5614;
		exam3.title = "title3";
		exam3.category = categoryQues3;
		exam3.duration = Duration.minute_120;
		exam3.creatorID = acc1;
		exam3.createDate = LocalDate.of(2010, 9, 7);
		exam3.questions = new Question[] { Ques1, Ques2 };

// Question 3: Trong file Program.java, hãy in ít nhất 1 giá trị của mỗi đối tượng ra		
		System.out.println("Phong So 1");
		System.out.println("ID:" + dep1.id);
		System.out.println("Name:" + dep1.name);

		System.out.println("Vi Tri So 1");
		System.out.println("ID:" + pos1.id);
		System.out.println("Name:" + pos1.name);

		System.out.println("Account So 1");
		System.out.println("ID:" + acc1.id);
		System.out.println("Email:" + acc1.email);
		System.out.println("User:" + acc1.userName);
		System.out.println("FullName:" + acc1.fullName);
		System.out.println("Ten Phong:" + acc1.dep.name);
		System.out.println("Ten Vi Tri:" + acc1.positon.name);
		System.out.println("Ngay Tao:" + acc1.createDate);

		System.out.println("Group Số 1");
		System.out.println("ID:" + group1.id);
		System.out.println("Name:" + group1.name);
		System.out.println("Tên thành viên:" + group1.creatorId.fullName);
		System.out.println("Ngày Tạo:" + group1.createDate);

		System.out.println("Loại câu hỏi số 2");
		System.out.println("ID:" + typeQues2.id);
		System.out.println("Name:" + typeQues2.name);

		System.out.println("CategoryQuestion số 1");
		System.out.println("ID:" + categoryQues1.id);
		System.out.println("Name:" + categoryQues1.name);

		System.out.println("Câu Hỏi số 1");
		System.out.println("ID:" + Ques1.id);
		System.out.println("Câu Hỏi:" + Ques1.content);
		System.out.println("Tên CategoryQuestion:" + Ques1.categoryQues.name);
		System.out.println("Kiểu câu hỏi:" + Ques1.typeQuestion.name);
		System.out.println("Tên Người Hỏi:" + Ques1.creatorID.fullName);
		System.out.println("Ngày Tạo:" + Ques1.createDate);

		System.out.println("Đáp án số 3");
		System.out.println("ID:" + answer3.id);
		System.out.println("Đáp Án:" + answer3.content);
		System.out.println("Câu Hỏi:" + answer3.question.content);
		System.out.println("Người Giải:" + answer3.creatorID.fullName);
		System.out.println("Đúng hay Sai:" + answer3.isCorrect);

		System.out.println("Bài Kiểm tra số 1");
		System.out.println("ID:" + exam1.id);
		System.out.println("Mã đề:" + exam1.code);
		System.out.println("Loại đề:" + exam1.title);
		System.out.println("Tên CategoryQuestion:" + exam1.category.name);
		System.out.println("Thời Gian Thi:" + exam1.duration);
		System.out.println("Người thi:" + exam1.creatorID.fullName);
		System.out.println("Ngày Thi:" + exam1.createDate);

// TestingSystem_2	
// Exercise 1 (Optional): Flow Control Question 1
// Question 1:
		if (acc2.dep == null) {
			System.out.println("Nhân viên này chưa có phòng ban");
		} else {
			System.out.println("Phòng ban của nhân viên này là :" + acc2.dep.name);
		}
		// Question 2:
		if (acc2.groups == null) {
			System.out.println("Nhân viên này chưa có group");
		} else if (acc2.groups.length == 1 || acc2.groups.length == 2) {
			System.out.println("Group của nhân viên này là Java Fresher, C# Fresher");
		} else if (acc2.groups.length == 3) {
			System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
		} else if (acc2.groups.length >= 4) {
			System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
		}
		// Question 4:
		if (acc1.positon.name == PositionName.DEV) {
			System.out.println("Đây là Developer");
		} else {
			System.out.println("Người này không phải là Developer");
		}

	}
}
