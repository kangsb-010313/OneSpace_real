package com.javaex.vo;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class TeamPostVO {

	// 필드

	// posts 테이블의 컬럼들
	private int teamPostNo; // 게시물 번호
	private int teamNo; // 팀 번호
	private int userNo; // 작성자 회원 번호
	private int voteNo; // votes 테이블 투표항목번호
	private String teamPostType; // 게시물 타입 ('일반공지', '팀자랑' 구분)
	private String teamPostTitle; // 제목
	private String instaAccount; // teams 테이블 인스타계정
	private String teamContent; // 내용
	private String teamWriteDate; // 작성일 (DATETIME은 String으로)
	private String teamUpdateDate; // 수정일

	// teams, users테이블에서 가져올 정보
	private String userName; // 작성자 이름 (users 테이블)
	private String teamName; // 팀 이름 (teams 테이블)

	private MultipartFile[] files;
	
    // (추가) 이 게시글에 달린 첨부파일 목록을 담을 리스트
    private List<TeamAttachmentsVO> attachments;

	// 기본생성자
	public TeamPostVO() {
	}

	public TeamPostVO(int teamPostNo, int teamNo, int userNo, int voteNo, String teamPostType, String teamPostTitle,
			String instaAccount, String teamContent, String teamWriteDate, String teamUpdateDate, String userName,
			String teamName, MultipartFile[] files) {
		super();
		this.teamPostNo = teamPostNo;
		this.teamNo = teamNo;
		this.userNo = userNo;
		this.voteNo = voteNo;
		this.teamPostType = teamPostType;
		this.teamPostTitle = teamPostTitle;
		this.instaAccount = instaAccount;
		this.teamContent = teamContent;
		this.teamWriteDate = teamWriteDate;
		this.teamUpdateDate = teamUpdateDate;
		this.userName = userName;
		this.teamName = teamName;
		this.files = files;
	}
	

	public TeamPostVO(int teamPostNo, int teamNo, int userNo, int voteNo, String teamPostType, String teamPostTitle,
			String instaAccount, String teamContent, String teamWriteDate, String teamUpdateDate, String userName,
			String teamName, MultipartFile[] files, List<TeamAttachmentsVO> attachments) {
		super();
		this.teamPostNo = teamPostNo;
		this.teamNo = teamNo;
		this.userNo = userNo;
		this.voteNo = voteNo;
		this.teamPostType = teamPostType;
		this.teamPostTitle = teamPostTitle;
		this.instaAccount = instaAccount;
		this.teamContent = teamContent;
		this.teamWriteDate = teamWriteDate;
		this.teamUpdateDate = teamUpdateDate;
		this.userName = userName;
		this.teamName = teamName;
		this.files = files;
		this.attachments = attachments;
	}

	// 메소드 gs
	public int getTeamPostNo() {
		return teamPostNo;
	}

	public void setTeamPostNo(int teamPostNo) {
		this.teamPostNo = teamPostNo;
	}

	public int getTeamNo() {
		return teamNo;
	}

	public void setTeamNo(int teamNo) {
		this.teamNo = teamNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(int voteNo) {
		this.voteNo = voteNo;
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

	public String getInstaAccount() {
		return instaAccount;
	}

	public void setInstaAccount(String instaAccount) {
		this.instaAccount = instaAccount;
	}

	public String getTeamContent() {
		return teamContent;
	}

	public void setTeamContent(String teamContent) {
		this.teamContent = teamContent;
	}

	public String getTeamWriteDate() {
		return teamWriteDate;
	}

	public void setTeamWriteDate(String teamWriteDate) {
		this.teamWriteDate = teamWriteDate;
	}

	public String getTeamUpdateDate() {
		return teamUpdateDate;
	}

	public void setTeamUpdateDate(String teamUpdateDate) {
		this.teamUpdateDate = teamUpdateDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public MultipartFile[] getFiles() {
		return files;
	}

	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	

	public List<TeamAttachmentsVO> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<TeamAttachmentsVO> attachments) {
		this.attachments = attachments;
	}


	// 메소드 일반
	@Override
	public String toString() {
		return "TeamPostVO [teamPostNo=" + teamPostNo + ", teamNo=" + teamNo + ", userNo=" + userNo + ", voteNo="
				+ voteNo + ", teamPostType=" + teamPostType + ", teamPostTitle=" + teamPostTitle + ", instaAccount="
				+ instaAccount + ", teamContent=" + teamContent + ", teamWriteDate=" + teamWriteDate
				+ ", teamUpdateDate=" + teamUpdateDate + ", userName=" + userName + ", teamName=" + teamName
				+ ", files=" + Arrays.toString(files) + ", attachments=" + attachments + "]";
	}
	
	
}
