package org.example.controller.schedule;

import org.example.result.Result;
import org.example.vo.employee.EmployeeInfoVo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


// TODO:
@RestController
@RequestMapping("/schedule")
public class ScheduleController {
    // 获取周排班信息
    @GetMapping("/{storeId}&{date}")
    public Result getSchedule(@PathVariable String storeId, @PathVariable String date) {



        return Result.ok();
    }

    // 获取日排班信息
    @GetMapping("/day/{storeId}&{date}")
    public Result getDaySchedule(@PathVariable String storeId, @PathVariable String date) {
        return Result.ok();
    }
}
