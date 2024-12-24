package org.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


@Data
@TableName("leave_requests")
public class leaveRequest {
    private int id;               // 请假记录ID，唯一标识
    private int employeeId;    // 员工ID，关联员工表 (使用String类型，若是数字类型则改为Integer)
    private String leaveType;     // 请假类型，事假、病假、调休等
    private String date;          // 请假日期，格式：yyyy-MM-dd
    private String startTime;     // 开始时间，格式：HH:mm
    private String endTime;       // 结束时间，格式：HH:mm
    private String reason;        // 请假原因
    private int status;       // 请假状态，0-待审批，1-已批准，2-已驳回
    private String applyTime;     // 申请时间，格式：yyyy-MM-dd HH:mm:ss
    private String approveTime;   // 审批时间，格式：yyyy-MM-dd HH:mm:ss
    private int adminId;       // 审批人ID，关联管理员或上级员工
}
