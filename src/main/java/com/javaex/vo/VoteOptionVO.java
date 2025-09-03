package com.javaex.vo;

public class VoteOptionVO {

	private long reservationNo;
	private long userNo;
	private long voteNo;
	private long roomNo;
	private long reciptNo;
	private String voteDate;
	private String voteTime;
	private int voteStatus;

	public VoteOptionVO() {
		super();
	}
	
	public VoteOptionVO(long userNo, long voteNo, long roomNo, String voteDate, String voteTime) {
		this.userNo = userNo;
		this.voteNo = voteNo;
		this.roomNo = roomNo;
		this.voteDate = voteDate;
		this.voteTime = voteTime;
	}

	public VoteOptionVO(long reservationNo, long userNo, long voteNo, long roomNo, long reciptNo, String voteDate,
			String voteTime, int voteStatus) {
		super();
		this.reservationNo = reservationNo;
		this.userNo = userNo;
		this.voteNo = voteNo;
		this.roomNo = roomNo;
		this.reciptNo = reciptNo;
		this.voteDate = voteDate;
		this.voteTime = voteTime;
		this.voteStatus = voteStatus;
	}

	public long getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(long reservationNo) {
		this.reservationNo = reservationNo;
	}

	public long getUserNo() {
		return userNo;
	}

	public void setUserNo(long userNo) {
		this.userNo = userNo;
	}

	public long getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(long voteNo) {
		this.voteNo = voteNo;
	}

	public long getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(long roomNo) {
		this.roomNo = roomNo;
	}

	public long getReciptNo() {
		return reciptNo;
	}

	public void setReciptNo(long reciptNo) {
		this.reciptNo = reciptNo;
	}

	public String getVoteDate() {
		return voteDate;
	}

	public void setVoteDate(String voteDate) {
		this.voteDate = voteDate;
	}

	public String getVoteTime() {
		return voteTime;
	}

	public void setVoteTime(String voteTime) {
		this.voteTime = voteTime;
	}

	public int getVoteStatus() {
		return voteStatus;
	}

	public void setVoteStatus(int voteStatus) {
		this.voteStatus = voteStatus;
	}

	@Override
	public String toString() {
		return "VoteOptionVO [reservationNo=" + reservationNo + ", userNo=" + userNo + ", voteNo=" + voteNo
				+ ", roomNo=" + roomNo + ", reciptNo=" + reciptNo + ", voteDate=" + voteDate + ", voteTime=" + voteTime
				+ ", voteStatus=" + voteStatus + "]";
	}

}
