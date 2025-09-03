package com.javaex.vo;

public class FacilityInfoVO {

	private Long spacesNo;
	private Long spacesGuideNo;
	private Long facilityNo;
	private String facilityName;

	public FacilityInfoVO() {
		super();
	}

	public FacilityInfoVO(Long spacesNo, Long spacesGuideNo, Long facilityNo, String facilityName) {
		super();
		this.spacesNo = spacesNo;
		this.spacesGuideNo = spacesGuideNo;
		this.facilityNo = facilityNo;
		this.facilityName = facilityName;
	}

	public Long getSpacesNo() {
		return spacesNo;
	}

	public void setSpacesNo(Long spacesNo) {
		this.spacesNo = spacesNo;
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
		return "FacilityInfoVO [spacesNo=" + spacesNo + ", spacesGuideNo=" + spacesGuideNo + ", facilityNo="
				+ facilityNo + ", facilityName=" + facilityName + "]";
	}

	
}
