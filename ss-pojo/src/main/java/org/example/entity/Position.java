package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.Date;

/**
 * 职位表，记录公司内部职位的信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Position {
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
     * 职位名称
     */
    private String name;

    /**
     * 职位描述
     */
    private String description;
}