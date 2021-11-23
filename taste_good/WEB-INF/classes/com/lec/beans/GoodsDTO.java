package com.lec.beans;


public class GoodsDTO {
	 private int gbsnum;   // wr_uid
	 private String gbsname;
	 private int gbsprice;
	 private String gbsdes;
	 private String picture;

	// 웹개발시...
	// 클래스 필드명 = DB 필드명 = form의 name명  (이름 일치시키는 게 좋음)
	 
	// 기본생성자
	 public GoodsDTO() {}

	public GoodsDTO(int gbsnum, String gbsname, int gbsprice, String gbsdes, String picture) {
		super();
		this.gbsnum = gbsnum;
		this.gbsname = gbsname;
		this.gbsprice = gbsprice;
		this.gbsdes = gbsdes;
		this.picture = picture;
	}

	public int getGbsnum() {
		return gbsnum;
	}

	public void setGbsnum(int gbsnum) {
		this.gbsnum = gbsnum;
	}

	public String getGbsname() {
		return gbsname;
	}

	public void setGbsname(String gbsname) {
		this.gbsname = gbsname;
	}

	public int getGbsprice() {
		return gbsprice;
	}

	public void setGbsprice(int gbsprice) {
		this.gbsprice = gbsprice;
	}

	public String getGbsdes() {
		return gbsdes;
	}

	public void setGbsdes(String gbsdes) {
		this.gbsdes = gbsdes;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	

	 
}
