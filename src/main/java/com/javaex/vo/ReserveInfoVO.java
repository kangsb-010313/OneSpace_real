package com.javaex.vo;

public class ReserveInfoVO {

	private String targetDate;
	private Long roomNo;

	public ReserveInfoVO() {
		super();
	}

	public ReserveInfoVO(String targetDate, Long roomNo) {
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

	public Long getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(long roomNo2) {
		this.roomNo = roomNo2;
	}

	@Override
	public String toString() {
		return "ReserveInfoVO [targetDate=" + targetDate + ", roomNo=" + roomNo + "]";
	}

}
