package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 节日表
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Festival {
    /**
     * 主键
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
     * 是否删除 0：未删除 1：已删除
     */
    private Byte isDeleted;

    /**
     * 节日名称
     */
    private String name;

    /**
     * 起始日期
     */
    private Date startDate;

    /**
     * 截止日期
     */
    private Date endDate;

    /**
     * 类型 0：农历 1：新历
     */
    private Byte type;

    /**
     * 门店id
     */
    private Long storeId;
}
