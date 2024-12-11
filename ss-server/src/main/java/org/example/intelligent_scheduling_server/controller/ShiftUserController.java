package org.example.intelligent_scheduling_server.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.dto.intelligent_scheduling_server.StaffWorkDto;
import org.example.entity.SchedulingShift;
import org.example.entity.ShiftUser;
import org.example.enums.ResultCodeEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.intelligent_scheduling_server.service.ShiftUserService;
import org.example.result.Result;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;


/**
 * 班次_用户中间表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-04 14:30:17
 */
@RestController
@RequestMapping("/scheduling/shiftuser")
public class ShiftUserController {
    @Autowired
    private ShiftUserService shiftUserService;
    @Autowired
    private SchedulingShiftService shiftService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public Result list(@RequestParam Map<String, Object> params) {
        PageUtils page = shiftUserService.queryPage(params);

        return Result.ok().addData("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id) {
        ShiftUser shiftUser = shiftUserService.getById(id);

        return Result.ok().addData("shiftUser", shiftUser);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public Result save(@RequestBody ShiftUser shiftUser) {
        shiftUserService.save(shiftUser);

        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public Result update(@RequestBody ShiftUser shiftUser) {
        shiftUserService.updateById(shiftUser);

        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public Result delete(@RequestBody Long[] ids) {
        shiftUserService.removeByIds(Arrays.asList(ids));

        return Result.ok();
    }

    /**
     * 查询指定时间段繁忙的用户id
     *
     * @param params
     * @return
     */
    @PostMapping("/listUserIdListIsBusy")
    public Result listUserIdIsBusy(@RequestBody Map<String, Object> params) {
//        System.out.println("shiftStartDate:" + params.get("shiftStartDate"));
//        System.out.println("shiftEndDate:" + params.get("shiftEndDate"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date shiftStartDate = null;
        Date shiftEndDate = null;
        try {
            shiftStartDate = sdf.parse(params.get("shiftStartDate").toString());
            shiftEndDate = sdf.parse(params.get("shiftEndDate").toString());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        Long storeId = Long.parseLong(params.get("storeId").toString());
        List<Long> userIdListIsBusy = shiftUserService.listUserIdIsBusy(shiftStartDate, shiftEndDate, storeId);
        return Result.ok().addData("userIdListIsBusy", userIdListIsBusy);
    }

    /**
     * 为班次替换人员或者追加人员
     *
     * @param params
     * @return
     */
    @PostMapping("/replaceOrAddMembersForShift")
    //修改班次的人员，影响班次
    //@CacheEvict(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, allEntries = true)
    public Result replaceOrAddMembersForShift(@RequestBody Map<String, Object> params, HttpServletRequest httpServletRequest) throws SSSException {

        Long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date shiftStartDate = null;
        Date shiftEndDate = null;
        try {
            shiftStartDate = sdf.parse(params.get("shiftStartDate").toString());
            shiftEndDate = sdf.parse(params.get("shiftEndDate").toString());
            System.out.println("replaceOrAddMembersForShift  shiftStartDate:" + params.get("shiftStartDate").toString());
            System.out.println("replaceOrAddMembersForShift  shiftEndDate:" + params.get("shiftEndDate").toString());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        //0：替换班次原本的员工 1：给班次追加员工
        Integer appointType = Integer.parseInt(params.get("appointType").toString());
        //员工列表
        String userIdListJson = JSON.toJSONString(params.get("userIdList"));
        //当前所指定的班次id
        Long shiftId = null;
        if (params.containsKey("shiftId")) {
            String shiftIdStr = params.get("shiftId").toString();
            if (shiftIdStr.contains("|")){
                shiftIdStr=shiftIdStr.split("\\|")[0];
            }
            shiftId = Long.parseLong(shiftIdStr);
        } else {
            throw new SSSException(ResultCodeEnum.FAIL.getCode(), "发请求时所携带的参数缺少shiftId");
        }
        List<Long> userIdList = JSON.parseObject(userIdListJson, new TypeReference<List<Long>>() {
        });
        if (userIdList.size() == 0) {
            throw new SSSException(ResultCodeEnum.FAIL.getCode(), "替换或追加的员工数量为0，请勾选员工");
        }
        //执行追加或替换操作
        shiftUserService.replaceOrAddMembersForShift(shiftStartDate, shiftEndDate, appointType, userIdList, storeId, shiftId);
        return Result.ok();
    }

    /**
     * 根据工作日查询出所有需要工作的员工id
     *
     * @param paramMap
     * @return
     */
    @PostMapping("/listUserIdByWorkDate")
//    @Cacheable(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, key = "#root.targetClass+'-'+#root.method.name+'-'+#root.args[0]", sync = true)
    public Result listUserIdByWorkDate(@RequestBody Map<String, Object> paramMap) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date workDate = null;
        try {
            workDate = sdf.parse(paramMap.get("date").toString());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        Long storeId = Long.parseLong(paramMap.get("storeId").toString());
        List<Long> userIdList = shiftUserService.listUserIdByWorkDate(workDate, storeId);
        return Result.ok().addData("userIdList", userIdList);
    }

    /**
     * 根据工作日查询出所有需要工作的员工id，及其所负责的班次
     *
     * @param paramMap
     * @return
     */
    @PostMapping("/listStaffWorkDtoByWorkDate")
//    @Cacheable(value = {RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_SHIFT}, key = "#root.targetClass+'-'+#root.method.name+'-'+#root.args[0]", sync = true)
    public Result listStaffWorkDtoByWorkDate(@RequestBody Map<String, Object> paramMap) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date workDate = null;
        try {
            workDate = sdf.parse(paramMap.get("date").toString());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        Long storeId = Long.parseLong(paramMap.get("storeId").toString());
        List<ShiftUser> shiftUserEntityList = shiftUserService.listStaffWorkDtoByWorkDate(workDate, storeId);
        List<StaffWorkDto> staffWorkDtoList = new ArrayList<>();
        Map<Long, List<Long>> userIdAndShiftUserList = new HashMap<>();
        for (ShiftUser shiftUserEntity : shiftUserEntityList) {
            if (!userIdAndShiftUserList.containsKey(shiftUserEntity.getUserId())) {
                List<Long> shiftIdList = new ArrayList<>();
                shiftIdList.add(shiftUserEntity.getShiftId());
                userIdAndShiftUserList.put(shiftUserEntity.getUserId(), shiftIdList);
            } else {
                userIdAndShiftUserList.get(shiftUserEntity.getUserId()).add(shiftUserEntity.getShiftId());
            }
        }
        for (Map.Entry<Long, List<Long>> shiftUser : userIdAndShiftUserList.entrySet()) {
            StaffWorkDto staffWorkDto = new StaffWorkDto();
            staffWorkDto.setUserId(shiftUser.getKey());
            List<Long> userIdList = shiftUser.getValue();
            List<SchedulingShift> shiftEntityList = shiftService.list(new QueryWrapper<SchedulingShift>().in("id", userIdList));
            staffWorkDto.setShiftEntityList(shiftEntityList);
            staffWorkDtoList.add(staffWorkDto);
        }
        return Result.ok().addData("staffWorkDtoList", staffWorkDtoList);
    }

    /**
     * 根据一个日期段内，所有需要工作的员工id
     *
     * @param paramMap
     * @return
     */
    @PostMapping("/listUserIdByDateSegment")
    public Result listUserIdByDateSegment(@RequestBody Map<String, Object> paramMap) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = sdf.parse(paramMap.get("startDate").toString());
            endDate = sdf.parse(paramMap.get("endDate").toString());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        Long storeId = Long.parseLong(paramMap.get("storeId").toString());
        Long taskId = null;
        if (paramMap.containsKey("taskId")) {
            taskId = Long.parseLong(paramMap.get("taskId").toString());
        }
        List<Long> userIdList = null;
        if (taskId == null) {
            userIdList = shiftUserService.listUserIdByDateSegment(startDate, endDate, storeId);
        } else {
            userIdList = shiftUserService.listUserIdByDateSegmentAndTaskId(startDate, endDate, storeId, taskId);
        }

        return Result.ok().addData("userIdList", userIdList);
    }


}
