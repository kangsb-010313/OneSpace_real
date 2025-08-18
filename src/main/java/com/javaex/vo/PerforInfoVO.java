package com.javaex.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class PerforInfoVO {

    private Long no;             // pk
    private String category;     // "공연" | "대회"
    private String title;
    private String url;
    private String region;
    private String content;
    private LocalDate closedate;     // 마감 날짜
    private LocalDateTime regdate;   // 작성일(등록일)

    private Long userno;         // 작성자 번호(선택)
    private String username;     // 작성자 이름(선택)

    // === getter/setter (java beans 규칙) ===
    public Long getNo() { return no; }
    public void setNo(Long no) { this.no = no; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public LocalDate getClosedate() { return closedate; }
    public void setClosedate(LocalDate closedate) { this.closedate = closedate; }

    public LocalDateTime getRegdate() { return regdate; }
    public void setRegdate(LocalDateTime regdate) { this.regdate = regdate; }

    public Long getUserno() { return userno; }
    public void setUserno(Long userno) { this.userno = userno; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}
