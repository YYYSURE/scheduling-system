package org.example.intelligent_scheduling_server.service.impl;

import org.example.intelligent_scheduling_server.service.LeaveService;
import org.example.mapper.LeaveMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class LeaveServiceImpl implements LeaveService {
    @Autowired
    private LeaveMapper leaveMapper;

    @Override
    public List<Long> getByTimeRange(Date start, Date end) {
        return leaveMapper.getByTimeRange(start,end);
    }
}
