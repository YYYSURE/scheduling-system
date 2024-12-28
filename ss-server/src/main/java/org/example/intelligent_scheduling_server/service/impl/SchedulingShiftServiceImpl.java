package org.example.intelligent_scheduling_server.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.*;
import org.example.intelligent_scheduling_server.dao.SchedulingShiftDao;
import org.example.intelligent_scheduling_server.mapper.EmployeeXyMapper;
import org.example.intelligent_scheduling_server.mapper.SchedulingShiftMapper;
import org.example.intelligent_scheduling_server.service.LeaveService;
import org.example.intelligent_scheduling_server.service.SchedulingDateService;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.intelligent_scheduling_server.service.ShiftUserService;
import org.example.vo.scheduling_calculate_service.AvailableVo;
import org.example.vo.scheduling_calculate_service.DatNameVo;
import org.example.vo.scheduling_calculate_service.DayShiftEmployeeVo;
import org.example.vo.scheduling_calculate_service.DayShiftVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ThreadPoolExecutor;

import static java.util.Arrays.stream;

@Service("schedulingShiftService")
public class SchedulingShiftServiceImpl extends ServiceImpl<SchedulingShiftDao, SchedulingShift> implements SchedulingShiftService {
    @Autowired
    private SchedulingDateService schedulingDateService;
    @Autowired
    private SchedulingShiftMapper schedulingShiftMapper;
    @Autowired
    private EmployeeXyMapper employeeMapper;
    @Autowired
    private LeaveService leaveService;

    @Override
    public List<DayShiftVo> getDayShiftList(Long storeId, Date date) {
        List<DayShiftVo> dayShiftVoList = new ArrayList<>();

        Long dateId = schedulingDateService.getByStoreId(storeId,date);
        List<SchedulingShift> shiftList = schedulingShiftMapper.getByDateId(dateId);
        for (SchedulingShift shift : shiftList) {
            DayShiftVo dayShiftVo = new DayShiftVo();
            dayShiftVo.setId(shift.getId());
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            String startDate = sdf.format(shift.getStartDate());
            String endDate = sdf.format(shift.getEndDate());
            dayShiftVo.setStartTime(startDate);
            dayShiftVo.setEndTime(endDate);
            dayShiftVo.setEmployeeId(shift.getUserId());
            if(shift.getUserId() == -1) {
                dayShiftVo.setEmployeeName("");
            }else {
                String name = employeeMapper.getNameById(shift.getUserId());
                dayShiftVo.setEmployeeName(name);
            }
            Integer mealType = shift.getMealType();
            String mealStartDate = null;
            String mealEndDate = null;
            if(mealType != 2){
                mealStartDate = sdf.format(shift.getMealStartDate());
                mealEndDate = sdf.format(shift.getMealEndDate());
            }
            if(mealType == 0) {
                dayShiftVo.setLunchStartTime(mealStartDate);
                dayShiftVo.setLunchEndTime(mealEndDate);
                dayShiftVo.setDinnerStartTime(null);
                dayShiftVo.setDinnerEndTime(null);
            }else if(mealType == 1) {
                dayShiftVo.setLunchStartTime(null);
                dayShiftVo.setLunchEndTime(null);
                dayShiftVo.setDinnerStartTime(mealStartDate);
                dayShiftVo.setDinnerEndTime(mealEndDate);
            }else{
                dayShiftVo.setLunchStartTime(null);
                dayShiftVo.setLunchEndTime(null);
                dayShiftVo.setDinnerStartTime(null);
                dayShiftVo.setDinnerEndTime(null);
            }
            dayShiftVoList.add(dayShiftVo);
        }
        dayShiftVoList.sort(Comparator.comparing(DayShiftVo::getStartTime));
        return dayShiftVoList;
    }

    @Override
    public List<AvailableVo> getAvailable(Long shiftId) {
        //查店铺的所有员工
        SchedulingShift shift =  schedulingShiftMapper.getById(shiftId);
        Date startDate = shift.getStartDate();
        Date endDate = shift.getEndDate();
        SchedulingDate date = schedulingDateService.getById(shift.getSchedulingDateId());
        Long storeId = date.getStoreId();
        List<Employee> list = employeeMapper.getByStoreId(storeId);
        //去掉这个班次时间范围内工作的员工
        Set<Long> employeeInBusy = schedulingShiftMapper.getByTimeRange(startDate,endDate);
        //去掉这个时间里请假的员工
        List<Long> employeeInLeave = leaveService.getByTimeRange(startDate,endDate);
        employeeInBusy.addAll(employeeInLeave);
        List<AvailableVo> availableVoList = new ArrayList<>();
        for (Employee employee : list) {
            if(!employeeInBusy.contains(employee.getId())) {
                AvailableVo availableVo = new AvailableVo();
                availableVo.setId(employee.getId());
                availableVo.setName(employee.getUsername());
                availableVoList.add(availableVo);
            }
        }
        return availableVoList;
    }

    @Override
    public void updateEmployee(long shiftId, long employeeId) {
        schedulingShiftMapper.update(shiftId,employeeId);
    }

    @Override
    public List<List<DatNameVo>> getDayData(Long storeId, Date date) {
        List<List<DatNameVo>> list = new ArrayList<>();
        for(int i = 0;i < 6;i++){
            list.add(new ArrayList<>());
        }
        Long dateId = schedulingDateService.getByStoreId(storeId, date);
        List<SchedulingShift> shiftList = schedulingShiftMapper.getByDateId(dateId);
        for (SchedulingShift shift : shiftList) {
            DatNameVo datNameVo = new DatNameVo();
            Long userId = shift.getUserId();
            String name = employeeMapper.getNameById(userId);
            if(name == null){
                continue;
            }
            datNameVo.setName(name);
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            String startDate = sdf.format(shift.getStartDate());
            String endDate = sdf.format(shift.getEndDate());
            try {
                Date start = sdf.parse(startDate);
                Date end = sdf.parse(endDate);
                // 按时间段判断是否有重叠
                if (isOverlap(start, end, "09:00", "10:59")) {
                    list.get(0).add(datNameVo); // 9:00-11:00
                }
                if (isOverlap(start, end, "11:00", "12:59")) {
                    list.get(1).add(datNameVo); // 11:00-13:00
                }
                if (isOverlap(start, end, "13:00", "14:59")) {
                    list.get(2).add(datNameVo); // 13:00-15:00
                }
                if (isOverlap(start, end, "15:00", "16:59")) {
                    list.get(3).add(datNameVo); // 15:00-17:00
                }
                if (isOverlap(start, end, "17:00", "18:59")) {
                    list.get(4).add(datNameVo); // 17:00-19:00
                }
                if (isOverlap(start, end, "19:00", "21:00")) {
                    list.get(5).add(datNameVo); // 19:00-21:00
                }
            } catch (ParseException e) {
                throw new RuntimeException("日期解析失败", e);
            }
        }
        return list;
    }

    @Override
    public List<List<DayShiftEmployeeVo>> getSchedule(Long id,Long storeId, Date date) {
        // 初始化返回结果，每个时间段对应一个空的列表
        List<List<DayShiftEmployeeVo>> list = new ArrayList<>();
        for (int i = 0; i < 6; i++) {
            list.add(new ArrayList<>());
        }

        // 获取当天的日期ID
        Long dateId = schedulingDateService.getByStoreId(storeId, date);
        // 获取当天该员工的所有班次
        List<SchedulingShift> shiftList = schedulingShiftMapper.getByDateIdAndUserId(dateId, id);

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

        for (SchedulingShift shift : shiftList) {
            Long userId = shift.getUserId();
            String name = employeeMapper.getNameById(userId);

            String startDateStr = sdf.format(shift.getStartDate());
            String endDateStr = sdf.format(shift.getEndDate());

            try {
                Date start = sdf.parse(startDateStr);
                Date end = sdf.parse(endDateStr);

                // 根据时间段拆分班次
                splitShiftIntoTimeSlots(start, end, list);
            } catch (Exception e) {
                throw new RuntimeException("日期解析失败", e);
            }
        }

        return list;
    }

    // 拆分班次到各个时间段
    private void splitShiftIntoTimeSlots(Date shiftStart, Date shiftEnd, List<List<DayShiftEmployeeVo>> list) {
        // 时间段的开始时间
        String[] timeSlots = {"09:00", "11:00", "13:00", "15:00", "17:00", "19:00"};

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

        // 处理每个时间段
        for (int i = 0; i < timeSlots.length; i++) {
            String timeSlotStart = timeSlots[i];
            String timeSlotEnd = (i < timeSlots.length - 1) ? timeSlots[i + 1] : "21:00";  // 最后一个时间段结束时间固定为 21:00

            try {
                Date timeStart = sdf.parse(timeSlotStart);
                Date timeEnd = sdf.parse(timeSlotEnd);
                // 如果班次与时间段有重叠
                if (!(shiftEnd.before(timeStart) || shiftStart.after(timeEnd))) {
                    // 计算开始时间和结束时间
                    Date actualStart = (shiftStart.after(timeStart)) ? shiftStart : timeStart;
                    Date actualEnd = (shiftEnd.before(timeEnd)) ? shiftEnd : timeEnd;
                    if(actualStart.equals(actualEnd)){
                        continue;
                    }
                    String timeStr = sdf.format(actualStart) + "-" + sdf.format(actualEnd);

                    // 创建并存储 DayShiftEmployeeVo
                    DayShiftEmployeeVo vo = new DayShiftEmployeeVo();
                    vo.setTime(timeStr);  // 设置拆分后的时间段字符串
                    list.get(i).add(vo);
                }
            } catch (Exception e) {
                throw new RuntimeException("时间解析失败", e);
            }
        }
    }

    private boolean isOverlap(Date shiftStart, Date shiftEnd, String timeStart, String timeEnd) {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        try {
            Date startTime = sdf.parse(timeStart);
            Date endTime = sdf.parse(timeEnd);

            // 判断是否有重叠
            return !(shiftEnd.before(startTime) || shiftStart.after(endTime));
        } catch (ParseException e) {
            throw new RuntimeException("时间格式解析错误", e);
        }
    }
}