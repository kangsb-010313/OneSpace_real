package com.javaex.vo;

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
    private String facilities;  // 하드코딩 체크박스 선택값 콤마 저장
    private String inst_dt;
    private String updt_dt;

    public Long getSpacesno() { return spacesno; }
    public void setSpacesno(Long spacesno) { this.spacesno = spacesno; }
    public Long getUserno() { return userno; }
    public void setUserno(Long userno) { this.userno = userno; }
    public String getSpacename() { return spacename; }
    public void setSpacename(String spacename) { this.spacename = spacename; }
    public String getSpacesummary() { return spacesummary; }
    public void setSpacesummary(String spacesummary) { this.spacesummary = spacesummary; }
    public String getSpaceinfo() { return spaceinfo; }
    public void setSpaceinfo(String spaceinfo) { this.spaceinfo = spaceinfo; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getTel() { return tel; }
    public void setTel(String tel) { this.tel = tel; }
    public String getSpacelink() { return spacelink; }
    public void setSpacelink(String spacelink) { this.spacelink = spacelink; }
    public String getPostcode() { return postcode; }
    public void setPostcode(String postcode) { this.postcode = postcode; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getAddressdetail() { return addressdetail; }
    public void setAddressdetail(String addressdetail) { this.addressdetail = addressdetail; }
    public String getFacilities() { return facilities; }
    public void setFacilities(String facilities) { this.facilities = facilities; }
    public String getInst_dt() { return inst_dt; }
    public void setInst_dt(String inst_dt) { this.inst_dt = inst_dt; }
    public String getUpdt_dt() { return updt_dt; }
    public void setUpdt_dt(String updt_dt) { this.updt_dt = updt_dt; }
}