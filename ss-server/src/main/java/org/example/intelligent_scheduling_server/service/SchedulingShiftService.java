package org.example.intelligent_scheduling_server.service;


import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.SchedulingShift;
import org.example.exception.SSSException;
import org.example.utils.PageUtils;
import org.example.vo.shiftScheduling.GanttShiftVo;
import org.example.vo.shiftScheduling.GanttStatisticsVo;
import org.example.vo.shiftScheduling.WeekViewVo;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 排班班次表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-04 14:30:17
 */
public interface SchedulingShiftService extends IService<SchedulingShift> {

    PageUtils queryPage(Map<String, Object> params);

    List<Long> listDateIdByPositionIdList(List<Long> positionIdList,List<Long> curMonthDateList);

    List<GanttShiftVo> listSchedulingShiftVoByDateId(Long dateId, List<Long> positionIdList, List<Long> userIdList, Boolean isSearchUnAssignedShifts);

    List<SchedulingShift> listShiftBetweenStartDateAndEndDate(Date startDate, Date endDate, long storeId);

    WeekViewVo listWeekViewShiftVoBetweenStartDateAndEndDate(Date startDate, Date endDate,
                                                             Integer realStartIndex, Integer realEndIndex ,
                                                             Long storeId, Long taskId, Map<Long, List<SchedulingShift>> userIdAndShiftList);

    List<Long> listDateIdByUserIdList(List<Long> userIdList, List<Long> curMonthDateList);

    List<SchedulingShift> listShiftIdOfShift(Date shiftStartDate, Date shiftEndDate, Long storeId);

    List<Long> listDateIdWithUnAssignedShifts(List<Long> curMonthDateIdList);

    List<SchedulingShift> selectUnAssignedShiftsByDateId(Long dateId);

    GanttStatisticsVo getGanttStatisticsVo(List<GanttShiftVo> schedulingShiftVoList);

    Long getTotalShiftNumByEnterpriseId(Long enterpriseId, Date firstDateOfYear, Date endDateOfYear) throws SSSException;

    Long getTotalShiftNumByStoreId(Long storeId, Date firstDateOfYear, Date endDateOfYear);

    List<SchedulingShift> getShiftListOfDates(List<Long> dateIdList);

    /**
     * 查询某天某人的所有班次
     * @param date
     * @param userId
     * @return
     */
    List<SchedulingShift> getOneDayShiftListOfUser(Date date, Long userId);

    /**
     * 获取起止日期内，每天的班次集合
     * @param startDate
     * @param endDate
     * @param userId
     * @return
     */
    List<List<SchedulingShift>> getWeekShiftListOfUser(Date startDate, Date endDate, Long userId);
}

