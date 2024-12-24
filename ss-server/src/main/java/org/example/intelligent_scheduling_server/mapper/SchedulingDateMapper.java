package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.example.entity.SchedulingDate;

import java.util.Date;
import java.util.List;

@Mapper
public interface SchedulingDateMapper {

    @Select("select id from scheduling_date where store_id = #{storeId} and date = #{date}")
    Long getIdByDate(Long storeId, Date date);

    @Insert("insert into scheduling_date(date, is_need_work, start_work_time, end_work_time, store_id, task_id) " +
            "values (#{date} ,#{isNeedWork} ,#{startWorkTime} ,#{endWorkTime} ,#{storeId} ,#{taskId} )")
    void insert(SchedulingDate d);
}
