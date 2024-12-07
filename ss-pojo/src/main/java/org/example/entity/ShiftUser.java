package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

/**
 * 班次_用户中间表，记录用户与班次的关联信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShiftUser {

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
     * 是否删除：0-未删除，1-已删除
     */
    private Integer isDeleted;

    /**
     * 班次ID
     */
    private Long shiftId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 职位ID（记录用户当时的职位）
     */
    private Long positionId;
}
