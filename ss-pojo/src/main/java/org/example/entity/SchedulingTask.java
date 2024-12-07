package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 排班任务表，记录排班任务的相关信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SchedulingTask {

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
     * 任务名称
     */
    private String name;

    /**
     * 班次总时长（分钟）
     */
    private Integer totalMinute;

    /**
     * 已分配班次的总时长（分钟）
     */
    private Integer totalAssignedMinute;

    /**
     * 分配比率
     */
    private BigDecimal allocationRatio;

    /**
     * 任务状态：0-新创建，1-计算中，2-计算完成，3-计算失败
     */
    private Integer status;

    /**
     * 排班规则ID
     */
    private Long schedulingRuleId;

    /**
     * 门店ID
     */
    private Long storeId;

    /**
     * 排班时段的时间段（以分钟为单位）
     */
    private Integer duration;

    /**
     * 每个排班时间单位包含的段数
     */
    private Integer intervalC;

    /**
     * 排班工作日及其客流量的详细信息
     */
    private String dateVoList;

    /**
     * 任务计算时间（小时）
     */
    private BigDecimal calculateTime;

    /**
     * 排班开始日期（UTC时间，比北京时间慢8小时）
     */
    private String startDate;

    /**
     * 排班结束日期（UTC时间，比北京时间慢8小时）
     */
    private String endDate;

    /**
     * 第一阶段算法
     */
    private String stepOneAlg;

    /**
     * 第二阶段算法
     */
    private String stepTwoAlg;

    /**
     * 第二阶段算法参数
     */
    private String stepTwoAlgParam;

    /**
     * 任务类型：0-真实任务，1-虚拟任务
     */
    private Byte type;

    /**
     * 父任务ID（虚拟任务才有父ID）
     */
    private Long parentId;

    /**
     * 是否发布任务：0-未发布，1-已发布
     */
    private Integer isPublish;
}
