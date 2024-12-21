package org.example.service.impl;

import org.example.entity.OperationLog;
import org.example.mapper.OperationLogMapper;
import org.example.service.OperationLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("operationLogService")
public class OperationLogServiceImpl implements OperationLogService {

    @Autowired
    private OperationLogMapper operationLogMapper;

    @Override
    public List<OperationLog> getAllLogs() {
        return operationLogMapper.selectAllLogs(); // 假设有一个方法可以获取所有日志
    }

    @Override
    public void addLog(OperationLog operationLog) {
        operationLogMapper.insert(operationLog); // 假设有一个方法可以插入日志
    }
}