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
@RequestMapping("/schedule")
public class SchedulingShiftController {
    //根据门店id获得排班信息,显每个时间段有多少人和是否包含就餐或休息时间

    @Autowired
    private SchedulingShiftService schedulingShiftService;

    /**
     * 获取日排班
     * @param date
     * @return
     */
    @GetMapping("/day")
    public Result getByDate(@RequestParam Long storeId,
                            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
        return Result.ok().addData("data",schedulingShiftService.getDayShiftList(storeId,date));
    }

    /**
     * 获取这个班次时间内空闲的员工
     * @param shiftId
     * @return
     */
    @GetMapping("/available")
    public Result getAvailable(@RequestParam Long shiftId) {
        List<AvailableVo> list = schedulingShiftService.getAvailable(shiftId);
        return Result.ok().addData("data",list);
    }

}
