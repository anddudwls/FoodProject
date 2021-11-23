package com.lec.beans;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AjaxCommentListJSON {
	
	
	int b_num;
	int count;
	String status;
	
	@JsonProperty("data")
	List<CommentDTO> c_list;
	
	
	
	
	public AjaxCommentListJSON() {
		super();
	}
	
	public int getB_num() {
		return b_num;
	}
	
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<CommentDTO> getC_list() {
		return c_list;
	}

	public void setC_list(List<CommentDTO> c_list) {
		this.c_list = c_list;
	}
	
	
}
