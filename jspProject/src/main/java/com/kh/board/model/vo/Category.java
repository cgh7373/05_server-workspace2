package com.kh.board.model.vo;

public class Category {

	private int categoryNo;
	private String categotyName;
	
	public Category() {}

	public Category(int categoryNo, String categotyName) {
		super();
		this.categoryNo = categoryNo;
		this.categotyName = categotyName;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategotyName() {
		return categotyName;
	}

	public void setCategotyName(String categotyName) {
		this.categotyName = categotyName;
	}

	@Override
	public String toString() {
		return "Category [categoryNo=" + categoryNo + ", categotyName=" + categotyName + "]";
	}
	
	
}
