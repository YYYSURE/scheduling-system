package org.example.intelligent_scheduling_server.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    private ThreadPoolExecutor executor;
    @Autowired
    private WebSocketServer webSocketServer;
    private static final String title = "消息管理";

/**
 * 执行计算
 *
 * @param taskIdList         要计算的任务id集合
 * @param httpServletRequest http请求对象
 * @return
 * @throws SSSException
 */
@PostMapping("/solve")
//重新计算，影响日历和班次
//@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, allEntries = true)
//@OperationLog(title = ShiftSchedulingAlgorithmController.title, businessType = BusinessTypeEnum.OTHER, detail = "对任务进行排班计算")
public Result solve(@RequestBody Long[] taskIdList, HttpServletRequest httpServletRequest) throws SSSException {
    String token = httpServletRequest.getHeader("token");
    Long storeId = Long.parseLong(JwtUtil.getStoreId(token));
    List<SchedulingCalculateVo> schedulingCalculateVoList = new ArrayList<>();

    //// 修改任务状态为计算状态
    for (Long taskId : taskIdList) {
        SchedulingTask schedulingTaskEntity = schedulingTaskService.getById(taskId);
        // 修改任务状态
        schedulingTaskEntity.setStatus(1);
        schedulingTaskService.updateById(schedulingTaskEntity);
        // 获取schedulingCalculateVo
        SchedulingCalculateVo schedulingCalculateVo = new SchedulingCalculateVo();
        BeanUtils.copyProperties(schedulingTaskEntity, schedulingCalculateVo);
        schedulingCalculateVo.setDuration(schedulingTaskEntity.getDuration());
        schedulingCalculateVo.setIntervalC(schedulingTaskEntity.getIntervalc());
        schedulingCalculateVo.setDateVoList(JSON.parseObject(schedulingTaskEntity.getDatevolist(), new TypeReference<List<DateVo>>() {
        }));
        schedulingCalculateVo.setTaskId(taskId);
        schedulingCalculateVo.setSchedulingRuleId(schedulingTaskEntity.getSchedulingRuleId());
        schedulingCalculateVoList.add(schedulingCalculateVo);
    }

    // 1.获取之前的请求头数据
    RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
    for (SchedulingCalculateVo schedulingCalculateVo : schedulingCalculateVoList) {
        Instance instance = algorithmService.buildInstance(schedulingCalculateVo, storeId);
        CompletableFuture.runAsync(() -> {
            // 2.每一个线程都共享之前的请求数据
            RequestContextHolder.setRequestAttributes(requestAttributes);
            long start = System.currentTimeMillis();
            // 判断计算vo是否有效
            try {
                algorithmService.judgeWhetherSchedulingCalculateVoEffective(schedulingCalculateVo);
                try {
                    algorithmService.caculate(schedulingCalculateVo, instance, storeId, token, true);
                } catch (SSSException e) {
                    e.printStackTrace();
                    throw new RuntimeException(e);
                }
            } catch (SSSException e) {
                HashMap<String, Object> message = new HashMap<>();
                message.put("taskId", schedulingCalculateVo.getTaskId());
                message.put("type", WebSocketEnum.CalculateEnd.getType());
                message.put("isSuccess", 0);
                message.put("cause", e.getMessage());
                SchedulingTask schedulingTaskEntity = schedulingTaskService.getById(schedulingCalculateVo.getTaskId());
                // 修改任务状态
                schedulingTaskEntity.setStatus(3);
                schedulingTaskService.updateById(schedulingTaskEntity);
                message.put("calculateTime", System.currentTimeMillis() - start);
                webSocketServer.sendMessage(JSON.toJSONString(message), WebSocketServer.tokenAndSessionMap.get(token));
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        }, executor).whenComplete((res, e) -> {
        }).exceptionally(throwable -> {
            throwable.printStackTrace();
            try {
                throw new SSSException(ResultCodeEnum.FAIL.getCode(), throwable.getMessage());
            } catch (SSSException e) {
                throw new RuntimeException(e);
            }
        });
    }
    return Result.ok();
}

    /**
     * 多算法计算
     *
     * @param httpServletRequest
     * @return
     */
    @PostMapping("/multiAlgorithmSolve")
//    @Cacheable(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, key = "#root.targetClass+'-'+#root.method.name+'-'+#root.args[0]", sync = true)
    //@OperationLog(title = ShiftSchedulingAlgorithmController.title, businessType = BusinessTypeEnum.OTHER, detail = "对任务进行多算法排班计算")
    public Result multiAlgorithmSolve(@RequestBody Map<String, Object> params, HttpServletRequest httpServletRequest) throws SSSException {
        String token = httpServletRequest.getHeader("token");
        Long storeId = Long.parseLong(JwtUtil.getStoreId(token));
        Long taskId = Long.parseLong(params.get("taskId").toString());
        List<String> checkedAlgoGroups = (List<String>) params.get("checkedAlgoGroups");

        ////查询数据库，找出还没有计算或者计算失败的算法组合
        List<AlgoGroupDto> unCalculateAlgoGroupDtoList = new ArrayList<>();
        for (String checkedAlgoGroup : checkedAlgoGroups) {
            String[] split = checkedAlgoGroup.split(AlgoEnumConstant.splitStr);
            String phaseOneName = split[0];
            String phaseTwoName = split[1];
            AlgoEnum.PhaseOne phaseOne = AlgoEnumConstant.nameAndPhaseOneMap.get(phaseOneName);
            AlgoEnum.PhaseTwo phaseTwo = AlgoEnumConstant.nameAndPhaseTwoMap.get(phaseTwoName);
            if (phaseOne == null || phaseTwo == null) {
                continue;
            }

            String[] stepTwoAlgArr = new String[]{phaseTwo.getCategoryName(), phaseTwo.getName()};
            long count = schedulingTaskService.countVirtualTask(phaseOne.getName(), JSON.toJSONString(stepTwoAlgArr), taskId);
            if (count == 0) {
                unCalculateAlgoGroupDtoList.add(new AlgoGroupDto(phaseOne, phaseTwo));
            }
        }

        ////将还没有计算的组合添加计算
        // 1.获取之前的请求头数据
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();

        if (unCalculateAlgoGroupDtoList.size() > 0) {
            ///准备好计算数据
            List<Instance> instanceList = new ArrayList<>();
            List<SchedulingCalculateVo> schedulingCalculateVoList = new ArrayList<>();
            algorithmService.multiAlgorithmInstancePrepare(unCalculateAlgoGroupDtoList, instanceList, schedulingCalculateVoList, taskId, storeId, token);
            CompletableFuture.runAsync(() -> {
                //2.每一个线程都共享之前的请求数据
                RequestContextHolder.setRequestAttributes(requestAttributes);
                try {
                    algorithmService.multiAlgorithmSolve(instanceList, schedulingCalculateVoList, taskId, storeId, token);
                } catch (SSSException e) {
                    throw new RuntimeException(e);
                }
            }, executor);
            return Result.ok().addData("message", "部分算法组合需要进行计算，请耐心等候");
        } else {
            return Result.ok().addData("message", "所有算法组合已经全部计算完成，请直接查看结果");
        }

    }

    /**
     * 查询多算法计算的结果
     *
     * @param httpServletRequest
     * @return
     */
    @PostMapping("/listMultiAlgorithmResult")
    public Result listMultiAlgorithmResult(@RequestBody Map<String, Object> params, HttpServletRequest httpServletRequest) {
        Long taskId = Long.parseLong(params.get("taskId").toString());

        ////查询数据库中是否存在虚拟任务，存在则返回结果，不存在通知用户
        PageUtils page = schedulingTaskService.listVirtualTask(params, taskId);
        return Result.ok().addData("page", page);
    }

    /**
     * 用虚拟任务的结果覆盖任务结果
     *
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/overlayResult")
    //用虚拟任务的结果覆盖真实任务的结果，影响日历和班次
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, allEntries = true)
    //@OperationLog(title = ShiftSchedulingAlgorithmController.title, businessType = BusinessTypeEnum.OTHER, detail = "用虚拟任务的结果覆盖真实任务的结果")
    public Result overlayResult(@RequestParam("virtualTaskId") Long virtualTaskId, HttpServletRequest httpServletRequest) {
        algorithmService.overlayResult(virtualTaskId);
        return Result.ok();
    }

    /**
     * 获取所有算法组合
     *
     * @return
     */
    @GetMapping("/getAllAlgorithmGroup")
    public Result getAllAlgorithmGroup(@RequestParam("taskId") Long taskId) {
        List<String> haveCalculateAlgoGroups = schedulingTaskService.listHaveCalculateAlgoGroup(taskId);
        return Result.ok().addData("algorithmGroupStrList", AlgoEnumConstant.algorithmGroupStrList)
                .addData("haveCalculateAlgoGroups", haveCalculateAlgoGroups);
    }


    @GetMapping("/deleteRelevantDataOfTask")
    //删除任务的结果，影响日历和班次
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, allEntries = true)
    //@OperationLog(title = ShiftSchedulingAlgorithmController.title, businessType = BusinessTypeEnum.DELETE, detail = "删除任务的计算结果")
    public Result deleteRelevantDataOfTask(@RequestParam("taskId") Long taskId) {
        algorithmService.deleteRelevantDataOfTask(taskId);
        return Result.ok();
    }


}