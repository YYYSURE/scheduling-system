package org.example.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.example.entity.UserMessage;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户-消息中间表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-20 15:43:46
 */
@Mapper
public interface UserMessageDao extends BaseMapper<UserMessage> {

}
