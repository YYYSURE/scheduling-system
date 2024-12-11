package org.example.intelligent_scheduling_server.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.*;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.dao.SchedulingShiftDao;
import org.example.intelligent_scheduling_server.service.SchedulingDateService;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.intelligent_scheduling_server.service.ShiftUserService;
import org.example.result.Result;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.utils.Query;
import org.example.vo.shiftScheduling.GanttShiftVo;
import org.example.vo.shiftScheduling.GanttStatisticsVo;
import org.example.vo.shiftScheduling.WeekViewShiftVo;
import org.example.vo.shiftScheduling.WeekViewVo;
import org.example.vo.system.UserInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.Collectors;


@Service("schedulingShiftService")
public class SchedulingShiftServiceImpl extends ServiceImpl<SchedulingShiftDao, SchedulingShift> implements SchedulingShiftService {
    @Autowired
    private ShiftUserService shiftUserService;
    @Autowired
    private SchedulingDateService dateService;
    @Autowired
    private SchedulingShiftService shiftService;
    @Autowired
    private ThreadPoolExecutor executor;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<SchedulingShift> page = this.page(
                new Query<SchedulingShift>().getPage(params),
                new QueryWrapper<SchedulingShift>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<Long> listDateIdByPositionIdList(List<Long> positionIdList, List<Long> curMonthDateList) {
        //根据职位id查询所涉及的班次集合
        List<Long> shiftIdList = shiftUserService.list(new QueryWrapper<ShiftUser>().select("DISTINCT shift_id").in("position_id", positionIdList)).stream().map(item -> {
            return item.getShiftId();
        }).collect(Collectors.toList());
        List<Long> dateIdList = null;
        if (shiftIdList.size() > 0 && curMonthDateList.size() > 0) {
            //查询这些班次所对应的Date
            dateIdList = baseMapper.selectList(new QueryWrapper<SchedulingShift>().select("DISTINCT scheduling_date_id").
                    in("id", shiftIdList).
                    in("scheduling_date_id", curMonthDateList)
            ).stream().map(item -> {
                return item.getSchedulingDateId();
            }).collect(Collectors.toList());
        }

        return dateIdList;
    }

    @Override
    public List<Long> listDateIdByUserIdList(List<Long> userIdList, List<Long> curMonthDateList) {
        //根据用户id查询所涉及的班次集合
        List<Long> shiftIdList = shiftUserService.list(new QueryWrapper<ShiftUser>().select("DISTINCT shift_id").in("user_id", userIdList)).stream().map(item -> {
            return item.getShiftId();
        }).collect(Collectors.toList());
        List<Long> dateIdList = new ArrayList<>();
        if (shiftIdList.size() > 0 && curMonthDateList.size() > 0) {
            //查询这些班次所对应的Date
            dateIdList = baseMapper.selectList(new QueryWrapper<SchedulingShift>().select("DISTINCT scheduling_date_id").
                    in("id", shiftIdList).
                    in("scheduling_date_id", curMonthDateList)
            ).stream().map(item -> {
                return item.getSchedulingDateId();
            }).collect(Collectors.toList());
        }

        return dateIdList;
    }

    @Override
    public List<SchedulingShift> listShiftIdOfShift(Date shiftStartDate, Date shiftEndDate, Long storeId) {

        return baseMapper.listShiftIdOfShift(shiftStartDate, shiftEndDate, storeId);
    }

    /**
     * 查询出有未分配班次的 date id
     *
     * @param curMonthDateIdList
     * @return
     */
    @Override
    public List<Long> listDateIdWithUnAssignedShifts(List<Long> curMonthDateIdList) {
        List<Long> dateIdListWithUnAssignedShifts = new ArrayList<>();
        //线程安全字典
        ConcurrentHashMap<Long, Boolean> dateAndHaveUnAssignedShiftsMap = new ConcurrentHashMap<>();
        CompletableFuture[] futureArr = new CompletableFuture[curMonthDateIdList.size()];
        for (int i = 0; i < curMonthDateIdList.size(); i++) {
            Long dateId = curMonthDateIdList.get(i);
            futureArr[i] = CompletableFuture.runAsync(() -> {
                SchedulingDate date = dateService.getById(dateId);
                if (date != null && date.getIsNeedWork() == 0) {
                    dateAndHaveUnAssignedShiftsMap.put(dateId, false);
                } else {
                    List<SchedulingShift> shiftList = shiftService.selectUnAssignedShiftsByDateId(dateId);
                    if (shiftList.size() > 0) {
                        dateAndHaveUnAssignedShiftsMap.put(dateId, true);
                    }
                }
            }, executor);
        }
        try {
            CompletableFuture.allOf(futureArr).get();
            for (Map.Entry<Long, Boolean> entry : dateAndHaveUnAssignedShiftsMap.entrySet()) {
                if (entry.getValue() == true) {
                    dateIdListWithUnAssignedShifts.add(entry.getKey());
                }
            }
            return dateIdListWithUnAssignedShifts;
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } catch (ExecutionException e) {
            throw new RuntimeException(e);
        }

        //直接sql查询
//        return baseMapper.listDateIdWithUnAssignedShifts(curMonthDateIdList);
    }

    /**
     * 查询一天没有分配的班次
     *
     * @param dateId
     * @return
     */
    @Override
    public List<SchedulingShift> selectUnAssignedShiftsByDateId(Long dateId) {
        return baseMapper.selectUnAssignedShiftsByDateId(dateId);
    }

    @Override
    public GanttStatisticsVo getGanttStatisticsVo(List<GanttShiftVo> schedulingShiftVoList) {
        GanttStatisticsVo ganttStatisticsVo = new GanttStatisticsVo();

        Integer totalShiftNum = 0;
        Long totalShiftMinute = 0L;
        Integer lunchPersonNum = 0;
        Integer dinnerPersonNum = 0;
        HashSet<String> staffIdSet = new HashSet<>();
        for (GanttShiftVo ganttShiftVo : schedulingShiftVoList) {
            if (ganttShiftVo.getMealType() == 0) {
                lunchPersonNum++;
            } else if (ganttShiftVo.getMealType() == 1) {
                dinnerPersonNum++;
            }
            if (ganttShiftVo.getParent() == null) {
                totalShiftNum++;
                if (!StringUtils.isEmpty(ganttShiftVo.getEid())) {
                    staffIdSet.add(ganttShiftVo.getEid());
                }
                totalShiftMinute += ganttShiftVo.getTotalMinute();
            }
        }
        ganttStatisticsVo.setTotalShiftNum(totalShiftNum);
        ganttStatisticsVo.setTotalShiftMinute(totalShiftMinute);
        ganttStatisticsVo.setStaffNum(staffIdSet.size());
        if (staffIdSet.size() == 0) {
            ganttStatisticsVo.setAverageWorkMinute(0.0);
        } else {
            ganttStatisticsVo.setAverageWorkMinute(totalShiftMinute * 1.0 / staffIdSet.size());
        }

        ganttStatisticsVo.setLunchPersonNum(lunchPersonNum);
        ganttStatisticsVo.setDinnerPersonNum(dinnerPersonNum);

        return ganttStatisticsVo;
    }

    @Override
    public Long getTotalShiftNumByEnterpriseId(Long enterpriseId, Date startDate, Date endDate) throws SSSException {
        //TODO
        /*Result r = enterpriseFeignService.listAllStoreByAppointEnterpriseId(enterpriseId);
        if (r.getCode() == ResultCodeEnum.SUCCESS.getCode().intValue()) {
            List<Store> storeEntityList = r.getData("list", new TypeReference<List<Store>>() {
            });
            long totalShiftNum = 0L;
            for (Store storeEntity : storeEntityList) {
                ////查询指定月份、指定门店的所有班次
                List<SchedulingDate> shiftDateEntityList = dateService.getWorkDayList(startDate, endDate, storeEntity.getId());
                List<Long> dateIdList = shiftDateEntityList.stream().map(SchedulingDate::getId).collect(Collectors.toList());
                ///查询出所有工作日的班次
                List<SchedulingShift> shiftEntityList = getShiftListOfDates(dateIdList);
                totalShiftNum += shiftEntityList.size();
            }
            return totalShiftNum;
        } else {
            throw new SSSException(ResultCodeEnum.Feign_ERROR);
        }*/
        return 0L;
    }

    @Override
    public Long getTotalShiftNumByStoreId(Long storeId, Date startDate, Date endDate) {
        long totalShiftNum = 0L;

        ////查询指定月份、指定门店的所有班次
        List<SchedulingDate> shiftDateEntityList = dateService.getWorkDayList(startDate, endDate, storeId);
        List<Long> dateIdList = shiftDateEntityList.stream().map(SchedulingDate::getId).collect(Collectors.toList());
        ///查询出所有工作日的班次
        List<SchedulingShift> shiftEntityList = getShiftListOfDates(dateIdList);
        totalShiftNum += shiftEntityList.size();

        return totalShiftNum;
    }

    @Override
    public List<SchedulingShift> getShiftListOfDates(List<Long> dateIdList) {
        QueryWrapper<SchedulingShift> shiftQueryWrapper = new QueryWrapper<SchedulingShift>().eq("is_deleted", 0);
        if (dateIdList.size() > 0) {
            shiftQueryWrapper.in("scheduling_date_id", dateIdList);
        } else {
            shiftQueryWrapper.eq("id", -1);
        }
        List<SchedulingShift> shiftEntityList = baseMapper.selectList(shiftQueryWrapper);
        return shiftEntityList;
    }

    /**
     * 查询某天某人的所有班次
     *
     * @param date
     * @param userId
     * @return
     */
    @Override
    public List<SchedulingShift> getOneDayShiftListOfUser(Date date, Long userId) {
        List<SchedulingShift> shiftEntityList = baseMapper.getOneDayShiftListOfUser(date, userId);
        //对班次按照上班时间升序排序
        Collections.sort(shiftEntityList, ((o1, o2) -> {
            long startTime1 = o1.getStartDate().getTime();
            long startTime2 = o2.getStartDate().getTime();
            return Long.compare(startTime1, startTime2);
        }));
        return shiftEntityList;
    }

    /**
     * 获取起止日期内，每天的班次集合
     *
     * @param startDate
     * @param endDate
     * @param userId
     * @return
     */
    @Override
    public List<List<SchedulingShift>> getWeekShiftListOfUser(Date startDate, Date endDate, Long userId) {
        List<List<SchedulingShift>> shiftListList = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            ///获取日期
            //ZoneId.systemDefault() 系统默认时区
            LocalDate localDate = startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate newLocalDate = localDate.plusDays(i);
            Date newDate = Date.from(newLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
            shiftListList.add(this.getOneDayShiftListOfUser(newDate, userId));
        }
        return shiftListList;
    }


    /**
     * 根据dateId查询出所有班次的信息
     *
     * @param dateId
     * @param positionIdList   只查询这些职位的员工所涉及的班次信息
     * @param searchUserIdList 只查询这些员工所设计的班次信息
     * @return
     */
    @Override
    public List<GanttShiftVo> listSchedulingShiftVoByDateId(Long dateId, List<Long> positionIdList, List<Long> searchUserIdList, Boolean isSearchUnAssignedShifts) {
        System.out.println("positionIdList:" + positionIdList);
        System.out.println("searchUserIdList:" + searchUserIdList);
//        System.out.println("positionIdList:" + positionIdList == null ? null : positionIdList.toString());
//        System.out.println("searchUserIdList:" + searchUserIdList == null ? null : searchUserIdList.toString());
        long start = System.currentTimeMillis();
        List<SchedulingShift> shiftEntityList;
        QueryWrapper<SchedulingShift> queryWrapper = new QueryWrapper<SchedulingShift>().eq("scheduling_date_id", dateId).orderByAsc("start_date");
        if (isSearchUnAssignedShifts == null || isSearchUnAssignedShifts == false) {
            if (positionIdList != null && positionIdList.size() > 0) {
                //根据职位集合筛选出所有shiftId
                List<ShiftUser> shiftUserEntityList = shiftUserService.list(new QueryWrapper<ShiftUser>().select("distinct shift_id").in("position_id", positionIdList));
                List<Long> shiftIdList = new LinkedList<>();
                for (ShiftUser shiftUserEntity : shiftUserEntityList) {
                    shiftIdList.add(shiftUserEntity.getShiftId());
                }
                queryWrapper.in("id", shiftIdList);
            }
            if (searchUserIdList != null && searchUserIdList.size() > 0) {
                //根据职位集合筛选出所有shiftId
                List<ShiftUser> shiftUserEntityList = shiftUserService.list(new QueryWrapper<ShiftUser>().select("distinct shift_id").in("user_id", searchUserIdList));
                List<Long> shiftIdList = new LinkedList<>();
                for (ShiftUser shiftUserEntity : shiftUserEntityList) {
                    shiftIdList.add(shiftUserEntity.getShiftId());
                }
                queryWrapper.in("id", shiftIdList);
            }
        } else {
            //--if--查询未分配的班次
            List<Long> shiftIdList = shiftUserService.listUnAssignedShiftIdByDateId(dateId);
//            System.out.println("isSearchUnAssignedShifts:" + isSearchUnAssignedShifts);
            if (shiftIdList.size() > 0) {
                queryWrapper.in("id", shiftIdList);
            }
        }
        shiftEntityList = baseMapper.selectList(queryWrapper);
//        System.out.println("listSchedulingShiftVoByDateId 1：" + (System.currentTimeMillis() - start) + "ms");

        ////封装班次信息数据
        Set<Long> totalUserIdList = new HashSet<>();
        Map<Long, List<Long>> shiftIdAndUserIdList = new HashMap<>();
        Set<Long> totalPositionIdSet = new HashSet<>();
        Map<Long, List<Long>> shiftIdAndPositionIdList = new HashMap<>();
        Map<Long, UserInfoVo> userIdAndUserInfoVoMap = new HashMap<>();
        Map<Long, Position> positionIdAndPositionMap = new HashMap<>();
        List<GanttShiftVo> shiftVoList = new ArrayList<>();
        CompletableFuture<Void>[] completableFutureArr = new CompletableFuture[shiftEntityList.size()];
        List<ShiftUser>[] shiftUserEntityListArr = new ArrayList[shiftEntityList.size()];
        // 1.获取之前的请求头数据
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        for (int i = 0; i < shiftEntityList.size(); i++) {
            SchedulingShift shift = shiftEntityList.get(i);
            int finalI = i;
            completableFutureArr[i] = CompletableFuture.runAsync(() -> {
                //2.每一个线程都共享之前的请求数据
                RequestContextHolder.setRequestAttributes(requestAttributes);
                shiftUserEntityListArr[finalI] = shiftUserService.list(
                        new QueryWrapper<ShiftUser>().
                                select("user_id", "position_id").
                                eq("shift_id", shift.getId()));
            }, executor);
        }
        try {
            CompletableFuture.allOf(completableFutureArr).get();
            for (int i = 0; i < shiftUserEntityListArr.length; i++) {
                SchedulingShift shift = shiftEntityList.get(i);
                GanttShiftVo schedulingShiftVo = new GanttShiftVo();
                schedulingShiftVo.setId(shift.getId() + "");
                BeanUtils.copyProperties(shift, schedulingShiftVo);

                ///查询排班相关员工信息和职位信息
                List<ShiftUser> shiftUserEntityList = shiftUserEntityListArr[i];
                List<Long> userIdList = new ArrayList<>();
                Set<Long> positionIdSet = new HashSet<>();
                for (ShiftUser shiftUser : shiftUserEntityList) {
                    userIdList.add(shiftUser.getUserId());
                    positionIdSet.add(shiftUser.getPositionId());
                }
                //查询相关员工信息
                schedulingShiftVo.setEid(org.example.utils.StringUtils.join(userIdList, ","));
                shiftIdAndUserIdList.put(shift.getId(), userIdList);
                totalUserIdList.addAll(userIdList);
                //查询相关职位信息
                shiftIdAndPositionIdList.put(shift.getId(), new ArrayList<>(positionIdSet));
                totalPositionIdSet.addAll(positionIdSet);

                ///处理午餐、晚餐时间
                if (shift.getMealType() == 0 || shift.getMealType() == 1) {
                    //--if--如果班次有安排了午餐或者晚餐，需要分离
                    Date mealStartDate = schedulingShiftVo.getMealStartDate();
                    Date mealEndDate = schedulingShiftVo.getMealEndDate();
                    Date startDate = schedulingShiftVo.getStartDate();
                    Date endDate = schedulingShiftVo.getEndDate();
                    if (startDate.getTime() < mealStartDate.getTime() && mealEndDate.getTime() < endDate.getTime()) {
                        //--if--如果吃饭时间在中间（分割出三段班次）
                        GanttShiftVo schedulingShiftVo0 = new GanttShiftVo();
                        GanttShiftVo schedulingShiftVo1 = new GanttShiftVo();
                        GanttShiftVo schedulingShiftVo2 = new GanttShiftVo();
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo0);
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo1);
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo2);
                        schedulingShiftVo0.setParent(schedulingShiftVo.getId());
                        schedulingShiftVo1.setParent(schedulingShiftVo.getId());
                        schedulingShiftVo2.setParent(schedulingShiftVo.getId());
                        //时间段设置
                        schedulingShiftVo0.setEndDate(mealStartDate);
                        schedulingShiftVo1.setStartDate(mealStartDate);
                        schedulingShiftVo1.setEndDate(mealEndDate);
                        schedulingShiftVo2.setStartDate(mealEndDate);
                        //颜色设置
                        schedulingShiftVo0.setPriority("1");
                        schedulingShiftVo1.setPriority(shift.getMealType() == 0 ? "2" : "3");
                        schedulingShiftVo2.setPriority("1");
                        //设置id
                        schedulingShiftVo0.setId(schedulingShiftVo.getId() + "|0");
                        schedulingShiftVo1.setId(schedulingShiftVo.getId() + "|1");
                        schedulingShiftVo2.setId(schedulingShiftVo.getId() + "|2");
                        //保存
                        schedulingShiftVo.setRender("split");
                        shiftVoList.add(schedulingShiftVo);
                        shiftVoList.add(schedulingShiftVo0);
                        shiftVoList.add(schedulingShiftVo1);
                        shiftVoList.add(schedulingShiftVo2);
                    } else if (startDate.getTime() == mealStartDate.getTime() && mealEndDate.getTime() < endDate.getTime()) {
                        //--if--如果吃饭时间和班次开始时间一致（分割出两段班次）
                        GanttShiftVo schedulingShiftVo0 = new GanttShiftVo();
                        GanttShiftVo schedulingShiftVo1 = new GanttShiftVo();
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo0);
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo1);
                        schedulingShiftVo0.setParent(schedulingShiftVo.getId());
                        schedulingShiftVo1.setParent(schedulingShiftVo.getId());
                        //时间段设置
                        schedulingShiftVo0.setEndDate(mealEndDate);
                        schedulingShiftVo1.setStartDate(mealEndDate);
                        //颜色设置
                        schedulingShiftVo0.setPriority(shift.getMealType() == 0 ? "2" : "3");
                        schedulingShiftVo1.setPriority("1");
                        //设置id
                        schedulingShiftVo0.setId(schedulingShiftVo.getId() + "|0");
                        schedulingShiftVo1.setId(schedulingShiftVo.getId() + "|1");
                        //保存
                        schedulingShiftVo.setRender("split");
                        shiftVoList.add(schedulingShiftVo);
                        shiftVoList.add(schedulingShiftVo0);
                        shiftVoList.add(schedulingShiftVo1);
                    } else if (startDate.getTime() > mealStartDate.getTime() && mealEndDate.getTime() == endDate.getTime()) {
                        //--if--如果吃饭时间和班次结束时间一致（分割出两段班次）
                        GanttShiftVo schedulingShiftVo0 = new GanttShiftVo();
                        GanttShiftVo schedulingShiftVo1 = new GanttShiftVo();
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo0);
                        BeanUtils.copyProperties(schedulingShiftVo, schedulingShiftVo1);
                        schedulingShiftVo0.setParent(schedulingShiftVo.getId());
                        schedulingShiftVo1.setParent(schedulingShiftVo.getId());
                        //时间段设置
                        schedulingShiftVo0.setEndDate(mealStartDate);
                        schedulingShiftVo1.setStartDate(mealStartDate);
                        //颜色设置
                        schedulingShiftVo0.setPriority("1");
                        schedulingShiftVo1.setPriority(shift.getMealType() == 0 ? "2" : "3");
                        //设置id
                        schedulingShiftVo0.setId(schedulingShiftVo.getId() + "|0");
                        schedulingShiftVo1.setId(schedulingShiftVo.getId() + "|1");
                        //保存
                        schedulingShiftVo.setRender("split");
                        shiftVoList.add(schedulingShiftVo);
                        shiftVoList.add(schedulingShiftVo0);
                        shiftVoList.add(schedulingShiftVo1);
                    } else if (startDate.getTime() == mealStartDate.getTime() && mealEndDate.getTime() == endDate.getTime()) {
                        //--if--如果吃饭时间和班次时间一致
                        schedulingShiftVo.setPriority(shift.getMealType() == 0 ? "2" : "3");
                        shiftVoList.add(schedulingShiftVo);
                    } else {

                    }
                } else {
                    schedulingShiftVo.setPriority("1");
                    shiftVoList.add(schedulingShiftVo);
                }
            }
//            System.out.println("listSchedulingShiftVoByDateId 2：" + (System.currentTimeMillis() - start) + "ms");

            ///调用远程服务查询员工的姓名
            System.out.println("totalUserIdList数量：" + totalUserIdList.size());
            if (totalUserIdList.size() > 0) {
                //TODO
                /*Result r = systemFeignService.listUserInfoVoByUserIds(new ArrayList<>(totalUserIdList));
                if (r.getCode() == ResultCodeEnum.SUCCESS.getCode().intValue()) {
                    List<UserInfoVo> userInfoVoList = r.getData("userInfoVoList", new TypeReference<List<UserInfoVo>>() {
                    });
                    if (userInfoVoList != null) {
                        for (UserInfoVo userInfoVo : userInfoVoList) {
                            userIdAndUserInfoVoMap.put(userInfoVo.getId(), userInfoVo);
                        }
                    }

                }*/
//                System.out.println("listSchedulingShiftVoByDateId 3：" + (System.currentTimeMillis() - start) + "ms");
            }

            ///调用远程服务查询员工的职位名称
            System.out.println("totalPositionIdSet数量：" + totalPositionIdSet.size());
            if (totalPositionIdSet.size() > 0) {
                //TODO
                /*Result r1 = enterpriseFeignService.listPositionListByPositionIdList(new ArrayList<>(totalPositionIdSet));
                if (r1.getCode() == ResultCodeEnum.SUCCESS.getCode().intValue()) {
                    for (Position position : r1.getData("positionEntityList", new TypeReference<List<Position>>() {
                    })) {
                        positionIdAndPositionMap.put(position.getId(), position);
                    }
                }*/
//                System.out.println("listSchedulingShiftVoByDateId 4：" + (System.currentTimeMillis() - start) + "ms");
            }

            ///存储班次中 员工的姓名和职位信息
            for (GanttShiftVo schedulingShiftVo : shiftVoList) {
                String shiftVoId = schedulingShiftVo.getId();
                if (schedulingShiftVo.getParent() != null) {
                    //--if--如果是子班次，将真正的id拿出来
                    shiftVoId = shiftVoId.split("\\|")[0];
                }
                //存储员工姓名
                List<String> staffNameList = new ArrayList<>();
                for (Long userId : shiftIdAndUserIdList.get(Long.parseLong(shiftVoId))) {
                    staffNameList.add(userIdAndUserInfoVoMap.get(userId).getName());
                }
                schedulingShiftVo.setStaffNameList(staffNameList);
                //存储员工职位
                List<String> positionNameList = new ArrayList<>();
                for (Long positionId : shiftIdAndPositionIdList.get(Long.parseLong(shiftVoId))) {
                    positionNameList.add(positionIdAndPositionMap.get(positionId).getName());
                }
                schedulingShiftVo.setPositionNameList(positionNameList);
            }
//            System.out.println("listSchedulingShiftVoByDateId 5：" + (System.currentTimeMillis() - start) + "ms");
//        System.out.println("shiftVoList:" + JSON.toJSONString(shiftVoList));

            ///对班次信息进行排序(按照开始时间升序排序，对于开始时间相同的，按照结束升序排序)
            Collections.sort(shiftVoList, ((o1, o2) -> {
                long startTime1 = o1.getStartDate().getTime();
                long endTime1 = o1.getEndDate().getTime();
                long startTime2 = o2.getStartDate().getTime();
                long endTime2 = o2.getEndDate().getTime();
                int compare1 = Long.compare(startTime1, startTime2);
                if (compare1 != 0) {
                    return compare1;
                } else {
                    int compare2 = Long.compare(endTime1, endTime2);
                    return compare2;
                }
            }));
            return shiftVoList;
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } catch (ExecutionException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    public List<SchedulingShift> listShiftBetweenStartDateAndEndDate(Date startDate, Date endDate, long storeId) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return baseMapper.listShiftBetweenStartDateAndEndDate(sdf.format(startDate), sdf.format(endDate), storeId);
    }

    /**
     * 查询周视图数据
     *
     * @param startDate      周视图的起始日期
     * @param endDate        周视图的结束日期
     * @param realStartIndex 真正要开始查询的索引
     * @param realEndIndex   真正要结束查询的索引
     * @param storeId
     * @param taskId
     * @return
     */
    @Override
    public WeekViewVo listWeekViewShiftVoBetweenStartDateAndEndDate(Date startDate, Date endDate,
                                                                    Integer realStartIndex, Integer realEndIndex,
                                                                    Long storeId, Long taskId, Map<Long, List<SchedulingShift>> userIdAndShiftList) {
        long start = System.currentTimeMillis();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        // 存储每一天的班次数据
        List<List<WeekViewShiftVo>> shiftListOfEachDay = new ArrayList<>();
        // 查询出两个日期之间的date
        List<SchedulingDate> dateEntityList = dateService.listDateBetweenStartDateAndEndDate(startDate, endDate, storeId, taskId);
        HashMap<String, SchedulingDate> strAndDateMap = new HashMap<>();
        HashMap<Integer, SchedulingDate> indexAndDateMap = new HashMap<>();
        Map<Long, Long> shiftIdAndUserIdMap = new HashMap<>();
        Map<Long, UserInfoVo> userIdAndUserInfoVoMap = new HashMap<>();
        boolean isExist = false;
        if (dateEntityList.size() > 0) {
            // --if-- 有效工作日，如果任务还没有发布的话，有效工作日的数量是0
            isExist = true;
            for (SchedulingDate schedulingDateEntity : dateEntityList) {
                strAndDateMap.put(sdf.format(schedulingDateEntity.getDate()), schedulingDateEntity);
            }

            // 查询出周视图两个日期之间的所有班次id
            List<Long> totalShiftIdList = baseMapper.listShiftIdBetweenStartDateAndEndDate(sdf.format(startDate), sdf.format(endDate), storeId, taskId);
            // 查询这些班次分配了哪些用户
            List<ShiftUser> shiftUserEntityList = new ArrayList<>();
            if (totalShiftIdList.size() > 0) {
                shiftUserEntityList.addAll(shiftUserService.list(new QueryWrapper<ShiftUser>().in("shift_id", totalShiftIdList)));
            }
//        System.out.println("listWeekViewShiftVoBetweenStartDateAndEndDate查询时间1："+(System.currentTimeMillis()-start)+"ms");
            // 查询出这些班次涉及的所有用户信息
            Set<Long> userIdSet = new HashSet<>();
            for (ShiftUser shiftUserEntity : shiftUserEntityList) {
                userIdSet.add(shiftUserEntity.getUserId());
                shiftIdAndUserIdMap.put(shiftUserEntity.getShiftId(), shiftUserEntity.getUserId());
            }
//        System.out.println("listWeekViewShiftVoBetweenStartDateAndEndDate查询时间2："+(System.currentTimeMillis()-start)+"ms");
            // 调用远程服务，根据id查询用户的具体信息
            //TODO
/*            Result r = systemFeignService.listUserInfoVoByUserIds(new ArrayList<>(userIdSet));
//        System.out.println("listWeekViewShiftVoBetweenStartDateAndEndDate查询时间3："+(System.currentTimeMillis()-start)+"ms");
            if (r.getCode() == ResultCodeEnum.SUCCESS.getCode().intValue()) {
                for (UserInfoVo userInfoVo : r.getData("userInfoVoList", new TypeReference<List<UserInfoVo>>() {
                })) {
                    userIdAndUserInfoVoMap.put(userInfoVo.getId(), userInfoVo);
                }
            }*/
//        System.out.println("listWeekViewShiftVoBetweenStartDateAndEndDate查询时间4："+(System.currentTimeMillis()-start)+"ms");
        }

        // 将起始日期Date类型转化为LocalDate类型，方便做日期相加
        LocalDate localDate = startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
        for (int i = 0; i < 7; i++) {
            /// 获取日期
            // ZoneId.systemDefault() 系统默认时区
            LocalDate newLocalDate = localDate.plusDays(i);
//            Date newDate = Date.from(newLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
//            SchedulingDate dateEntity = strAndDateMap.get(sdf.format(newDate));
            SchedulingDate dateEntity = strAndDateMap.get(newLocalDate.toString());
            if (dateEntity == null) {
                Date newDate = Date.from(newLocalDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
                dateEntity = new SchedulingDate();
                dateEntity.setDate(newDate);
            }
            indexAndDateMap.put(i, dateEntity);

            if (dateEntityList.size() > 0) {
                // realStartIndex、realEndIndex取值范围：[1,7]
                if ((realStartIndex != null && realEndIndex != null && !((realStartIndex - 1) <= i && i <= (realEndIndex - 1))) || dateEntity == null) {
                    // 如果存在真实日期范围的索引，且当前日期不在索引里面，就直接添加空数据
                    List<WeekViewShiftVo> shiftVoList = new ArrayList<>();
                    shiftListOfEachDay.add(shiftVoList);
                    continue;
                }

                /// 设置当天的排班信息及人员信息
                List<SchedulingShift> shiftList = baseMapper.selectList(new QueryWrapper<SchedulingShift>()
                        .eq("scheduling_date_id", dateEntity.getId())
                        .orderByAsc("start_date"));
                List<List<SchedulingShift>> shiftListGroup = this.groupShiftByStartDateAndEndDate(shiftList);
                List<WeekViewShiftVo> shiftVoList = new ArrayList<>();
                for (List<SchedulingShift> group : shiftListGroup) {
                    // 设置班次的基础信息
                    WeekViewShiftVo shiftVo = new WeekViewShiftVo();
                    Date shiftStartDate = group.get(0).getStartDate();
                    Date shiftEndDate = group.get(0).getEndDate();
                    shiftVo.setStartTime(sdf1.format(shiftStartDate));
                    shiftVo.setEndTime(sdf1.format(shiftEndDate));
                    shiftVo.setShiftMinute((shiftEndDate.getTime() - shiftStartDate.getTime()) / (1000 * 60));
                    if (group.get(0).getMealType() != 2) {
                        shiftVo.setMealType(group.get(0).getMealType());
                        shiftVo.setMealStartTime(sdf1.format(group.get(0).getMealStartDate()));
                        shiftVo.setMealEndTime(sdf1.format(group.get(0).getMealEndDate()));
                    }
                    // 给班次设置人员
                    List<UserInfoVo> userInfoVoList = new ArrayList<>();
                    for (SchedulingShift shift : group) {
                        Long userId = shiftIdAndUserIdMap.get(shift.getId());
                        if (!userIdAndShiftList.containsKey(userId)) {
                            List<SchedulingShift> shiftEntityList = new ArrayList<>();
                            shiftEntityList.add(shift);
                            if (userId != null) {
                                userIdAndShiftList.put(userId, shiftEntityList);
                            }
                        } else {
                            userIdAndShiftList.get(userId).add(shift);
                        }
                        userInfoVoList.add(userIdAndUserInfoVoMap.get(shiftIdAndUserIdMap.get(shift.getId())));
                    }
                    shiftVo.setUserInfoVoList(userInfoVoList);
                    shiftVoList.add(shiftVo);
                }
                shiftListOfEachDay.add(shiftVoList);
            } else {
                // 添加null，是为了方便前端的显示
                shiftListOfEachDay.add(null);
            }
        }

        if (dateEntityList.size() > 0) {
            // 排序每个用户对应的班次信息
            for (Map.Entry<Long, List<SchedulingShift>> entry : userIdAndShiftList.entrySet()) {
                List<SchedulingShift> shiftEntityList = entry.getValue();
                // 按照开始时间对班次升序排序
                Collections.sort(shiftEntityList, ((o1, o2) -> {
                    Long o1StartTime = o1.getStartDate().getTime();
                    Long o2StartTime = o2.getStartDate().getTime();
                    return Long.compare(o1StartTime, o2StartTime);
                }));
            }
        }

        WeekViewVo weekViewVo = new WeekViewVo(isExist, shiftListOfEachDay, indexAndDateMap);
        System.out.println("listWeekViewShiftVoBetweenStartDateAndEndDate查询时间：" + (System.currentTimeMillis() - start) + "ms");
        return weekViewVo;
//        System.out.println("listWeekViewShiftVoBetweenStartDateAndEndDate查询时间5："+(System.currentTimeMillis()-start)+"ms");
    }


    /**
     * 按照起始时间-结束时间 对班次进行分组并排序
     *
     * @param shiftList
     * @return 按照时间段分组之后的班次信息
     */
    private List<List<SchedulingShift>> groupShiftByStartDateAndEndDate(List<SchedulingShift> shiftList) {
        // 按照时间戳对班次进行分组
        Map<Long, List<SchedulingShift>> timeStampAndShiftListMap = new HashMap<>();
        List<List<SchedulingShift>> groupList = new ArrayList<>();

        for (SchedulingShift shift : shiftList) {
            long timeStamp = shift.getStartDate().getTime() + shift.getEndDate().getTime();
            if (!timeStampAndShiftListMap.containsKey(timeStamp)) {
                List<SchedulingShift> shiftEntityList = new ArrayList<>();
                shiftEntityList.add(shift);
                timeStampAndShiftListMap.put(timeStamp, shiftEntityList);
            } else {
                timeStampAndShiftListMap.get(timeStamp).add(shift);
            }
        }

        List<Long> keyList = new ArrayList<>(timeStampAndShiftListMap.keySet());
        // 升序排序
        Collections.sort(keyList);

        for (Long key : keyList) {
            groupList.add(timeStampAndShiftListMap.get(key));
        }

        return groupList;
    }

}