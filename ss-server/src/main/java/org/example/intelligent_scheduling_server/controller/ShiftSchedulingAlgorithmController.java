package org.example.intelligent_scheduling_server.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import net.sf.jsqlparser.expression.DateTimeLiteralExpression;
import org.example.dto.intelligent_scheduling.Instance;
import org.example.dto.intelligent_scheduling_server.AlgoGroupDto;
import org.example.entity.SchedulingTask;
import org.example.enums.AlgoEnum;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.component.WebSocketServer;
import org.example.intelligent_scheduling_server.constant.AlgoEnumConstant;
import org.example.intelligent_scheduling_server.enums.WebSocketEnum;
import org.example.intelligent_scheduling_server.service.SchedulingTaskService;
import org.example.intelligent_scheduling_server.service.ShiftSchedulingAlgorithmService;
import org.example.intelligent_scheduling_server.service.StoreFlowService;
import org.example.result.Result;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.SchedulingCalculateVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ThreadPoolExecutor;

@RequestMapping("/scheduling/calculate")
@RestController
public class ShiftSchedulingAlgorithmController {

    @Autowired
    private ShiftSchedulingAlgorithmService algorithmService;
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
    @PostMapping("/solve")
    //重新计算，影响日历和班次
    public Result solve(@RequestParam Long storeId,
                        @RequestParam @DateTimeFormat(pattern = "yyyy/MM/dd") Date beginDate,
                        @RequestParam @DateTimeFormat(pattern = "yyyy/MM/dd") Date endDate) throws SSSException {

        SchedulingTask schedulingTask = new SchedulingTask();
        schedulingTask.setStoreId(storeId);
        schedulingTask.setStartDate(beginDate.toString());
        schedulingTask.setEndDate(endDate.toString());
        schedulingTask.setIsPublish(0);
        List<DateVo> dateVoList = storeFlowService.getFlowByTime(storeId,beginDate,endDate);
        Instance instance = algorithmService.buildInstance(dateVoList,storeId,beginDate,endDate,schedulingTask);
        algorithmService.caculate(dateVoList,instance, storeId, true,schedulingTask);
        return Result.ok();
    }


}