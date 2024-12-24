package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.dto.intelligent_scheduling.Shift;
import org.example.entity.SchedulingShift;

import java.util.List;

@Mapper
public interface SchedulingShiftMapper {

    @Select("select * from scheduling_shift where scheduling_date_id = #{dateId} ")
    List<SchedulingShift> getByDateId(Long dateId);
}
