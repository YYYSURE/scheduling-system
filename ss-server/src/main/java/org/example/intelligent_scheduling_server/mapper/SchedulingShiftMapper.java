package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.dto.intelligent_scheduling.Shift;
import org.example.entity.SchedulingShift;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Mapper
public interface SchedulingShiftMapper {

    @Select("select * from scheduling_shift where scheduling_date_id = #{dateId} ")
    List<SchedulingShift> getByDateId(Long dateId);

    @Select("select * from scheduling_shift where id = #{shiftId} ")
    SchedulingShift getById(Long shiftId);

    @Select("SELECT user_id FROM scheduling_shift " +
            "WHERE (start_date < #{endDate} AND end_date > #{startDate})")
    Set<Long> getByTimeRange(Date startDate, Date endDate);

}
