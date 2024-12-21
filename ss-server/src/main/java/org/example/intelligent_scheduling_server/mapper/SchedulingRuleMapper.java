package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SchedulingRuleMapper {

    @Select("select id from scheduling_rule where store_id = #{id}")
    Long ruleIdByStoreId(Long id);
}
