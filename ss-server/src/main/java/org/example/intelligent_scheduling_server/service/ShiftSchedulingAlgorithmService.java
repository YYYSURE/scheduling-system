package org.example.intelligent_scheduling_server.service;

import org.example.dto.intelligent_scheduling.Instance;
import org.example.dto.intelligent_scheduling.Solution;
import org.example.dto.intelligent_scheduling_server.AlgoGroupDto;
import org.example.enums.AlgoEnum;
import org.example.exception.SSSException;
import org.example.vo.scheduling_calculate_service.SchedulingCalculateVo;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ShiftSchedulingAlgorithmService {
    public void caculate(Instance instance, Long storeId, Boolean isSendMessage) throws SSSException;

    /**
     * 删除任务相关数据，班次、工作日、user_shift
     *
     * @param taskId
     */
    public void deleteRelevantDataOfTask(Long taskId);

    /**
     * 删除任务集合的所有相关数据，班次、工作日、user_shift
     *
     * @param taskIdList
     */
    public void deleteRelevantDataOfTaskList(List<Long> taskIdList);

    void multiAlgorithmSolve(List<Instance> instanceList, List<SchedulingCalculateVo> schedulingCalculateVoList, Long taskId, Long storeId, String token) throws SSSException;


    public void saveSolutionToDatabase(Long storeId, SchedulingCalculateVo schedulingCalculateVo, Instance instance, Solution solution, long calculateTime);

    void overlayResult(Long virtualTaskId);

    /**
     * 判断vo是否有效
     *
     * @param schedulingCalculateVo
     * @return
     */
    public boolean judgeWhetherSchedulingCalculateVoEffective(SchedulingCalculateVo schedulingCalculateVo) throws SSSException;

    public Instance buildInstance(Long storeId, Date beginDate, Date endDate) throws SSSException;

    /**
     * 准备多算法计算的数据
     *
     * @param algoGroupDtoList
     * @param taskId
     * @param storeId
     * @param token
     * @return
     */
    public void multiAlgorithmInstancePrepare(List<AlgoGroupDto> algoGroupDtoList, List<Instance> instanceList, List<SchedulingCalculateVo> schedulingCalculateVoList, Long taskId, Long storeId, String token) throws SSSException;
}
