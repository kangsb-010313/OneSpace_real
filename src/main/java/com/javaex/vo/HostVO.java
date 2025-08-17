package com.javaex.vo;

public class HostVO {
    private Long spacesno;        // PK (spaces.spacesNo)
    private Long userno;          // FK (users.userNo)

    private String spacename;
    private String spacesummary;
    private String spaceinfo;
    private String spacearea;     // host_info2용 (선택)

    private String email;         // email 전체 (aaa@bbb.com)
    private String phone;         // 휴대폰
    private String tel;           // 대표전화

    private String address;
    private String addressdetail;

    private String facility_csv;  // 시설 CSV
    private Integer refund_agreed; // 0/1
    private String rep_image_url; // 대표 이미지 URL

    private Integer hidden_in_search; // 0/1

    // getter/setter (소문자 메서드)
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

    public String getspacearea() { return spacearea; }
    public void setspacearea(String spacearea) { this.spacearea = spacearea; }

    public String getemail() { return email; }
    public void setemail(String email) { this.email = email; }

    public String getphone() { return phone; }
    public void setphone(String phone) { this.phone = phone; }

    public String gettel() { return tel; }
    public void settel(String tel) { this.tel = tel; }

    public String getaddress() { return address; }
    public void setaddress(String address) { this.address = address; }

    public String getaddressdetail() { return addressdetail; }
    public void setaddressdetail(String addressdetail) { this.addressdetail = addressdetail; }

    public String getfacility_csv() { return facility_csv; }
    public void setfacility_csv(String facility_csv) { this.facility_csv = facility_csv; }

    public Integer getrefund_agreed() { return refund_agreed; }
    public void setrefund_agreed(Integer refund_agreed) { this.refund_agreed = refund_agreed; }

    public String getrep_image_url() { return rep_image_url; }
    public void setrep_image_url(String rep_image_url) { this.rep_image_url = rep_image_url; }

    public Integer gethidden_in_search() { return hidden_in_search; }
    public void sethidden_in_search(Integer hidden_in_search) { this.hidden_in_search = hidden_in_search; }
}
