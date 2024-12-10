package org.example.vo.shiftScheduling.applet;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WeeklyTaskVo implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 任务起始时间
     */
    private String timeStart;
    /**
     * 任务结束时间
     */
    private String timeEnd;
    /**
     * 该任务的起始时间距离这一天中该任务上一个任务结束的时间差距
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long timeStartToLast;
    /**
     * 该班次任务的时间差（任务时长）
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long timeDifference;
}
