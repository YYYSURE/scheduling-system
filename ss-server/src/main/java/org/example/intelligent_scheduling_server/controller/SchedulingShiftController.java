package org.example.intelligent_scheduling_server.controller;

import org.example.entity.SchedulingShift;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.result.Result;
import org.example.utils.DateUtil;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.vo.shiftScheduling.GanttShiftVo;
import org.example.vo.shiftScheduling.GanttStatisticsVo;
import org.example.vo.shiftScheduling.WeekViewVo;
import org.example.vo.shiftScheduling.applet.WeeklyTaskVo;
import org.example.vo.shiftScheduling.applet.WeeklyViewDayVo;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/scheduling/schedulingshift")
public class SchedulingShiftController {
    //根据门店id获得排班信息,显每个时间段有多少人和是否包含就餐或休息时间

    @Autowired
    private SchedulingShiftService schedulingShiftService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public Result list(@RequestParam Map<String, Object> params) {
        PageUtils page = schedulingShiftService.queryPage(params);

        return Result.ok().addData("page", page);
    }

    /**
     * 根据日期id获取当天的班次信息
     * 如果选择了职位，只查询职位所绑定的工作人员的班次
     *
     * @return
     */
    @PostMapping("listSchedulingShiftVoByDateId")
    public Result listSchedulingShiftVoByDateId(@RequestBody Map<String, Object> map) {
        long start = System.currentTimeMillis();
        Long dateId = Long.parseLong(map.get("dateId").toString());
        List<Long> positionIdList = (List<Long>) map.get("positionIdArr");
        List<Long> userIdList = (List<Long>) map.get("userIdList");
        Boolean isSearchUnAssignedShifts = null;
        if (map.containsKey("isSearchUnAssignedShifts")) {
//            isSearchUnAssignedShifts = Boolean.parseBoolean(map.get("isSearchUnAssignedShifts").toString());
            isSearchUnAssignedShifts = "true".equals(map.get("isSearchUnAssignedShifts").toString());
        }
        List<GanttShiftVo> schedulingShiftVoList = schedulingShiftService.listSchedulingShiftVoByDateId(dateId, positionIdList, userIdList, isSearchUnAssignedShifts);
        GanttStatisticsVo ganttStatisticsVo = schedulingShiftService.getGanttStatisticsVo(schedulingShiftVoList);
        System.out.println("listSchedulingShiftVoByDateId时间：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok()
                .addData("schedulingShiftVoList", schedulingShiftVoList)
                .addData("ganttStatisticsVo", ganttStatisticsVo);
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id) {
        SchedulingShift schedulingShift = schedulingShiftService.getById(id);

        return Result.ok().addData("schedulingShift", schedulingShift);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public Result save(@RequestBody SchedulingShift schedulingShift) {
        schedulingShiftService.save(schedulingShift);

        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public Result update(@RequestBody SchedulingShift schedulingShift) {
        schedulingShiftService.updateById(schedulingShift);

        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public Result delete(@RequestBody Long[] ids) {
        schedulingShiftService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

    /**
     * 获取周视图数据
     *
     * @param params startDate：一周的开始日期 endDate：一周的结束日期
     * @return
     */
    @PostMapping("/getWeekViewData")
    public Result getWeekViewData(@RequestBody Map<String, String> params, HttpServletRequest httpServletRequest) {
        long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date startDate = sdf.parse(params.get("startDate"));
            Date endDate = sdf.parse(params.get("endDate"));
            Integer realStartIndex = null;
            Integer realEndIndex = null;
            Long taskId = null;
            if (params.containsKey("realStartIndex")) {
                realStartIndex = Integer.parseInt(params.get("realStartIndex"));
            }
            if (params.containsKey("realEndIndex")) {
                realEndIndex = Integer.parseInt(params.get("realEndIndex"));
            }
            if (params.containsKey("taskId")) {
                taskId = Long.parseLong(params.get("taskId"));
            }

            Map<Long, List<SchedulingShift>> userIdAndShiftList = new HashMap<>();
            WeekViewVo weekViewVo = schedulingShiftService.listWeekViewShiftVoBetweenStartDateAndEndDate(
                    startDate,
                    endDate,
                    realStartIndex,
                    realEndIndex,
                    storeId,
                    taskId,
                    userIdAndShiftList);
            return Result.ok()
                    .addData("isExist", weekViewVo.isExist())
                    .addData("shiftListOfEachDay", weekViewVo.getShiftListOfEachDay())
                    .addData("indexAndDateMap", weekViewVo.getIndexAndDateMap() != null && weekViewVo.getIndexAndDateMap().size() > 0 ? weekViewVo.getIndexAndDateMap() : null)
                    .addData("userIdAndShiftList", userIdAndShiftList);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 获取用户指定日期的班次
     *
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getTodayShiftListOfUser")
    public Result getTodayShiftListOfUser(HttpServletRequest httpServletRequest) throws ParseException {
        String token = httpServletRequest.getHeader("token");
        Long userId = Long.parseLong(JwtUtil.getUserId(token));
        Date date = new Date();
        DateUtil.DateEntity dateEntity = DateUtil.parseDate(date);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date parse = sdf.parse(dateEntity.getYear() + "-" + dateEntity.getMonth() + "-" + dateEntity.getDay());
        //查询某天某人的所有班次
        List<SchedulingShift> shiftList = schedulingShiftService.getOneDayShiftListOfUser(parse, userId);
        return Result.ok().addData("shiftList", shiftList);
    }

    /**
     * 获取用户从起始日期到截止日期中，每天的班次信息
     *
     * @param startDateStr       格式 yyyy-MM-dd
     * @param endDateStr
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getWeekShiftListOfUser")
    public Result getWeekShiftListOfUser(@RequestParam("startDateStr") String startDateStr, @RequestParam("endDateStr") String endDateStr, HttpServletRequest httpServletRequest) throws SSSException {
        ////日期解析
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = sdf.parse(startDateStr);
            endDate = sdf.parse(endDateStr);
        } catch (ParseException e) {
            throw new SSSException(ResultCodeEnum.FAIL.getCode(), e.getMessage());
        }

        ////查询每一天的班次数据
        String token = httpServletRequest.getHeader("token");
        Long userId = Long.parseLong(JwtUtil.getUserId(token));
        //获取起止日期内，每天的班次集合
        List<List<SchedulingShift>> shiftListList = schedulingShiftService.getWeekShiftListOfUser(startDate, endDate, userId);

        ////类课程表数据封装
        SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
        List<WeeklyViewDayVo> classTime = new ArrayList<>();
        //该周的最早上班时间（需要的是整时，即8:35也变成8:30）
        String earliestStartTime = "";
        Integer earliestStartTimeMinute = Integer.MAX_VALUE;
        String latestEndTime = "";
        Integer latestEndTimeMinute = 0;
        for (int i = 0; i < shiftListList.size(); i++) {
            WeeklyViewDayVo weeklyViewDayVo = new WeeklyViewDayVo();
            weeklyViewDayVo.setDayOfWeek(i + 1);
            List<SchedulingShift> shiftList = shiftListList.get(i);
            List<WeeklyTaskVo> taskVoList = new ArrayList<>();
            Long lastTaskEndMinute = -1L;
            if (shiftList.size() > 0) {
                //找出最早开始时间
                SchedulingShift earlyShift = shiftList.get(0);
                String[] formatTimeArr = sdf1.format(earlyShift.getStartDate()).split(":");
                int hour = Integer.parseInt(formatTimeArr[0]);
                int minute = Integer.parseInt(formatTimeArr[1]);
                int curMinute = hour * 60;
                if (curMinute < earliestStartTimeMinute) {
                    earliestStartTimeMinute = curMinute;
                    earliestStartTime = sdf1.format(earlyShift.getStartDate()).split(":")[0] + ":00";
                }
                //找出最晚开始时间
                SchedulingShift latestShift = shiftList.get(shiftList.size() - 1);
                String[] formatTimeArr1 = sdf1.format(latestShift.getEndDate()).split(":");
                int hour1 = Integer.parseInt(formatTimeArr1[0]);
                int minute1 = Integer.parseInt(formatTimeArr1[1]);
                int hourPlus1 = hour1 + 1;
                int curMinute2 = minute1 > 0 ? hourPlus1 * 60 : hour1 * 60;
                if (curMinute2 > latestEndTimeMinute) {
                    latestEndTimeMinute = curMinute2;
                    if (minute1 > 0) {
                        latestEndTime = (hourPlus1 + "") + ":00";
                    } else {
                        latestEndTime = (hour1 + "") + ":00";
                    }

                }

                for (int j = 0; j < shiftList.size(); j++) {
                    SchedulingShift shift = shiftList.get(j);
                    Date shiftStartDate = shift.getStartDate();
                    long startMinute = shiftStartDate.getTime() / (1000 * 60);
                    Date shiftEndDate = shift.getEndDate();
                    long endMinute = shiftEndDate.getTime() / (1000 * 60);
                    WeeklyTaskVo weeklyTaskVo = new WeeklyTaskVo();
                    weeklyTaskVo.setTimeStart(sdf1.format(shiftStartDate));
                    weeklyTaskVo.setTimeEnd(sdf1.format(shiftEndDate));
                    weeklyTaskVo.setTimeStartToLast(lastTaskEndMinute == -1 ? 0 : startMinute - lastTaskEndMinute);
                    weeklyTaskVo.setTimeDifference(endMinute - startMinute);
                    lastTaskEndMinute = endMinute;
                    taskVoList.add(weeklyTaskVo);
                }
            }
            weeklyViewDayVo.setTask(taskVoList);
            classTime.add(weeklyViewDayVo);
        }
        ///修改每天的第一个班次的timeStartToLast
        for (WeeklyViewDayVo weeklyViewDayVo : classTime) {
            if (weeklyViewDayVo.getTask().size() == 0) {
                continue;
            }
            WeeklyTaskVo firstWeeklyTaskVo = weeklyViewDayVo.getTask().get(0);
            String timeStart = firstWeeklyTaskVo.getTimeStart();
            String[] formatTimeArr = timeStart.split(":");
            int hour = Integer.parseInt(formatTimeArr[0]);
            int minute = Integer.parseInt(formatTimeArr[1]);
            long curMinute = hour * 60 + minute;
            firstWeeklyTaskVo.setTimeStartToLast(curMinute - earliestStartTimeMinute);
        }

        return Result.ok().addData("classTime", classTime)
                .addData("earliestStartTime", earliestStartTime)
                .addData("latestEndTime", latestEndTime)
                .addData("earliestAndLatestOffset", latestEndTimeMinute - earliestStartTimeMinute);
    }


}
