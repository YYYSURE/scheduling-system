package org.example.dto;

import java.util.Date;

public class HolidayDTO {
    private String type; // 请假类型：调休、病假、事假
    private String notes; // 请假理由
    private Integer state; // 请假状态：0-待批准，1-已批准，2-已驳回
    private Date startTime; // 开始时间
    private Date endTime; // 结束时间

    // Getters and Setters

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}
