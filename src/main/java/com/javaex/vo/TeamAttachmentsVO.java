package com.javaex.vo;

public class TeamAttachmentsVO {
	
	private int teamfileNo;				
	private int postNo;					//어느 게시글에 속한 파일인지
	private String teamStoredFileName;	//저장될 때의 파일 이름
	private String teamOriginFileName;	//사용자가 올린 원래 파일 이름
	private String teamFilePath;
	private String teamFileCreatedDate;	//등록일(작성일)
	private String teamFileUpdateDate;	//수정일
	
	//테이블에 없지만 파일 크기 관리하면 나중에 유용할 수도 있어서 일단 추가
	private long  teamFileSize;

	
	
	//생성자
	public TeamAttachmentsVO() {
	}



	public TeamAttachmentsVO(int teamfileNo, int postNo, String teamStoredFileName, String teamOriginFileName,
			String teamFilePath, String teamFileCreatedDate, String teamFileUpdateDate, long teamFileSize) {
		super();
		this.teamfileNo = teamfileNo;
		this.postNo = postNo;
		this.teamStoredFileName = teamStoredFileName;
		this.teamOriginFileName = teamOriginFileName;
		this.teamFilePath = teamFilePath;
		this.teamFileCreatedDate = teamFileCreatedDate;
		this.teamFileUpdateDate = teamFileUpdateDate;
		this.teamFileSize = teamFileSize;
	}


	//메소드 gs
	public int getTeamfileNo() {
		return teamfileNo;
	}



	public void setTeamfileNo(int teamfileNo) {
		this.teamfileNo = teamfileNo;
	}



	public int getPostNo() {
		return postNo;
	}



	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}



	public String getTeamStoredFileName() {
		return teamStoredFileName;
	}



	public void setTeamStoredFileName(String teamStoredFileName) {
		this.teamStoredFileName = teamStoredFileName;
	}



	public String getTeamOriginFileName() {
		return teamOriginFileName;
	}



	public void setTeamOriginFileName(String teamOriginFileName) {
		this.teamOriginFileName = teamOriginFileName;
	}



	public String getTeamFilePath() {
		return teamFilePath;
	}



	public void setTeamFilePath(String teamFilePath) {
		this.teamFilePath = teamFilePath;
	}



	public String getTeamFileCreatedDate() {
		return teamFileCreatedDate;
	}



	public void setTeamFileCreatedDate(String teamFileCreatedDate) {
		this.teamFileCreatedDate = teamFileCreatedDate;
	}



	public String getTeamFileUpdateDate() {
		return teamFileUpdateDate;
	}



	public void setTeamFileUpdateDate(String teamFileUpdateDate) {
		this.teamFileUpdateDate = teamFileUpdateDate;
	}



	public long getTeamFileSize() {
		return teamFileSize;
	}



	public void setTeamFileSize(long teamFileSize) {
		this.teamFileSize = teamFileSize;
	}


	//메소드 일반
	@Override
	public String toString() {
		return "TeamAttachmentsVO [teamfileNo=" + teamfileNo + ", postNo=" + postNo + ", teamStoredFileName="
				+ teamStoredFileName + ", teamOriginFileName=" + teamOriginFileName + ", teamFilePath=" + teamFilePath
				+ ", teamFileCreatedDate=" + teamFileCreatedDate + ", teamFileUpdateDate=" + teamFileUpdateDate
				+ ", teamFileSize=" + teamFileSize + "]";
	}


	
	
	

}
