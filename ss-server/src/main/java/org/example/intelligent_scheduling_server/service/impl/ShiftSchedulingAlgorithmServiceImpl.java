package org.example.intelligent_scheduling_server.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.example.dto.intelligent_scheduling.*;
import org.example.dto.intelligent_scheduling_server.AlgoGroupDto;
import org.example.entity.SchedulingDate;
import org.example.entity.SchedulingShift;
import org.example.entity.SchedulingTask;
import org.example.entity.ShiftUser;
import org.example.enums.AlgoEnum;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling.IntelligentSchedulingPureAlgo;
import org.example.intelligent_scheduling_server.component.WebSocketServer;
import org.example.intelligent_scheduling_server.enums.WebSocketEnum;
import org.example.intelligent_scheduling_server.service.*;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.example.service.imp.EnterpriseAdmin_StoreServiceImpl;
import org.example.vo.enterprise.SchedulingRuleVo;
import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.PassengerFlowVo;
import org.example.vo.scheduling_calculate_service.SchedulingCalculateVo;
import org.example.vo.system.UserInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.Collectors;

@Service
public class ShiftSchedulingAlgorithmServiceImpl implements ShiftSchedulingAlgorithmService {
    @Autowired
    private SchedulingTaskService schedulingTaskService;
    @Autowired
    private SchedulingShiftService schedulingShiftService;
    @Autowired
    private ShiftUserService shiftUserService;
    @Autowired
    private SchedulingDateService schedulingDateService;
    @Autowired
    private WebSocketServer webSocketServer;
    @Autowired
    private ThreadPoolExecutor executor;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private SchedulingRuleService schedulingRuleService;
    @Autowired
    private EnterpriseAdmin_StoreServiceImpl storeService;
    /**
     * @param schedulingCalculateVo
     * @param instance
     * @param storeId
     * @param token
     * @param isSendMessage         是否发送消息给客户端通知客户端计算完成
     */
    @Override
    public void caculate(Instance instance, Long storeId, Boolean isSendMessage) throws SSSException {
        try {
            Solution solution = new IntelligentSchedulingPureAlgo().solve(instance);
            this.saveSolutionToDatabase(storeId,instance, solution);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //TODO 发送消息给前端
    }

    /**
     * 判断 排班计算的参数vo 是否有效
     *
     * @param schedulingCalculateVo
     * @return
     */
    @Override
    public boolean judgeWhetherSchedulingCalculateVoEffective(SchedulingCalculateVo schedulingCalculateVo) throws SSSException {
        Long taskId = schedulingCalculateVo.getTaskId();
        Long schedulingRuleId = schedulingCalculateVo.getSchedulingRuleId();
        List<DateVo> dateVoList = schedulingCalculateVo.getDateVoList();

        if (taskId == null) {
            throw new SSSException(ResultCodeEnum.FAIL.getCode(), "taskId为空");
        } else if (schedulingRuleId == null) {
            throw new SSSException(ResultCodeEnum.FAIL.getCode(), "门店规则还没有设置");
        }

        if (dateVoList == null) {
            throw new SSSException(ResultCodeEnum.FAIL.getCode(), "工作日未设置完成");
        } else {
            int flowVoListSize = 0;
            for (DateVo dateVo : dateVoList) {
                flowVoListSize += dateVo.getPassengerFlowVoList().size();
            }
            if (flowVoListSize == 0) {
                throw new SSSException(ResultCodeEnum.FAIL.getCode(), "客流量未导入");
            }
        }

        return true;
    }

    /**
     * 存储数据到数据库
     *
     * @param solution
     */
    @Transactional
    public void saveSolutionToDatabase(Long storeId, Instance instance, Solution solution) {

        Employee[] employees = instance.getEmployees();
        List<String> staffIdList = new ArrayList<>();//员工编号
        for (Employee employee : employees) {
            staffIdList.add(employee.getId());
        }

        //// 获取solution信息
        // 排班班次信息
        List<List<ShiftPlanning>> shiftPlanningListList = solution.getShiftPlanningListList();

        //// 声明变量
        List<DateVo> dateVoList = schedulingCalculateVo.getDateVoList();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/M/d");
        List<SchedulingDate> dateEntityList = new ArrayList<>();
        List<SchedulingShift> assignedShiftEntityList = new ArrayList<>();
        List<SchedulingShift> unAssignedShiftEntityList = new ArrayList<>();
        List<ShiftUser> shiftUserEntityList = new ArrayList<>();

        //TODO 存放排班工作日数据
        for (int i = 0; i < shiftPlanningListList.size(); i++) {
            /// 存储排班工作日相关数据
            DateVo dateVo = dateVoList.get(i);
            SchedulingDate schedulingDateEntity = new SchedulingDate();
            try {
                schedulingDateEntity.setDate(sdf.parse(dateVo.getDate()));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            schedulingDateEntity.setIsNeedWork(dateVo.getIsNeedWork() == true ? 1 : 0);
            schedulingDateEntity.setStartWorkTime(dateVo.getStartWorkTime());
            schedulingDateEntity.setEndWorkTime(dateVo.getEndWorkTime());
            schedulingDateEntity.setStoreId(storeId);
            schedulingDateEntity.setTaskId(schedulingCalculateVo.getTaskId());
            dateEntityList.add(schedulingDateEntity);
            /// 存储每天对应班次相关数据
            String[] timeFrameArr = dateVo.getTimeFrameArr();
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            // 存储已分配的班次
            this.saveAssignedShifts(instance, solution, staffIdList, assignedShiftEntityList, shiftUserEntityList, i, timeFrameArr, sdf1);
            // 未分配的班次
            this.saveUnAssignedShifts(instance, solution, unAssignedShiftEntityList, i, timeFrameArr, sdf1);
        }

        //// 批量存储
        /// 先批量存储任务
        schedulingDateService.saveBatch(dateEntityList);
        /// 给班次设置dateId，存储已经分配的班次
        for (SchedulingShift schedulingShiftEntity : assignedShiftEntityList) {
            schedulingShiftEntity.setSchedulingDateId(dateEntityList.get(Integer.parseInt(schedulingShiftEntity.getSchedulingDateId().toString())).getId());
        }
        schedulingShiftService.saveBatch(assignedShiftEntityList);
        /// 给shiftUser设置班次id
        for (int i = 0; i < assignedShiftEntityList.size(); i++) {
            shiftUserEntityList.get(i).setShiftId(assignedShiftEntityList.get(i).getId());
        }
        shiftUserService.saveBatch(shiftUserEntityList);
        /// 给班次设置dateId，存储未分配的班次
        for (SchedulingShift schedulingShiftEntity : unAssignedShiftEntityList) {
            schedulingShiftEntity.setSchedulingDateId(dateEntityList.get(Integer.parseInt(schedulingShiftEntity.getSchedulingDateId().toString())).getId());
        }
        schedulingShiftService.saveBatch(unAssignedShiftEntityList);
    }

    /**
     * 存储已经分配的班次
     *
     * @param instance
     * @param solution
     * @param staffIdList
     * @param shiftEntityList
     * @param shiftUserEntityList
     * @param i
     * @param timeFrameArr
     * @param sdf1
     */
    private void saveAssignedShifts(Instance instance, Solution solution, List<String> staffIdList, List<SchedulingShift> shiftEntityList,
                                    List<ShiftUser> shiftUserEntityList, int i, String[] timeFrameArr, SimpleDateFormat sdf1) {
        List<ShiftPlanning> shiftPlannings = solution.getShiftPlanningListList().get(i);
        for (ShiftPlanning shiftPlanning : shiftPlannings) {

            Shift shift = shiftPlanning.getShift();
            int totalMinute = shift.getTotalMinute();
            int head = shift.getHead();
            int len = shift.getLen();
            int mealHead = shift.getMealHead();
            int mealLen = shift.getMealLen();
            Short mealType = shift.getMealType();

            ///存储每个班次
            SchedulingShift schedulingShiftEntity = new SchedulingShift();
            try {
                schedulingShiftEntity.setStartDate(sdf1.parse(timeFrameArr[head].split(",")[0]));
                schedulingShiftEntity.setEndDate(sdf1.parse(timeFrameArr[head + len - 1].split(",")[1]));
                //还没有id，可以先存储一下索引，批量存储结束之后，根据索引获取id
//                    schedulingShiftEntity.setSchedulingDateId(schedulingDateEntity.getId());
                long index = i;
                schedulingShiftEntity.setSchedulingDateId(index);
                if (mealHead != -1) {
                    schedulingShiftEntity.setMealStartDate(sdf1.parse(timeFrameArr[mealHead].split(",")[0]));
                    schedulingShiftEntity.setMealEndDate(sdf1.parse(timeFrameArr[mealHead + mealLen - 1].split(",")[1]));
                }
                schedulingShiftEntity.setMealType(mealType == null ? 2 : (int) mealType);
                schedulingShiftEntity.setTotalMinute(totalMinute);
                if (head <= instance.getDoubleShiftTimeFramesEachDay().get(i)[0]) {
                    //--if--开店工作
                    schedulingShiftEntity.setShiftType(1);
                } else if (head >= instance.getDoubleShiftTimeFramesEachDay().get(i)[1]) {
                    //--if--收尾工作
                    schedulingShiftEntity.setShiftType(2);
                } else {
                    schedulingShiftEntity.setShiftType(0);
                }
//                    schedulingShiftService.save(schedulingShiftEntity);
                shiftEntityList.add(schedulingShiftEntity);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
//                if ("id:7".equals(employees[shiftPlanning.getEmployeeIndex()].getId())) {
//                    System.out.println("wqdqwdw: " + schedulingShiftEntity);
//                }

            ///存储班次和用户的对应关系
            ShiftUser shiftUserEntity = new ShiftUser();
            shiftUserEntity.setShiftId(schedulingShiftEntity.getId());
            if (staffIdList.indexOf(instance.getEmployees()[shiftPlanning.getEmployeeIndex()].getId()) != -1) {
                staffIdList.remove(staffIdList.indexOf(instance.getEmployees()[shiftPlanning.getEmployeeIndex()].getId()));
            }
            shiftUserEntity.setUserId(Long.parseLong(instance.getEmployees()[shiftPlanning.getEmployeeIndex()].getId().split(":")[1]));
            shiftUserEntity.setPositionId(Long.parseLong(instance.getEmployees()[shiftPlanning.getEmployeeIndex()].getPosition()));
            shiftUserEntityList.add(shiftUserEntity);

        }
    }

    /**
     * 存储未分配的班次
     *
     */
    private void saveUnAssignedShifts(Instance instance, Solution solution, List<SchedulingShift> shiftEntityList, int i, String[] timeFrameArr, SimpleDateFormat sdf1) {
        List<Shift> unAssignedShiftList = solution.getUnabsorbedShiftListList().get(i);
//        System.out.println("未分配班次数量：" + unAssignedShiftList.size());
        for (Shift shift : unAssignedShiftList) {
            int totalMinute = shift.getTotalMinute();
            int head = shift.getHead();
            int len = shift.getLen();
            int mealHead = shift.getMealHead();
            int mealLen = shift.getMealLen();
            Short mealType = shift.getMealType();
            ///存储每个班次
            SchedulingShift schedulingShiftEntity = new SchedulingShift();
            try {
                schedulingShiftEntity.setStartDate(sdf1.parse(timeFrameArr[head].split(",")[0]));
                schedulingShiftEntity.setEndDate(sdf1.parse(timeFrameArr[head + len - 1].split(",")[1]));
                //还没有id，可以先存储一下索引，批量存储结束之后，根据索引获取id
//                    schedulingShiftEntity.setSchedulingDateId(schedulingDateEntity.getId());
                long index = i;
                schedulingShiftEntity.setSchedulingDateId(index);
                if (mealHead != -1) {
                    schedulingShiftEntity.setMealStartDate(sdf1.parse(timeFrameArr[mealHead].split(",")[0]));
                    schedulingShiftEntity.setMealEndDate(sdf1.parse(timeFrameArr[mealHead + mealLen - 1].split(",")[1]));
                }
                schedulingShiftEntity.setMealType(mealType == null ? 2 : (int) mealType);
                schedulingShiftEntity.setTotalMinute(totalMinute);
                if (head <= instance.getDoubleShiftTimeFramesEachDay().get(i)[0]) {
                    //--if--开店工作
                    schedulingShiftEntity.setShiftType(1);
                } else if (head >= instance.getDoubleShiftTimeFramesEachDay().get(i)[1]) {
                    //--if--收尾工作
                    schedulingShiftEntity.setShiftType(2);
                } else {
                    schedulingShiftEntity.setShiftType(0);
                }
//                    schedulingShiftService.save(schedulingShiftEntity);
                shiftEntityList.add(schedulingShiftEntity);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }
    }

    /**
     * 用虚拟任务的结果覆盖任务结果
     */
    @Override
    @Transactional
    public void overlayResult(Long virtualTaskId) {
        ////查询出虚拟任务所对应的真实任务
        SchedulingTask virtualTask = schedulingTaskService.getById(virtualTaskId);
        SchedulingTask realTask = schedulingTaskService.getById(virtualTask.getParentId());

        ////删除任务的结果
        this.deleteRelevantDataOfTask(realTask.getParentId());

        ////复制虚拟任务的结果到真实任务
        ///覆盖task信息
        BeanUtils.copyProperties(virtualTask, realTask,
                "id", "createTime", "updateTime", "name", "schedulingRuleId", "storeId",
                "duration", "intervalc", "datevolist", "startDate", "endDate", "type", "parentId", "isPublish");
        schedulingTaskService.updateById(realTask);

        ///复制其他信息
        List<SchedulingDate> dateEntityList = schedulingDateService.list(new QueryWrapper<SchedulingDate>().eq("task_id", virtualTaskId));
        List<SchedulingDate> newDateList = new ArrayList<>();
        List<SchedulingShift> newShiftList = new ArrayList<>();
        List<SchedulingShift>[] newShiftListArr = new List[dateEntityList.size()];
        Map<String, List<ShiftUser>> keyAndShiftUserListMap = new HashMap<>();
        List<ShiftUser> newShiftUserList = new ArrayList<>();
        for (int i = 0; i < dateEntityList.size(); i++) {
            SchedulingDate schedulingDateEntity = dateEntityList.get(i);
            //复制date
            SchedulingDate newDate = new SchedulingDate();
            BeanUtils.copyProperties(schedulingDateEntity, newDate);
            newDate.setTaskId(realTask.getId());
            //复制shift
            List<SchedulingShift> shiftEntityList = schedulingShiftService.list(new QueryWrapper<SchedulingShift>().eq("scheduling_date_id", schedulingDateEntity.getId()));
            newShiftListArr[i] = new ArrayList<>();
            for (int j = 0; j < shiftEntityList.size(); j++) {
                SchedulingShift shift = shiftEntityList.get(j);
                SchedulingShift newShift = new SchedulingShift();
                BeanUtils.copyProperties(shift, newShift);
                newShiftListArr[i].add(newShift);
                //复制shiftUser
                List<ShiftUser> shiftUserEntityList = shiftUserService.list(new QueryWrapper<ShiftUser>().eq("shift_id", shift.getId()));
                List<ShiftUser> shiftUserList = new ArrayList<>();
                for (int k = 0; k < shiftUserEntityList.size(); k++) {
                    ShiftUser shiftUser = new ShiftUser();
                    BeanUtils.copyProperties(shiftUserEntityList.get(k), shiftUser);
                    shiftUserList.add(shiftUser);
                }
                keyAndShiftUserListMap.put(i + "-" + j, shiftUserList);
            }
        }
        ///存储task
        schedulingDateService.saveBatch(newDateList);
        ///存储shift
        for (int i = 0; i < newDateList.size(); i++) {
            SchedulingDate date = newDateList.get(i);
            for (int j = 0; j < newShiftListArr[i].size(); j++) {
                //设置dateId
                newShiftListArr[i].get(j).setSchedulingDateId(date.getId());
                newShiftList.add(newShiftListArr[i].get(j));
                //索引对应集合
                keyAndShiftUserListMap.put((newShiftList.size() - 1) + "", keyAndShiftUserListMap.get(i + "-" + j));
            }
        }
        schedulingShiftService.saveBatch(newShiftList);
        ///存储shiftUser
        for (int index = 0; index < newShiftList.size(); index++) {
            for (ShiftUser shiftUserEntity : keyAndShiftUserListMap.get(index + "")) {
                shiftUserEntity.setShiftId(newShiftList.get(index).getId());
                newShiftUserList.add(shiftUserEntity);
            }
        }
        shiftUserService.saveBatch(newShiftUserList);
    }

    /**
     * 删除任务相关数据，班次、工作日、user_shift
     */
    public void deleteRelevantDataOfTask(Long taskId) {
        ////查询当前任务所对应的数据
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
        if (schedulingDateIdList.size() > 0) {
            schedulingDateService.removeByIds(schedulingDateIdList);
        }

        if (shiftIdList.size() > 0) {
            //删除相关班次数据
            schedulingShiftService.removeByIds(shiftIdList);
            //删除用户-班次中间数据
            shiftUserService.remove(new QueryWrapper<ShiftUser>().in("shift_id", shiftIdList));
        }

    }

    /**
     * 删除任务集合的所有相关数据，班次、工作日、user_shift
     */
    public void deleteRelevantDataOfTaskList(List<Long> taskIdList) {
        ////查询当前任务所对应的数据
        List<SchedulingDate> schedulingDateEntityList = schedulingDateService.list(new QueryWrapper<SchedulingDate>().in("task_id", taskIdList));
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
        if (schedulingDateIdList.size() > 0) {
            schedulingDateService.removeByIds(schedulingDateIdList);
        }

        if (shiftIdList.size() > 0) {
            //删除相关班次数据
            schedulingShiftService.removeByIds(shiftIdList);
            //删除用户-班次中间数据
            shiftUserService.remove(new QueryWrapper<ShiftUser>().in("shift_id", shiftIdList));
        }

    }

    @Override
    public void multiAlgorithmInstancePrepare(List<AlgoGroupDto> algoGroupDtoList, List<Instance> instanceList, List<SchedulingCalculateVo> schedulingCalculateVoList, Long taskId, Long storeId, String token) throws SSSException {
        System.out.println("调用多算法数据准备--------------------------------------------------------------------------------------");
        long start = System.currentTimeMillis();

        SchedulingTask schedulingTaskEntity = schedulingTaskService.getById(taskId);
        ////将任务复制多份
        List<SchedulingTask> newTaskList = new ArrayList<>();
        for (AlgoGroupDto algoGroupDto : algoGroupDtoList) {
            SchedulingTask newTask = schedulingTaskEntity.clone();
            newTask.setType(1);
            newTask.setParentId(schedulingTaskEntity.getId());
            newTask.setStepOneAlg(algoGroupDto.getPhaseOne().getName());
            String[] arr = new String[]{algoGroupDto.getPhaseTwo().getCategoryName(), algoGroupDto.getPhaseTwo().getName()};
            newTask.setStepTwoAlg(JSON.toJSONString(arr));
            newTaskList.add(newTask);
        }

        //将虚拟任务批量保存到数据库中
        schedulingTaskService.saveBatch(newTaskList);
        System.out.println("虚拟任务创建完成");
        System.out.println("创建计算数据vo完成");

        ////构造计算数据
        for (SchedulingTask task : newTaskList) {
            //获取schedulingCalculateVo
            SchedulingCalculateVo schedulingCalculateVo = new SchedulingCalculateVo();
            schedulingCalculateVo.setStepOneAlg(task.getStepOneAlg());
            schedulingCalculateVo.setStepTwoAlg(task.getStepTwoAlg());
            schedulingCalculateVo.setStepTwoAlgParam(task.getStepTwoAlgParam());
            schedulingCalculateVo.setDuration(task.getDuration());
            schedulingCalculateVo.setIntervalC(task.getIntervalc());
            schedulingCalculateVo.setDateVoList(JSON.parseObject(task.getDatevolist(), new TypeReference<List<DateVo>>() {
            }));
            schedulingCalculateVo.setTaskId(task.getId());
            schedulingCalculateVo.setSchedulingRuleId(task.getSchedulingRuleId());

            boolean flag = this.judgeWhetherSchedulingCalculateVoEffective(schedulingCalculateVo);
            if (flag == false) {
                HashMap<String, Object> message = new HashMap<>();
                message.put("taskId", schedulingCalculateVo.getTaskId());
                message.put("type", WebSocketEnum.CalculateEnd.getType());
                message.put("isSuccess", 0);
                message.put("cause", "计算数据出错，请检查工作日设置是否正确？修改了任务的起止日期之后，需要重新设置工作日");
                SchedulingTask schedulingTaskEntity1 = schedulingTaskService.getById(schedulingCalculateVo.getTaskId());
                //todo 判断是计算成功还是失败
                //修改任务状态
                schedulingTaskEntity1.setStatus(3);
                schedulingTaskService.updateById(schedulingTaskEntity1);
                message.put("calculateTime", System.currentTimeMillis() - start);
                webSocketServer.sendMessage(JSON.toJSONString(message), WebSocketServer.tokenAndSessionMap.get(token));
            } else {
                schedulingCalculateVoList.add(schedulingCalculateVo);
                Instance instance = this.buildInstance(schedulingCalculateVo, storeId);
                instanceList.add(instance);
            }
        }
    }

    /**
     * 计算不同的算法组合
     */
    @Override
    public void multiAlgorithmSolve(List<Instance> instanceList, List<SchedulingCalculateVo> schedulingCalculateVoList, Long taskId, Long storeId, String token) throws SSSException {
        System.out.println("调用多算法计算");

        ////添加计算(多线程)
/*         long start = System.currentTimeMillis();
       CompletableFuture<Void>[] completableFutureArr = new CompletableFuture[schedulingCalculateVoList.size()];
        for (int i = 0; i < schedulingCalculateVoList.size(); i++) {
            SchedulingCalculateVo schedulingCalculateVo = schedulingCalculateVoList.get(i);
            completableFutureArr[i] = CompletableFuture.runAsync(() -> {
                try {
                    this.caculate(schedulingCalculateVo, storeId, token, false);
                } catch (SSSException e) {

                }
            }, executor).whenComplete((res, e) -> {
                e.printStackTrace();
            });
        }
        try {
            CompletableFuture.allOf(completableFutureArr).get();
            //当所有算法都计算完成之后
            Map<String, Object> message = new HashMap<>();
            message.put("type", WebSocketEnum.AllAlgorithmCalculateEnd.getType());
            message.put("isSuccess", 1);
            message.put("calculateTime", System.currentTimeMillis() - start);
            webSocketServer.sendMessage(JSON.toJSONString(message), WebSocketServer.tokenAndSessionMap.get(token));
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } catch (ExecutionException e) {
            throw new RuntimeException(e);
        }*/

        ////添加计算（单线程）
        long start = System.currentTimeMillis();

        for (int i = 0; i < instanceList.size(); i++) {
            SchedulingCalculateVo schedulingCalculateVo = schedulingCalculateVoList.get(i);
            this.caculate(schedulingCalculateVo, instanceList.get(i), storeId, token, false);
            System.out.println(schedulingCalculateVo.getStepTwoAlg() + "+" + schedulingCalculateVo.getStepTwoAlg() + "计算完成");
        }

        //当所有算法都计算完成之后
        Map<String, Object> message = new HashMap<>();
        message.put("type", WebSocketEnum.AllAlgorithmCalculateEnd.getType());
        message.put("taskId", taskId);
        message.put("isSuccess", 1);
        message.put("calculateTime", System.currentTimeMillis() - start);
        message.put("cause", "");
        webSocketServer.sendMessage(JSON.toJSONString(message), WebSocketServer.tokenAndSessionMap.get(token));

        System.out.println("所有算法计算完成，耗时：" + (System.currentTimeMillis() - start) + "ms");
    }

    /**
     * 构建计算实例
     *
     * @param schedulingCalculateVo 计算参数
     * @return
     */
    @Override
    public Instance buildInstance(Long storeId,Date beginDate, Date endDate) throws SSSException {
        long start = System.currentTimeMillis();
        //// 声明变量
        Instance instance = new Instance();
        //TODO 获取客流量数据
        List<DateVo> dateVoList = null;
        int duration = instance.getMinuteEachC();

        // 设置门店员工信息
        //TODO
        List<UserInfoVo> userInfoVoList = adminService.listUserByStoreId(storeId);
        // 移除有问题的员工数据，如没有职位信息，或者没有排班长度偏好
        List<UserInfoVo> userInfoVoListWithoutPosition = new ArrayList<>();
        for (UserInfoVo userInfoVo : userInfoVoList) {
            if (userInfoVo.getPositionId() == null ||
                    userInfoVo.getShiftLengthPreferenceOneDay() == null ||
                    userInfoVo.getShiftLengthPreferenceOneWeek() == null ||
                    userInfoVo.getWorkTimePreference() == null) {
                userInfoVoListWithoutPosition.add(userInfoVo);
            }
        }
        userInfoVoList.removeAll(userInfoVoListWithoutPosition);
        // 转化为算法需要的用户数据
        Employee[] employees = new Employee[userInfoVoList.size()];
        for (int i = 0; i < userInfoVoList.size(); i++) {
            UserInfoVo userInfoVo = userInfoVoList.get(i);
            Employee employee = buildEmployee(duration, userInfoVo);
            employees[i] = employee;
        }
        instance.setEmployees(employees);

        Long ruleId = schedulingRuleService.queryRuleIdByStoreId(storeId);
        // 解析排班规则
        SchedulingRuleVo schedulingRuleVo = schedulingRuleService.getSchedulingRuleVoByRuleId(ruleId);
        // 解析门店工作时间段
        List<Time[]> oneWeekTimeFrameList = getWeekTimeFrameList(schedulingRuleVo);
        // 员工每天最多工作多少段
        instance.setMaxWorkCEachDay((schedulingRuleVo.getMostWorkHourInOneDay().intValue() * 60) / duration);
        // 员工每周最多工作多少段
        instance.setMaxWorkCEachWeek((schedulingRuleVo.getMostWorkHourInOneWeek().intValue() * 60) / duration);
        // 设置最小班次时间的时间段数
        instance.setMinC(schedulingRuleVo.getMinShiftMinute() / duration);
        // 设置最大班次时间的时间段数
        instance.setMaxC(schedulingRuleVo.getMaxShiftMinute() / duration);
        // 员工最长连续工作时间段数
        instance.setMaxContinuousWorkC(schedulingRuleVo.getMaximumContinuousWorkTime().intValue() / duration);
        // 设置每一天是星期几，每一天所被分成的时间段
        this.setWeekArrAndTimeFrameEachDay(instance, schedulingRuleVo, dateVoList, duration, oneWeekTimeFrameList);

        return new Instance();
    }

    /**
     * 解析门店一个星期中每天的工作时间
     *
     * @param schedulingRuleVo
     * @return
     */
    private List<Time[]> getWeekTimeFrameList(SchedulingRuleVo schedulingRuleVo) {
        String storeWorkTimeFrame = schedulingRuleVo.getStoreWorkTimeFrame();
        Time[] monArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Mon");
        Time[] tueArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Tue");
        Time[] wedArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Wed");
        Time[] thurArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Thur");
        Time[] friArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Fri");
        Time[] satArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Sat");
        Time[] sunArr = parseStoreWorkTimeFrame(storeWorkTimeFrame, "Sun");
        List<Time[]> oneWeekTimeFrameList = new ArrayList<>();
        Collections.addAll(oneWeekTimeFrameList, monArr, tueArr, wedArr, thurArr, friArr, satArr, sunArr);
        return oneWeekTimeFrameList;
    }


    /**
     * 构建算法需要的员工数据
     *
     * @param duration
     * @param userInfoVo
     * @return
     */
    private Employee buildEmployee(int duration, UserInfoVo userInfoVo) {
        Employee employee = new Employee();
        employee.setId("id:" + userInfoVo.getId());
        employee.setPosition(userInfoVo.getPositionId() + "");
        // 每个星期工作日偏好设置
        short[] workDayPreference = new short[7];
        for (int j = 0; j < workDayPreference.length; j++) {
            workDayPreference[j] = (userInfoVo.getWorkDayPreferenceList().contains(j + 1) ? (short) 1 : (short) 0);
        }
        employee.setWorkDayPreference(workDayPreference);
        // 工作时间段偏好设置 1:00~3.00|5.00~8.00|17.00~21.00
        if (userInfoVo.getWorkTimePreference() != null) {
            String[] timeFrameStrArr = userInfoVo.getWorkTimePreference().split("\\|");
            TimeFrame[] workTimePreference = new TimeFrame[timeFrameStrArr.length];
            for (int j = 0; j < timeFrameStrArr.length; j++) {
                String[] timeStrArr = timeFrameStrArr[j].split("~");
                workTimePreference[j] = new TimeFrame(parseStrToTime(timeStrArr[0]), parseStrToTime(timeStrArr[1]));
            }
            List<TimeFrame> timeFrameList = new ArrayList<>();
            for (int j = 0; j < workTimePreference.length; j++) {
                if (timeFrameList.size() == 0) {
                    timeFrameList.add(workTimePreference[j]);
                } else {
                    //合并连续的时间段
                    TimeFrame lastTimeFrame = timeFrameList.get(timeFrameList.size() - 1);
                    if (getTotalMinuteNum(lastTimeFrame.getLatestTime()) == getTotalMinuteNum(workTimePreference[j].getEarliestTime())) {
                        lastTimeFrame.setLatestTime((workTimePreference[j].getLatestTime()));
                    } else {
                        timeFrameList.add(workTimePreference[j]);
                    }
                }
            }
            employee.setWorkTimePreference(workTimePreference);
        }
        // 一天工作时长偏好
        if (userInfoVo.getShiftLengthPreferenceOneDay() != null) {
            employee.setShiftTimePreference_maxWorkTimeEachDay(getSegmentNum(parseStrToTime(userInfoVo.getShiftLengthPreferenceOneDay()), duration));
        }
        // 一周工作时长偏好
        if (userInfoVo.getShiftLengthPreferenceOneWeek() != null) {
            employee.setShiftTimePreference_maxWorkTimeEachWeek(getSegmentNum(parseStrToTime(userInfoVo.getShiftLengthPreferenceOneWeek()), duration));
        }
        return employee;
    }

    /**
     * 设置每一天是星期几
     * 每一天所被分成的时间段
     * 每个时间段所需要的员工人数
     * 职业约束
     *
     * @param instance
     * @param dateVoList
     * @param duration
     * @param oneWeekTimeFrameList
     */
    private void setWeekArrAndTimeFrameEachDay(Instance instance,
                                               SchedulingRuleVo schedulingRuleVo,
                                               List<DateVo> dateVoList,
                                               int duration,
                                               List<Time[]> oneWeekTimeFrameList) {
        int[] weekArr;
        List<TimeFrame[]> timeFramesEachDay;
        List<int[]> doubleShiftTimeFramesEachDay;
        HashSet<String>[] positionConstraintArr = new HashSet[3];
        // 存储每天、每个时间段所需要的客流量
        List<int[]> employeesRequiredArrEachDay;

        /// 获取开店规则和关店规则
        // 开店
        String openStoreRule = schedulingRuleVo.getOpenStoreRule();
        JSONObject openStoreJsonObject = JSON.parseObject(openStoreRule);
        double openStoreVariableParam = Double.parseDouble(openStoreJsonObject.get("variableParam").toString());
        int openStorePrepareMinute = (int) openStoreJsonObject.get("prepareMinute");
        JSONArray openStorePositionIdArr = JSON.parseArray(JSON.toJSONString(openStoreJsonObject.get("positionIdArr")));

        // 收尾
        String closeStoreRule = schedulingRuleVo.getCloseStoreRule();
        JSONObject closeStoreJsonObject = JSON.parseObject(closeStoreRule);
        double closeStoreVariableParam1 = Double.parseDouble(closeStoreJsonObject.get("variableParam1").toString());
        double closeStoreVariableParam2 = Double.parseDouble(closeStoreJsonObject.get("variableParam2").toString());
        int closeStoreCloseMinute = (int) closeStoreJsonObject.get("closeMinute");
        JSONArray closeStorePositionIdArr = JSON.parseArray(JSON.toJSONString(closeStoreJsonObject.get("positionIdArr")));

        /// 正常班规则
        String normalRule = schedulingRuleVo.getNormalRule();
        JSONObject normalJsonObject = JSON.parseObject(normalRule);
        double normalVariableParam = Double.parseDouble(normalJsonObject.get("variableParam").toString());
        JSONArray normalPositionIdArr = JSON.parseArray(JSON.toJSONString(normalJsonObject.get("positionIdArr")));

        /// 无客流量规则
        String noPassengerRule = schedulingRuleVo.getNoPassengerRule();
        JSONObject noPassengerJsonObject = JSON.parseObject(noPassengerRule);
        int staffNum = Integer.parseInt(noPassengerJsonObject.get("staffNum").toString());
//        JSONArray noPassengerPositionIdArr = JSON.parseArray(JSON.toJSONString(normalJsonObject.get("positionIdArr")));

        /// 设置午餐时间
        String lunchTimeRule = schedulingRuleVo.getLunchTimeRule();
        JSONObject lunchJsonObject = JSON.parseObject(lunchTimeRule);
        Time[] lunchTimeArr = getTimes(JSON.parseArray(JSON.toJSONString(lunchJsonObject.get("timeFrame"))));
        List<int[]> lunchFrames = new ArrayList<>();
        instance.setLunchC((Integer) lunchJsonObject.get("needMinute") / duration);

        /// 设置晚餐时间
        String dinnerTimeRule = schedulingRuleVo.getDinnerTimeRule();
        JSONObject dinnerJsonObject = JSON.parseObject(dinnerTimeRule);
        Time[] dinnerTimeArr = getTimes(JSON.parseArray(JSON.toJSONString(dinnerJsonObject.get("timeFrame"))));
        List<int[]> dinnerFrames = new ArrayList<>();

        instance.setDinnerC((Integer) dinnerJsonObject.get("needMinute") / duration);

        /// 设置职位约束
        HashSet<String> set1 = new HashSet<>();
        for (int j = 0; j < openStorePositionIdArr.size(); j++) {
            set1.add(openStorePositionIdArr.get(j).toString());
        }
        HashSet<String> set2 = new HashSet<>();
        for (int j = 0; j < normalPositionIdArr.size(); j++) {
            set2.add(normalPositionIdArr.get(j).toString());
        }
        HashSet<String> set3 = new HashSet<>();
        for (int j = 0; j < closeStorePositionIdArr.size(); j++) {
            set3.add(closeStorePositionIdArr.get(j).toString());
        }
        positionConstraintArr[0] = set1;
        positionConstraintArr[1] = set2;
        positionConstraintArr[2] = set3;
        instance.setPositionConstraintArr(positionConstraintArr);

        if (dateVoList != null) {
            weekArr = new int[dateVoList.size()];
            timeFramesEachDay = new ArrayList<>();
            doubleShiftTimeFramesEachDay = new ArrayList<>();
            employeesRequiredArrEachDay = new ArrayList<>();
            Collections.sort(dateVoList, ((o1, o2) -> {
                return dateStrCompare(o1.getDate(), o2.getDate());
            }));
            for (int i = 0; i < dateVoList.size(); i++) {
                ///声明变量
                String[] timeFrameArr;

                DateVo dateVo = dateVoList.get(i);
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/M/d");
                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
                Date date;
                //2022-12-11
                String dateStr;
                try {
                    date = sdf1.parse(dateVo.getDate());
                    dateStr = sdf2.format(date);
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }

                /// 设置星期几
                weekArr[i] = this.getWeek(date);

                /// 设置分段
                // 根据周几获取当天工作开始、结束时间(week-1才是索引)
                int week = weekArr[i];
                Time[] times = oneWeekTimeFrameList.get(week - 1);
                dateVo.setStartWorkTime(times[0].toFormatString());
                dateVo.setEndWorkTime(times[1].toFormatString());
                // 计算当前的段数
//                System.out.println("times[0]:" + times[0]);
//                System.out.println("times[1]:" + times[1]);
                int startMinute = getTotalMinuteNum(times[0]) - openStorePrepareMinute;
                int endMinute = getTotalMinuteNum(times[1]) + closeStoreCloseMinute;
                int segmentNum = (endMinute - startMinute) / duration;
                timeFrameArr = new String[segmentNum];
                TimeFrame[] timeFramesArr = new TimeFrame[segmentNum];
                // 获取开始上班时间，从开店时间开始算
                Time start = getTimeAfterAdd(times[0], -openStorePrepareMinute);
                for (int j = 0; j < segmentNum; j++) {
                    Time end = getTimeAfterAdd(start, duration);
//                    System.out.println("start:" + start + ",end:" + end);
                    Time startTime = new Time(start.getHour(), start.getMinute());
                    Time endTime = new Time(end.getHour(), end.getMinute());
                    timeFramesArr[j] = new TimeFrame(startTime, new Time(end.getHour(), end.getMinute()));
                    timeFrameArr[j] = dateStr + " " + startTime.toFormatString() + "," + dateStr + " " + endTime.toFormatString();
                    start = end;
                }
                dateVo.setTimeFrameArr(timeFrameArr);
                if (dateVo.getIsNeedWork() == true) {
                    timeFramesEachDay.add(timeFramesArr);
                } else {
                    timeFramesEachDay.add(null);
                }

                /// 设置一天中两头班(清扫和收尾)的时间段索引数组 [清扫的结束时间段索引，收尾的开始时间段索引]
                int openStoreIndex = openStorePrepareMinute / duration - 1;
                int closeStoreIndex = segmentNum - closeStoreCloseMinute / duration;
                if (dateVo.getIsNeedWork() == true) {
                    doubleShiftTimeFramesEachDay.add(new int[]{openStoreIndex, closeStoreIndex});
                } else {
                    doubleShiftTimeFramesEachDay.add(null);
                }

                /// 设置午餐时间、晚餐时间
                lunchFrames.add(new int[]{this.getSegmentNum(new TimeFrame(times[0], lunchTimeArr[0]), duration), this.getSegmentNum(new TimeFrame(times[0], lunchTimeArr[1]), duration) - 1});
                dinnerFrames.add(new int[]{this.getSegmentNum(new TimeFrame(times[0], dinnerTimeArr[0]), duration), this.getSegmentNum(new TimeFrame(times[0], dinnerTimeArr[1]), duration) - 1});

                /// 设置每个时间段所需要的人数
                int[] employeesRequiredArr = new int[segmentNum];
                // 设置正常班所需的人数
                for (int j = openStoreIndex + 1; j < closeStoreIndex; j++) {
                    int segmentStartMinute = j * duration + startMinute;
                    int segmentEndMinute = (j + 1) * duration + startMinute;
                    // 时间段乘以客流量的总和
                    double totalPassengerFlow = 0;
                    for (PassengerFlowVo passengerFlowVo : dateVo.getPassengerFlowVoList()) {
                        int passengerStartTime = getTotalMinuteNum(parseStrToTime(passengerFlowVo.getStartTime()));
                        int passengerEndTime = getTotalMinuteNum(parseStrToTime(passengerFlowVo.getEndTime()));
                        totalPassengerFlow += getIntersectMinute(segmentStartMinute, segmentEndMinute, passengerStartTime, passengerEndTime) * passengerFlowVo.getPassengerFlow();
                    }
                    totalPassengerFlow /= duration;
                    if (totalPassengerFlow == 0) {
                        //--if--客流量为零，设置为值班人数
                        employeesRequiredArr[j] = staffNum * (dateVo.getIsNeedWork() == true ? 1 : 0);
                    } else {
                        employeesRequiredArr[j] = (int) (Math.ceil(totalPassengerFlow / normalVariableParam) * (dateVo.getIsNeedWork() == true ? 1 : 0));
                    }
                }
                // 设置开店所需人数
                for (int j = 0; j <= openStoreIndex; j++) {
                    employeesRequiredArr[j] = (int) (Math.ceil(schedulingRuleVo.getStoreSize().floatValue() / openStoreVariableParam) * (dateVo.getIsNeedWork() == true ? 1 : 0));
                }
                // 设置关店所需人数
                for (int j = closeStoreIndex; j < segmentNum; j++) {
                    employeesRequiredArr[j] = (int) (Math.ceil(schedulingRuleVo.getStoreSize().floatValue() / closeStoreVariableParam1 + closeStoreVariableParam2) * (dateVo.getIsNeedWork() == true ? 1 : 0));
                }
                if (dateVo.getIsNeedWork() == true) {
                    employeesRequiredArrEachDay.add(employeesRequiredArr);
                } else {
                    employeesRequiredArrEachDay.add(null);
                }
            }
            instance.setWeekArr(weekArr);
            instance.setTimeFramesEachDay(timeFramesEachDay);
            instance.setDoubleShiftTimeFramesEachDay(doubleShiftTimeFramesEachDay);
            instance.setEmployeesRequiredArrEachDay(employeesRequiredArrEachDay);
            instance.setLunchFrames(lunchFrames);
            instance.setDinnerFrames(dinnerFrames);
        }
    }

    /**
     * 比较两个日期先更后，date1更后返回1，相同返回0，否则返回-1
     *
     * @param date1 格式:2023/3/10
     */
    private int dateStrCompare(String date1, String date2) {
        String[] split1 = date1.split("/");
        String[] split2 = date2.split("/");

        if (Integer.parseInt(split1[0]) > Integer.parseInt(split2[0])) {
            return 1;
        } else if (Integer.parseInt(split1[0]) < Integer.parseInt(split2[0])) {
            return -1;
        }
        if (Integer.parseInt(split1[1]) > Integer.parseInt(split2[1])) {
            return 1;
        } else if (Integer.parseInt(split1[1]) < Integer.parseInt(split2[1])) {
            return -1;
        }
        if (Integer.parseInt(split1[2]) > Integer.parseInt(split2[2])) {
            return 1;
        } else if (Integer.parseInt(split1[2]) < Integer.parseInt(split2[2])) {
            return -1;
        }
        return 0;
    }

    /**
     * 获取两根线段的重叠长度
     */
    private int getIntersectMinute(int start1, int end1, int start2, int end2) {
        int line1Max;
        int line1Min;
        int line2Max;
        int line2Min;

        if ((start1 + end1) / 2 <= (start2 + end2) / 2) {
            line1Max = end1;
            line1Min = start1;
            line2Max = end2;
            line2Min = start2;
        } else {
            line1Max = end2;
            line1Min = start2;
            line2Max = end1;
            line2Min = start1;
        }

        if (line2Min >= line1Max) {
            return 0;
        } else if (line2Min >= line1Min && line2Max >= line1Max) {
            return line1Max - line2Min;
        } else if (line2Min >= line1Min && line2Max <= line1Max) {
            return line2Max - line2Min;
        } else if (line2Min <= line1Min && line2Max >= line1Max) {
            return line1Max - line1Min;
        }
        return 0;
    }

    /**
     * 将start加上duration分钟，返回新的time
     *
     */
    private Time getTimeAfterAdd(Time start, int duration) {
        int endMinute = getTotalMinuteNum(start) + duration;
        return new Time(endMinute / 60, endMinute % 60);
    }

    /**
     * 判断一天是星期几
     *
     * @param date
     */
    private int getWeek(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("EEEE");
        String week = sdf.format(date);
        int num = -1;
        switch (week) {
            case "星期一":
                num = 1;
                break;
            case "星期二":
                num = 2;
                break;
            case "星期三":
                num = 3;
                break;
            case "星期四":
                num = 4;
                break;
            case "星期五":
                num = 5;
                break;
            case "星期六":
                num = 6;
                break;
            case "星期日":
                num = 7;
                break;
            case "Monday":
                num = 1;
                break;
            case "Tuesday":
                num = 2;
                break;
            case "Wednesday":
                num = 3;
                break;
            case "Thursday":
                num = 4;
                break;
            case "Friday":
                num = 5;
                break;
            case "Saturday":
                num = 6;
                break;
            case "Sunday":
                num = 7;
                break;
            default:
                break;
        }
        if (num == -1) {
            throw new RuntimeException("获取星期几不合法，week：" + week);
        }
        return num;
    }

    /**
     * 解析门店工作时间段
     */
    private Time[] parseStoreWorkTimeFrame(String storeWorkTimeFrame, String key) {
        JSONObject storeWorkTimeFrameObject = JSON.parseObject(storeWorkTimeFrame);
        JSONArray arr = JSON.parseArray(JSON.toJSONString(storeWorkTimeFrameObject.get(key)));
        return getTimes(arr);
    }

    private Time[] getTimes(JSONArray arr) {
        Time startTime = parseStrToTime(formatTime((String) arr.get(0)));
        Time endTime = parseStrToTime(formatTime((String) arr.get(1)));
        return new Time[]{startTime, endTime};
    }

    /**
     * 解析时间字符串为时间类型 8:00
     */
    private Time parseStrToTime(String formatTime) {
        String[] split = formatTime.split(":");
        return new Time(Integer.parseInt(split[0]), Integer.parseInt(split[1]));
    }

    /**
     * 将国际时间格式：yyyy-MM-dd'T'HH:mm:ss.S'Z' 格式化 为北京时间（时：分）
     */
    private String formatTime(String raw) {
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S'Z'");
        Date dateTime = null;
        try {
            dateTime = sdf1.parse(raw);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        SimpleDateFormat sdf2 = new SimpleDateFormat("H:mm");
        String format = sdf2.format(dateTime);
        //将时间改为东八区时间，即将小时数+8
        String[] split = format.split(":");
        int hour = (Integer.parseInt(split[0]) + 8) % 24;
        String time = hour / 10 > 0 ? hour + ":" + split[1] : "0" + hour + ":" + split[1];
        return time;
    }

    /**
     * 计算时间段数
     */
    private int getSegmentNum(Time time, int duration) {
        int totalMinuteNum = getTotalMinuteNum(time);
        return totalMinuteNum / duration;
    }

    /**
     * 计算Time有多少分钟
     */
    private int getTotalMinuteNum(Time time) {
        return time.getHour() * 60 + time.getMinute();
    }

    /**
     * 计算时间段数
     */
    private int getSegmentNum(TimeFrame timeFrame, int duration) {
        int latestTotalMinuteNum = getTotalMinuteNum(timeFrame.getLatestTime());
        int earliestTotalMinuteNum = getTotalMinuteNum(timeFrame.getEarliestTime());
        return (latestTotalMinuteNum - earliestTotalMinuteNum) / duration;
    }

}
