package com.javaex.vo;

public class PerforInfoVO {

    private long infoPostNo;
    private long userNo;
    private String infoPostTitle;
    private String agencyName;
    private String infoContent;
    private String infoOutUrl;
    private String infoPostType;
    private String deadlineDate;
    private String infoArea;
    private String perforImg;
    private String infoWriteDate;
    private String infoUpdateDate;
    private String infoImg;
    private String username; // JOIN users.name

    // getter/setter
    public long getInfoPostNo() {
        return infoPostNo;
    }
    public void setInfoPostNo(long infoPostNo) {
        this.infoPostNo = infoPostNo;
    }

    public long getUserNo() {
        return userNo;
    }
    public void setUserNo(long userNo) {
        this.userNo = userNo;
    }

    public String getInfoPostTitle() {
        return infoPostTitle;
    }
    public void setInfoPostTitle(String infoPostTitle) {
        this.infoPostTitle = infoPostTitle;
    }

    public String getAgencyName() {
        return agencyName;
    }
    public void setAgencyName(String agencyName) {
        this.agencyName = agencyName;
    }

    public String getInfoContent() {
        return infoContent;
    }
    public void setInfoContent(String infoContent) {
        this.infoContent = infoContent;
    }

    public String getInfoOutUrl() {
        return infoOutUrl;
    }
    public void setInfoOutUrl(String infoOutUrl) {
        this.infoOutUrl = infoOutUrl;
    }

    public String getInfoPostType() {
        return infoPostType;
    }
    public void setInfoPostType(String infoPostType) {
        this.infoPostType = infoPostType;
    }

    public String getDeadlineDate() {
        return deadlineDate;
    }
    public void setDeadlineDate(String deadlineDate) {
        this.deadlineDate = deadlineDate;
    }

    public String getInfoArea() {
        return infoArea;
    }
    public void setInfoArea(String infoArea) {
        this.infoArea = infoArea;
    }

    public String getPerforImg() {
        return perforImg;
    }
    public void setPerforImg(String perforImg) {
        this.perforImg = perforImg;
    }

    public String getInfoWriteDate() {
        return infoWriteDate;
    }
    public void setInfoWriteDate(String infoWriteDate) {
        this.infoWriteDate = infoWriteDate;
    }

    public String getInfoUpdateDate() {
        return infoUpdateDate;
    }
    public void setInfoUpdateDate(String infoUpdateDate) {
        this.infoUpdateDate = infoUpdateDate;
    }

    public String getInfoImg() {
        return infoImg;
    }
    public void setInfoImg(String infoImg) {
        this.infoImg = infoImg;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "PerforInfoVO{" +
                "infoPostNo=" + infoPostNo +
                ", userNo=" + userNo +
                ", infoPostTitle='" + infoPostTitle + '\'' +
                ", agencyName='" + agencyName + '\'' +
                ", infoContent='" + infoContent + '\'' +
                ", infoOutUrl='" + infoOutUrl + '\'' +
                ", infoPostType='" + infoPostType + '\'' +
                ", deadlineDate='" + deadlineDate + '\'' +
                ", infoArea='" + infoArea + '\'' +
                ", perforImg='" + perforImg + '\'' +
                ", infoWriteDate='" + infoWriteDate + '\'' +
                ", infoUpdateDate='" + infoUpdateDate + '\'' +
                ", infoImg='" + infoImg + '\'' +
                ", username='" + username + '\'' +
                '}';
    }
}
