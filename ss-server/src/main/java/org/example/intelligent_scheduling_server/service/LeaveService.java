package org.example.intelligent_scheduling_server.service;


import java.util.Date;
import java.util.List;

public interface LeaveService {
    /**
     * 与给定时间范围有重叠的请假人员的数据
     * @param start
     * @param end
     * @return
     */
    public List<Long> getByTimeRange(Date start, Date end);
}
