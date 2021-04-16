package com.vti.entity;

import java.time.LocalDate;

public class Exam {
	public int id;
	public int code;
	public String title;	
	public CategoryQuestion category;
	public Duration duration;
	public Account creatorID;
	public LocalDate createDate;	
	public Question[] questions;
	
	public enum Duration {
		minute_60(60), minute_90(90), minute_120(120);
		Duration(int value){
	}
}
}	
