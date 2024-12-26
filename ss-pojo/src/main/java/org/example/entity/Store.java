package org.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 门店表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-09 11:17:26
 */
@Data
@TableName("store")
public class Store extends Base implements Serializable {
    private static final long serialVersionUID = 1L;
    // 对应数据库的 id 字段
    private Long id;

    /**
     * 名称
     */
    private String name;
    /**
     * 省
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private String province;
    /**
     * 市
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private String city;
    /**
     * 区
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private String region;
    /**
     * 详细地址
     */
    private String address;
    /**
     * 工作场所面积
     */
    private BigDecimal size;
    /**
     * 0：营业中 1：休息中（默认0）
     */
    private Integer status;

}
