package org.example.intelligent_scheduling_server.service.impl;

import com.alibaba.fastjson.TypeReference;
import org.example.entity.SchedulingShift;
import org.example.entity.ShiftUser;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.feign.EnterpriseFeignService;
import org.example.intelligent_scheduling_server.dao.ShiftUserDao;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.intelligent_scheduling_server.service.ShiftUserService;
import org.example.result.Result;
import org.example.utils.PageUtils;
import org.example.utils.Query;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.springframework.transaction.annotation.Transactional;


@Service("shiftUserService")
public class ShiftUserServiceImpl extends ServiceImpl<ShiftUserDao, ShiftUser> implements ShiftUserService {

    @Autowired
    private SchedulingShiftService shiftService;
    @Autowired
    private ShiftUserService shiftUserService;
    @Autowired
    private EnterpriseFeignService enterpriseFeignService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ShiftUser> page = this.page(
                new Query<ShiftUser>().getPage(params),
                new QueryWrapper<ShiftUser>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<Long> listUserIdIsBusy(Date shiftStartDate, Date shiftEndDate, Long storeId) {
        return baseMapper.listUserIdIsBusy(shiftStartDate, shiftEndDate, storeId);
    }

    /**
     * 为班次替换人员或者追加人员
     *
     * @param shiftStartDate
     * @param shiftEndDate
     * @param appointType
     * @param userIdList
     * @param storeId
     * @param shiftId
     */
    @Override
    @Transactional
    public void replaceOrAddMembersForShift(Date shiftStartDate, Date shiftEndDate, Integer appointType, List<Long> userIdList, Long storeId, Long shiftId) throws SSSException {
        ///查询相同时间段，且对应于真实任务的所有班次数据
//        List<SchedulingShift> shiftList = shiftService.listShiftIdOfShift(shiftStartDate, shiftEndDate, storeId);
        SchedulingShift appointShift = shiftService.getById(shiftId);

        Result r = enterpriseFeignService.getUserIdAndPositionIdMapByUserIdList(userIdList);
        Map<Long, Long> userIdAndPositionIdMap = null;
        if (r.getCode() == ResultCodeEnum.SUCCESS.getCode().intValue()) {
            userIdAndPositionIdMap = r.getData("userIdAndPositionIdMap", new TypeReference<Map<Long, Long>>() {
            });
        }

        if (appointType == 0) {
            //--if--替换班次的员工
            if (userIdList.size() > 1) {
                throw new SSSException(ResultCodeEnum.FAIL.getCode(), "选择替换操作只能勾选一个员工，请重新勾选");
            }
            ///删除相关数据
            //修改shift_user数据
            ShiftUser shiftUser = shiftUserService.getOne(new QueryWrapper<ShiftUser>().eq("shift_id", shiftId));
            if (shiftUser == null) {
                //--if--班次为未分配班次
                ShiftUser shiftUserEntity = new ShiftUser();
                shiftUserEntity.setShiftId(shiftId);
                shiftUserEntity.setUserId(userIdList.get(0));
                shiftUserEntity.setPositionId(userIdAndPositionIdMap.get(userIdList.get(0)));
                shiftUserService.save(shiftUserEntity);
            } else {
                shiftUser.setUserId(userIdList.get(0));
                shiftUser.setPositionId(userIdAndPositionIdMap.get(userIdList.get(0)));
                shiftUserService.updateById(shiftUser);
            }

        } else {
            //--if--为班次追加员工
            ///增加新的班次
            List<SchedulingShift> newShiftList = new ArrayList<>();
            for (int i = 0; i < userIdList.size(); i++) {
                SchedulingShift shift = new SchedulingShift();
                BeanUtils.copyProperties(appointShift, shift);
                shift.setId(null);
                shift.setCreateTime(null);
                shift.setUpdateTime(null);
                newShiftList.add(shift);
            }
            shiftService.saveBatch(newShiftList);
            ///增加shift_user

            List<ShiftUser> shiftUserEntityList = new ArrayList<>();
            for (int i = 0; i < userIdList.size(); i++) {
                Long userId = userIdList.get(i);
                ShiftUser shiftUserEntity = new ShiftUser();
                shiftUserEntity.setShiftId(newShiftList.get(i).getId());
                shiftUserEntity.setUserId(userId);
                shiftUserEntity.setPositionId(userIdAndPositionIdMap.get(userId));
                shiftUserEntityList.add(shiftUserEntity);
            }
            shiftUserService.saveBatch(shiftUserEntityList);
        }

    }

    /**
     * 查询出任务相关的员工
     *
     * @param taskId
     * @return
     */
    @Override
    public List<Long> listRelevantUserId(Long taskId) {
        return baseMapper.listRelevantUserId(taskId);
    }

    /**
     * 根据工作日查询出所有需要工作的员工id
     *
     * @param workDate
     * @param storeId
     * @return
     */
    @Override
    public List<Long> listUserIdByWorkDate(Date workDate, Long storeId) {
        return baseMapper.listUserIdByWorkDate(workDate, storeId);
    }

    @Override
    public List<ShiftUser> listStaffWorkDtoByWorkDate(Date workDate, Long storeId) {
        return baseMapper.listStaffWorkDtoByWorkDate(workDate, storeId);
    }

    /**
     * 查询出班次对应的员工id集合
     *
     * @param shiftIdList
     * @return
     */
    @Override
    public List<Long> listUserIdByShiftIdList(List<Long> shiftIdList) {
        return baseMapper.listUserIdByShiftIdList(shiftIdList);
    }

    @Override
    public int getAssignedNum(List<Long> shiftIdList) {
        return baseMapper.getAssignedNum(shiftIdList);
    }

    @Override
    public List<Long> listUserIdByDateSegment(Date startDate, Date endDate, Long storeId) {
        return baseMapper.listUserIdByDateSegment(startDate, endDate, storeId);
    }

    @Override
    public List<Long> listUserIdByDateSegmentAndTaskId(Date startDate, Date endDate, Long storeId, Long taskId) {
        return baseMapper.listUserIdByDateSegmentAndTaskId(startDate, endDate, storeId, taskId);
    }

    @Override
    public List<Long> listUnAssignedShiftIdByDateId(Long dateId) {
        return baseMapper.listUnAssignedShiftIdByDateId(dateId);
    }


}