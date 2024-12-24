package org.example.vo.system;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;
import lombok.ToString;
import org.example.entity.Base;

import java.util.List;

@Data
@ToString
public class UserInfoVo extends Base {
    /**
     * 职位id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long positionId;
    /**
     * 职位名称
     */
    private String positionName;
    /**
     * 电话
     */
    private String phone;
    /**
     * 门店id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
    /**
     * 门店名称
     */
    private String storeName;
    /**
     * 用户名
     */
    private String username;
    /**
     * 性别 0：男 1：女
     */
    private Integer gender;
    /**
     * 年龄
     */
    private Integer age;
    /**
     * 工作日偏好（喜欢星期几工作1|3|4喜欢星期一、三、四工作），缺省为全部
     */
    private List<Integer> workDayPreferenceList;
    /**
     * 工作时间偏好（1:00~3.00|5.00~8.00|17.00~21.00），缺省为全部）
     */
    private String workTimePreference;
    /**
     * 班次时长偏好（3|38：三小时38分钟）
     */
    /**
     * 每天班次时长偏好
     */
    private String shiftLengthPreferenceOneDay;
    /**
     * 每周班次时长偏好
     */
    private String shiftLengthPreferenceOneWeek;
    /**
     * 用户是否繁忙
     */
    private Boolean isBusy;
}
