package org.example.intelligent_scheduling_server.service.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.intelligent_scheduling_server.mapper.StoreFlowMapper;
import org.example.intelligent_scheduling_server.service.StoreFlowService;
import org.example.vo.scheduling_calculate_service.DateVo;
import org.example.vo.scheduling_calculate_service.PassengerFlowVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class StoreFlowServiceImpl implements StoreFlowService {
    @Autowired
    private StoreFlowMapper storeFlowMapper;

    @Override
    public List<DateVo> getFlowByTime(Long storeId, Date beginDate, Date endDate) {
        List<DateVo> flowList = new ArrayList<>();
        Map<String, List<PassengerFlowVo>> passengerFlowData = new HashMap<>();
        // 创建 ObjectMapper 实例
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // 使用 Calendar 来遍历日期
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(beginDate);

            // 遍历日期，从 beginDate 到 endDate
            while (!calendar.getTime().after(endDate)) {
                Date currentDate = calendar.getTime(); // 获取当前日期

                // 获取当前日期的年、月、日
                int year = calendar.get(Calendar.YEAR);
                int month = calendar.get(Calendar.MONTH) + 1; // 注意：月份是从0开始的，需要加1
                int day = calendar.get(Calendar.DAY_OF_MONTH);

                // 查询该日期的数据
                String flow = storeFlowMapper.queruByTime(storeId, year, month, day);
                List<PassengerFlowVo> tempData = objectMapper.readValue(
                        flow, new TypeReference<List<PassengerFlowVo>>() {}
                );

                // 处理数据
                processDataForSingleDay(tempData, passengerFlowData);
                // 将日期增加一天
                calendar.add(Calendar.DAY_OF_MONTH, 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 将 Map 中的数据转换为 DateVo 类型并返回
        passengerFlowData.forEach((date, flowListForDate) -> {
            DateVo dateVo = new DateVo();
            dateVo.setDate(date);
            dateVo.setPassengerFlowVoList(flowListForDate);
            dateVo.setIsNeedWork(true); // TODO 根据节假日表判断是否需要工作

            // 判断日期是工作日还是节假日
            //LocalDate localDate = LocalDate.parse(date); // 判断是否为节假日
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDate localDate = LocalDate.parse(date, formatter);
            DayOfWeek dayOfWeek = localDate.getDayOfWeek();

            // 根据判断设置工作时间
            if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
                // 周六、周日（节假日）：早10点到晚10点
                dateVo.setStartWorkTime("10:00");
                dateVo.setEndWorkTime("22:00");
            } else {
                // 工作日（周一到周五）：早9点到晚9点
                dateVo.setStartWorkTime("09:00");
                dateVo.setEndWorkTime("21:00");
            }

            flowList.add(dateVo);
        });

        return flowList;
    }

    // 用于处理某一天的数据
    private void processDataForSingleDay(List<PassengerFlowVo> flowData,
                                         Map<String, List<PassengerFlowVo>> passengerFlowData) {
        for (PassengerFlowVo passengerFlowVo : flowData) {
            String date = passengerFlowVo.getDate();
            if (!passengerFlowData.containsKey(date)) {
                passengerFlowData.put(date, new ArrayList<>());
            }
            passengerFlowData.get(date).add(passengerFlowVo);
        }
    }
}