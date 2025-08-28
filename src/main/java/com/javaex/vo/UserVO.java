package com.javaex.vo;

public class UserVO {

	// 필드
	private int userNo;
	private String userId;
	private String kakaoId; //카카오
	private String password;
	private String userName;
	private String email;
	private String createdDate;

	// 생성자
	public UserVO() {
		super();
	}
	
	public UserVO(int userNo, String userId, String password, String userName, String email, String createdDate) {
		this.userNo = userNo;
		this.userId = userId;
		this.password = password;
		this.userName = userName;
		this.email = email;
		this.createdDate = createdDate;
	}

	

	// 메소드 gs
	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}
	
	// 카카오
	public String getKakaoId() { 
		return kakaoId; 
	}
	public void setKakaoId(String kakaoId) { 
		this.kakaoId = kakaoId; 
	}
	//
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	// 메소드 일반
	@Override
	public String toString() {
		return "UserVO [userNo=" + userNo + ", userId=" + userId + ", password=" + password + ", userName=" + userName
				+ ", email=" + email + ", createdDate=" + createdDate + "]";
	}

}
