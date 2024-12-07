package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

/**
 * 排班班次表，记录系统的班次安排
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SchedulingShift {

    /**
     * 主键ID
     */
    private Long id;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 删除标识：0-未删除，1-已删除
     */
    private Integer isDeleted;

    /**
     * 班次开始时间
     */
    private LocalDateTime startDate;

    /**
     * 班次结束时间
     */
    private LocalDateTime endDate;

    /**
     * 对应排班工作日的ID
     */
    private Long schedulingDateId;

    /**
     * 吃饭开始时间
     */
    private LocalDateTime mealStartDate;

    /**
     * 吃饭结束时间
     */
    private LocalDateTime mealEndDate;

    /**
     * 午餐、晚餐或不安排用餐：0-午餐，1-晚餐，2-不安排用餐
     */
    private Integer mealType;

    /**
     * 班次总时间（分钟）
     */
    private Integer totalMinute;

    /**
     * 班次类型：0-正常班，1-开店，2-收尾
     */
    private Integer shiftType;
}
