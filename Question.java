package com.vti.entity;

import java.time.LocalDate;

public class Question {
	public int id;
	public String content;
	public CategoryQuestion categoryQues;	
	public TypeQuestion typeQuestion;
	public Account creatorID;
	public LocalDate createDate;	
	public Exam[] exams;
}
