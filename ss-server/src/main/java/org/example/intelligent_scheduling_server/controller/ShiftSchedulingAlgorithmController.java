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
import org.example.result.Result;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.SchedulingCalculateVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
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
    private SchedulingTaskService schedulingTaskService;
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
    public Result solve(@RequestBody Long storeId, Date beginDate, Date endDate) throws SSSException {


        Instance instance = algorithmService.buildInstance(storeId,beginDate,endDate);
        algorithmService.caculate(instance, storeId, true);

        return Result.ok();
    }


    @GetMapping("/deleteRelevantDataOfTask")
    //删除任务的结果，影响日历和班次
    public Result deleteRelevantDataOfTask(@RequestParam("taskId") Long taskId) {
        algorithmService.deleteRelevantDataOfTask(taskId);
        return Result.ok();
    }
}