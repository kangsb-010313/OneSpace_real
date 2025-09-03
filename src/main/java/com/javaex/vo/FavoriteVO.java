package com.javaex.vo;

import java.util.List;

public class FavoriteVO {

	private long studioWishlistNo;
	private long userNo;
	private long roomNo;
	private long spacesNo;
	private String roomName;
	private String roomInfo;
	private String area;
	private int capacity;
	private String thumbImg;      //방이미지
	private String spaceName;
	private String spaceSummary;
	private String spaceInfo;
	private String email;
	private String phone;
	private String tel;
	private String postCode;
	private String address;
	private String addressDetail;
	private String repImg;    //건물 이미지
	private int minPrice;
	private int maxPrice;

	private List<FacilityInfoVO> selectedFacilityInfoList;

	public FavoriteVO() {
		super();
	}

	public FavoriteVO(long studioWishlistNo, long userNo, long roomNo, long spacesNo, String roomName, String roomInfo,
			String area, int capacity, String thumbImg, String spaceName, String spaceSummary, String spaceInfo,
			String email, String phone, String tel, String postCode, String address, String addressDetail,
			String repImg, int minPrice, int maxPrice, List<FacilityInfoVO> selectedFacilityInfoList) {
		super();
		this.studioWishlistNo = studioWishlistNo;
		this.userNo = userNo;
		this.roomNo = roomNo;
		this.spacesNo = spacesNo;
		this.roomName = roomName;
		this.roomInfo = roomInfo;
		this.area = area;
		this.capacity = capacity;
		this.thumbImg = thumbImg;
		this.spaceName = spaceName;
		this.spaceSummary = spaceSummary;
		this.spaceInfo = spaceInfo;
		this.email = email;
		this.phone = phone;
		this.tel = tel;
		this.postCode = postCode;
		this.address = address;
		this.addressDetail = addressDetail;
		this.repImg = repImg;
		this.minPrice = minPrice;
		this.maxPrice = maxPrice;
		this.selectedFacilityInfoList = selectedFacilityInfoList;
	}

	public long getStudioWishlistNo() {
		return studioWishlistNo;
	}

	public void setStudioWishlistNo(long studioWishlistNo) {
		this.studioWishlistNo = studioWishlistNo;
	}

	public long getUserNo() {
		return userNo;
	}

	public void setUserNo(long userNo) {
		this.userNo = userNo;
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

	public String getRepImg() {
		return repImg;
	}

	public void setRepImg(String repImg) {
		this.repImg = repImg;
	}

	public int getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}

	public int getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(int maxPrice) {
		this.maxPrice = maxPrice;
	}

	public List<FacilityInfoVO> getSelectedFacilityInfoList() {
		return selectedFacilityInfoList;
	}

	public void setSelectedFacilityInfoList(List<FacilityInfoVO> selectedFacilityInfoList) {
		this.selectedFacilityInfoList = selectedFacilityInfoList;
	}

	@Override
	public String toString() {
		return "FavoriteVO [studioWishlistNo=" + studioWishlistNo + ", userNo=" + userNo + ", roomNo=" + roomNo
				+ ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo=" + roomInfo + ", area=" + area
				+ ", capacity=" + capacity + ", thumbImg=" + thumbImg + ", spaceName=" + spaceName + ", spaceSummary="
				+ spaceSummary + ", spaceInfo=" + spaceInfo + ", email=" + email + ", phone=" + phone + ", tel=" + tel
				+ ", postCode=" + postCode + ", address=" + address + ", addressDetail=" + addressDetail + ", repImg="
				+ repImg + ", minPrice=" + minPrice + ", maxPrice=" + maxPrice + ", selectedFacilityInfoList="
				+ selectedFacilityInfoList + "]";
	}

}
