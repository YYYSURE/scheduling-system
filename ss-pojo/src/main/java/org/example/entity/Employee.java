package org.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

/**
 * 用户表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-06 15:50:29
 */
@Data
@TableName("employee")
public class Employee extends Base implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 电话
     */
    private String phone;
//    /**
//     * 邮箱
//     */
//    private String mail;
    /**
     * 门店id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
    /**
     * 职位id
     */
    private Long positionId;
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 性别 0：男 1：女
     */
    private Integer gender;
    /**
     * 年龄
     */
    private Integer age;
    /**
     * 身份证号
     */
    private String idCard;
    /**
     * 地址
     */
    private String address;
    /**
     * 工作日偏好（喜欢星期几工作1|3|4喜欢星期一、三、四工作），缺省为全部
     */
    private String workDayPreference;
    /**
     * 工作时间偏好（1:00~3.00|5.00~8.00|17.00~21.00），缺省为全部）
     */
    private String workTimePreference;
    /**
     * 每天班次时长偏好
     */
    private String shiftLengthPreferenceOneDay;
    /**
     * 每周班次时长偏好
     */
    private String shiftLengthPreferenceOneWeek;

    @Override
    public String toString() {
        return "UserEntity{" +
                "id=" + getId() +
                ", phone='" + phone + '\'' +

                ", storeId=" + storeId +
                ", position_id=" + positionId +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender=" + gender +
                ", age=" + age +
                ", workDayPreference='" + workDayPreference + '\'' +
                ", workTimePreference='" + workTimePreference + '\'' +
                ", shiftLengthPreference=" + shiftLengthPreferenceOneDay +
                ", shiftLengthPreferenceOneWeek=" + shiftLengthPreferenceOneWeek +
                '}';
    }
}
