package com.javaex.vo;

public class TeamReciptVO {
	
	//필드
	private int reciptNo;
	private int userNo;
	private int roomNo;
	private int voteNo;
	private String paymentMethod;
	private String phoneNum;
	private String reservationTime;
	
	
	//생성자
	public TeamReciptVO() {
		super();
	}
	public TeamReciptVO(int reciptNo, int userNo, int roomNo, int voteNo, String paymentMethod, String phoneNum,
			String reservationTime) {
		super();
		this.reciptNo = reciptNo;
		this.userNo = userNo;
		this.roomNo = roomNo;
		this.voteNo = voteNo;
		this.paymentMethod = paymentMethod;
		this.phoneNum = phoneNum;
		this.reservationTime = reservationTime;
	}
	
	
	//메소드 gs
	public int getReciptNo() {
		return reciptNo;
	}
	public void setReciptNo(int reciptNo) {
		this.reciptNo = reciptNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}
	public int getVoteNo() {
		return voteNo;
	}
	public void setVoteNo(int voteNo) {
		this.voteNo = voteNo;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getReservationTime() {
		return reservationTime;
	}
	public void setReservationTime(String reservationTime) {
		this.reservationTime = reservationTime;
	}
	
	
	//메소드 일반
	@Override
	public String toString() {
		return "TeamReciptVO [reciptNo=" + reciptNo + ", userNo=" + userNo + ", roomNo=" + roomNo + ", voteNo=" + voteNo
				+ ", paymentMethod=" + paymentMethod + ", phoneNum=" + phoneNum + ", reservationTime=" + reservationTime
				+ "]";
	}
	
	

	

}
