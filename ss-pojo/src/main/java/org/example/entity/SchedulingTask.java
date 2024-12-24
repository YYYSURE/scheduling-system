package org.example.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 排班任务表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-01 13:58:33
 */
@Data
@TableName("scheduling_task")
@NoArgsConstructor
public class SchedulingTask implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "id")
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    private Date updateTime;

    /**
     * 排班规则id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long schedulingRuleId;
    /**
     * 门店id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
    /**
     * 排班起始日期
     */
    private String startDate;
    /**
     * 排班结束日期
     */
    private String endDate;
    /**
     * 是否发布任务 0：未发布 1：已经发布
     */
    private Integer isPublish;

    public SchedulingTask( Long schedulingRuleId, Long storeId,
                                String startDate, String endDate, Integer isPublish) {
        this.schedulingRuleId = schedulingRuleId;
        this.storeId = storeId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isPublish = isPublish;
    }

    @Override
    public SchedulingTask clone() {
        return new SchedulingTask(
                schedulingRuleId,
                storeId,
                startDate,
                endDate,
                isPublish);
    }

}
