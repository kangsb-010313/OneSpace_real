package com.javaex.vo;

import java.util.List;

public class HostVO {
	private Long spacesno;
	private Long userno;
	private String spacename;
	private String spacesummary;
	private String spaceinfo;
	private String email;
	private String phone;
	private String tel;
	private String spacelink;
	private String postcode;
	private String address;
	private String addressdetail;
	private String facilities; // 하드코딩 체크박스 선택값 콤마 저장
	private String inst_dt;
	private String updt_dt;
	private String repimg;

	// 화면에서 선택해서 저장할때
	private List<Integer> facilityNos;

	// 선택한 시설리스트 db에 가져올때
	private List<FacilityInfoVO> checkedFacilityList;

	public HostVO() {
		super();
	}

	public HostVO(Long spacesno, Long userno, String spacename, String spacesummary, String spaceinfo, String email,
			String phone, String tel, String spacelink, String postcode, String address, String addressdetail,
			String facilities, String inst_dt, String updt_dt, String repimg, List<Integer> facilityNos,
			List<FacilityInfoVO> checkedFacilityList) {
		super();
		this.spacesno = spacesno;
		this.userno = userno;
		this.spacename = spacename;
		this.spacesummary = spacesummary;
		this.spaceinfo = spaceinfo;
		this.email = email;
		this.phone = phone;
		this.tel = tel;
		this.spacelink = spacelink;
		this.postcode = postcode;
		this.address = address;
		this.addressdetail = addressdetail;
		this.facilities = facilities;
		this.inst_dt = inst_dt;
		this.updt_dt = updt_dt;
		this.repimg = repimg;
		this.facilityNos = facilityNos;
		this.checkedFacilityList = checkedFacilityList;
	}

	public Long getSpacesno() {
		return spacesno;
	}

	public void setSpacesno(Long spacesno) {
		this.spacesno = spacesno;
	}

	public Long getUserno() {
		return userno;
	}

	public void setUserno(Long userno) {
		this.userno = userno;
	}

	public String getSpacename() {
		return spacename;
	}

	public void setSpacename(String spacename) {
		this.spacename = spacename;
	}

	public String getSpacesummary() {
		return spacesummary;
	}

	public void setSpacesummary(String spacesummary) {
		this.spacesummary = spacesummary;
	}

	public String getSpaceinfo() {
		return spaceinfo;
	}

	public void setSpaceinfo(String spaceinfo) {
		this.spaceinfo = spaceinfo;
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

	public String getSpacelink() {
		return spacelink;
	}

	public void setSpacelink(String spacelink) {
		this.spacelink = spacelink;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressdetail() {
		return addressdetail;
	}

	public void setAddressdetail(String addressdetail) {
		this.addressdetail = addressdetail;
	}

	public String getFacilities() {
		return facilities;
	}

	public void setFacilities(String facilities) {
		this.facilities = facilities;
	}

	public String getInst_dt() {
		return inst_dt;
	}

	public void setInst_dt(String inst_dt) {
		this.inst_dt = inst_dt;
	}

	public String getUpdt_dt() {
		return updt_dt;
	}

	public void setUpdt_dt(String updt_dt) {
		this.updt_dt = updt_dt;
	}

	public String getRepimg() {
		return repimg;
	}

	public void setRepimg(String repimg) {
		this.repimg = repimg;
	}

	public List<Integer> getFacilityNos() {
		return facilityNos;
	}

	public void setFacilityNos(List<Integer> facilityNos) {
		this.facilityNos = facilityNos;
	}

	public List<FacilityInfoVO> getCheckedFacilityList() {
		return checkedFacilityList;
	}

	public void setCheckedFacilityList(List<FacilityInfoVO> checkedFacilityList) {
		this.checkedFacilityList = checkedFacilityList;
	}

	@Override
	public String toString() {
		return "HostVO [spacesno=" + spacesno + ", userno=" + userno + ", spacename=" + spacename + ", spacesummary="
				+ spacesummary + ", spaceinfo=" + spaceinfo + ", email=" + email + ", phone=" + phone + ", tel=" + tel
				+ ", spacelink=" + spacelink + ", postcode=" + postcode + ", address=" + address + ", addressdetail="
				+ addressdetail + ", facilities=" + facilities + ", inst_dt=" + inst_dt + ", updt_dt=" + updt_dt
				+ ", repimg=" + repimg + ", facilityNos=" + facilityNos + ", checkedFacilityList=" + checkedFacilityList
				+ "]";
	}

}