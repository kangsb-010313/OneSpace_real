package com.javaex.vo;

import java.time.LocalDateTime;

public class RoomsVO {
    private Long roomNo;
    private Long spacesNo;
    private String roomName;
    private String roomInfo;
    private String area;
    private Integer capacity;
    private LocalDateTime instDtm;
    private LocalDateTime updtDtm;

    public RoomsVO() {}

    public RoomsVO(Long roomNo, Long spacesNo, String roomName, String roomInfo,
                  String area, Integer capacity, LocalDateTime instDtm, LocalDateTime updtDtm) {
        this.roomNo = roomNo;
        this.spacesNo = spacesNo;
        this.roomName = roomName;
        this.roomInfo = roomInfo;
        this.area = area;
        this.capacity = capacity;
        this.instDtm = instDtm;
        this.updtDtm = updtDtm;
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

	public LocalDateTime getInstDtm() {
		return instDtm;
	}

	public void setInstDtm(LocalDateTime instDtm) {
		this.instDtm = instDtm;
	}

	public LocalDateTime getUpdtDtm() {
		return updtDtm;
	}

	public void setUpdtDtm(LocalDateTime updtDtm) {
		this.updtDtm = updtDtm;
	}

	@Override
	public String toString() {
		return "RoomsVO [roomNo=" + roomNo + ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo="
				+ roomInfo + ", area=" + area + ", capacity=" + capacity + ", instDtm=" + instDtm + ", updtDtm="
				+ updtDtm + "]";
	}
    
}