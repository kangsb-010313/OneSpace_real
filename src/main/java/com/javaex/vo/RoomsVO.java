package com.javaex.vo;

import java.time.LocalDateTime;
import java.util.List;

public class RoomsVO {
	
	//필드
    private Long roomNo;
    private Long spacesNo;
    private String roomName;
    private String roomInfo;
    private String area;
    private Integer capacity;
    private LocalDateTime instDtm;
    private LocalDateTime updtDtm;
    
    private List<RoomPrices> prices;
    private List<RoomAttachment> photos;
    
    //생성자
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
   
   public List<RoomPrices> getPrices() { return prices; }
   public void setPrices(List<RoomPrices> prices) { this.prices = prices; }
   public List<RoomAttachment> getPhotos() { return photos; }
   public void setPhotos(List<RoomAttachment> photos) { this.photos = photos; }

   @Override
   public String toString() {
      return "RoomsVO [roomNo=" + roomNo + ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo="
            + roomInfo + ", area=" + area + ", capacity=" + capacity + ", instDtm=" + instDtm + ", updtDtm="
            + updtDtm + "]";
   }
   
// -------- 요금 --------
public static class RoomPrices {
    private Long pricesNo;
    private Long roomNo;
    private String dayType; // "평일"/"주말"
    private String startTime;
    private String endTime;
    private String hourlyPrice;
    private String instDt;
    private String updtDt;

    public Long getPricesNo() {
    	return pricesNo;
    }
    
    public void setPricesNo(Long pricesNo) {
    	this.pricesNo = pricesNo;
    }
    
    public Long getRoomNo() {
    	return roomNo;
    }
    
    public void setRoomNo(Long roomNo) {
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
    
    public String getHourlyPrice() {
    	return hourlyPrice;
    }
    
    public void setHourlyPrice(String hourlyPrice) {
    	this.hourlyPrice = hourlyPrice;
    }
    
    public String getInstDt() {
    	return instDt;
    }
    
    public void setInstDt(String instDt) {
    	this.instDt = instDt;
    }
    
    public String getUpdtDt() {
    	return updtDt;
    }
    
    public void setUpdtDt(String updtDt) {
    	this.updtDt = updtDt;
    }
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

    public Long getPictureSno() {
    	return pictureSno;
    }
    
    public void setPictureSno(Long pictureSno) {
    	this.pictureSno = pictureSno;
    }
    
    public Long getRoomNo() {
    	return roomNo;
    }
    
    public void setRoomNo(Long roomNo) {
    	this.roomNo = roomNo;
    }
    
    public String getStoredFileName() {
    	return storedFileName;
    }
    
    public void setStoredFileName(String storedFileName) {
    	this.storedFileName = storedFileName;
    }
    
    public String getOriginFileName() {
    	return originFileName;
    }
    
    public void setOriginFileName(String originFileName) {
    	this.originFileName = originFileName;
    }
    
    public String getFilePath() {
    	return filePath;
    }
    
    public void setFilePath(String filePath) {
    	this.filePath = filePath;
    }
    
    public String getInstDt() {
    	return instDt;
    }
    
    public void setInstDt(String instDt) {
    	this.instDt = instDt;
    }
    
    public String getUpdtDt() {
    	return updtDt;
    }
    
    public void setUpdtDt(String updtDt) {
    	this.updtDt = updtDt;
    }
}
    
}