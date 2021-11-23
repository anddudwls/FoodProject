package com.lec.beans;

public class FileDTO {
	private int f_num;   // bf_num
	private String source;  // bf_source
	private String file;   // bf_file
	private boolean isImage;   // 이미지여부
	
	public FileDTO() { super();	}

	public FileDTO(int f_num, String source, String file) {
		super();
		this.f_num = f_num;
		this.source = source;
		this.file = file;
	}

	public int getF_num() {
		return f_num;
	}

	public void setF_num(int f_num) {
		this.f_num = f_num;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public boolean isImage() {
		return isImage;
	}

	public void setImage(boolean isImage) {
		this.isImage = isImage;
	}
	

	
	
}
