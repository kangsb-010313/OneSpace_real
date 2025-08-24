package com.javaex.vo;

public class TeamVoteResultVO {

	
	//필드
	private int userNo;
	private String userName;
	
	
	//생성자
	public TeamVoteResultVO() {
		super();
	}
	
	public TeamVoteResultVO(int userNo, String userName) {
		super();
		this.userNo = userNo;
		this.userName = userName;
	}



	//메소드 gs
	public int getUserNo() {
		return userNo;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	//메소드 일반
	@Override
	public String toString() {
		return "TeamVoteResultVO [userNo=" + userNo + ", userName=" + userName + "]";
	}
	
	
	
	
}
