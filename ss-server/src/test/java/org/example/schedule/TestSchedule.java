package org.example.schedule;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.dto.ScheduleRuleDTO;
import org.example.dto.TimeData;
import org.example.entity.SchedulingRule;
import org.example.intelligent_scheduling_server.mapper.SchedulingRuleMapper;
import org.example.vo.ScheduleRuleVO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@SpringBootTest
public class TestSchedule {
    @Autowired
    private SchedulingRuleMapper schedulingRuleMapper;

    @Test
    public void TestGetSchduleWorkTime() {
        SchedulingRule scheduleRule = schedulingRuleMapper.getScheduleRule(1);

        String workTime = scheduleRule.getStoreWorkTimeFrame();
        System.out.println(workTime);
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            // 解析 JSON 数据到 Map 对象
            Map<String, List<String>> schedule = objectMapper.readValue(workTime, Map.class);

            // 打印解析后的数据
            for (Map.Entry<String, List<String>> entry : schedule.entrySet()) {
                System.out.println(entry.getKey() + ": " + String.join(", ", entry.getValue()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    @Test
    public void TestGetSchduleRule() {

        SchedulingRule scheduleRule = schedulingRuleMapper.getScheduleRule(1);
        ScheduleRuleVO scheduleRuleVO = new ScheduleRuleVO();

        scheduleRuleVO.setDayTime(scheduleRule.getMostWorkHourInOneDay());
        scheduleRuleVO.setTime(scheduleRule.getMostWorkHourInOneWeek());
        scheduleRuleVO.setMinTime(scheduleRule.getMinShiftMinute() / 60);
        scheduleRuleVO.setMaxTime(scheduleRule.getMaxShiftMinute() / 60);

        ObjectMapper objectMapper = new ObjectMapper();

        String lunchTime = scheduleRule.getLunchTimeRule();
        String dinnerTime = scheduleRule.getDinnerTimeRule();
        String workTime = scheduleRule.getStoreWorkTimeFrame();
        try {
            // 解析 JSON 数据到 Map 对象
            TimeData lunch = objectMapper.readValue(lunchTime, TimeData.class);
            TimeData dinner = objectMapper.readValue(dinnerTime, TimeData.class);

            Map<String, List<String>> schedule = objectMapper.readValue(workTime, Map.class);

            // 打印解析后的数据
            System.out.println("Time Frame: " + lunch.getTimeFrame().get(0) + " to " + lunch.getTimeFrame().get(1));
            System.out.println("Need Minute: " + lunch.getNeedMinute());

            System.out.println("Time Frame: " + dinner.getTimeFrame().get(0) + " to " + dinner.getTimeFrame().get(1));
            System.out.println("Need Minute: " + dinner.getNeedMinute());


            for (Map.Entry<String, List<String>> entry : schedule.entrySet()) {
                System.out.println(entry.getKey() + ": " + String.join(", ", entry.getValue()));
            }

            scheduleRuleVO.setLunchStartTime(lunch.getTimeFrame().get(0));
            scheduleRuleVO.setLunchEndTime(lunch.getTimeFrame().get(1));

            scheduleRuleVO.setDinnerStartTime(dinner.getTimeFrame().get(0));
            scheduleRuleVO.setDinnerEndTime(dinner.getTimeFrame().get(1));

            List<String> workTime1 = schedule.get("Mon");
            List<String> workTime2 = schedule.get("Sun");

            String workTime3 = workTime1.get(0) + "-" + workTime1.get(1);
            String workTime4 = workTime2.get(0) + "-" + workTime2.get(1);
            String workTime5 = "周一到周五: " + workTime3 + ", 周六到周日: " + workTime4;

            scheduleRuleVO.setWorkTime(workTime5);


        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println(scheduleRuleVO);

    }

    @Test
    public void TestModifyScheduleRule() {
        ScheduleRuleDTO scheduleRuleDTO = new ScheduleRuleDTO(4, 30, "11:30", "13:30", "17:00", "19:00", 2, 4, null, "09:00-21:00", "10:00-22:00");

        SchedulingRule schedulingRule = new SchedulingRule();
        schedulingRule.setStoreId(1L);

        String[] time1 =scheduleRuleDTO.getWorkTime1().split("-");
        String[] time2 = scheduleRuleDTO.getWorkTime2().split("-");

        String workTime = "{"
                + "\"Mon\":[\"" + time1[0] + "\",\"" + time1[1] + "\"],"
                + "\"Tue\":[\"" + time1[0] + "\",\"" + time1[1] + "\"],"
                + "\"Wed\":[\"" + time1[0] + "\",\"" + time1[1] + "\"],"
                + "\"Thur\":[\"" + time1[0] + "\",\"" + time1[1] + "\"],"
                + "\"Fri\":[\"" + time1[0] + "\",\"" + time1[1] + "\"],"
                + "\"Sat\":[\"" + time2[0] + "\",\"" + time2[1] + "\"],"
                + "\"Sun\":[\"" + time2[0] + "\",\"" + time2[1] + "\"]"
                + "}";


        schedulingRule.setStoreWorkTimeFrame(workTime);

        schedulingRule.setMostWorkHourInOneDay(BigDecimal.valueOf(scheduleRuleDTO.getDayTime()));
        schedulingRule.setMostWorkHourInOneWeek(BigDecimal.valueOf(scheduleRuleDTO.getTime()));
        schedulingRule.setMinShiftMinute(scheduleRuleDTO.getMinTime() * 60);
        schedulingRule.setMaxShiftMinute(scheduleRuleDTO.getMaxTime() * 60);
        schedulingRule.setRestMinute(scheduleRuleDTO.getMaxTime() * 60 - scheduleRuleDTO.getMinTime() * 60);
        schedulingRule.setMaximumContinuousWorkTime(BigDecimal.valueOf(240));
        schedulingRule.setOpenStoreRule(null);
        schedulingRule.setCloseStoreRule(null);
        schedulingRule.setNormalRule(null);
        schedulingRule.setNoPassengerRule(null);
        schedulingRule.setMinimumShiftNumInOneDay(3);
        schedulingRule.setNormalShiftRule(null);

        String lunchTime = "{"
                + "\"timeFrame\":[\"" + scheduleRuleDTO.getLunchStartTime() + "\",\"" + scheduleRuleDTO.getLunchEndTime() + "\"],"
                + "\"needMinute\":30"
                +"}";

        String dinnerTime = "{"
                + "\"timeFrame\":[\"" + scheduleRuleDTO.getDinnerStartTime() + "\",\"" + scheduleRuleDTO.getDinnerEndTime() + "\"],"
                + "\"needMinute\":30"
                +"}";

        schedulingRule.setLunchTimeRule(lunchTime);
        schedulingRule.setDinnerTimeRule(dinnerTime);

        schedulingRule.setRuleType(0);

        schedulingRuleMapper.update(schedulingRule, 1);



    }
}
