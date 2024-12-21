package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeInfoDTO {
    /**
     * 姓名
     */
    private String name;
    /**
     * 性别
     */
    private String gender;
    /**
     * 职位
     */
    private String posts;
    /**
     * 门店
     */
    private String store;
    /**
     * 年龄
     */
    private int age;
    /**
     * 手机号
     */
    private String phone;
    /**
     *工作日偏好
     */
    private String day;
    /**
     *工作时间偏好
     */
    private String date;
    /**
     * 班次时长偏好
     */
    private String time;
    /**
     * 身份证
     */
    private String idCard;
    /**
     * 地址
     */
    private String address;



}
