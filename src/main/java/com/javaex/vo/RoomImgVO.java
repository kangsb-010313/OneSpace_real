package com.javaex.vo;

public class RoomImgVO {

   private long picturesNo;
   private long roomNo;
   private String refType;
   private String storedFileName;
   private String originFileName;
   private String filePath;
   private String instDtm;
   private String updtDtm;

   public RoomImgVO() {
   }

   public RoomImgVO(long picturesNo, long roomNo, String refType, String storedFileName, String originFileName,
         String filePath, String instDtm, String updtDtm) {
      this.picturesNo = picturesNo;
      this.roomNo = roomNo;
      this.refType = refType;
      this.storedFileName = storedFileName;
      this.originFileName = originFileName;
      this.filePath = filePath;
      this.instDtm = instDtm;
      this.updtDtm = updtDtm;
   }

   public long getPicturesNo() {
      return picturesNo;
   }

   public void setPicturesNo(long picturesNo) {
      this.picturesNo = picturesNo;
   }

   public long getRoomNo() {
      return roomNo;
   }

   public void setRoomNo(long roomNo) {
      this.roomNo = roomNo;
   }

   public String getRefType() {
      return refType;
   }

   public void setRefType(String refType) {
      this.refType = refType;
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
      return "RoomImgVO [picturesNo=" + picturesNo + ", roomNo=" + roomNo + ", refType=" + refType
            + ", storedFileName=" + storedFileName + ", originFileName=" + originFileName + ", filePath=" + filePath
            + ", instDtm=" + instDtm + ", updtDtm=" + updtDtm + "]";
   }

}
