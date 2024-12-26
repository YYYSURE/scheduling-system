package org.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 管理员表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-12-25
 */
@Data
@TableName("admin")
public class StoreAdmin extends Base implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private Long id;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 姓名
     */
    private String name;

    /**
     * 电话
     */
    private String phone;

    /**
     * 门店ID
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Integer storeId;

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
     * 类型
     */
    private Integer type;

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", storeId=" + storeId +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender=" + gender +
                ", age=" + age +
                ", type=" + type +
                '}';
    }
}