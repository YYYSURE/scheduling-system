package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.Date;

/**
 * 排班规则表，记录系统的排班规则设置
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SchedulingRule {
    /**
     * 主键ID
     */
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 删除标识：0-未删除，1-已删除
     */
    private Byte isDeleted;

    /**
     * 门店ID
     */
    private Long storeId;

    /**
     * 门店工作时间区间（如：09:00-18:00）
     */
    private String storeWorkTimeFrame;

    /**
     * 一天最大工作小时数
     */
    private Double mostWorkHourInOneDay;

    /**
     * 一周最大工作小时数
     */
    private Double mostWorkHourInOneWeek;

    /**
     * 最短排班时间（分钟）
     */
    private Integer minShiftMinute;

    /**
     * 最长排班时间（分钟）
     */
    private Integer maxShiftMinute;

    /**
     * 休息时间（分钟）
     */
    private Integer restMinute;

    /**
     * 最大连续工作时间（小时）
     */
    private Double maximumContinuousWorkTime;

    /**
     * 开店规则
     */
    private String openStoreRule;

    /**
     * 关店规则
     */
    private String closeStoreRule;

    /**
     * 正常排班规则
     */
    private String normalRule;

    /**
     * 无顾客时排班规则
     */
    private String noPassengerRule;

    /**
     * 每天最小排班数量
     */
    private Integer minimumShiftNumInOneDay;

    /**
     * 正常班次排班规则
     */
    private String normalShiftRule;

    /**
     * 午餐时间规则
     */
    private String lunchTimeRule;

    /**
     * 晚餐时间规则
     */
    private String dinnerTimeRule;

    /**
     * 排班规则类型：0-普通，1-特殊
     */
    private Byte ruleType;
}
