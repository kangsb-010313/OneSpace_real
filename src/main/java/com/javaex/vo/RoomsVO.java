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

    private List<RoomPriceVO> prices;
    private List<RoomsVO.RoomAttachment> photos; // ★ 그대로 유지

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
    
    public List<RoomsVO.RoomAttachment> getPhotos() { return photos; }
    public void setPhotos(List<RoomsVO.RoomAttachment> photos) { this.photos = photos; }

    // ★ 내부클래스 복구 (레포/서비스/컨트롤러와 호환)
    public static class RoomAttachment {
        private Long pictureSno;
        private String refType;     // 'ROOM'
        private Long refNo;         // rooms.roomNo
        private String storedFileName;
        private String originFileName;
        private String filePath;
        private LocalDateTime instDtm;
        private LocalDateTime updtDtm;

        public Long getPictureSno() { return pictureSno; }
        public void setPictureSno(Long pictureSno) { this.pictureSno = pictureSno; }
       
        public String getRefType() { return refType; }
        public void setRefType(String refType) { this.refType = refType; }
        
        public Long getRefNo() { return refNo; }
        public void setRefNo(Long refNo) { this.refNo = refNo; }
        
        public String getStoredFileName() { return storedFileName; }
        public void setStoredFileName(String storedFileName) { this.storedFileName = storedFileName; }
        
        public String getOriginFileName() { return originFileName; }
        public void setOriginFileName(String originFileName) { this.originFileName = originFileName; }
        
        public String getFilePath() { return filePath; }
        public void setFilePath(String filePath) { this.filePath = filePath; }
        
        public LocalDateTime getInstDtm() { return instDtm; }
        public void setInstDtm(LocalDateTime instDtm) { this.instDtm = instDtm; }
        
        public LocalDateTime getUpdtDtm() { return updtDtm; }
        public void setUpdtDtm(LocalDateTime updtDtm) { this.updtDtm = updtDtm; }
    }
}
