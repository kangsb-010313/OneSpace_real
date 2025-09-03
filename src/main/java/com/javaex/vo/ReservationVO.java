package com.javaex.vo;

public class ReservationVO {

	private long reservationNo;
	private long userNo;
	private long voteNo;
	private long roomNo;
	private long reciptNo;
	private String voteDate;
	private int voteStatus;
	private String voteTime;

	public ReservationVO() {
		super();
	}

	public ReservationVO(long reservationNo, long userNo, long voteNo, long roomNo, long reciptNo, String voteDate,
			int voteStatus, String voteTime) {
		super();
		this.reservationNo = reservationNo;
		this.userNo = userNo;
		this.voteNo = voteNo;
		this.roomNo = roomNo;
		this.reciptNo = reciptNo;
		this.voteDate = voteDate;
		this.voteStatus = voteStatus;
		this.voteTime = voteTime;
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

	public int getVoteStatus() {
		return voteStatus;
	}

	public void setVoteStatus(int voteStatus) {
		this.voteStatus = voteStatus;
	}

	public String getVoteTime() {
		return voteTime;
	}

	public void setVoteTime(String voteTime) {
		this.voteTime = voteTime;
	}

	@Override
	public String toString() {
		return "ReservationVO [reservationNo=" + reservationNo + ", userNo=" + userNo + ", voteNo=" + voteNo
				+ ", roomNo=" + roomNo + ", reciptNo=" + reciptNo + ", voteDate=" + voteDate + ", voteStatus="
				+ voteStatus + ", voteTime=" + voteTime + "]";
	}

}
