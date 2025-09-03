package com.javaex.vo;

public class VoteVO {
	private long voteNo;
	private long postNo;
	private long userNo;
	private long totalPrice;

	public VoteVO() {
		super();
	}

	public VoteVO(long voteNo, long postNo, long userNo, long totalPrice) {
		super();
		this.voteNo = voteNo;
		this.postNo = postNo;
		this.userNo = userNo;
		this.totalPrice = totalPrice;
	}

	public long getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(long voteNo) {
		this.voteNo = voteNo;
	}

	public long getPostNo() {
		return postNo;
	}

	public void setPostNo(long postNo) {
		this.postNo = postNo;
	}

	public long getUserNo() {
		return userNo;
	}

	public void setUserNo(long userNo) {
		this.userNo = userNo;
	}

	public long getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(long totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "VoteVO [voteNo=" + voteNo + ", postNo=" + postNo + ", userNo=" + userNo + ", totalPrice=" + totalPrice
				+ "]";
	}

}
