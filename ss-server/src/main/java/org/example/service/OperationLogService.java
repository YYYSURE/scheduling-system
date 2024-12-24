package org.example.service;

import org.example.entity.OperationLog;
import java.util.List;

/**
 * 操作日志服务接口
 *
 * @author dam
 * @date 2024-12-19
 */
public interface OperationLogService {

    List<OperationLog> getAllLogs();

    void addLog(OperationLog operationLog);
}