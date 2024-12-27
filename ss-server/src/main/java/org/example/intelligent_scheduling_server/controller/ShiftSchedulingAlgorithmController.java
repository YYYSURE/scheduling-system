package org.example.intelligent_scheduling_server.controller;

import org.example.dto.intelligent_scheduling.Instance;
import org.example.entity.SchedulingTask;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.component.WebSocketServer;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.intelligent_scheduling_server.service.ShiftSchedulingAlgorithmService;
import org.example.intelligent_scheduling_server.service.StoreFlowService;
import org.example.result.Result;
import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.DayShiftVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping
@RestController
public class ShiftSchedulingAlgorithmController {

    @Autowired
    private ShiftSchedulingAlgorithmService algorithmService;
    @Autowired
    private SchedulingShiftService schedulingShiftService;
    @Autowired
    private StoreFlowService storeFlowService;
    @Autowired
    private WebSocketServer webSocketServer;
    private static final String title = "消息管理";

    /**
    * 生成排班
    *
    * @throws SSSException
     */
    @GetMapping("/generateWeeklySchedule")
    //重新计算，影响日历和班次
    public Result solve(@RequestParam Long storeId,
                        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date beginDate) throws SSSException {
        Date endDate = dayParse(beginDate,6);
        SchedulingTask schedulingTask = new SchedulingTask();
        schedulingTask.setStoreId(storeId);
        schedulingTask.setStartDate(beginDate.toString());
        schedulingTask.setEndDate(endDate.toString());
        schedulingTask.setIsPublish(0);
        List<DateVo> dateVoList = storeFlowService.getFlowByTime(storeId,beginDate,endDate);
        Instance instance = algorithmService.buildInstance(dateVoList,storeId,beginDate,endDate,schedulingTask);
        Long taskId =  algorithmService.caculate(dateVoList,instance, storeId, true,schedulingTask);
        List<List<DayShiftVo>> list = new ArrayList<>();
        for(int i = 0;i < 7;i++){
            Date end = dayParse(beginDate,i);
            List<DayShiftVo> dayShiftVoList = schedulingShiftService.getDayShiftList(storeId,end);
            list.add(dayShiftVoList);
        }

        return Result.ok().addData("data",list).addData("id",taskId);
    }

    private Date dayParse(Date begin,int d){
        try {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(begin);
            // 在 beginDate 上加 6 天
            calendar.add(Calendar.DATE, d);
            // 获取加上 6 天后的日期
            Date end = calendar.getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            // 将 Date 对象格式化为字符串
            String formattedEndDate = sdf.format(end);
            // 将格式化后的字符串解析回 Date 对象
            end = sdf.parse(formattedEndDate);
            return end;
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

}