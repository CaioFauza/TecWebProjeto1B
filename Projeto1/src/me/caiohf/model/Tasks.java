package me.caiohf.model;

import java.util.Calendar;

public class Tasks {
	private Integer id;
	private String creator;
	private String text;
	private Calendar day;
	private String category;
	
	
	public Integer getId() {return this.id;}
	public void setId(Integer id) {this.id = id;}
	
	public String getCreator() {return this.creator;}
	public void setCreator(String creator) {this.creator = creator;}
	
	public String getText() {return this.text;}
	public void setText(String text) {this.text = text;}
	
	public Calendar getDay() {return this.day;}
	public void setDay(Calendar day) {this.day = day;}
	
	public String getCategory() { return this.category;}
	public void setCategory(String category) {this.category = category;}
	
}
