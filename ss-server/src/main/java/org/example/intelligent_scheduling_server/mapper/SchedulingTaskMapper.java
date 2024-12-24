package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.example.entity.SchedulingTask;

@Mapper
public interface SchedulingTaskMapper {

    @Insert("INSERT INTO scheduling_task (scheduling_rule_id, store_id, start_date, end_date, is_publish) " +
            "VALUES (#{schedulingRuleId}, #{storeId}, #{startDate}, #{endDate}, #{isPublish})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    public void insert(SchedulingTask schedulingTask);

    @Delete("delete from scheduling_task where id = #{id}")
    public void deleteById(Long id);
}
