package org.example.intelligent_scheduling_server.service;


import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.SchedulingShift;
import org.example.exception.SSSException;
import org.example.utils.PageUtils;
import org.example.vo.scheduling_calculate_service.AvailableVo;
import org.example.vo.scheduling_calculate_service.DatNameVo;
import org.example.vo.scheduling_calculate_service.DayShiftEmployeeVo;
import org.example.vo.scheduling_calculate_service.DayShiftVo;
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

    public List<DayShiftVo> getDayShiftList(Long storeId,Date date);

    List<AvailableVo> getAvailable(Long shiftId);

    void updateEmployee(long shiftId, long employeeId);

    List<List<DatNameVo>> getDayData(Long storeId, Date date);

    List<List<DayShiftEmployeeVo>> getSchedule(Long id, Long storeId,Date date);
}

