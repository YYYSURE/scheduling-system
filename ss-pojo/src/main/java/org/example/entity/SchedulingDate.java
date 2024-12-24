package org.example.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 排班日期表
 *

 */
@Data
@TableName("scheduling_date")
public class SchedulingDate implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.NONE)
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

    @TableField(value = "update_time", fill = FieldFill.UPDATE)
    private Date updateTime;

    /**
     * 日期
     */
    private Date date;
    /**
     * 是否需要工作 0：休假 1：工作
     */
    private Integer isNeedWork;
    /**
     * 上班时间（8:00）
     */
    private String startWorkTime;
    /**
     * 下班时间（21:00）
     */
    private String endWorkTime;
    /**
     * 门店id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
    /**
     * 任务id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long taskId;
    /**
     * 当天是否含有班次
     */
    @TableField(exist = false)
    private Integer isHaveShift = 0;

}
