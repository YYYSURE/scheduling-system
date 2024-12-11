package org.example.dto;

import lombok.Data;

@Data
public class UserRegistDTO {
    /**
     * 姓名
     */
    private String name;
    /**
     * 电话号码
     */
    private String phone;
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 性别：
     */
    private String gender;
    /**
     * 年龄
     */
    private Integer age;
}
