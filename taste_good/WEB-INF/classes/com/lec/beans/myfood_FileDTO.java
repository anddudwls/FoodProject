package com.lec.beans;

public class myfood_FileDTO {
	private int ff_num; 
	private String ff_source; 
	private String ff_file;  
	private boolean isImage;   
	
	public myfood_FileDTO(){}

	public myfood_FileDTO(int f_num, String source, String file) {
		super();
		this.ff_num = f_num;
		this.ff_source = source;
		this.ff_file = file;
	}

	public boolean isImage() {
		return isImage;
	}

	public void setImage(boolean isImage) {
		this.isImage = isImage;
	}

	public int getFf_num() {
		return ff_num;
	}

	public void setFf_num(int ff_num) {
		this.ff_num = ff_num;
	}

	public String getFf_source() {
		return ff_source;
	}

	public void setFf_source(String ff_source) {
		this.ff_source = ff_source;
	}

	public String getFf_file() {
		return ff_file;
	}

	public void setFf_file(String ff_file) {
		this.ff_file = ff_file;
	}

	
	

} // end FileDTO
