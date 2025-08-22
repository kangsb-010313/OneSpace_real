package com.javaex.vo;

public class SlotVO {

	private int roomNo;
	private String targetDate;
	private int slotNo;
	private int price;

	public SlotVO() {
	}

	public SlotVO(int roomNo, String targetDate, int slotNo, int price) {
		this.roomNo = roomNo;
		this.targetDate = targetDate;
		this.slotNo = slotNo;
		this.price = price;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getTargetDate() {
		return targetDate;
	}

	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}

	public int getSlotNo() {
		return slotNo;
	}

	public void setSlotNo(int slotNo) {
		this.slotNo = slotNo;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "SlotVO [roomNo=" + roomNo + ", targetDate=" + targetDate + ", slotNo=" + slotNo + ", price=" + price
				+ "]";
	}

}
