package org.example.intelligent_scheduling_server.service.impl;

import org.example.entity.*;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.dao.SchedulingTaskDao;
import org.example.intelligent_scheduling_server.mapper.SchedulingTaskMapper;
import org.example.intelligent_scheduling_server.service.*;
import org.example.utils.PageUtils;
import org.example.utils.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.springframework.transaction.annotation.Transactional;


@Service
public class SchedulingTaskServiceImpl extends ServiceImpl<SchedulingTaskDao, SchedulingTask> implements SchedulingTaskService {
    @Autowired
    private ShiftUserService shiftUserService;
    @Autowired
    private SchedulingTaskMapper schedulingTaskMapper;
    @Autowired
    private SchedulingDateService schedulingDateService;
    @Autowired
    private SchedulingShiftService schedulingShiftService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, QueryWrapper<SchedulingTask> wrapper) {
        IPage<SchedulingTask> page = this.page(
                new Query<SchedulingTask>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }


    /**
     * 删除任务的所有结果
     *
     * @param taskId
     */
    public void deleteAllResultOfTask(Long taskId) {
        List<SchedulingDate> schedulingDateEntityList = schedulingDateService.list(new QueryWrapper<SchedulingDate>().eq("task_id", taskId));
        List<Long> shiftIdList = new ArrayList<>();
        List<Long> schedulingDateIdList = schedulingDateEntityList.stream().map(date -> {
            //查询每天的相关班次数据
            List<SchedulingShift> schedulingShiftEntityList = schedulingShiftService.list(new QueryWrapper<SchedulingShift>().eq("scheduling_date_id", date.getId()));
            shiftIdList.addAll(schedulingShiftEntityList.stream().map(shift -> {
                return shift.getId();
            }).collect(Collectors.toList()));

            return date.getId();
        }).collect(Collectors.toList());

        ////批量删除
        //删除当前任务所对应的数据
        if (!schedulingDateIdList.isEmpty()) {
            schedulingDateService.removeByIds(schedulingDateIdList);
        }

        if (!shiftIdList.isEmpty()) {
            //删除相关班次数据
            schedulingShiftService.removeByIds(shiftIdList);
            //删除用户-班次中间数据
            shiftUserService.remove(new QueryWrapper<ShiftUser>().in("shift_id", shiftIdList));
        }
        schedulingTaskMapper.deleteById(taskId);
    }


    @Override
    public void insert(SchedulingTask schedulingTask) throws SSSException {
        schedulingTaskMapper.insert(schedulingTask);
    }


    @Override
    @Transactional
    public void updateTaskPublishStatus(Long taskId, Integer isPublish) {
        ////修改任务状态
        SchedulingTask taskEntity = new SchedulingTask();
        taskEntity.setId(taskId);
        taskEntity.setIsPublish(isPublish);
        baseMapper.updateById(taskEntity);
        ////发布信息通知相关员工
        ///找出相关任务中被安排了班次的相关员工id
        List<Long> userIdList = shiftUserService.listRelevantUserId(taskId);
        ///编辑消息
        StringBuilder messageStrBuilder = new StringBuilder();
        SchedulingTask task = baseMapper.selectById(taskId);
        ///发送消息通知员工
        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("userIdList", userIdList);
        if (isPublish == 1) {
            String startDate = org.example.utils.DateUtil.convertUTCToBeijing(task.getStartDate());
            String endDate = org.example.utils.DateUtil.convertUTCToBeijing(task.getEndDate());
            String htmlContent = "<html>"
                    + "<head>"
                    + "<style>"
                    + "body {font-family: Arial, sans-serif; font-size: 16px; color: #333333; background-color: #FFFFFF; line-height: 1.5;}"
                    + "h1 {font-size: 24px; color: #007FFF; margin-bottom: 10px;}"
                    + "p {margin-bottom: 10px;}"
                    + ".date {font-weight: bold; color: #007FFF;}"
                    + ".wrapper {max-width: 600px; margin: 0 auto;}"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class=\"wrapper\">"
                    + "<h2>排班计划发布</h2>"
                    + "<p>尊敬的员工，</p>"
                    + "<p>&emsp;&emsp;管理员刚刚发布了新的排班计划，排班时间范围：<span class=\"date\">" + startDate
                    + "</span>至<span class=\"date\">" + endDate
                    + "</span>，请及时登录系统查看排班日历，明确自己的工作时间。</p>"
                    + "<p>谢谢。</p>"
                    + "</div>"
                    + "</body>"
                    + "</html>";
            messageStrBuilder.append(htmlContent);
            paramMap.put("subject", "智能排班系统——排班任务发布通知");
            paramMap.put("message", messageStrBuilder.toString());
            paramMap.put("type", 1);
        } else {
            String startDate = org.example.utils.DateUtil.convertUTCToBeijing(task.getStartDate());
            String endDate = org.example.utils.DateUtil.convertUTCToBeijing(task.getEndDate());

            String htmlContent = "<html>"
                    + "<head>"
                    + "<style>"
                    + "body {font-family: Arial, sans-serif; font-size: 16px; color: #333333; background-color: #FFFFFF; line-height: 1.5;}"
                    + "h1 {font-size: 24px; color: #007FFF; margin-bottom: 10px;}"
                    + "p {margin-bottom: 10px;}"
                    + ".date {font-weight: bold; color: #007FFF;}"
                    + ".wrapper {max-width: 600px; margin: 0 auto;}"
                    + "</style>"
                    + "</head>"
                    + "<body>"
                    + "<div class=\"wrapper\">"
                    + "<h2>排班计划撤回</h2>"
                    + "<p>尊敬的员工，</p>"
                    + "<p>&emsp;&emsp;管理员刚刚撤回了部分排班计划，排班时间范围：<span class=\"date\">" + startDate
                    + "</span>至<span class=\"date\">" + endDate
                    + "</span>，可登录系统查看具体的排班日历。</p>"
                    + "<p>谢谢。</p>"
                    + "</div>"
                    + "</body>"
                    + "</html>";
            messageStrBuilder.append(htmlContent);
            paramMap.put("subject", "智能排班系统——排班任务撤回通知");
            paramMap.put("message", messageStrBuilder.toString());
            paramMap.put("type", 1);

        }
        //enterpriseFeignService.sendMesToUserList(paramMap);
    }


}