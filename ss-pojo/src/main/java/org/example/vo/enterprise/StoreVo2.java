package org.example.vo.enterprise;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreVo2 {
    private static final long serialVersionUID = 1L;
    // 对应数据库的 id 字段
    private Long id;
    private Integer employeeCount;

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
