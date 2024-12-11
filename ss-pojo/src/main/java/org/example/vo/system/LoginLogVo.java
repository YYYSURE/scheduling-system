package org.example.vo.system;

import org.example.entity.Base;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.util.Date;

@Data
public class LoginLogVo extends Base {
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
     * 企业名称
     */
    private String enterpriseName;
    /**
     * 门店id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
    /**
     * 门店名称
     */
    private String storeName;
}
