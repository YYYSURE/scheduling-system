package org.example.dto.intelligent_scheduling_server;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.example.enums.AlgoEnum;

@Data
@AllArgsConstructor
public class AlgoGroupDto {
    private AlgoEnum.PhaseOne phaseOne;
    private AlgoEnum.PhaseTwo phaseTwo;
}