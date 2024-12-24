package org.example.intelligent_scheduling_server.service;


import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.SchedulingDate;
import org.example.utils.PageUtils;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 排班日期表
 *
 */
public interface SchedulingDateService extends IService<SchedulingDate> {

    PageUtils queryPage(Map<String, Object> params);

    List<SchedulingDate> listDateBetweenStartDateAndEndDate(Date startDate, Date endDate, Long storeId, Long taskId);

    Boolean judgeOneDateIsRest(Long storeId, Date workDate);

    List<SchedulingDate> getWorkDayList(Date startDate, Date endDate, Long storeId);

    Long getByStoreId(Long storeId, Date date);

    void insert(List<SchedulingDate> dateEntityList);
}

