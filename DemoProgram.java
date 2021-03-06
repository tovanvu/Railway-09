package com.vti.frontend;

import java.time.LocalDate;
import java.util.Random;
import java.util.Scanner;

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
		Account acc5 = new Account(5, "email5", "usernam5", "fullname5");

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
//		add group account
		acc1.groups = new Group[] { group1, group3 };
		acc2.groups = new Group[] { group2, group3 };
		acc3.groups = new Group[] { group2, group1 };
// Question 3: Trong file Program.java, h??y in ??t nh???t 1 gi?? tr??? c???a m???i ?????i t?????ng ra		
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

		System.out.println("Group S??? 1");
		System.out.println("ID:" + group1.id);
		System.out.println("Name:" + group1.name);
		System.out.println("T??n th??nh vi??n:" + group1.creatorId.fullName);
		System.out.println("Ng??y T???o:" + group1.createDate);

		System.out.println("Lo???i c??u h???i s??? 2");
		System.out.println("ID:" + typeQues2.id);
		System.out.println("Name:" + typeQues2.name);

		System.out.println("CategoryQuestion s??? 1");
		System.out.println("ID:" + categoryQues1.id);
		System.out.println("Name:" + categoryQues1.name);

		System.out.println("C??u H???i s??? 1");
		System.out.println("ID:" + Ques1.id);
		System.out.println("C??u H???i:" + Ques1.content);
		System.out.println("T??n CategoryQuestion:" + Ques1.categoryQues.name);
		System.out.println("Ki???u c??u h???i:" + Ques1.typeQuestion.name);
		System.out.println("T??n Ng?????i H???i:" + Ques1.creatorID.fullName);
		System.out.println("Ng??y T???o:" + Ques1.createDate);

		System.out.println("????p ??n s??? 3");
		System.out.println("ID:" + answer3.id);
		System.out.println("????p ??n:" + answer3.content);
		System.out.println("C??u H???i:" + answer3.question.content);
		System.out.println("Ng?????i Gi???i:" + answer3.creatorID.fullName);
		System.out.println("????ng hay Sai:" + answer3.isCorrect);

		System.out.println("B??i Ki???m tra s??? 1");
		System.out.println("ID:" + exam1.id);
		System.out.println("M?? ?????:" + exam1.code);
		System.out.println("Lo???i ?????:" + exam1.title);
		System.out.println("T??n CategoryQuestion:" + exam1.category.name);
		System.out.println("Th???i Gian Thi:" + exam1.duration);
		System.out.println("Ng?????i thi:" + exam1.creatorID.fullName);
		System.out.println("Ng??y Thi:" + exam1.createDate);

// TestingSystem_2	
// Exercise 1 (Optional): Flow Control Question 1
// Question 1:
		if (acc2.dep == null) {
			System.out.println("Nh??n vi??n n??y ch??a c?? ph??ng ban");
		} else {
			System.out.println("Ph??ng ban c???a nh??n vi??n n??y l?? :" + acc2.dep.name);
		}
		// Question 2:
		if (acc2.groups == null) {
			System.out.println("Nh??n vi??n n??y ch??a c?? group");
		} else if (acc2.groups.length == 1 || acc2.groups.length == 2) {
			System.out.println("Group c???a nh??n vi??n n??y l?? Java Fresher, C# Fresher");
		} else if (acc2.groups.length == 3) {
			System.out.println("Nh??n vi??n n??y l?? ng?????i quan tr???ng, tham gia nhi???u group");
		} else if (acc2.groups.length >= 4) {
			System.out.println("Nh??n vi??n n??y l?? ng?????i h??ng chuy???n, tham gia t???t c??? c??c group");
		}
// Question3:
		System.out.println(acc2.dep == null ? "Nh??n vi??n n??y ch??a c?? ph??ng ban"
				: "Ph??ng ban c???a nh??n vi??n n??y l?? :" + acc2.dep.name);

// Question 4:
		System.out.println(
				acc1.positon.name == PositionName.DEV ? "????y l?? Developer" : "Ng?????i n??y kh??ng ph???i l?? Developer");
// Question 5:
		System.out.println("Question 5: L???y ra s??? l?????ng account ");
		if (group1.accounts == null) {
			System.out.println("Group ch??a c?? th??nh vi??n tham gia");
		} else {
			int countAccOfGroup = group1.accounts.length;
			switch (countAccOfGroup) {
			case 1:
				System.out.println("Nh??m c?? m???t th??nh vi??n");
				break;
			case 2:
				System.out.println("Nh??m c?? hai th??nh vi??n");
				break;
			case 3:
				System.out.println("Nh??m c?? ba th??nh vi??n");
				break;
			default:
				System.out.println("Nh??m c?? nhi???u th??nh vi??n");
				break;
			}
		}
// Question 6: 
		System.out.println("Question 6: S??? d???ng switch case ????? l??m l???i Question 2");
		if (acc2.groups == null) {
			System.out.println("Nh??n vi??n n??y ch??a c?? group");
		} else {
			int countGroupsOfAcc = acc2.groups.length;
			switch (countGroupsOfAcc) {
			case 1:
				System.out.println("Group c???a nh??n vi??n n??y l?? Java Fresher, C# Fresher");
				break;
			case 2:
				System.out.println("Group c???a nh??n vi??n n??y l?? Java Fresher, C# Fresher");
				break;
			case 3:
				System.out.println("Nh??n vi??n n??y l?? ng?????i quan tr???ng, tham gia nhi???u group");
				break;
			default:
				System.out.println("Nh??n vi??n n??y l?? ng?????i h??ng chuy???n, tham gia t???t c??? c??c group");
				break;
			}
		}
// Question 7: 
		System.out.println("Question 7: S??? d???ng switch case ????? l??m l???i Question 4");
		String z = acc1.positon.name.toString();
		switch (z) {
		case "DEV":
			System.out.println("????y l?? Developer");
			break;
		default:
			System.out.println("Ng?????i n??y kh??ng ph???i l?? Developer");
		}
// Question 8:
		System.out.println("Question 8: In ra th??ng tin c??c account bao g???m: Email, FullName v?? t??n ph??ng ban c???a h???");
		Account[] AccArray = { acc1, acc2, acc3 };
		for (Account account : AccArray) {
			System.out.println("AccountID:" + account.id + " Email:" + account.email + " Full_Name:" + account.fullName
					+ " Ph??ng_Ban:" + account.dep.name);
		}
// Question 9:
		System.out.println("Question 9: In ra th??ng tin c??c ph??ng ban bao g???m: id v?? name");
		Department[] depArray = { dep1, dep2, dep3 };
		for (Department department : depArray) {
			System.out.println("DepID:" + department.id + " DepName:" + department.name);
		}
// Question 10:		
		System.out.println("Question 10: In ra th??ng tin c??c account bao g???m: Email, FullName v?? t??n ph??ng ban c???a h???");
		Account[] AccArray1 = { acc1, acc2, acc3 };
		for (int i = 0; i < AccArray1.length; i++) {
			System.out.println("Th??ng tin account th??? " + (i + 1) + " l??:");
			System.out.println("Email: " + AccArray1[i].email);
			System.out.println("FullName: " + AccArray1[i].fullName);
			System.out.println("Ph??ng_Ban: " + AccArray1[i].dep.name);
		}
// Question 11:			
		System.out.println("Question 11: In ra th??ng tin c??c ph??ng ban bao g???m: id v?? name");
		Department[] DepArray1 = { dep1, dep2, dep3 };
		for (int i = 0; i < DepArray1.length; i++) {
			System.out.println("Th??ng tin ph??ng ban th??? " + (i + 1) + " l??:");
			System.out.println("ID: " + DepArray1[i].id);
			System.out.println("Name: " + DepArray1[i].name);
		}
// Question 12:		
		System.out.println("Question 12: Ch??? in ra th??ng tin 2 department ?????u ti??n theo ?????nh d???ng nh?? Question 10");
		Account[] AccArray2 = { acc1, acc2, acc3 };
		for (int i = 0; i < 2; i++) {
			System.out.println("Th??ng tin account th??? " + (i + 1) + " l??:");
			System.out.println("Email: " + AccArray2[i].email);
			System.out.println("FullName: " + AccArray2[i].fullName);
			System.out.println("Ph??ng_Ban: " + AccArray2[i].dep.name);
		}
// Question 13:
		System.out.println("Question 13: In ra th??ng tin t???t c??? c??c account ngo???i tr??? account th??? 2");
		Account[] AccArray6 = { acc1, acc2, acc3 };
		for (int i = 0; i < AccArray6.length; i++) {
			if (i != 1) {
				System.out.println("Th??ng tin account th??? " + (i + 1) + " l??:");
				System.out.println("Email: " + AccArray6[i].email);
				System.out.println("FullName: " + AccArray6[i].fullName);
				System.out.println("Ph??ng_Ban: " + AccArray6[i].dep.name);
			}
		}
// Question 14:
		System.out.println("Question 14: In ra th??ng tin t???t c??? c??c account c?? id < 4");
		Account[] Account2Array = { acc1, acc2, acc3 };
		for (int i = 0; i < Account2Array.length; i++) {
			if (Account2Array[i].id < 4) {
				System.out.println("Th??ng tin account th??? " + (i + 1) + " l??:");
				System.out.println("Email: " + Account2Array[i].email);
				System.out.println("FullName: " + Account2Array[i].fullName);
				System.out.println("Ph??ng_Ban: " + Account2Array[i].dep.name);
			}
		}
// Question 15:				
		System.out.println("Question 15: In ra c??c s??? ch???n nh??? h??n ho???c b???ng 20");
		for (int i = 2; i <= 20; i = i + 2) {
			System.out.println(i);
		}
// Question 16:
		System.out.println("Question 16: S??? d???ng while in ra th??ng tin t???t c??? c??c account");
		Account[] AccArray3 = { acc1, acc2, acc3 };
		int i3 = 0;
		while (i3 < AccArray3.length) {
			System.out.println("Th??ng tin account th??? " + (i3 + 1) + " l??:");
			System.out.println("Email: " + AccArray3[i3].email);
			System.out.println("FullName: " + AccArray3[i3].fullName);
			System.out.println("Ph??ng_Ban: " + AccArray3[i3].dep.name);
			i3++;
		}
		System.out.println("S??? d???ng while in ra th??ng tin c??c ph??ng ban bao g???m: id v?? name");
		Department[] DepArray2 = { dep1, dep2, dep3 };
		int i1 = 0;
		while (i1 < DepArray2.length) {
			System.out.println("Th??ng tin ph??ng ban th??? " + (i1 + 1) + " l??:");
			System.out.println("ID: " + DepArray2[i1].id);
			System.out.println("Name: " + DepArray2[i1].name);
			i1++;
		}
		System.out.println("s??? d???ng while in ra th??ng tin 2 department ?????u ti??n");
		Account[] AccountArray = { acc1, acc2, acc3 };
		int i = 0;
		while (i < 2) {
			System.out.println("Th??ng tin account th??? " + (i + 1) + " l??:");
			System.out.println("Email: " + AccountArray[i].email);
			System.out.println("FullName: " + AccountArray[i].fullName);
			System.out.println("Ph??ng_Ban: " + AccountArray[i].dep.name);
			i++;
		}

		System.out.println("S??? d???ng While in ra th??ng tin t???t c??? c??c account c?? id < 4");
		Account[] Account4Array = { acc1, acc2, acc3 };
		int j = 0;
		while (j < Account4Array.length) {
			if (Account4Array[j].id < 4) {
				System.out.println("Th??ng tin account th??? " + (j + 1) + " l??:");
				System.out.println("Email: " + Account4Array[j].email);
				System.out.println("FullName: " + Account4Array[j].fullName);
				System.out.println("Ph??ng_Ban: " + Account4Array[j].dep.name);
				j++;
			}
		}
		System.out.println("S??? d???ng While in ra th??ng tin t???t c??? c??c account ngo???i tr??? account th??? 2");
		Account[] AccArray9 = { acc1, acc2, acc3 };
		int z3 = 0;
		while (z3 < AccArray9.length) {
			if (z3 == 1) {
				z3++;
				continue;
			}
			System.out.println("Th??ng tin account th??? " + (z3 + 1) + " l??:");
			System.out.println("Email: " + AccArray9[z3].email);
			System.out.println("FullName: " + AccArray9[z3].fullName);
			System.out.println("Ph??ng_Ban: " + AccArray9[z3].dep.name);
			z3++;
		}
		System.out.println("S??? d???ng While in ra c??c s??? ch???n nh??? h??n ho???c b???ng 20");
		i = 2;
		while (i <= 20) {
			System.out.println(i);
			i = i + 2;
		}
// Question 17:
		System.out.println("Question 17: S??? d???ng do while in ra th??ng tin t???t c??? c??c account");
		Account[] AccArray4 = { acc1, acc2, acc3 };
		int i2 = 0;
		do {
			System.out.println("Th??ng tin account th??? " + (i2 + 1) + " l??:");
			System.out.println("Email: " + AccArray4[i2].email);
			System.out.println("FullName: " + AccArray4[i2].fullName);
			System.out.println("Ph??ng_Ban: " + AccArray4[i2].dep.name);
			i2++;
		} while (i2 < AccArray4.length);
// Exercise 2:
// Exercise 3: 			
// Exercise 4:
// Question 1:
		System.out.println("Question 1: In ng???u nhi??n ra 1 s??? nguy??n");
		Random random2 = new Random();
		int n3 = random2.nextInt();
		System.out.println("S??? ng???u nhi??n l??: " + n3);
// Question 2:
		System.out.println("Question 1: In ng???u nhi??n ra 1 s??? th???c");
		Random random3 = new Random();
		float n4 = random3.nextFloat();
		System.out.println("S??? ng???u nhi??n l??: " + n4);
// Question 3:
		System.out.println("Question 3: in ng???u nhi??n ra t??n c???a 1 b???n");
		Account[] studentArray = { acc1, acc2, acc3 };
		Random random1 = new Random();
		int n1 = random1.nextInt(studentArray.length);
		System.out.println("T??n ng???u nhi??n: " + studentArray[n1].fullName);
// Question 4:
		Random random = new Random();
		int minDay = (int) LocalDate.of(1995, 7, 24).toEpochDay();
		int maxDay = (int) LocalDate.of(1995, 12, 20).toEpochDay();
		System.out.println("minday:" + minDay);
		System.out.println("maxday:" + maxDay);
		long randomInt = minDay + random.nextInt(maxDay - minDay);
		LocalDate randomDay = LocalDate.ofEpochDay(randomInt);
		System.out.println(randomDay);
// Question 7:
		Random random5 = new Random();
		int n5 = random5.nextInt(999 - 100 + 1);
		System.out.println("S??? ng???u nhi??n c?? 3 ch??? s??? l??: " + n5);
// Execise 5;
// Question 1:
		System.out.println("H??y nh???p v??o 3 s??? nguy??n");
		Scanner sc = new Scanner(System.in);
		for (int a = 0; a < 3; a++) {
			int t = sc.nextInt();
		}
// Question 2:
		System.out.println("H??y nh???p v??o 3 s??? th???c");
		for (int a = 0; a < 3; a++) {
			double y = sc.nextDouble();
		}
// Question 3:		
		System.out.println("H??y nh???p v??o h??? c???a b???n: ");
		String h = sc.next();
		System.out.println("H??y nh???p v??o t??n c???a b???n: ");
		String t = sc.next();
// Question 5:
		Account acc = new Account();
		Scanner sc1 = new Scanner(System.in);
		System.out.println("M???i b???n nh???p v??o ID: ");
		acc.id = sc1.nextInt();
		System.out.println("M???i b???n nh???p v??o Email: ");
		acc.email = sc1.next();
		System.out.println("M???i b???n nh???p v??o UserName: ");
		acc.userName = sc1.next();
		System.out.println("M???i b???n nh???p v??o FullName: ");
		acc.fullName = sc1.next();
		System.out.println("M???i b???n nh???p v??o Position( 1.DEV, 2.Test, 3.ScrumMaster, 4.PM): ");
		int position = sc1.nextInt();
		switch (position) {
		case 1:
			Position pos4 = new Position();
			pos4.name = PositionName.DEV;
			acc.positon = pos4;
			break;
		case 2:
			Position pos5 = new Position();
			pos5.name = PositionName.TEST;
			acc.positon = pos5;
			break;
		case 3:
			Position pos6 = new Position();
			pos6.name = PositionName.SCRUM_MASTER;
			acc.positon = pos6;
			break;
		case 4:
			Position pos7 = new Position();
			pos7.name = PositionName.PM;
			acc.positon = pos7;
			break;
		default:
			break;
		}
		System.out.println("ID: " + acc.id);
		System.out.println("Email: " + acc.email);
		System.out.println("UserName: " + acc.userName);
		System.out.println("FullName: " + acc.fullName);
		System.out.println("PositionName: " + acc.positon.name);
// Question 6:
		System.out.println("Nh???p v??o Department");
		Department dep = new Department();
		System.out.println("Nh???p ID: ");
		dep.id = sc.nextInt();
		System.out.println("Nh???p t??n ph??ng ban: ");
		dep.name = sc.next();
		System.out.println("ID ph??ng ban l??: " + dep.id);
		System.out.println("T??n ph??ng ban l??: " + dep.name);
// Question 7:
		System.out.println("Nh???p v??o 1 s??? ch???n: ");
		int number = sc.nextInt();
		if (number % 2 == 0) {
			System.out.println("S??? ch???n l??: " + number);
		} else {
			System.out.println("Nh???p sai");
		}
// Question 8:		
		System.out.println("Demo Menu");
		Scanner sc5 = new Scanner(System.in);
		int choose;
		while (true) {
			System.out.println("M???i b???n ch???n ch???c n??ng: 1.T???o t??i kho???n, 2.t???o Department");
			choose = sc5.nextInt();
			if (choose == 1 || choose == 2) {
				switch (choose) {
				case 1:
					System.out.println("t???o t??i kho???n");
					break;
				case 2:
					System.out.println("t???o department");
					break;
				}
				return;
			} else {
				System.out.println("M???i b???n ch???n l???i ch???c n??ng");
			}
		}
	}
}
