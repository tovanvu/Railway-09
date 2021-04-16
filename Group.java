package com.vti.entity;

import java.time.LocalDate;

public class Group {
	public int id;
	public String name;
	public Account creatorId;
	public LocalDate createDate;
	public Account[] accounts;
}
