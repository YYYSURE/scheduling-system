package org.example.intelligent_scheduling_server.service;

import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.PassengerFlowVo;

import java.util.Date;
import java.util.List;

/**
 * 客流量数据
 */
public interface StoreFlowService {

    public List<DateVo> getFlowByTime(Long Store_id, Date beginDate, Date endDate);
}
