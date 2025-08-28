package com.javaex.vo;

public class TeamVotePostVO {
	
    // 필드
    private int voteNo;         // votes 테이블 pk
    private int roomNo;         // rooms 테이블 pk
    private String spaceName;   // spaces 테이블
    private String roomName;    // rooms 테이블
    private String address;     // spaces 테이블
    private String voteDate;    // voteOptions 테이블
    private String startTime; 
    private String endTime;
    private String thumbImg;
    private String spaceLink;
    
    //다른 테이블에서 가져와야됨
    private int totalPrice;         // 연습실 가격
    private String spacesGuideNo;   // 편의시설 정보 (ex: "주차/최대15인")
    private String picturesNo;   	// 대표 이미지 경로 
    
    private int competitionCount;	// 경쟁 팀 수를 담을 필드
    private int isReserved;   	  	// 예약 완료 여부를 담을 필드

    
    //생성자
	public TeamVotePostVO() {
		super();
	}

	public TeamVotePostVO(int voteNo, int roomNo, String spaceName, String roomName, String address, String voteDate,
			String startTime, String endTime, String thumbImg, int totalPrice, String spacesGuideNo, String picturesNo,
			int competitionCount, int isReserved) {
		super();
		this.voteNo = voteNo;
		this.roomNo = roomNo;
		this.spaceName = spaceName;
		this.roomName = roomName;
		this.address = address;
		this.voteDate = voteDate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.thumbImg = thumbImg;
		this.totalPrice = totalPrice;
		this.spacesGuideNo = spacesGuideNo;
		this.picturesNo = picturesNo;
		this.competitionCount = competitionCount;
		this.isReserved = isReserved;
	}



	//메소드 gs
	public int getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(int voteNo) {
		this.voteNo = voteNo;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getVoteDate() {
		return voteDate;
	}

	public void setVoteDate(String voteDate) {
		this.voteDate = voteDate;
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

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getSpacesGuideNo() {
		return spacesGuideNo;
	}

	public void setSpacesGuideNo(String spacesGuideNo) {
		this.spacesGuideNo = spacesGuideNo;
	}

	public String getPicturesNo() {
		return picturesNo;
	}

	public void setPicturesNo(String picturesNo) {
		this.picturesNo = picturesNo;
	}

	public int getCompetitionCount() {
		return competitionCount;
	}

	public void setCompetitionCount(int competitionCount) {
		this.competitionCount = competitionCount;
	}
	
	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public int getIsReserved() {
		return isReserved;
	}

	public void setIsReserved(int isReserved) {
		this.isReserved = isReserved;
	}
	
	public String getSpaceLink() {
	    return spaceLink;
	}
	public void setSpaceLink(String spaceLink) {
	    this.spaceLink = spaceLink;
	}
	
	//메소드 일반
	@Override
	public String toString() {
		return "TeamVotePostVO [voteNo=" + voteNo + ", roomNo=" + roomNo + ", spaceName=" + spaceName + ", roomName="
				+ roomName + ", address=" + address + ", voteDate=" + voteDate + ", startTime=" + startTime
				+ ", endTime=" + endTime + ", thumbImg=" + thumbImg + ", totalPrice=" + totalPrice + ", spacesGuideNo="
				+ spacesGuideNo + ", picturesNo=" + picturesNo + ", competitionCount=" + competitionCount
				+ ", isReserved=" + isReserved + "]";
	}
    

    
    

}
