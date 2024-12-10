package org.example.dto.intelligent_scheduling;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ShiftPlanning {
    /**
     * 员工在员工数组中的索引
     **/
    int employeeIndex;
    /**
     * 班次
     **/
    Shift shift;
}
