package com.javaex.vo;

public class TeamVO {
	
	
	//필드
	private int teamNo;
	private String teamName;
	private String instaAccount;
	private String teamCreatedDate;
	private int userNo;
	

	//생성자
	public TeamVO() {
		super();
	}
	public TeamVO(int teamNo, String teamName, String instaAccount, String teamCreatedDate, int userNo) {
		super();
		this.teamNo = teamNo;
		this.teamName = teamName;
		this.instaAccount = instaAccount;
		this.teamCreatedDate = teamCreatedDate;
		this.userNo = userNo;
	}
	

	//메소드 gs
	public int getTeamNo() {
		return teamNo;
	}
	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getInstaAccount() {
		return instaAccount;
	}
	public void setInstaAccount(String instaAccount) {
		this.instaAccount = instaAccount;
	}
	public String getTeamCreatedDate() {
		return teamCreatedDate;
	}
	public void setTeamCreatedDate(String teamCreatedDate) {
		this.teamCreatedDate = teamCreatedDate;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	
	//메소드 일반
	@Override
	public String toString() {
		return "TeamVO [teamNo=" + teamNo + ", teamName=" + teamName + ", instaAccount=" + instaAccount
				+ ", teamCreatedDate=" + teamCreatedDate + ", userNo=" + userNo + "]";
	}
	
	

}
