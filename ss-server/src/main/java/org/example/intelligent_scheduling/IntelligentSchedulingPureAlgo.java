package org.example.intelligent_scheduling;

import org.example.dto.intelligent_scheduling.Instance;
import org.example.dto.intelligent_scheduling.Shift;
import org.example.dto.intelligent_scheduling.Solution;
import org.example.dto.intelligent_scheduling.ShiftPlanning;
import org.example.enums.AlgoEnum;
import org.example.exception.SSSException;
import org.example.intelligent_scheduling.personal_scheduling.PS_EASA;
import org.example.intelligent_scheduling.personal_scheduling.PS_SAEA;
import org.example.intelligent_scheduling.shift_genetation.SG_GOA;

import java.io.IOException;
import java.util.*;

public class IntelligentSchedulingPureAlgo {
    public Solution solve(Instance instance, AlgoEnum.PhaseOne phaseOne, AlgoEnum.PhaseTwo phaseTwo, Map<String, Object> parameter) throws IOException, SSSException {
        // 初始化 solution
        Solution solution = new Solution();
        long phaseOneStartTime = System.currentTimeMillis();
        int totalMinute = 0;
        List<List<Shift>> shiftListList = new ArrayList<>();
        int[] shiftNumArr = new int[instance.getTimeFramesEachDay().size()];
        int[] shiftMinuteArr = new int[instance.getTimeFramesEachDay().size()];
        for (int i = 0; i < instance.getTimeFramesEachDay().size(); i++) {
            List<Shift> shiftList = new ArrayList<>();
            if (instance.getTimeFramesEachDay().get(i) != null) {
                if (phaseOne.equals(AlgoEnum.PhaseOne.GOA)) {
                    shiftList = new SG_GOA(instance.getTimeFramesEachDay().get(i), // 时间段集合，例如：TimeFrame{earliestTime = 8 h 0 min , latestTime = 8 h 30 min , duration = 30.0 min}
                            instance.getEmployeesRequiredArrEachDay().get(i), // 每个时间段需要的员工数：employeesRequiredArr.len = timeFrames.len
                            instance.getEmployees().length, // 员工数
                            instance.getMinC(), // 最小班次时间的时间段数，例如：以30分钟为一段，最小班次为2小时，那么这个值就是4
                            instance.getMaxC(), // 最大班次时间的时间段数，例如：以30分钟为一段，最大班次为4小时，那么这个值就是8
                            instance.getIntervalC(), // 以多少个段为基准去排班，例如：以30分钟为一段，如果这个值设置为2，就代表每个班次的时长必须是2*30=60分钟的整数倍
                            instance.getMinuteEachC(), // 以多少分钟为一段，设置为30，就是以30分钟为一段
                            instance.getLunchFrames().get(i), // 午餐时间范围，在timeFrames中的索引范围
                            instance.getDinnerFrames().get(i), // 晚餐时间范围，在timeFrames中的索引范围
                            instance.getLunchC(), // 午餐时间占多少段，例如：以30分钟为一段，这个值如果是1，就代表午餐时间为30分钟
                            instance.getDinnerC() // 晚餐时间占多少段，例如：以30分钟为一段，这个值如果是1，就代表晚餐时间为30分钟
                    ).solve();
                } else {
                    throw new RuntimeException("【班次生成阶段】无法识别的算法: " + phaseOne);
                }
                shiftList.sort(new Comparator<Shift>() {
                    @Override
                    public int compare(Shift o1, Shift o2) {
                        return Integer.compare(o1.getHead(), o2.getHead());
                    }
                });
            }
            int curDayTotalMinute = 0;
            for (int j = 0; j < shiftList.size(); j++) {
                curDayTotalMinute += shiftList.get(j).getTotalMinute();
                shiftList.get(j).setKey(i + "-" + j);
                shiftList.get(j).setDayIndex(i);
                shiftList.get(j).setShiftIndex(j);
            }
            totalMinute += curDayTotalMinute;
            shiftNumArr[i] = shiftList.size();
            shiftMinuteArr[i] = curDayTotalMinute;
            shiftListList.add(shiftList);
        }
        long phaseOneUseTime = System.currentTimeMillis() - phaseOneStartTime;
        solution.setPhaseOneUseTime(phaseOneUseTime);
        solution.setTotalMinute(totalMinute);
        solution.setShiftListList(Shift.copyListList(shiftListList));

        // 班次分配阶段
        long phaseTwoStartTime = System.currentTimeMillis();
        if (phaseTwo.equals(AlgoEnum.PhaseTwo.SAEA)) {
            new PS_SAEA(solution, instance.getRestC(), instance.getMaxWorkCEachDay(), instance.getMaxWorkCEachWeek(), instance.getMaxContinuousWorkC(), instance.getTimeFramesEachDay(), instance.getWeekArr(), instance.getEmployees(), instance.getPositionConstraintArr(), instance.getDoubleShiftTimeFramesEachDay(), shiftListList).solve();
        } else if (phaseTwo.equals(AlgoEnum.PhaseTwo.EASA)) {
            new PS_EASA(solution, instance.getRestC(), instance.getMaxWorkCEachDay(), instance.getMaxWorkCEachWeek(), instance.getMaxContinuousWorkC(), instance.getTimeFramesEachDay(), instance.getWeekArr(), instance.getEmployees(), instance.getPositionConstraintArr(), instance.getDoubleShiftTimeFramesEachDay(), shiftListList).solve();
        }else {
            throw new RuntimeException("【班次分配阶段】无法识别的算法: " + phaseOne);
        }
        long phaseTwoUseTime = System.currentTimeMillis() - phaseTwoStartTime;
        solution.setPhaseTwoUseTime(phaseTwoUseTime);
        // 输出结果
        int totalM = 0;
        HashSet<String> hashSet = new HashSet<>();
        solution.setUnabsorbedShiftListList(new ArrayList<>());
        for (int i = 0; i < solution.getShiftPlanningListList().size(); i++) {
            if (solution.getUnabsorbedShiftListList().size() <= i) {
                solution.getUnabsorbedShiftListList().add(new ArrayList<>());
            }
            int m = 0; // 已分配班次的时长
            for (ShiftPlanning shiftPlanning : solution.getShiftPlanningListList().get(i)) {
                m += shiftPlanning.getShift().getTotalMinute();
                if (!hashSet.add(shiftPlanning.getShift().getKey())) {
                    throw new RuntimeException("重复的班次: " + shiftPlanning.getShift());
                }
            }
            totalM += m;
        }
        // 识别未分配的班次
        int unabsorbedShiftTotalMinute = 0;
        for (int i = 0; i < solution.getShiftListList().size(); i++) {
            for (Shift shift : solution.getShiftListList().get(i)) {
                if (!hashSet.contains(shift.getKey())) {
                    unabsorbedShiftTotalMinute += shift.getTotalMinute();
                    solution.getUnabsorbedShiftListList().get(i).add(Shift.copy(shift));
                }
            }
        }
        solution.setTotalAssignedMinute(totalM);
        solution.setAllocationRatio(totalMinute == 0 ? 0 : (double) totalM / totalMinute);
        // 求解完毕，返回 solution
        return solution;
    }

}
