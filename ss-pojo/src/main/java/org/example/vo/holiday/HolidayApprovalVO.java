package org.example.vo.holiday;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HolidayApprovalVO {
    /**
     * 请假人姓名
     */
    private String name;
    /**
     * 请假类型
     */
    private String type;

    /**
     * 开始时间
     */
    private String startTime;
    /**
     *结束时间
     */
    private String endTime;
    /**
     * 状态
     * 1 已批准 2 已驳回 0 待批准
     */

    private int state;
    /**
     * 时间
     */
    private String time;
}
