package com.lec.beans;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

public class CommentDTO {
	private int c_num;		// 댓글 글번호
	private int b_num;		// 게시글 번호
	private String c_id;		// 댓글 작성자
	
	private String c_content;	// 댓글 내용
	
	@JsonDeserialize(using = LocalDateTimeDeserializer.class)
	@JsonSerialize(using = LocalDateTimeSerializer.class)	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	@JsonProperty("c_date")
	private LocalDateTime c_date;		// 댓글 작성일
	 
	public CommentDTO() {};
	
	
	public CommentDTO(int c_num, int b_num, String c_id, String c_content, LocalDateTime c_date) {
		super();
		this.c_num = c_num;
		this.b_num = b_num;
		this.c_id = c_id;
		this.c_date = c_date;
		this.c_content = c_content;
	}

	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	public LocalDateTime getC_date() {
		return c_date;
	}
	public void setC_date(LocalDateTime c_date) {
		this.c_date = c_date;
	}

	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	
	// regDate -> String
	public String getC_dateTime() {
		if(this.c_date == null) return "";
		return this.c_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}
	
	@Override
	public String toString() {
		return String.format("CommentDTO] %d : %s : %s : %s : %s : %d : %s", 
				c_num, b_num, c_id, c_content, c_date);
	}
}
