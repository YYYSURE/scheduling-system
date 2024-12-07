package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

/**
 * 用户-消息中间表，记录用户与消息的关联信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserMessage {

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
     * 用户ID
     */
    private Long userId;

    /**
     * 消息ID
     */
    private Long messageId;
}
