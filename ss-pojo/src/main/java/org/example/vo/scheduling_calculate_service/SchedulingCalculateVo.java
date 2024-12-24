package org.example.vo.scheduling_calculate_service;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class SchedulingCalculateVo implements Serializable {
    private static final long serialVersionUID = 1L;

    @JsonSerialize(using = ToStringSerializer.class)
    private Long taskId;
    @JsonSerialize(using = ToStringSerializer.class)
    private Long schedulingRuleId;
    /**
     * 工作日
     */
    private List<DateVo> dateVoList;
    /**
     * 以多少分钟为一段
     */
    private final int duration = 30;
    /**
     * 以多少个段为基准去排班
     */
    private final int intervalC = 2;

}
