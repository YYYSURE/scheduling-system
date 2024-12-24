package org.example.vo.scheduling_calculate_service;

import lombok.Data;


@Data
public class DayShiftVo {
    private Long id;
    private String startTime;
    private String endTime;
    private Long employeeId;
    private String employeeName;
    private String lunchStartTime;
    private String lunchEndTime;
    private String dinnerStartTime;
    private String dinnerEndTime;
}
