package org.example.intelligent_scheduling_server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.SchedulingDate;
import org.example.entity.SchedulingTask;
import org.example.intelligent_scheduling_server.dao.SchedulingDateDao;
import org.example.intelligent_scheduling_server.mapper.SchedulingDateMapper;
import org.example.intelligent_scheduling_server.service.SchedulingDateService;
import org.example.intelligent_scheduling_server.service.SchedulingTaskService;
import org.example.intelligent_scheduling_server.service.ShiftSchedulingAlgorithmService;
import org.example.utils.PageUtils;
import org.example.utils.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@Service("schedulingDateService")
public class SchedulingDateServiceImpl extends ServiceImpl<SchedulingDateDao, SchedulingDate> implements SchedulingDateService {
    @Autowired
    private ShiftSchedulingAlgorithmService shiftSchedulingAlgorithmService;
    @Autowired
    private SchedulingTaskService schedulingTaskService;
    @Autowired
    private SchedulingDateMapper schedulingDateMapper;
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<SchedulingDate> page = this.page(
                new Query<SchedulingDate>().getPage(params),
                new QueryWrapper<SchedulingDate>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<SchedulingDate> listDateBetweenStartDateAndEndDate(Date startDate, Date endDate, Long storeId, Long taskId) {
        return baseMapper.listDateBetweenStartDateAndEndDate(startDate, endDate, storeId, taskId);
    }

    @Override
    public Boolean judgeOneDateIsRest(Long storeId, Date workDate) {
        Integer isNeedWork = baseMapper.judgeOneDateIsRest(storeId, workDate);
        if (isNeedWork == null) {
            return false;
        }
        return isNeedWork == 0 ? true : false;
    }

    /**
     * 获取门店指定时间段的工作日
     *
     * @param startDate
     * @param endDate
     * @param storeId
     * @return
     */
    @Override
    public List<SchedulingDate> getWorkDayList(Date startDate, Date endDate, Long storeId) {
        long start = System.currentTimeMillis();
        ///查询出改门店的所有真实任务
        QueryWrapper<SchedulingTask> taskQueryWrapper = new QueryWrapper<SchedulingTask>().eq("store_id", storeId).eq("is_deleted", 0).eq("is_publish", 1).eq("type", 0);
        List<Long> realTaskIdList = schedulingTaskService.list(taskQueryWrapper).stream().map(SchedulingTask::getId).collect(Collectors.toList());
        ///查询出所有指定月份、指定门店的所有工作日
        QueryWrapper dateQueryWrapper = new QueryWrapper<SchedulingDate>()
                .eq("store_id", storeId)
                .eq("is_deleted", 0)
                .eq("is_need_work", 1)
                .ge("date", startDate).le("date", endDate);
        if (realTaskIdList.size() > 0) {
            dateQueryWrapper.in("task_id", realTaskIdList);
        } else {
            //--if--肯定查不到数据
            dateQueryWrapper.eq("id", -1);
        }
        List<SchedulingDate> shiftDateEntityList = baseMapper.selectList(dateQueryWrapper);
//        System.out.println("getWorkDayList时间："+(System.currentTimeMillis()-start)+"ms");
        return shiftDateEntityList;
    }

    @Override
    public Long getByStoreId(Long storeId, Date date) {
        return schedulingDateMapper.getIdByDate(storeId,date);
    }

}