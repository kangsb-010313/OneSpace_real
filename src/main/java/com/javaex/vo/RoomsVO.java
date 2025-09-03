package com.javaex.vo;

import java.util.List;

public class RoomsVO {
	private Long roomNo;
	private Long spacesNo;
	private String roomName;
	private String roomInfo;
	private String area;
	private int capacity;
	private String thumbImg;
	private String instDtm;
	private String updtDtm;

	private List<RoomPriceVO> prices;

	public Long getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(Long roomNo) {
		this.roomNo = roomNo;
	}

	public Long getSpacesNo() {
		return spacesNo;
	}

	public void setSpacesNo(Long spacesNo) {
		this.spacesNo = spacesNo;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRoomInfo() {
		return roomInfo;
	}

	public void setRoomInfo(String roomInfo) {
		this.roomInfo = roomInfo;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	public String getThumbImg() {
		return thumbImg;
	}

	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}

	public String getInstDtm() {
		return instDtm;
	}

	public void setInstDtm(String instDtm) {
		this.instDtm = instDtm;
	}

	public String getUpdtDtm() {
		return updtDtm;
	}

	public void setUpdtDtm(String updtDtm) {
		this.updtDtm = updtDtm;
	}

	public List<RoomPriceVO> getPrices() {
		return prices;
	}

	public void setPrices(List<RoomPriceVO> prices) {
		this.prices = prices;
	}

	public static class RoomAttachment {
		private Long pictureSno;
		private String refType;
		private Long refNo;
		private String storedFileName;
		private String originFileName;
		private String filePath;
		private String instDtm;
		private String updtDtm;

		public Long getPictureSno() {
			return pictureSno;
		}

		public void setPictureSno(Long pictureSno) {
			this.pictureSno = pictureSno;
		}

		public String getRefType() {
			return refType;
		}

		public void setRefType(String refType) {
			this.refType = refType;
		}

		public Long getRefNo() {
			return refNo;
		}

		public void setRefNo(Long refNo) {
			this.refNo = refNo;
		}

		public String getStoredFileName() {
			return storedFileName;
		}

		public void setStoredFileName(String storedFileName) {
			this.storedFileName = storedFileName;
		}

		public String getOriginFileName() {
			return originFileName;
		}

		public void setOriginFileName(String originFileName) {
			this.originFileName = originFileName;
		}

		public String getFilePath() {
			return filePath;
		}

		public void setFilePath(String filePath) {
			this.filePath = filePath;
		}

		public String getInstDtm() {
			return instDtm;
		}

		public void setInstDtm(String instDtm) {
			this.instDtm = instDtm;
		}

		public String getUpdtDtm() {
			return updtDtm;
		}

		public void setUpdtDtm(String updtDtm) {
			this.updtDtm = updtDtm;
		}
	}

	@Override
	public String toString() {
		return "RoomsVO [roomNo=" + roomNo + ", spacesNo=" + spacesNo + ", roomName=" + roomName + ", roomInfo="
				+ roomInfo + ", area=" + area + ", capacity=" + capacity + ", thumbImg=" + thumbImg + ", instDtm="
				+ instDtm + ", updtDtm=" + updtDtm + ", prices=" + prices + "]";
	}

}