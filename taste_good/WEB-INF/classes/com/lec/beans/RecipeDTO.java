package com.lec.beans;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class RecipeDTO {
	private int m_num;
	private String kinds;
	private String subject;
	private String content;
	private String id;
	private int u_num;
	private int good;
	public int getGood() {
		return good;
	}

	public void setGood(int good) {
		this.good = good;
	}

	private String ff_file;

	
	public String getFf_file() {
		return ff_file;
	}

	public void setFf_file(String ff_file) {
		this.ff_file = ff_file;
	}

	public RecipeDTO() {}
	
	public RecipeDTO(int m_num, String kinds, String subject, String content, String id, int good) {
		super();
		this.m_num = m_num;
		this.kinds = kinds;
		this.subject = subject;
		this.content = content;
		this.id = id;
		this.good = good;
	}

	public RecipeDTO(int m_num, String kinds, String subject, String content, String id, String ff_file, int good) {
		super();
		this.m_num = m_num;
		this.kinds = kinds;
		this.subject = subject;
		this.content = content;
		this.id = id;
		this.ff_file = ff_file;
		this.good = good;
	}

	public int getM_num() {
		return m_num;
	}

	public void setM_num(int m_num) {
		this.m_num = m_num;
	}

	public String getKinds() {
		return kinds;
	}

	public void setKinds(String kinds) {
		this.kinds = kinds;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getU_num() {
		return u_num;
	}

	public void setU_num(int u_num) {
		this.u_num = u_num;
	}
	
	
	
	
}

































