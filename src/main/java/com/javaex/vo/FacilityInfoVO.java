package com.javaex.vo;

public class FacilityInfoVO {

	private Long spacesGuideNo;
	private Long facilityNo;
	private String facilityName;

	public FacilityInfoVO() {
		super();
	}

	public FacilityInfoVO(Long spacesGuideNo, Long facilityNo, String facilityName) {
		super();
		this.spacesGuideNo = spacesGuideNo;
		this.facilityNo = facilityNo;
		this.facilityName = facilityName;
	}

	public Long getSpacesGuideNo() {
		return spacesGuideNo;
	}

	public void setSpacesGuideNo(Long spacesGuideNo) {
		this.spacesGuideNo = spacesGuideNo;
	}

	public Long getFacilityNo() {
		return facilityNo;
	}

	public void setFacilityNo(Long facilityNo) {
		this.facilityNo = facilityNo;
	}

	public String getFacilityName() {
		return facilityName;
	}

	public void setFacilityName(String facilityName) {
		this.facilityName = facilityName;
	}

	@Override
	public String toString() {
		return "FacilityInfoVO [spacesGuideNo=" + spacesGuideNo + ", facilityNo=" + facilityNo + ", facilityName="
				+ facilityName + "]";
	}

}
