package org.example.intelligent_scheduling_server.service;

import org.example.dto.intelligent_scheduling.Instance;
import org.example.dto.intelligent_scheduling.Solution;
import org.example.dto.intelligent_scheduling_server.AlgoGroupDto;
import org.example.entity.SchedulingTask;
import org.example.enums.AlgoEnum;
import org.example.exception.SSSException;
import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.SchedulingCalculateVo;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ShiftSchedulingAlgorithmService {
    public Long caculate(List<DateVo> dateVoList,Instance instance, Long storeId, Boolean isSendMessage,SchedulingTask schedulingTask) throws SSSException;


    public Long saveSolutionToDatabase(List<DateVo> dateVoList,Long storeId, Instance instance, Solution solution,SchedulingTask schedulingTask) throws SSSException;

    /**
     * 判断vo是否有效
     *
     * @param schedulingCalculateVo
     * @return
     */
    public boolean judgeWhetherSchedulingCalculateVoEffective(SchedulingCalculateVo schedulingCalculateVo) throws SSSException;

    public Instance buildInstance(List<DateVo> dateVoList, Long storeId, Date beginDate, Date endDate, SchedulingTask schedulingTask) throws SSSException;
}
