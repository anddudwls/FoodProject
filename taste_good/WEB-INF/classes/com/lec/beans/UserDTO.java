package com.lec.beans;


public class UserDTO {
	 private int u_num;   // wr_uid
	 private String id;
	 private String pass;
	 private String name;
	 private String gender;
	 private String tel;
	 private String email;
	 private String address1;
	 private String address2;
	 
	// 웹개발시...
	// 클래스 필드명 = DB 필드명 = form의 name명  (이름 일치시키는 게 좋음)
	 
	// 기본생성자
	 public UserDTO() {}

	 // 매개변수 받는 생성자
	public UserDTO(int u_num, String id, String pass, String name, String gender, String tel, String email,
			String address1, String address2) {
		super();
		this.u_num = u_num;
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.gender = gender;
		this.tel = tel;
		this.email = email;
		this.address1 = address1;
		this.address2 = address2;
	}

	public int getU_num() {
		return u_num;
	}

	public void setU_num(int u_num) {
		this.u_num = u_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	 
	 
}
