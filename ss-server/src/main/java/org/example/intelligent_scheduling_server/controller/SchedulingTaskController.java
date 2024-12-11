package org.example.intelligent_scheduling_server.controller;

import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.example.constant.RedisConstant;
import org.example.entity.SchedulingTask;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.service.SchedulingTaskService;
import org.example.result.Result;
import org.example.utils.DateUtil;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.vo.scheduling_calculate_service.PassengerFlowVo;
import org.example.vo.shiftScheduling.TaskCreateTimeTreeItemVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 排班任务表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2024-05-24 13:58:33
 */
@RestController
@RequestMapping("/scheduling/schedulingTask")
public class SchedulingTaskController {
    @Autowired
    private SchedulingTaskService schedulingTaskService;
    private static final String title = "任务管理";

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@PreAuthorize("hasAuthority('bnt.task.list')")
    public Result list(@RequestParam Map<String, Object> params, HttpServletRequest httpServletRequest) {
        long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        QueryWrapper<SchedulingTask> wrapper = new QueryWrapper<>();
        wrapper.eq("store_id", storeId);
        wrapper.eq("type", 0);
        String taskName = (String) params.get("taskName");
        if (!StringUtils.isEmpty(taskName)) {
            wrapper.like("name", "%" + taskName + "%");
        }
        if (params.containsKey("year") && params.containsKey("month")) {
            Integer year = Integer.parseInt(params.get("year").toString());
            Integer month = Integer.parseInt(params.get("month").toString());
            Date[] startAndEndDateOfMonth = DateUtil.getStartAndEndDateOfMonth(year, month);
            wrapper.ge("create_time", startAndEndDateOfMonth[0]).le("create_time", startAndEndDateOfMonth[1]);
        }
        //按照开始时间升序排序
        wrapper.orderByAsc("start_date");
        PageUtils page = schedulingTaskService.queryPage(params, wrapper);

        return Result.ok().addData("page", page);
    }

    /**
     * 获取系统的用户数量
     *
     * @return int count
     */
    @RequestMapping("/getAllTaskNum")
    public Result getAllTaskNum() {
        long count = schedulingTaskService.count(new QueryWrapper<SchedulingTask>().eq("is_deleted", 0).eq("type", 0));
        return Result.ok().addData("count", count);
    }

    /**
     * 列表
     */
    @RequestMapping("/listAllDate")
    public Result listAllDate(HttpServletRequest httpServletRequest) {
        long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        List<TaskCreateTimeTreeItemVo> createTimeTreeItemVoList = schedulingTaskService.listAllDate(storeId);
        return Result.ok().addData("createTimeTreeItemVoList", createTimeTreeItemVoList);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@PreAuthorize("hasAuthority('bnt.task.list')")
    public Result info(@PathVariable("id") Long id) {
        SchedulingTask schedulingTask = schedulingTaskService.getById(id);
        return Result.ok().addData("schedulingTask", schedulingTask);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@PreAuthorize("hasAuthority('bnt.task.add')")
    //@OperationLog(title = SchedulingTaskController.title, businessType = BusinessTypeEnum.INSERT, detail = "新增排班任务")
    public Result save(@RequestBody SchedulingTask schedulingTask, HttpServletRequest httpServletRequest) throws SSSException {
        long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        schedulingTask.setStoreId(storeId);

        //默认复制门店的排班规则
        //TODO
/*        Result r = enterpriseFeignService.copySchedulingRule(storeId);
        if (r.getCode() == ResultCodeEnum.SUCCESS.getCode().intValue()) {
            Long ruleId = r.getData("ruleId", new TypeReference<Long>() {
            });
            if (ruleId == null) {
                throw new SSSException(ResultCodeEnum.FAIL.getCode(), "门店规则还没有设置，请先设置规则再添加任务");
            }
            schedulingTask.setSchedulingRuleId(ruleId);
        }*/

        schedulingTaskService.save(schedulingTask);

        return Result.ok();
    }

    /**
     * 获取门店的最大排班日期
     *
     * @param httpServletRequest
     * @return
     */
    @RequestMapping("/getMaxEndDateOfTask")
    public Result getMaxEndDateOfTask(HttpServletRequest httpServletRequest) {
        long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        Date maxEndDate = schedulingTaskService.getMaxEndDate(storeId);
        return Result.ok().addData("maxEndDate", maxEndDate);
    }

    /**
     * 查询出taskId之外的其他任务
     *
     * @param taskId
     * @return
     */
    @RequestMapping("/listOtherTaskList")
    public Result listOtherTaskList(@RequestParam("taskId") Long taskId, HttpServletRequest httpServletRequest) {
        long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        QueryWrapper<SchedulingTask> queryWrapper = new QueryWrapper<>();
        if (taskId == -1) {
            queryWrapper.eq("store_id", storeId).eq("type", 0);
        } else {
            queryWrapper.eq("store_id", storeId).ne("id", taskId).eq("type", 0);
        }

        List<SchedulingTask> taskList = schedulingTaskService.list(queryWrapper);
        return Result.ok().addData("taskList", taskList);
    }


    /**
     * 修改
     *
     * @param schedulingTask
     * @param updateType     1:修改任务信息 2:修改工作日数据
     * @return
     */
    @RequestMapping("/update/{updateType}")
    // 任务的数据更新，会影响到日历和班次
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE}, allEntries = true)
    //@OperationLog(title = SchedulingTaskController.title, businessType = BusinessTypeEnum.UPDATE, detail = "#root.args[1]==1?'修改任务信息':'修改工作日数据'")
    public Result update(@RequestBody SchedulingTask schedulingTask, @PathVariable("updateType") Integer updateType) {
        if (updateType == 1) {
            SchedulingTask task = schedulingTaskService.getById(schedulingTask.getId());
            //判断一下起始日期和结束日期是否和数据库中的一致，如果不一致，需要重置工作日选择（不一样返回true）
            boolean flag1 = (schedulingTask.getStartDate() != null && !schedulingTask.getStartDate().equals(task.getStartDate())) ||
                    (schedulingTask.getEndDate() != null && !schedulingTask.getEndDate().equals(task.getEndDate()));
            if (flag1) {
//                System.out.println("起始日期改变，工作日数据清空，任务id："+schedulingTask.getId());
                schedulingTask.setDatevolist("");
            }
            //判断一下 时间段长、排班时间 是否和数据库的数据一样（不一样返回true）
            boolean flag2 = (schedulingTask.getDuration() != null && !schedulingTask.getDuration().equals(task.getDuration())) ||
                    (schedulingTask.getIntervalc() != null && !schedulingTask.getIntervalc().equals(task.getIntervalc()));
            if (flag1 || flag2) {
                //删除任务的所有计算结果
                schedulingTaskService.deleteAllResultOfTask(schedulingTask.getId());
            }
        } else if (updateType == 2) {
            SchedulingTask task = schedulingTaskService.getById(schedulingTask.getId());
            //判断一下起始日期和结束日期是否和数据库中的一致，如果不一致，需要重置工作日选择（不一样返回true）
            boolean flag1 = (schedulingTask.getDatevolist() != null && !schedulingTask.getDatevolist().equals(task.getDatevolist()));
            if (flag1) {
                //删除任务的所有计算结果
                schedulingTaskService.deleteAllResultOfTask(schedulingTask.getId());
            }
        }

        schedulingTaskService.updateById(schedulingTask);

        return Result.ok();
    }


    /**
     * 修改任务的发布状态
     *
     * @param paramMap
     * @return
     */
    @PostMapping("/updateTaskPublishStatus")
    //只会影响日历，后面公开的话，班次还是一样的
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE}, allEntries = true)
    //@OperationLog(title = SchedulingTaskController.title, businessType = BusinessTypeEnum.STATUS, detail = "修改任务的发布状态")
    public Result updateTaskPublishStatus(@RequestBody Map<String, Object> paramMap) {
        Long taskId = Long.parseLong(paramMap.get("taskId").toString());
        Integer isPublish = Integer.parseInt(paramMap.get("isPublish").toString());
        schedulingTaskService.updateTaskPublishStatus(taskId, isPublish);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/deleteBatch")
    //删除了任务，会影响到日历和班次
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE}, allEntries = true)
    //@PreAuthorize("hasAuthority('bnt.task.delete')")
    //@OperationLog(title = SchedulingTaskController.title, businessType = BusinessTypeEnum.DELETE, detail = "批量删除任务")
    public Result deleteBatch(@RequestBody Long[] ids) {
        //删除任务的结果
        for (Long taskId : ids) {
            //删除任务的所有计算结果
            schedulingTaskService.deleteAllResultOfTask(taskId);
        }
        //批量删除任务
        schedulingTaskService.removeByIdArr(Arrays.asList(ids));
        return Result.ok();
    }

    /**
     * 删除任务对应的所有算法对应的计算结果
     *
     * @param taskId
     * @return
     */
    @RequestMapping("/deleteAllVirtualTaskById")
    //删除虚拟任务，会影响虚拟任务的班次和日历
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE}, allEntries = true)
    public Result deleteAllVirtualTaskById(@RequestParam("taskId") Long taskId) {
        schedulingTaskService.deleteAllVirtualTask(taskId);
        return Result.ok();
    }

    /**
     * 删除任务对应的所有计算结果（包括真实任务、虚拟任务）
     *
     * @param taskId
     * @return
     */
    @RequestMapping("/deleteAllResultOfTask")
    //删除真实任务及其虚拟任务，会影响虚拟任务的班次和日历
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE}, allEntries = true)
    public Result deleteAllResultOfTask(@RequestParam("taskId") Long taskId) {
        schedulingTaskService.deleteAllResultOfTask(taskId);
        return Result.ok();
    }

    /**
     * 导入excel文件并完成解析
     *
     * @param multipartFile
     * @param paramMap      前端上传文件的同时提交的数据
     * @return
     * @throws Exception
     */
    @PostMapping("/uploadExcelFile")
    //任务的数据改变，影响日历和班次
    @CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT, RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_DATE}, allEntries = true)
    //@PreAuthorize("hasAuthority('bnt.task.uploadExcelFile')")
    //@OperationLog(title = SchedulingTaskController.title, businessType = BusinessTypeEnum.IMPORT, detail = "客流量导入")
    public Result uploadExcelFile(@RequestParam(value = "file", required = true) MultipartFile multipartFile, @RequestParam(required = false) Map paramMap) throws Exception {
        if (multipartFile.isEmpty() || multipartFile.getSize() > 52428800) {
            Result.error(ResultCodeEnum.FAIL.getCode(), "上传文件不能为空,且不能大于50MB");
        }
        String originalFilename = multipartFile.getOriginalFilename();
        if (!(originalFilename.endsWith(".xlsx") || originalFilename.endsWith(".xls"))) {
            return Result.error(ResultCodeEnum.FAIL.getCode(), "只能导入xlsx、xls文件");
        }

        InputStream inputStream = multipartFile.getInputStream();
        Workbook workbook;
        if (originalFilename.endsWith(".xlsx")) {
            workbook = new XSSFWorkbook(inputStream);
        } else {
            workbook = new HSSFWorkbook(inputStream);
        }

        Long taskId = Long.parseLong((String) paramMap.get("taskId"));
        List<PassengerFlowVo> passengerFlowVoList = schedulingTaskService.readPassengerFlowFromWorkbook(workbook);
        workbook.close();
        try {
            List<String> unIncludeDateList = schedulingTaskService.savePassengerFlowVoList(taskId, passengerFlowVoList);
            return Result.ok().addData("fileName", originalFilename).addData("unIncludeDateList", unIncludeDateList);
        } catch (SSSException e) {
            return Result.error(e.getCode(), e.getMessage());
        }

    }
}
