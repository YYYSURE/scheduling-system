package org.example.intelligent_scheduling_server.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.example.entity.SchedulingRule;

/**
 * 门店规则中间表
 * 
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-23 21:34:22
 */
@Mapper
public interface SchedulingRuleDao extends BaseMapper<SchedulingRule> {
	
}
