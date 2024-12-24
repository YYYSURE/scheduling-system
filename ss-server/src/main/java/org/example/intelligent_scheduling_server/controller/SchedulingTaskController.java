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
 */
@RestController
@RequestMapping("/scheduling/schedulingTask")
public class SchedulingTaskController {
    @Autowired
    private SchedulingTaskService schedulingTaskService;
    private static final String title = "任务管理";

    /**
     * 修改任务的发布状态
     */
    @PostMapping("/updateTaskPublishStatus")
    public Result updateTaskPublishStatus(@RequestBody Map<String, Object> paramMap) {
        //TODO 消息通知功能
        Long taskId = Long.parseLong(paramMap.get("taskId").toString());
        Integer isPublish = Integer.parseInt(paramMap.get("isPublish").toString());
        schedulingTaskService.updateTaskPublishStatus(taskId, isPublish);
        return Result.ok();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    public Result deleteBatch(@RequestParam Long id) {
        //删除任务的所有计算结果
        schedulingTaskService.deleteAllResultOfTask(id);
        return Result.ok();
    }
}
