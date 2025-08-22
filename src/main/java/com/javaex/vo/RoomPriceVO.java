package com.javaex.vo;

public class RoomPriceVO {

	private int priceNo;
	private int roomNo;
	private String dayType;
	private String startTime;
	private String endTime;
	private int hourlyPrice;
	

	public RoomPriceVO() {
		super();
	}

	public RoomPriceVO(int priceNo, int roomNo, String dayType, String startTime, String endTime, int hourlyPrice) {
		super();
		this.priceNo = priceNo;
		this.roomNo = roomNo;
		this.dayType = dayType;
		this.startTime = startTime;
		this.endTime = endTime;
		this.hourlyPrice = hourlyPrice;
	}

	public int getPriceNo() {
		return priceNo;
	}

	public void setPriceNo(int priceNo) {
		this.priceNo = priceNo;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getDayType() {
		return dayType;
	}

	public void setDayType(String dayType) {
		this.dayType = dayType;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getHourlyPrice() {
		return hourlyPrice;
	}

	public void setHourlyPrice(int hourlyPrice) {
		this.hourlyPrice = hourlyPrice;
	}

	@Override
	public String toString() {
		return "SlotsVO [priceNo=" + priceNo + ", roomNo=" + roomNo + ", dayType=" + dayType + ", startTime="
				+ startTime + ", endTime=" + endTime + ", hourlyPrice=" + hourlyPrice + "]";
	}

}
