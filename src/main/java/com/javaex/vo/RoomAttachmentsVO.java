package com.javaex.vo;

import java.time.LocalDateTime;

public class RoomAttachmentsVO {

    private Long pictureSno;
    private String refType;      // "ROOM"
    private Long refNo;          // roomNo
    private String storedFileName;
    private String originFileName;
    private String filePath;
    private Long fileSize;
    private String contentType;
    private LocalDateTime instDtm;
    private LocalDateTime updtDtm;

    public RoomAttachmentsVO() {}

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

    public Long getFileSize() { return fileSize; }
    public void setFileSize(Long fileSize) { this.fileSize = fileSize; }

    public String getContentType() { return contentType; }
    public void setContentType(String contentType) { this.contentType = contentType; }

    public LocalDateTime getInstDtm() { return instDtm; }
    public void setInstDtm(LocalDateTime instDtm) { this.instDtm = instDtm; }

    public LocalDateTime getUpdtDtm() { return updtDtm; }
    public void setUpdtDtm(LocalDateTime updtDtm) { this.updtDtm = updtDtm; }
}
