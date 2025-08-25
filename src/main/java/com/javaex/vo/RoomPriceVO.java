package com.javaex.vo;

import java.time.LocalDateTime;

public class RoomPriceVO {
    private Long pricesNo;
    private Long roomNo;
    private String dayType;       // WEEKDAY / WEEKEND / MON ... 등
    private String startTime;     // 'HH:mm:ss'
    private String endTime;       // 'HH:mm:ss'
    private Integer hourlyPrice;
    private LocalDateTime instDtm;
    private LocalDateTime updtDtm;

    public Long getPricesNo() { return pricesNo; }
    public void setPricesNo(Long pricesNo) { this.pricesNo = pricesNo; }
    public Long getRoomNo() { return roomNo; }
    public void setRoomNo(Long roomNo) { this.roomNo = roomNo; }
    public String getDayType() { return dayType; }
    public void setDayType(String dayType) { this.dayType = dayType; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
    public Integer getHourlyPrice() { return hourlyPrice; }
    public void setHourlyPrice(Integer hourlyPrice) { this.hourlyPrice = hourlyPrice; }
    public LocalDateTime getInstDtm() { return instDtm; }
    public void setInstDtm(LocalDateTime instDtm) { this.instDtm = instDtm; }
    public LocalDateTime getUpdtDtm() { return updtDtm; }
    public void setUpdtDtm(LocalDateTime updtDtm) { this.updtDtm = updtDtm; }
}
