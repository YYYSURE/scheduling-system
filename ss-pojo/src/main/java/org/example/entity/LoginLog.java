package org.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import lombok.Data;

import java.util.Date;

@Data
@TableName("login_log")
public class LoginLog extends Base{
    private static final long serialVersionUID = 1L;
    private String username;
    private String ipaddr;
    private Integer status;
    private String msg;
    private String browser;
    private String os;
    private Date access_time;
    /**
     * 企业id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long enterpriseId;
    /**
     * 门店名称
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
}
