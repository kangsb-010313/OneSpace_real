package com.javaex.vo;

import java.time.LocalDateTime;
import java.util.List;

public class RoomsVO {
	
    private Long roomNo;
    private Long spacesNo;
    private String roomName;
    private String roomInfo;
    private String area;
    private Integer capacity;
    private String thumbImg;
    private LocalDateTime instDtm;
    private LocalDateTime updtDtm;

    // 가격은 외부 VO 사용
    private List<RoomPriceVO> prices;

    // 사진
    private List<RoomAttachment> photos;

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

    public Long getRoomNo() { return roomNo; }
    public void setRoomNo(Long roomNo) { this.roomNo = roomNo; }
    public Long getSpacesNo() { return spacesNo; }
    public void setSpacesNo(Long spacesNo) { this.spacesNo = spacesNo; }
    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }
    public String getRoomInfo() { return roomInfo; }
    public void setRoomInfo(String roomInfo) { this.roomInfo = roomInfo; }
    public String getArea() { return area; }
    public void setArea(String area) { this.area = area; }
    public Integer getCapacity() { return capacity; }
    public void setCapacity(Integer capacity) { this.capacity = capacity; }
    public String getThumbImg() { return thumbImg; }
    public void setThumbImg(String thumbImg) { this.thumbImg = thumbImg; }
    public LocalDateTime getInstDtm() { return instDtm; }
    public void setInstDtm(LocalDateTime instDtm) { this.instDtm = instDtm; }
    public LocalDateTime getUpdtDtm() { return updtDtm; }
    public void setUpdtDtm(LocalDateTime updtDtm) { this.updtDtm = updtDtm; }

    public List<RoomPriceVO> getPrices() { return prices; }
    public void setPrices(List<RoomPriceVO> prices) { this.prices = prices; }

    public List<RoomAttachment> getPhotos() { return photos; }
    public void setPhotos(List<RoomAttachment> photos) { this.photos = photos; }

    @Override
    public String toString() {
        return "RoomsVO [roomNo=" + roomNo + ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo="
                + roomInfo + ", area=" + area + ", capacity=" + capacity + ", instDtm=" + instDtm + ", updtDtm="
                + updtDtm + "]";
    }

    // -------- 사진 --------
    public static class RoomAttachment {
        private Long pictureSno;
        private Long roomNo;
        private String storedFileName;
        private String originFileName;
        private String filePath;
        private String instDt;
        private String updtDt;

        public Long getPictureSno() { return pictureSno; }
        public void setPictureSno(Long pictureSno) { this.pictureSno = pictureSno; }
        public Long getRoomNo() { return roomNo; }
        public void setRoomNo(Long roomNo) { this.roomNo = roomNo; }
        public String getStoredFileName() { return storedFileName; }
        public void setStoredFileName(String storedFileName) { this.storedFileName = storedFileName; }
        public String getOriginFileName() { return originFileName; }
        public void setOriginFileName(String originFileName) { this.originFileName = originFileName; }
        public String getFilePath() { return filePath; }
        public void setFilePath(String filePath) { this.filePath = filePath; }
        public String getInstDt() { return instDt; }
        public void setInstDt(String instDt) { this.instDt = instDt; }
        public String getUpdtDt() { return updtDt; }
        public void setUpdtDt(String updtDt) { this.updtDt = updtDt; }
    }
}
