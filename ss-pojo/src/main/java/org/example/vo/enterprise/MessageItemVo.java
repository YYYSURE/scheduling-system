package org.example.vo.enterprise;

import org.example.entity.Base;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class MessageItemVo extends Base implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 通知类型(0-企业公开,1-门店公开，2-指定用户可以看)
     */
    private Integer type;
    /**
     * 通知主题
     */
    private String subject;
    /**
     * 通知内容
     */
    private String content;
    /**
     * 门店id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long storeId;
    /**
     * 企业id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long enterpriseId;
    /**
     * 是否发布（0：未发布；1：已发布）
     */
    private Integer isPublish;
    /**
     * 发布时间
     */
    private Date publishTime;

    /**
     * 创建人id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long createUserId;
    /**
     * 发送人用户名
     */
    private String createUsername;
    /**
     * 发送人真实姓名
     */
    private String createName;
    /**
     * 发起人头像
     */
    private String createAvatar;
    /**
     * 发布人id
     */
    @JsonSerialize(using = ToStringSerializer.class)
    private Long publishUserId;
    /**
     * 发布人用户名
     */
    private String publishUsername;
    /**
     * 发布人真实姓名
     */
    private String publishName;
    /**
     * 发布人头像
     */
    private String publishAvatar;

}
