package com.javaex.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class PerforInfoVO {

    // === infowrite 테이블 컬럼 ===
    private Long infoPostNo;          // PK (auto_increment)
    private Long userNo;              // 작성자 번호
    private String infoPostTitle;     // 제목
    private String agencyName;        // 주최/주관
    private String infoContent;       // 내용
    private String infoOutUrl;        // 외부 링크
    private String infoPostType;      // 분류(공연/대회 등)
    private LocalDate deadlineDate;   // 마감일
    private String infoArea;          // 지역
    private String perforImg;         // 공연 이미지(선택)
    private LocalDateTime infoWriteDate;   // 작성일
    private LocalDateTime infoUpdateDate;  // 수정일
    private String infoImg;           // 썸네일/기타 이미지(선택)

    // ===== getter/setter =====
    public Long getInfoPostNo() { return infoPostNo; }
    public void setInfoPostNo(Long infoPostNo) { this.infoPostNo = infoPostNo; }

    public Long getUserNo() { return userNo; }
    public void setUserNo(Long userNo) { this.userNo = userNo; }

    public String getInfoPostTitle() { return infoPostTitle; }
    public void setInfoPostTitle(String infoPostTitle) { this.infoPostTitle = infoPostTitle; }

    public String getAgencyName() { return agencyName; }
    public void setAgencyName(String agencyName) { this.agencyName = agencyName; }

    public String getInfoContent() { return infoContent; }
    public void setInfoContent(String infoContent) { this.infoContent = infoContent; }

    public String getInfoOutUrl() { return infoOutUrl; }
    public void setInfoOutUrl(String infoOutUrl) { this.infoOutUrl = infoOutUrl; }

    public String getInfoPostType() { return infoPostType; }
    public void setInfoPostType(String infoPostType) { this.infoPostType = infoPostType; }

    public LocalDate getDeadlineDate() { return deadlineDate; }
    public void setDeadlineDate(LocalDate deadlineDate) { this.deadlineDate = deadlineDate; }

    public String getInfoArea() { return infoArea; }
    public void setInfoArea(String infoArea) { this.infoArea = infoArea; }

    public String getPerforImg() { return perforImg; }
    public void setPerforImg(String perforImg) { this.perforImg = perforImg; }

    public LocalDateTime getInfoWriteDate() { return infoWriteDate; }
    public void setInfoWriteDate(LocalDateTime infoWriteDate) { this.infoWriteDate = infoWriteDate; }

    public LocalDateTime getInfoUpdateDate() { return infoUpdateDate; }
    public void setInfoUpdateDate(LocalDateTime infoUpdateDate) { this.infoUpdateDate = infoUpdateDate; }

    public String getInfoImg() { return infoImg; }
    public void setInfoImg(String infoImg) { this.infoImg = infoImg; }
}
