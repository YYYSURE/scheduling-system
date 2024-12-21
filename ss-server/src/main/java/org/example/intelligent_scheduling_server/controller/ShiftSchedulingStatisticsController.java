package org.example.intelligent_scheduling_server.controller;

import com.alibaba.fastjson.TypeReference;
import org.example.intelligent_scheduling_server.service.ShiftSchedulingStatisticsService;
import org.example.result.Result;
import org.example.utils.JwtUtil;
import org.example.vo.statistics.enterpriseManager.*;
import org.example.vo.statistics.storeManager.AverageWorkTimeVo;
import org.example.vo.statistics.storeManager.MonthAverageStaffWorkTimeVo;
import org.example.vo.statistics.storeManager.MonthLunchNumAndDinnerNumVo;
import org.example.vo.statistics.storeManager.MonthShiftNumAndAllocationRateVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static org.example.constant.RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_ENTERPRISE_STATISTIC;
import static org.example.constant.RedisConstant.MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC;

//统计数据获取
@RestController
@RequestMapping("/scheduling/statistics")
public class ShiftSchedulingStatisticsController {
    @Autowired
    private ShiftSchedulingStatisticsService shiftSchedulingStatisticsService;

    /**
     * 获取指定月份的各门店的员工日均工作时长 员工日均工作时长 = ∑(当天班次总工作时长/当天参与工作的员工数量)/该月工作日数量
     *
     * @param year
     * @param month
     * @return
     */
    @GetMapping("/getStoreAverageStaffWorkTime")
    public Result getStoreAverageStaffWorkTime(@RequestParam("year") Integer year, @RequestParam("month") Integer month, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long enterpriseId = Long.parseLong(JwtUtil.getEnterpriseId(httpServletRequest.getHeader("token")));
        //TODO
/*        Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_ENTERPRISE_STATISTIC + "getStoreAverageStaffWorkTime:" + enterpriseId + "_" + year + "_" + month,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<StoreAverageStaffWorkTimeVo> storeAverageStaffWorkTimeVoList = shiftSchedulingStatisticsService.getStoreAverageStaffWorkTime(year, month, enterpriseId);
                    List<String> storeNameList = new ArrayList<>();
                    List<Double> averageStaffWorkTimeList = new ArrayList<>();
                    for (StoreAverageStaffWorkTimeVo storeAverageStaffWorkTimeVo : storeAverageStaffWorkTimeVoList) {
                        storeNameList.add(storeAverageStaffWorkTimeVo.getStoreName());
                        averageStaffWorkTimeList.add(storeAverageStaffWorkTimeVo.getAverageStaffWorkTime());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("storeNameList", storeNameList);
                    resultMap1.put("averageStaffWorkTimeList", averageStaffWorkTimeList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);*/

        System.out.println("getStoreAverageStaffWorkTime耗时：" + (System.currentTimeMillis() - start) + "ms");
        /*return Result.ok().addData("storeNameList", resultMap.get("storeNameList"))
                .addData("averageStaffWorkTimeList", resultMap.get("averageStaffWorkTimeList"));*/
        return Result.ok();
    }

    /**
     * 查询指定月份的各门店的日均班次数量及日均分配率
     *
     * @param year
     * @param month
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getStoreShiftNumAndAllocationRate")
    public Result getStoreShiftNumAndAllocationRate(@RequestParam("year") Integer year, @RequestParam("month") Integer month, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long enterpriseId = Long.parseLong(JwtUtil.getEnterpriseId(httpServletRequest.getHeader("token")));
        //TODO
/*        Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_ENTERPRISE_STATISTIC + "getStoreShiftNumAndAllocationRate:" + enterpriseId + "_" + year + "_" + month,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<StoreShiftNumAndAllocationRateVo> storeShiftNumAndAllocationRateVoList = shiftSchedulingStatisticsService.getStoreShiftNumAndAllocationRate(year, month, enterpriseId);
                    List<String> storeNameList = new ArrayList<>();
                    List<Double> averageShiftNumList = new ArrayList<>();
                    List<Double> averageShiftAllocationRateList = new ArrayList<>();
                    for (StoreShiftNumAndAllocationRateVo storeAverageStaffWorkTimeVo : storeShiftNumAndAllocationRateVoList) {
                        storeNameList.add(storeAverageStaffWorkTimeVo.getStoreName());
                        averageShiftNumList.add(storeAverageStaffWorkTimeVo.getAverageShiftNum());
                        averageShiftAllocationRateList.add(storeAverageStaffWorkTimeVo.getAverageShiftAllocationRate());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("storeNameList", storeNameList);
                    resultMap1.put("averageShiftNumList", averageShiftNumList);
                    resultMap1.put("averageShiftAllocationRateList", averageShiftAllocationRateList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getStoreShiftNumAndAllocationRate耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("storeNameList", resultMap.get("storeNameList"))
                .addData("averageShiftNumList", resultMap.get("averageShiftNumList"))
                .addData("averageShiftAllocationRateList", resultMap.get("averageShiftAllocationRateList"));*/
        return Result.ok();
    }

    /**
     * 获取指定月份各门店的日均客流量
     *
     * @param year
     * @param month
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getAveragePassengerFlow")
    public Result getAveragePassengerFlow(@RequestParam("year") Integer year, @RequestParam("month") Integer month, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long enterpriseId = Long.parseLong(JwtUtil.getEnterpriseId(httpServletRequest.getHeader("token")));
        //TODO
/*        Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_ENTERPRISE_STATISTIC + "getAveragePassengerFlow:" + enterpriseId + "_" + year + "_" + month,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<StoreAveragePassengerFlowVo> storeAveragePassengerFlowVoList = shiftSchedulingStatisticsService.getAveragePassengerFlow(year, month, enterpriseId);
                    List<String> storeNameList = new ArrayList<>();
                    List<Double> averagePassengerFlowList = new ArrayList<>();
                    for (StoreAveragePassengerFlowVo storeAveragePassengerFlowVo : storeAveragePassengerFlowVoList) {
                        storeNameList.add(storeAveragePassengerFlowVo.getStoreName());
                        averagePassengerFlowList.add(storeAveragePassengerFlowVo.getAveragePassengerFlow());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("storeNameList", storeNameList);
                    resultMap1.put("averagePassengerFlowList", averagePassengerFlowList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getAveragePassengerFlow耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("storeNameList", resultMap.get("storeNameList"))
                .addData("averagePassengerFlowList", resultMap.get("averagePassengerFlowList"));*/
        return Result.ok();
    }

    /**
     * 获取指定月份的午餐数量和晚餐数量
     *
     * @param year
     * @param month
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getTotalLunchNumAndDinnerNum")
    public Result getTotalLunchNumAndDinnerNum(@RequestParam("year") Integer year, @RequestParam("month") Integer month, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long enterpriseId = Long.parseLong(JwtUtil.getEnterpriseId(httpServletRequest.getHeader("token")));

        //TODO
        /*Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_ENTERPRISE_STATISTIC + "getTotalLunchNumAndDinnerNum:" + enterpriseId + "_" + year + "_" + month,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<TotalLunchNumAndDinnerNumVo> totalLunchNumAndDinnerNumVoList = shiftSchedulingStatisticsService.getTotalLunchNumAndDinnerNum(year, month, enterpriseId);
                    List<String> storeNameList = new ArrayList<>();
                    List<Long> totalLunchNumList = new ArrayList<>();
                    List<Long> totalDinnerNumList = new ArrayList<>();
                    for (TotalLunchNumAndDinnerNumVo storeAveragePassengerFlowVo : totalLunchNumAndDinnerNumVoList) {
                        storeNameList.add(storeAveragePassengerFlowVo.getStoreName());
                        totalLunchNumList.add(storeAveragePassengerFlowVo.getLunchNum());
                        totalDinnerNumList.add(storeAveragePassengerFlowVo.getDinnerNum());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("storeNameList", storeNameList);
                    resultMap1.put("totalLunchNumList", totalLunchNumList);
                    resultMap1.put("totalDinnerNumList", totalDinnerNumList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getTotalLunchNumAndDinnerNum耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("storeNameList", resultMap.get("storeNameList"))
                .addData("totalLunchNumList", resultMap.get("totalLunchNumList"))
                .addData("totalDinnerNumList", resultMap.get("totalDinnerNumList"));*/
        return Result.ok();
    }

    /**
     * 获取企业统计数据
     *
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getStatisticsVoByEnterpriseId")
    public Result getStatisticsVoByEnterpriseId(HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long enterpriseId = Long.parseLong(JwtUtil.getEnterpriseId(httpServletRequest.getHeader("token")));
        //TODO
/*        StatisticsVo statisticsVo = (StatisticsVo) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_ENTERPRISE_STATISTIC + "getStatisticsVoByEnterpriseId:" + enterpriseId,
                new TypeReference<StatisticsVo>() {
                },
                () -> shiftSchedulingStatisticsService.getStatisticsVoByEnterpriseId(enterpriseId),
                1,
                TimeUnit.DAYS);
        System.out.println("getStatisticsVoByEnterpriseId耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("statisticsVo", statisticsVo);*/
        return Result.ok();
    }

    /**
     * 获取门店统计数据
     *
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getStatisticsVoByStoreId")
    public Result getStatisticsVoByStoreId(HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));

        //TODO
//        StatisticsVo statisticsVo = (StatisticsVo) distributedCache.safeGet(
//                MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC + "getStatisticsVoByStoreId:" + storeId,
//                new TypeReference<StatisticsVo>() {
//                },
//                () -> shiftSchedulingStatisticsService.getStatisticsVoByStoreId(storeId),
//                1,
//                TimeUnit.DAYS);
//
//        System.out.println("getStatisticsVoByStoreId耗时：" + (System.currentTimeMillis() - start) + "ms");
//        return Result.ok().addData("statisticsVo", statisticsVo);
        return Result.ok();
    }

    /**
     * 获取当前门店指定年 各月份的员工日均工作时长 员工日均工作时长 = ∑(当天班次总工作时长/当天参与工作的员工数量)/该月工作日数量
     *
     * @param year
     * @return
     */
    @GetMapping("/getMonthAverageStaffWorkTime")
    public Result getMonthAverageStaffWorkTime(@RequestParam("year") Integer year, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));

        //TODO
        /*Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC + "getMonthAverageStaffWorkTime:" + storeId + "_" + year,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<MonthAverageStaffWorkTimeVo> storeAverageStaffWorkTimeVoList = shiftSchedulingStatisticsService.getMonthAverageStaffWorkTime(year, storeId);
                    List<String> monthNameList = new ArrayList<>();
                    List<Double> averageStaffWorkTimeList = new ArrayList<>();
                    for (MonthAverageStaffWorkTimeVo storeAverageStaffWorkTimeVo : storeAverageStaffWorkTimeVoList) {
                        monthNameList.add(storeAverageStaffWorkTimeVo.getMonthName());
                        averageStaffWorkTimeList.add(storeAverageStaffWorkTimeVo.getAverageStaffWorkTime());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("monthNameList", monthNameList);
                    resultMap1.put("averageStaffWorkTimeList", averageStaffWorkTimeList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getMonthAverageStaffWorkTime耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("monthNameList", resultMap.get("monthNameList"))
                .addData("averageStaffWorkTimeList", resultMap.get("averageStaffWorkTimeList"));*/
        return Result.ok();
    }

    /**
     * 获取指定年份 各月的午餐数量和晚餐数量
     *
     * @param year
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getMonthTotalLunchNumAndDinnerNum")
    public Result getMonthTotalLunchNumAndDinnerNum(@RequestParam("year") Integer year, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));


        //TODO
        /*Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC + "getMonthTotalLunchNumAndDinnerNum:" + storeId + "_" + year,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<MonthLunchNumAndDinnerNumVo> totalLunchNumAndDinnerNumVoList = shiftSchedulingStatisticsService.getMonthTotalLunchNumAndDinnerNum(year, storeId);
                    List<String> monthNameList = new ArrayList<>();
                    List<Long> totalLunchNumList = new ArrayList<>();
                    List<Long> totalDinnerNumList = new ArrayList<>();
                    for (MonthLunchNumAndDinnerNumVo monthLunchNumAndDinnerNumVo : totalLunchNumAndDinnerNumVoList) {
                        monthNameList.add(monthLunchNumAndDinnerNumVo.getMonthName());
                        totalLunchNumList.add(monthLunchNumAndDinnerNumVo.getLunchNum());
                        totalDinnerNumList.add(monthLunchNumAndDinnerNumVo.getDinnerNum());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("monthNameList", monthNameList);
                    resultMap1.put("averageStaffWorkTimeList", totalLunchNumList);
                    resultMap1.put("totalDinnerNumList", totalDinnerNumList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getMonthTotalLunchNumAndDinnerNum耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("monthNameList", resultMap.get("monthNameList"))
                .addData("totalLunchNumList", resultMap.get("totalLunchNumList"))
                .addData("totalDinnerNumList", resultMap.get("totalDinnerNumList"));*/
        return Result.ok();
    }

    /**
     * 查询指定年份，每月的各门店的日均班次数量及日均分配率
     *
     * @param year
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getMonthShiftNumAndAllocationRate")
    public Result getMonthShiftNumAndAllocationRate(@RequestParam("year") Integer year, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        //TODO
        /*Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC + "getMonthShiftNumAndAllocationRate:" + storeId + "_" + year,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<MonthShiftNumAndAllocationRateVo> storeShiftNumAndAllocationRateVoList = shiftSchedulingStatisticsService.getMonthShiftNumAndAllocationRate(year, storeId);
                    List<String> monthNameList = new ArrayList<>();
                    List<Double> averageShiftNumList = new ArrayList<>();
                    List<Double> averageShiftAllocationRateList = new ArrayList<>();
                    for (MonthShiftNumAndAllocationRateVo storeAverageStaffWorkTimeVo : storeShiftNumAndAllocationRateVoList) {
                        monthNameList.add(storeAverageStaffWorkTimeVo.getMonthName());
                        averageShiftNumList.add(storeAverageStaffWorkTimeVo.getAverageShiftNum());
                        averageShiftAllocationRateList.add(storeAverageStaffWorkTimeVo.getAverageShiftAllocationRate());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("monthNameList", monthNameList);
                    resultMap1.put("averageShiftNumList", averageShiftNumList);
                    resultMap1.put("averageShiftAllocationRateList", averageShiftAllocationRateList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getMonthShiftNumAndAllocationRate耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("monthNameList", resultMap.get("monthNameList"))
                .addData("averageShiftNumList", resultMap.get("averageShiftNumList"))
                .addData("averageShiftAllocationRateList", resultMap.get("averageShiftAllocationRateList"));*/
        return Result.ok();
    }

    /**
     * 获取指定月份 日均工作时间最长/最短的前 n 名员工
     *
     * @param year
     * @param month
     * @param httpServletRequest
     * @return
     */
    @GetMapping("/getUserWorkTime")
    @Cacheable(value = {MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC}, key = "#root.targetClass+'-'+#root.method.name+'-'+#root.args[0]+'-'+#root.args[1]+'-'+#root.args[2]+'-'+#root.args[3]", sync = true)
    public Result getUserWorkTime(@RequestParam("year") Integer year, @RequestParam("month") Integer month, @RequestParam("type") Integer type, @RequestParam("num") Integer num, HttpServletRequest httpServletRequest) {
        long start = System.currentTimeMillis();
        Long storeId = Long.parseLong(JwtUtil.getStoreId(httpServletRequest.getHeader("token")));
        //TODO
        /*Map<String, Object> resultMap = (Map<String, Object>) distributedCache.safeGet(
                MODULE_SHIFT_SCHEDULING_CALCULATE_STORE_STATISTIC + "getUserWorkTime:" + storeId + "_" + year,
                new TypeReference<Map<String, Object>>() {
                },
                () -> {
                    List<AverageWorkTimeVo> averageWorkTimeVoList = shiftSchedulingStatisticsService.getAverageUserWorkTime(year, month, storeId, type, num);
                    List<String> staffNameList = new ArrayList<>();
                    List<Double> averageWorkTimeList = new ArrayList<>();
                    for (AverageWorkTimeVo averageWorkTimeVo : averageWorkTimeVoList) {
                        staffNameList.add(averageWorkTimeVo.getStaffName());
                        averageWorkTimeList.add(averageWorkTimeVo.getAverageWorkTime());
                    }
                    Map<String, Object> resultMap1 = new HashMap<>();
                    resultMap1.put("monthNameList", staffNameList);
                    resultMap1.put("averageWorkTimeList", averageWorkTimeList);
                    return resultMap1;
                },
                1,
                TimeUnit.DAYS);

        System.out.println("getUserWorkTime耗时：" + (System.currentTimeMillis() - start) + "ms");
        return Result.ok().addData("staffNameList", resultMap.get("staffNameList")).addData("averageWorkTimeList", resultMap.get("averageWorkTimeList"));*/
        return Result.ok();
    }

}
