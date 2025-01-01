package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleRuleVO {
    /**
     * 员工一天最长工作时间
     */
    private BigDecimal dayTime;
    /**
     * 员工一周最长工作时间
     */
    private BigDecimal time;
    /**
     * 午餐开始时间
     */
    private String lunchStartTime;
    /**
     * 午餐结束时间
     */
    private String lunchEndTime;
    /**
     * 晚餐开始时间
     */
    private String dinnerStartTime;
    /**
     * 晚餐结束时间
     */
    private String dinnerEndTime;
    /**
     * 班次最小时间
     */
    private int minTime;
    /**
     * 班次最长时间
     */
    private int maxTime;
    /**
     * 门店工作时间段
     */
    private String workTime;

}
