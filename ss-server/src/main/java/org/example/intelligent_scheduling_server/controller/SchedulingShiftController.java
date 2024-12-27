package org.example.intelligent_scheduling_server.controller;

import org.example.entity.SchedulingShift;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.result.Result;
import org.example.utils.DateUtil;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.vo.scheduling_calculate_service.AvailableVo;
import org.example.vo.scheduling_calculate_service.DatNameVo;
import org.example.vo.scheduling_calculate_service.DayShiftEmployeeVo;
import org.example.vo.scheduling_calculate_service.DayShiftVo;
import org.example.vo.shiftScheduling.GanttShiftVo;
import org.example.vo.shiftScheduling.GanttStatisticsVo;
import org.example.vo.shiftScheduling.WeekViewVo;
import org.example.vo.shiftScheduling.applet.WeeklyTaskVo;
import org.example.vo.shiftScheduling.applet.WeeklyViewDayVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 排班班次表
 *
 */
@RestController
@RequestMapping
public class SchedulingShiftController {
    //根据门店id获得排班信息,显每个时间段有多少人和是否包含就餐或休息时间

    @Autowired
    private SchedulingShiftService schedulingShiftService;


    /**
     * 首页日排班
     */
    @GetMapping("/schedule")
    public Result getDayData(@RequestParam Long storeId,
                             @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
        List<List<DatNameVo>> data = schedulingShiftService.getDayData(storeId, date);
        System.out.println(data);
        return Result.ok().addData("data",data);
    }

    /**
     * 获取日排班
     * @param date
     * @return
     */
    @GetMapping("/schedule/day")
    public Result getByDate(@RequestParam Long storeId,
                            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
        List<DayShiftVo> data = schedulingShiftService.getDayShiftList(storeId, date);
        System.out.println(data);
        return Result.ok().addData("data", data);
    }

    /**
     * 获取这个班次时间内空闲的员工
     * @param shiftId
     * @return
     */
    @GetMapping("/schedule/available")
    public Result getAvailable(@RequestParam Long shiftId) {
        List<AvailableVo> list = schedulingShiftService.getAvailable(shiftId);
        return Result.ok().addData("data",list);
    }

    @PostMapping("/schedule/update")
    public Result updateEmployee(@RequestParam long shiftId,@RequestParam long employeeId){
        schedulingShiftService.updateEmployee(shiftId,employeeId);
        return Result.ok();
    }

    /**
     * 员工查看自己的日排班
     */
    @GetMapping("/employee/Schedule")
    public Result getSchedule(@RequestParam Long id,
                              @RequestParam Long storeId,
                              @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
        List<List<DayShiftEmployeeVo>> list =  schedulingShiftService.getSchedule(id,storeId,date);
        System.out.println(list.toString());
        return Result.ok().addData("data",list);
    }
}