package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

/**
 * 系统定时通知表，记录系统发送的定时通知信息
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SystemScheduledNotice {

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
     * 门店ID
     */
    private Long storeId;

    /**
     * 上班通知提醒时间
     */
    private LocalDateTime workNoticeTime;

    /**
     * 上班通知方式：0-系统消息，1-邮件，2-系统消息及邮件
     */
    private Integer workNoticeType;

    /**
     * 休假通知提醒时间
     */
    private LocalDateTime holidayNoticeTime;

    /**
     * 休假通知方式：0-系统消息，1-邮件，2-系统消息及邮件
     */
    private Integer holidayNoticeType;
}
