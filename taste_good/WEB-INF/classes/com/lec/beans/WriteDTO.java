package com.lec.beans;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class WriteDTO {
	private int b_num;
	private String kind;
	private String subject;
	private String content;
	private String id;
	private int viewcnt;
	private int u_num;


	private LocalDateTime regDate;
	
	public WriteDTO() {}
	
	public WriteDTO(int b_num, String kind, String subject, String content, String id, int viewcnt,
			LocalDateTime regDate) {
		super();
		this.b_num = b_num;
		this.kind = kind;
		this.subject = subject;
		this.content = content;
		this.id = id;
		this.viewcnt = viewcnt;
		this.regDate = regDate;
	}

	public int getU_num() {
		return u_num;
	}
	
	public void setU_num(int u_num) {
		this.u_num = u_num;
	}

	public int getB_num() {
		return b_num;
	}

	public void setB_num(int b_num) {
		this.b_num = b_num;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public LocalDateTime getRegDate() {
		return regDate;
	}

	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
		// regDate -> String
	public String getRegDateTime() {
		if(this.regDate == null) return "";
		return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}
	
	@Override
	public String toString() {
		return String.format("WriteDTO] %d : %s : %s : %s : %s : %d : %s", 
				b_num, kind, subject, content, id, viewcnt, regDate);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

































