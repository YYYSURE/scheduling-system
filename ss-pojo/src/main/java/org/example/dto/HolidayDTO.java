package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HolidayDTO {
    private int id;       // 员工 id
    private String type; // 请假类型：调休、病假、事假
    private String notes; // 请假理由
    private Integer state; // 请假状态：0-待批准，1-已批准，2-已驳回
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startTime; // 开始时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endTime; // 结束时间
}
