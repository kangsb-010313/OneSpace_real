package com.javaex.vo;

public class ReserveInfoVO {

	private String targetDate;
	private int roomNo;

	public ReserveInfoVO() {
		super();
	}

	public ReserveInfoVO(String targetDate, int roomNo) {
		super();
		this.targetDate = targetDate;
		this.roomNo = roomNo;
	}

	public String getTargetDate() {
		return targetDate;
	}

	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	@Override
	public String toString() {
		return "RerveInfoVO [targetDate=" + targetDate + ", roomNo=" + roomNo + "]";
	}

}
