package com.javaex.vo;

public class TeamVoteOptionVO {
	
	//필드
    // from spaces
    private int spacesNo;
    private String spaceName;
    private String address;

    // from rooms
    private int roomNo;
    private String roomName;
    private String area;
    private int capacity;

    // from roomPrices (가격)
    private int hourlyPrice;

    // from roomAttachments (대표 이미지)
    private String thumbnailPath;

    
    //생성자
	public TeamVoteOptionVO() {
		super();
	}

	public TeamVoteOptionVO(int spacesNo, String spaceName, String address, int roomNo, String roomName, String area,
			int capacity, int hourlyPrice, String thumbnailPath) {
		super();
		this.spacesNo = spacesNo;
		this.spaceName = spaceName;
		this.address = address;
		this.roomNo = roomNo;
		this.roomName = roomName;
		this.area = area;
		this.capacity = capacity;
		this.hourlyPrice = hourlyPrice;
		this.thumbnailPath = thumbnailPath;
	}

	
	//메소드 gs
	public int getSpacesNo() {
		return spacesNo;
	}

	public void setSpacesNo(int spacesNo) {
		this.spacesNo = spacesNo;
	}

	public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public int getHourlyPrice() {
		return hourlyPrice;
	}

	public void setHourlyPrice(int hourlyPrice) {
		this.hourlyPrice = hourlyPrice;
	}

	public String getThumbnailPath() {
		return thumbnailPath;
	}

	public void setThumbnailPath(String thumbnailPath) {
		this.thumbnailPath = thumbnailPath;
	}

	
	//메소드 일반
	@Override
	public String toString() {
		return "TeamVoteOptionVO [spacesNo=" + spacesNo + ", spaceName=" + spaceName + ", address=" + address
				+ ", roomNo=" + roomNo + ", roomName=" + roomName + ", area=" + area + ", capacity=" + capacity
				+ ", hourlyPrice=" + hourlyPrice + ", thumbnailPath=" + thumbnailPath + "]";
	}
    
    

}
