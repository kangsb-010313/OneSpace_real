package com.javaex.vo;

import java.util.List;

public class RoomVO {

   private long roomNo;
   private long spacesNo;
   private String roomName;
   private String roomInfo;
   private String area;
   private int capacity;
   private String thumbImg;
   private String instDtm;
   private String updtDtm;
   
   private List<RoomImgVO> roomImgList;
   
   public RoomVO() {
   }

   public RoomVO(long roomNo, long spacesNo, String roomName, String roomInfo, String area, int capacity,
         String thumbImg, String instDtm, String updtDtm) {
      this.roomNo = roomNo;
      this.spacesNo = spacesNo;
      this.roomName = roomName;
      this.roomInfo = roomInfo;
      this.area = area;
      this.capacity = capacity;
      this.thumbImg = thumbImg;
      this.instDtm = instDtm;
      this.updtDtm = updtDtm;
   }

   public long getRoomNo() {
      return roomNo;
   }

   public void setRoomNo(long roomNo) {
      this.roomNo = roomNo;
   }

   public long getSpacesNo() {
      return spacesNo;
   }

   public void setSpacesNo(long spacesNo) {
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

   public int getCapacity() {
      return capacity;
   }

   public void setCapacity(int capacity) {
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

   @Override
   public String toString() {
      return "RoomVO [roomNo=" + roomNo + ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo="
            + roomInfo + ", area=" + area + ", capacity=" + capacity + ", thumbImg=" + thumbImg + ", instDtm="
            + instDtm + ", updtDtm=" + updtDtm + "]";
   }

}
