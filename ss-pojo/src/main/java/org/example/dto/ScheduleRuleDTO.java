package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleRuleDTO {
    private int dayTime;
    private int time;
    private String lunchStartTime;
    private String lunchEndTime;
    private String dinnerStartTime;
    private String dinnerEndTime;
    private int minTime;
    private int maxTime;
    private String workTime;
    private String workTime1;
    private String workTime2;
}
