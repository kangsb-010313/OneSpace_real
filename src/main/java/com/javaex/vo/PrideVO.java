package com.javaex.vo;

import java.time.LocalDateTime;

public class PrideVO {

	//필드
	    private Long teamPostNo;       // PK
	    private Long teamNo;           // 팀 FK
	    private String teamPostType;   // TEAM_PRIDE / NOTICE / VOTE ...
	    private String teamPostTitle;  // 제목
	    private String teamContent;    // 내용
	    private LocalDateTime teamWriteDate;
	    private LocalDateTime teamUpdateDate;

	    // 조인 표시용(teams 테이블)
	    private String teamName;       // 팀명
	    private String instaAccount;   // 인스타 계정       

    // 생성자
    public PrideVO() {
    	
    }

	public PrideVO(Long teamPostNo, Long teamNo, String teamPostType, String teamPostTitle, String teamContent,
			LocalDateTime teamWriteDate, LocalDateTime teamUpdateDate, String teamName, String instaAccount) {
		super();
		this.teamPostNo = teamPostNo;
		this.teamNo = teamNo;
		this.teamPostType = teamPostType;
		this.teamPostTitle = teamPostTitle;
		this.teamContent = teamContent;
		this.teamWriteDate = teamWriteDate;
		this.teamUpdateDate = teamUpdateDate;
		this.teamName = teamName;
		this.instaAccount = instaAccount;
	}
    //메소드gs
	public Long getTeamPostNo() {
		return teamPostNo;
	}

	public void setTeamPostNo(Long teamPostNo) {
		this.teamPostNo = teamPostNo;
	}

	public Long getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(Long teamNo) {
		this.teamNo = teamNo;
	}

	public String getTeamPostType() {
		return teamPostType;
	}

	public void setTeamPostType(String teamPostType) {
		this.teamPostType = teamPostType;
	}

	public String getTeamPostTitle() {
		return teamPostTitle;
	}

	public void setTeamPostTitle(String teamPostTitle) {
		this.teamPostTitle = teamPostTitle;
	}

	public String getTeamContent() {
		return teamContent;
	}

	public void setTeamContent(String teamContent) {
		this.teamContent = teamContent;
	}

	public LocalDateTime getTeamWriteDate() {
		return teamWriteDate;
	}

	public void setTeamWriteDate(LocalDateTime teamWriteDate) {
		this.teamWriteDate = teamWriteDate;
	}

	public LocalDateTime getTeamUpdateDate() {
		return teamUpdateDate;
	}

	public void setTeamUpdateDate(LocalDateTime teamUpdateDate) {
		this.teamUpdateDate = teamUpdateDate;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getInstaAccount() {
		return instaAccount;
	}

	public void setInstaAccount(String instaAccount) {
		this.instaAccount = instaAccount;
	}
	
	//메소드일반
	@Override
	public String toString() {
		return "PrideVO [teamPostNo=" + teamPostNo + ", teamNo=" + teamNo + ", teamPostType=" + teamPostType
				+ ", teamPostTitle=" + teamPostTitle + ", teamContent=" + teamContent + ", teamName=" + teamName
				+ ", instaAccount=" + instaAccount + "]";
	}

	
    
}
