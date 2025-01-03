package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.entity.SchedulingRule;
import org.example.vo.ScheduleRuleVO;

@Mapper
public interface SchedulingRuleMapper {

    @Select("select id from scheduling_rule where store_id = #{id}")
    Long ruleIdByStoreId(Long id);

    @Select("select * from scheduling_rule where id = #{storeId}")
    SchedulingRule getScheduleRule(int storeId);

    @Update("update scheduling_rule set store_work_time_frame = #{schedulingRule.storeWorkTimeFrame}, " +
            "most_work_hour_in_one_day = #{schedulingRule.mostWorkHourInOneDay}, " +
            "most_work_hour_in_one_week = #{schedulingRule.mostWorkHourInOneWeek}, " +
            "min_shift_minute = #{schedulingRule.minShiftMinute}, " +
            "max_shift_minute = #{schedulingRule.maxShiftMinute}, " +
            "rest_minute = #{schedulingRule.restMinute}, " +
            "lunch_time_rule = #{schedulingRule.lunchTimeRule}, " +
            "dinner_time_rule = #{schedulingRule.dinnerTimeRule} where id = #{storeId}")
    void update(SchedulingRule schedulingRule, int storeId);
}
