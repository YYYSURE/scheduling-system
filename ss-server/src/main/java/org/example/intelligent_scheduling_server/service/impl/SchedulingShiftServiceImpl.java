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
import org.example.vo.scheduling_calculate_service.DayShiftVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        System.out.println(shiftId);
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

}