package org.example.controller.holiday;


import org.example.dto.HolidayDTO;
import org.example.entity.leaveRequest;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.example.vo.holiday.HolidayVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/Holiday")
public class HolidayController {
    @Autowired
    private EmployeeService employeeService;


    // 获取请假记录
    @GetMapping("/notes/{id}")
    public Result getNotes(@PathVariable int id) {
        System.out.println("id: " + id);

        List<leaveRequest> list = employeeService.getHoidayRecord(id);
        System.out.println(list);

        List<HolidayVO> list1 = new ArrayList<>();
        for (leaveRequest leave : list) {
           HolidayVO holidayVO = new HolidayVO();
            BeanUtils.copyProperties(leave, holidayVO);
            holidayVO.setType(leave.getLeaveType());
            holidayVO.setState(leave.getStatus());
            list1.add(holidayVO);
        }

        System.out.println(list1);

        return Result.ok().addData("data", list1);
    }


    // 提交请假申请
    @PostMapping("/Save")
    public Result saveHoliday(@RequestBody HolidayDTO holiday) {
        System.out.println("holiday: " + holiday);

        employeeService.saveHolidayRecord(holiday);

        return Result.ok();
    }
}
