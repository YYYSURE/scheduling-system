package org.example.vo.enterprise;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.entity.Base;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreVo extends Base {

    /**
     * 名称
     */
    private String name;
    /**
     * 门店id
     */
    private Long id;
    /**
     * 人数
     */
    private Long number;

    /**
     * 省
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long provinceId;
    private String provinceName;
    /**
     * 市
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long cityId;
    private String cityName;
    /**
     * 区
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long regionId;
    private String regionName;
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
