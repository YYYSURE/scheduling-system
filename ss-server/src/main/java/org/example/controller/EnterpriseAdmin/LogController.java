package org.example.controller.EnterpriseAdmin;

import org.example.entity.OperationLog;
import org.example.result.Result;
import org.example.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 日志管理控制器
 *
 * @author dam
 * @date 2024-12-19
 */
@RestController
@RequestMapping("Log")
public class LogController {

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 获取操作日志列表
     */
    @GetMapping("/logs")
    public Result getLogs(HttpServletRequest httpRequest) {
        // 获取日志列表
        List<OperationLog> logs = operationLogService.getAllLogs();
        return Result.ok().addData("logs", logs);
    }

    /**
     * 添加操作日志
     */
    @PostMapping("/logs")
    public Result addLog(@RequestBody OperationLog operationLog) {
        // 添加日志
        operationLogService.addLog(operationLog);
        return Result.ok().addData("message", "日志添加成功");
    }
}