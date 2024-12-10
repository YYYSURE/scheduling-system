package org.example.dto.intelligent_scheduling_server;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;
import org.example.entity.SchedulingShift;

import java.util.List;

@Data
public class StaffWorkDto {
    /**
     * 员工id
     */
    
    @JsonSerialize(using = ToStringSerializer.class)
private Long userId;
    /**
     * 员工所负责的班次
     */
    private List<SchedulingShift> shiftEntityList;
}
