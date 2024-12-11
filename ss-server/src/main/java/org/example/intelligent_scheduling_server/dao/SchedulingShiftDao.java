package org.example.intelligent_scheduling_server.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.entity.SchedulingShift;

import java.util.Date;
import java.util.List;

/**
 * 排班班次表
 * 
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-04 14:30:17
 */
@Mapper
public interface SchedulingShiftDao extends BaseMapper<SchedulingShift> {

    List<SchedulingShift> listShiftBetweenStartDateAndEndDate(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("storeId") long storeId);

    List<Long> listShiftIdBetweenStartDateAndEndDate(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("storeId") long storeId, Long taskId);

    List<Long> listPublishedShiftIdBetweenStartDateAndEndDate(@Param("format") String format, @Param("format1") String format1, @Param("storeId") Long storeId);


    List<SchedulingShift> listShiftIdOfShift(@Param("shiftStartDate") Date shiftStartDate, @Param("shiftEndDate") Date shiftEndDate, @Param("storeId") Long storeId);

    List<Long> listDateIdWithUnAssignedShifts(@Param("curMonthDateIdList") List<Long> curMonthDateIdList);

    List<SchedulingShift> selectUnAssignedShiftsByDateId(@Param("dateId") Long dateId);

    List<SchedulingShift> getOneDayShiftListOfUser(@Param("date") Date date, @Param("userId") Long userId);

}
