package com.javaex.vo;

import java.time.LocalDateTime;

public class SpacesVO {
	
	//필드
    private Long spacesNo;
    private Long userNo;
    private String spaceName;
    private String spaceSummary;
    private String spaceInfo;
    private String email;
    private String phone;
    private String tel;
    private String spaceLink;
    private String repImg;
    private String postCode;
    private String address;
    private String addressDetail;
    private LocalDateTime instDtm;
    private LocalDateTime updtDtm;
    private String imageUrl;
    private Long roomNo;
    private String picturesNo;
    
    //생성자
    public SpacesVO() {
    }
    

    
    public SpacesVO(Long spacesNo, Long userNo, String spaceName, String spaceSummary, String spaceInfo, String email,
			String phone, String tel, String spaceLink, String repImg, String postCode, String address,
			String addressDetail, LocalDateTime instDtm, LocalDateTime updtDtm, String imageUrl, Long roomNo,
			String picturesNo) {
		super();
		this.spacesNo = spacesNo;
		this.userNo = userNo;
		this.spaceName = spaceName;
		this.spaceSummary = spaceSummary;
		this.spaceInfo = spaceInfo;
		this.email = email;
		this.phone = phone;
		this.tel = tel;
		this.spaceLink = spaceLink;
		this.repImg = repImg;
		this.postCode = postCode;
		this.address = address;
		this.addressDetail = addressDetail;
		this.instDtm = instDtm;
		this.updtDtm = updtDtm;
		this.imageUrl = imageUrl;
		this.roomNo = roomNo;
		this.picturesNo = picturesNo;
	}



	//메소드gs
    public Long getSpacesNo() {
        return spacesNo;
    }

    public void setSpacesNo(Long spacesNo) {
        this.spacesNo = spacesNo;
    }

    public Long getUserNo() {
        return userNo;
    }

    public void setUserNo(Long userNo) {
        this.userNo = userNo;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public String getSpaceSummary() {
        return spaceSummary;
    }

    public void setSpaceSummary(String spaceSummary) {
        this.spaceSummary = spaceSummary;
    }

    public String getSpaceInfo() {
        return spaceInfo;
    }

    public void setSpaceInfo(String spaceInfo) {
        this.spaceInfo = spaceInfo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getSpaceLink() {
        return spaceLink;
    }

    public void setSpaceLink(String spaceLink) {
        this.spaceLink = spaceLink;
    }
    
    public String getRepImg() { return repImg; }
    public void setRepImg(String repImg) { this.repImg = repImg; }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
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
    
    public String getImageUrl() {
    	return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
    	this.imageUrl = imageUrl;
    }
    
    public Long getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Long roomNo) {
		this.roomNo = roomNo;
	}
	

	public String getPicturesNo() {
		return picturesNo;
	}



	public void setPicturesNo(String picturesNo) {
		this.picturesNo = picturesNo;
	}



	@Override
	public String toString() {
		return "SpacesVO [spacesNo=" + spacesNo + ", userNo=" + userNo + ", spaceName=" + spaceName + ", spaceSummary="
				+ spaceSummary + ", spaceInfo=" + spaceInfo + ", email=" + email + ", phone=" + phone + ", tel=" + tel
				+ ", spaceLink=" + spaceLink + ", repImg=" + repImg + ", postCode=" + postCode + ", address=" + address
				+ ", addressDetail=" + addressDetail + ", instDtm=" + instDtm + ", updtDtm=" + updtDtm + ", imageUrl="
				+ imageUrl + ", roomNo=" + roomNo + ", picturesNo=" + picturesNo + "]";
	}




}