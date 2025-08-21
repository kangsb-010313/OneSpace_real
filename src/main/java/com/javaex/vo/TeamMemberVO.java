package com.javaex.vo;

public class TeamMemberVO {
	
	//필드
	private int teamMemberNo;
	private int teamNo;
	private int userNo;
	private String position;
	private String status;
	private String joinedDate;
	
	//users테이블에서 가져옴
	private String userName;

	
	//생성자
	public TeamMemberVO() {
		super();
	}

	public TeamMemberVO(int teamMemberNo, int teamNo, int userNo, String position, String status, String joinedDate,
			String userName) {
		super();
		this.teamMemberNo = teamMemberNo;
		this.teamNo = teamNo;
		this.userNo = userNo;
		this.position = position;
		this.status = status;
		this.joinedDate = joinedDate;
		this.userName = userName;
	}

	
	//메소드 gs
	public int getTeamMemberNo() {
		return teamMemberNo;
	}

	public void setTeamMemberNo(int teamMemberNo) {
		this.teamMemberNo = teamMemberNo;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getJoinedDate() {
		return joinedDate;
	}

	public void setJoinedDate(String joinedDate) {
		this.joinedDate = joinedDate;
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
		return "TeamMemberVO [teamMemberNo=" + teamMemberNo + ", teamNo=" + teamNo + ", userNo=" + userNo
				+ ", position=" + position + ", status=" + status + ", joinedDate=" + joinedDate + ", userName="
				+ userName + "]";
	}
	
	

}
