package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.Date;

/**
 * 排班日期表，记录每个排班日期的详细信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SchedulingDate {
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
     * 排班日期
     */
    private Date date;

    /**
     * 是否需要工作：0-否，1-是
     */
    private Byte isNeedWork;

    /**
     * 开始工作时间（例如：09:00）
     */
    private String startWorkTime;

    /**
     * 结束工作时间（例如：18:00）
     */
    private String endWorkTime;

    /**
     * 所属门店ID
     */
    private Long storeId;
}
