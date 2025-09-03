package com.javaex.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class RoomVO {

	private Long roomNo;
	private Long spacesNo;
	private String roomName;
	private String roomInfo;
	private String area;
	private Integer capacity;
	private String thumbImg;
	private String instDtm;
	private String updtDtm;

	private List<RoomImgVO> roomImgList;

	// 화면에서 받을때
	private List<String> dayTypes;
	private List<String> startTimes;
	private List<String> endTimes;
	private List<Integer> hourlyPrices;

	private MultipartFile thumbFile; // 대표이미지
	private List<MultipartFile> photos; // 이미지들

	// 생성자
	public RoomVO() {
	}

	public RoomVO(Long roomNo, Long spacesNo, String roomName, String roomInfo, String area, Integer capacity,
			String thumbImg, String instDtm, String updtDtm, List<RoomImgVO> roomImgList, List<String> dayTypes,
			List<String> startTimes, List<String> endTimes, List<Integer> hourlyPrices, MultipartFile thumbFile,
			List<MultipartFile> photos) {
		super();
		this.roomNo = roomNo;
		this.spacesNo = spacesNo;
		this.roomName = roomName;
		this.roomInfo = roomInfo;
		this.area = area;
		this.capacity = capacity;
		this.thumbImg = thumbImg;
		this.instDtm = instDtm;
		this.updtDtm = updtDtm;
		this.roomImgList = roomImgList;
		this.dayTypes = dayTypes;
		this.startTimes = startTimes;
		this.endTimes = endTimes;
		this.hourlyPrices = hourlyPrices;
		this.thumbFile = thumbFile;
		this.photos = photos;
	}

	public Long getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Long roomNo) {
		this.roomNo = roomNo;
	}

	public Long getSpacesNo() {
		return spacesNo;
	}

	public void setSpacesNo(Long spacesNo) {
		this.spacesNo = spacesNo;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRoomInfo() {
		return roomInfo;
	}

	public void setRoomInfo(String roomInfo) {
		this.roomInfo = roomInfo;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Integer getCapacity() {
		return capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public String getInstDtm() {
		return instDtm;
	}

	public void setInstDtm(String instDtm) {
		this.instDtm = instDtm;
	}

	public String getUpdtDtm() {
		return updtDtm;
	}

	public void setUpdtDtm(String updtDtm) {
		this.updtDtm = updtDtm;
	}

	public List<RoomImgVO> getRoomImgList() {
		return roomImgList;
	}

	public void setRoomImgList(List<RoomImgVO> roomImgList) {
		this.roomImgList = roomImgList;
	}

	public List<String> getDayTypes() {
		return dayTypes;
	}

	public void setDayTypes(List<String> dayTypes) {
		this.dayTypes = dayTypes;
	}

	public List<String> getStartTimes() {
		return startTimes;
	}

	public void setStartTimes(List<String> startTimes) {
		this.startTimes = startTimes;
	}

	public List<String> getEndTimes() {
		return endTimes;
	}

	public void setEndTimes(List<String> endTimes) {
		this.endTimes = endTimes;
	}

	public List<Integer> getHourlyPrices() {
		return hourlyPrices;
	}

	public void setHourlyPrices(List<Integer> hourlyPrices) {
		this.hourlyPrices = hourlyPrices;
	}

	public MultipartFile getThumbFile() {
		return thumbFile;
	}

	public void setThumbFile(MultipartFile thumbFile) {
		this.thumbFile = thumbFile;
	}

	public List<MultipartFile> getPhotos() {
		return photos;
	}

	public void setPhotos(List<MultipartFile> photos) {
		this.photos = photos;
	}

	@Override
	public String toString() {
		return "RoomVO [roomNo=" + roomNo + ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo="
				+ roomInfo + ", area=" + area + ", capacity=" + capacity + ", thumbImg=" + thumbImg + ", instDtm="
				+ instDtm + ", updtDtm=" + updtDtm + ", roomImgList=" + roomImgList + ", dayTypes=" + dayTypes
				+ ", startTimes=" + startTimes + ", endTimes=" + endTimes + ", hourlyPrices=" + hourlyPrices
				+ ", thumbFile=" + thumbFile + ", photos=" + photos + "]";
	}

}
