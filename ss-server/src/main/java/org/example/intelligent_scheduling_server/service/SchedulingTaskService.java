package org.example.intelligent_scheduling_server.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.poi.ss.usermodel.Workbook;
import org.example.entity.SchedulingTask;
import org.example.exception.SSSException;
import org.example.utils.PageUtils;
import org.example.vo.scheduling_calculate_service.PassengerFlowVo;
import org.example.vo.shiftScheduling.TaskCreateTimeTreeItemVo;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 排班任务表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-01 13:58:33
 */
public interface SchedulingTaskService extends IService<SchedulingTask> {

    PageUtils queryPage(Map<String, Object> params, QueryWrapper<SchedulingTask> wrapper);

    List<TaskCreateTimeTreeItemVo> listAllDate(long storeId);

    List<PassengerFlowVo> readPassengerFlowFromWorkbook(Workbook workbook);

    List<String> savePassengerFlowVoList(Long taskId, List<PassengerFlowVo> passengerFlowVoList) throws SSSException;

    void removeByIdArr(List<Long> asList);

    PageUtils listVirtualTask(Map<String, Object> params, Long taskId);

    /**
     * 删除所有虚拟任务
     * @param taskId
     */
    void deleteAllVirtualTask(Long taskId);

    long countVirtualTask(String name, String toJSONString, Long taskId);

    List<String> listHaveCalculateAlgoGroup(Long taskId);

    Date getMaxEndDate(long storeId);


    void updateTaskPublishStatus(Long taskId, Integer isPublish);

    /**
     * 删除任务的所有结果
     * @param taskId
     */
    public void deleteAllResultOfTask(Long taskId);

    Long getTotalTaskByEnterpriseId(Long enterpriseId, Date firstDateOfYear, Date endDateOfYear) throws SSSException;

    Long getTotalTaskByStoreId(Long storeId, Date firstDateOfYear, Date endDateOfYear);

    Double getTotalPassengerFlowByEnterpriseId(Long enterpriseId, Date firstDateOfYear, Date endDateOfYear) throws SSSException;

    Double getTotalPassengerFlowByStoreId(Long storeId, Date firstDateOfYear, Date endDateOfYear);

    List<SchedulingTask> getRealTaskListBetweenDateFrame(Date startDate, Date endDate, Long storeId);



}

