package org.example.vo.shiftScheduling;

import org.example.vo.system.UserInfoVo;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;
import org.example.vo.system.UserInfoVo;

import java.io.Serializable;
import java.util.List;

/**
 * 用来绘制周视图
 */
@Data
public class WeekViewShiftVo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 上班时间
     */
    private String startTime;
    /**
     * 下班时间
     */
    private String endTime;
    /**
     * 吃饭类型 0：午餐 1：晚餐
     */
    private Integer mealType;
    private String mealStartTime;
    private String mealEndTime;
    /**
     * 班次时长
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long shiftMinute;
    /**
     * 班次的员工信息
     */
    private List<UserInfoVo> userInfoVoList;
}
