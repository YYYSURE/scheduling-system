package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

@Mapper
public interface LeaveMapper {
    @Select("select employee_id from leave_requests where start_time < #{end} and end_time > #{start}")
    List<Long> getByTimeRange(Date start, Date end);
}
