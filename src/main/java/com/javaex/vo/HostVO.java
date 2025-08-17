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
    private String inst_dt;   // datetime
    private String updt_dt;   // datetime

    // ----- 네 스타일(소문자) -----
    public Long getspacesno() { return spacesno; }
    public void setspacesno(Long spacesno) { this.spacesno = spacesno; }
    public Long getuserno() { return userno; }
    public void setuserno(Long userno) { this.userno = userno; }
    public String getspacename() { return spacename; }
    public void setspacename(String spacename) { this.spacename = spacename; }
    public String getspacesummary() { return spacesummary; }
    public void setspacesummary(String spacesummary) { this.spacesummary = spacesummary; }
    public String getspaceinfo() { return spaceinfo; }
    public void setspaceinfo(String spaceinfo) { this.spaceinfo = spaceinfo; }
    public String getemail() { return email; }
    public void setemail(String email) { this.email = email; }
    public String getphone() { return phone; }
    public void setphone(String phone) { this.phone = phone; }
    public String gettel() { return tel; }
    public void settel(String tel) { this.tel = tel; }
    public String getspacelink() { return spacelink; }
    public void setspacelink(String spacelink) { this.spacelink = spacelink; }
    public String getpostcode() { return postcode; }
    public void setpostcode(String postcode) { this.postcode = postcode; }
    public String getaddress() { return address; }
    public void setaddress(String address) { this.address = address; }
    public String getaddressdetail() { return addressdetail; }
    public void setaddressdetail(String addressdetail) { this.addressdetail = addressdetail; }
    public String getinst_dt() { return inst_dt; }
    public void setinst_dt(String inst_dt) { this.inst_dt = inst_dt; }
    public String getupdt_dt() { return updt_dt; }
    public void setupdt_dt(String updt_dt) { this.updt_dt = updt_dt; }

    // ----- 호환용 표준 자바빈 getter/setter (대문자 시작) -----
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
    public String getInst_dt() { return inst_dt; }
    public void setInst_dt(String inst_dt) { this.inst_dt = inst_dt; }
    public String getUpdt_dt() { return updt_dt; }
    public void setUpdt_dt(String updt_dt) { this.updt_dt = updt_dt; }
}
