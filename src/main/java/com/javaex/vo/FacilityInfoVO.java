package com.javaex.vo;

public class FacilityInfoVO {
	
	private Long facilityNo;
	private String facilityName;
	public FacilityInfoVO() {
		super();
	}
	public FacilityInfoVO(Long facilityNo, String facilityName) {
		super();
		this.facilityNo = facilityNo;
		this.facilityName = facilityName;
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
		return "FacilityInfoVO [facilityNo=" + facilityNo + ", facilityName=" + facilityName + "]";
	}
	
	

}
