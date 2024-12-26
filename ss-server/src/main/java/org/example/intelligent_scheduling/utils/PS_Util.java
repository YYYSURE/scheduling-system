package org.example.intelligent_scheduling.utils;

import org.example.dto.intelligent_scheduling.*;

import java.util.*;

public class PS_Util {

    // 判断员工是否可以和该班次匹配
    public static boolean judgeFeasible(Shift shift, Employee employee, EmployeePlan employeePlan, List<int[]> doubleShiftTimeFramesEachDay, HashSet<String>[] positionConstraintArr,
                                        List<TimeFrame[]> timeFramesEachDay, int[] weekArr, int restC, int maxWorkCEachDay, int maxWorkCEachWeek, int maxContinuousWorkC) {
        int curDayIndex = shift.getDayIndex();
        // 1. 检验该员工是否满足该shift的职位约束
        int type = 1; // 默认和清扫阶段、收尾阶段没有交叉
        if (shift.getHead() < doubleShiftTimeFramesEachDay.get(curDayIndex)[0]) {
            type = 0; // 和清扫阶段有交叉
        } else if (shift.getHead() + shift.getLen() - 1 > doubleShiftTimeFramesEachDay.get(curDayIndex)[1]) {
            type = 2; // 和收尾阶段有交叉
        }
        if (positionConstraintArr != null && !positionConstraintArr[type].contains(employee.getPosition())) {
            // 不满足职位约束，直接返回false
//            System.out.println("不满足职位约束，直接返回false");
            return false;
        }
        // 2. 检验当前班次和员工已经被分配的班次有没有时间上的重叠 和 是否满足休息时间约束
        for (Shift employeePlanShift : employeePlan.shiftListList.get(curDayIndex)) {
            if (!(employeePlanShift.getHead() > shift.getHead() + shift.getLen() - 1 || shift.getHead() > employeePlanShift.getHead() + employeePlanShift.getLen() - 1)) {
//                System.out.println("班次时间重叠，返回false: " + employeePlanShift + " , " + shift);
                return false;
            } else {
                int diffC = 0;
                if (employeePlanShift.getHead() < shift.getHead()) {
                    diffC = shift.getHead() - (employeePlanShift.getHead() + employeePlanShift.getLen());
                } else {
                    diffC = employeePlanShift.getHead() - (shift.getHead() + shift.getLen());
                }
                if (diffC == 0 && (shift.getLen() + employeePlanShift.getLen() > 8)) {
                    //System.out.println("不满足休息时间约束，返回false");
                    return false;
                }
            }
        }
        // 3. 检验shift是否符合员工的偏好
        // 3.1 工作日偏好
        if (employee.getWorkDayPreference() != null && employee.getWorkDayPreference()[weekArr[curDayIndex] - 1] == 0) {
//            System.out.println("不满足工作日偏好，返回false");
            return false;
        }
        // 3.2 工作时间偏好
        if (employee.getWorkTimePreference() != null) {
            Time startTime = timeFramesEachDay.get(curDayIndex)[shift.getHead()].getEarliestTime();
            Time endTime = timeFramesEachDay.get(curDayIndex)[shift.getHead() + shift.getLen() - 1].getLatestTime();
            boolean b = false;
            for (TimeFrame timeFrame : employee.getWorkTimePreference()) {
                // 检查是否存在重叠
                if ((startTime.compareTo(timeFrame.getLatestTime()) <= 0 && endTime.compareTo(timeFrame.getEarliestTime()) >= 0)) {
                    b = true;  // 存在重叠
                    break;  // 一旦找到重叠就跳出循环
                }
            }
            if (!b) {
                // 如果没有找到任何重叠
                //System.out.println("不满足时长偏好");
                return false;
            }
        }
        // 3.3 班次时长偏好，每天时长不超过多少段
        int workTime = (shift.getLen() - (shift.getMealType() == null ? 0 : shift.getMealLen()));
        if (employeePlan.workTimeEachDay[curDayIndex] + workTime > maxWorkCEachDay) {
            //System.out.println("不满足每天工作时长偏好，返回false");
            return false;
        }
        if (employee.getShiftTimePreference_maxWorkTimeEachDay() != null && employeePlan.workTimeEachDay[curDayIndex] + workTime > employee.getShiftTimePreference_maxWorkTimeEachDay()) {
            //System.out.println("不满足每天工作时长偏好，返回false");
            return false;
        }
        // 3.4 班次时长偏好，每周时长不超过多少段
        int weekTime = 0;
        int head = Math.max(0, curDayIndex - 7 + 1);
        for (int i = head; i < timeFramesEachDay.size() && i < curDayIndex + 7; i++) {
            int curWorkTime = employeePlan.workTimeEachDay[i] + (i == curDayIndex ? workTime : 0);
            if (i < head + 7) {
                weekTime += curWorkTime;
            } else {
                weekTime = weekTime + curWorkTime - employeePlan.workTimeEachDay[i - 6];
            }
            if (employee.getShiftTimePreference_maxWorkTimeEachWeek() != null && weekTime > employee.getShiftTimePreference_maxWorkTimeEachWeek()) {
                //System.out.println("不满足每周工作时长偏好，返回false: " + weekTime+" , ShiftTimePreference_maxWorkTimeEachWeek: "+employee.getShiftTimePreference_maxWorkTimeEachWeek());
                return false;
            }
            if (weekTime > maxWorkCEachWeek) {
                //System.out.println("不满足每周工作时长偏好，返回false");
                return false;
            }
        }
        // 走到这就通过检验了！
        return true;
    }

    public static boolean judgeFeasibleForSecond(Shift shift, Employee employee, EmployeePlan employeePlan, List<int[]> doubleShiftTimeFramesEachDay, HashSet<String>[] positionConstraintArr, List<TimeFrame[]> timeFramesEachDay, int[] weekArr, int restC, int maxWorkCEachDay, int maxWorkCEachWeek, int maxContinuousWorkC) {
        int curDayIndex = shift.getDayIndex();
        // 1. 检验该员工是否满足该shift的职位约束
        int type = 1; // 默认和清扫阶段、收尾阶段没有交叉
        if (shift.getHead() < doubleShiftTimeFramesEachDay.get(curDayIndex)[0]) {
            type = 0; // 和清扫阶段有交叉
        } else if (shift.getHead() + shift.getLen() - 1 > doubleShiftTimeFramesEachDay.get(curDayIndex)[1]) {
            type = 2; // 和收尾阶段有交叉
        }
        if (positionConstraintArr != null && !positionConstraintArr[type].contains(employee.getPosition())) {
            // 不满足职位约束，直接返回false
//            System.out.println("不满足职位约束，直接返回false");
            return false;
        }
        // 2. 检验当前班次和员工已经被分配的班次有没有时间上的重叠 和 是否满足休息时间约束
        for (Shift employeePlanShift : employeePlan.shiftListList.get(curDayIndex)) {
            if (!(employeePlanShift.getHead() > shift.getHead() + shift.getLen() - 1 || shift.getHead() > employeePlanShift.getHead() + employeePlanShift.getLen() - 1) || (employeePlanShift.getHead() == shift.getHead()  && employeePlanShift.getLen() == shift.getLen())) {
//                System.out.println("班次时间重叠，返回false: " + employeePlanShift + " , " + shift);
                return false;
            } else {
                int diffC = 0;
                if (employeePlanShift.getHead() < shift.getHead()) {
                    diffC = shift.getHead() - (employeePlanShift.getHead() + employeePlanShift.getLen());
                } else {
                    diffC = employeePlanShift.getHead() - (shift.getHead() + shift.getLen());
                }
                if (diffC == 0 && (shift.getLen() + employeePlanShift.getLen() > 8)) {
                    //System.out.println("不满足休息时间约束，返回false");
                    return false;
                }
            }
        }
        // 3. 检验shift是否符合员工的偏好
        // 3.1 工作日偏好
        // 3. 检验工作日偏好：当天符合或者前后一天符合即可
        if (employee.getWorkDayPreference() != null) {
            int currentWeekDay = weekArr[curDayIndex] - 1;  // 0-based week index

            if (!((employee.getWorkDayPreference()[currentWeekDay] == 1) ||
                    (employee.getWorkDayPreference()[(currentWeekDay - 1 + 7) % 7] == 1)||
                    (employee.getWorkDayPreference()[(currentWeekDay + 1) % 7] == 1))) {
                return false;
            }
        }
        // 3.3 班次时长偏好，每天时长不超过多少段
        int workTime = (shift.getLen() - (shift.getMealType() == null ? 0 : shift.getMealLen()));
        if (employeePlan.workTimeEachDay[curDayIndex] + workTime > maxWorkCEachDay) {
            //System.out.println("不满足每天工作时长偏好，返回false");
            return false;
        }
        if (employee.getShiftTimePreference_maxWorkTimeEachDay() != null && employeePlan.workTimeEachDay[curDayIndex] + workTime > employee.getShiftTimePreference_maxWorkTimeEachDay()) {
            //System.out.println("不满足每天工作时长偏好，返回false");
            return false;
        }
        // 3.4 班次时长偏好，每周时长不超过多少段
        int weekTime = 0;
        int head = Math.max(0, curDayIndex - 7 + 1);
        for (int i = head; i < timeFramesEachDay.size() && i < curDayIndex + 7; i++) {
            int curWorkTime = employeePlan.workTimeEachDay[i] + (i == curDayIndex ? workTime : 0);
            if (i < head + 7) {
                weekTime += curWorkTime;
            } else {
                weekTime = weekTime + curWorkTime - employeePlan.workTimeEachDay[i - 6];
            }
            if (employee.getShiftTimePreference_maxWorkTimeEachWeek() != null && weekTime > employee.getShiftTimePreference_maxWorkTimeEachWeek()) {
                //System.out.println("不满足每周工作时长偏好，返回false: " + weekTime+" , ShiftTimePreference_maxWorkTimeEachWeek: "+employee.getShiftTimePreference_maxWorkTimeEachWeek());
                return false;
            }
            if (weekTime > maxWorkCEachWeek) {
                //System.out.println("不满足每周工作时长偏好，返回false");
                return false;
            }
        }
        // 走到这就通过检验了！
        return true;
    }

    public static boolean judgeFeasibleForThrid(Shift shift, Employee employee, EmployeePlan employeePlan, List<int[]> doubleShiftTimeFramesEachDay, HashSet<String>[] positionConstraintArr, List<TimeFrame[]> timeFramesEachDay, int[] weekArr, int restC, int maxWorkCEachDay, int maxWorkCEachWeek, int maxContinuousWorkC) {
        int curDayIndex = shift.getDayIndex();
        // 1. 检验该员工是否满足该shift的职位约束
        int type = 1; // 默认和清扫阶段、收尾阶段没有交叉
        if (shift.getHead() < doubleShiftTimeFramesEachDay.get(curDayIndex)[0]) {
            type = 0; // 和清扫阶段有交叉
        } else if (shift.getHead() + shift.getLen() - 1 > doubleShiftTimeFramesEachDay.get(curDayIndex)[1]) {
            type = 2; // 和收尾阶段有交叉
        }
        if (positionConstraintArr != null && !positionConstraintArr[type].contains(employee.getPosition())) {
            // 不满足职位约束，直接返回false
//            System.out.println("不满足职位约束，直接返回false");
            return false;
        }
        // 2. 检验当前班次和员工已经被分配的班次有没有时间上的重叠 和 是否满足休息时间约束
        for (Shift employeePlanShift : employeePlan.shiftListList.get(curDayIndex)) {
            if (!(employeePlanShift.getHead() > shift.getHead() + shift.getLen() - 1 || shift.getHead() > employeePlanShift.getHead() + employeePlanShift.getLen() - 1)) {
//                System.out.println("班次时间重叠，返回false: " + employeePlanShift + " , " + shift);
                return false;
            } else {
                int diffC = 0;
                if (employeePlanShift.getHead() < shift.getHead()) {
                    diffC = shift.getHead() - (employeePlanShift.getHead() + employeePlanShift.getLen());
                } else {
                    diffC = employeePlanShift.getHead() - (shift.getHead() + shift.getLen());
                }
                if (diffC == 0 && (shift.getLen() + employeePlanShift.getLen() > 8)) {
                    //System.out.println("不满足休息时间约束，返回false");
                    return false;
                }
            }
        }
        // 3. 检验shift是否符合员工的偏好
        // 3.3 班次时长偏好，每天时长不超过多少段
        int workTime = (shift.getLen() - (shift.getMealType() == null ? 0 : shift.getMealLen()));
        if (employeePlan.workTimeEachDay[curDayIndex] + workTime > maxWorkCEachDay) {
            //System.out.println("不满足每天工作时长偏好，返回false");
            return false;
        }
        if (employee.getShiftTimePreference_maxWorkTimeEachDay() != null && employeePlan.workTimeEachDay[curDayIndex] + workTime > employee.getShiftTimePreference_maxWorkTimeEachDay()) {
            //System.out.println("不满足每天工作时长偏好，返回false");
            return false;
        }
        // 3.4 班次时长偏好，每周时长不超过多少段
        int weekTime = 0;
        int head = Math.max(0, curDayIndex - 7 + 1);
        for (int i = head; i < timeFramesEachDay.size() && i < curDayIndex + 7; i++) {
            int curWorkTime = employeePlan.workTimeEachDay[i] + (i == curDayIndex ? workTime : 0);
            if (i < head + 7) {
                weekTime += curWorkTime;
            } else {
                weekTime = weekTime + curWorkTime - employeePlan.workTimeEachDay[i - 6];
            }
            if (employee.getShiftTimePreference_maxWorkTimeEachWeek() != null && weekTime > employee.getShiftTimePreference_maxWorkTimeEachWeek()) {
                //System.out.println("不满足每周工作时长偏好，返回false: " + weekTime+" , ShiftTimePreference_maxWorkTimeEachWeek: "+employee.getShiftTimePreference_maxWorkTimeEachWeek());
                return false;
            }
            if (weekTime > maxWorkCEachWeek) {
                //System.out.println("不满足每周工作时长偏好，返回false");
                return false;
            }
        }
        // 走到这就通过检验了！
        return true;
    }
    // 找到班次最多的一天Definitely索引
    public static int findMaxShiftNumDayIndex(short[] finishArr, List<List<Shift>> shiftListList) {
        int res = -1;
        for (int i = 0; i < shiftListList.size(); i++) {
            if (finishArr[i] == 0) {
                if (res == -1 || shiftListList.get(i).size() > shiftListList.get(res).size()) {
                    res = i;
                }
            }
        }
        return res;
    }

}
