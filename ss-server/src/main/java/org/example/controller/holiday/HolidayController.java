package org.example.controller.holiday;


import org.example.dto.HolidayDTO;
import org.example.result.Result;
import org.example.vo.holiday.HolidayVO;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/Holiday")
public class HolidayController {
    // 获取请假记录
    @GetMapping("/notes/{email}")
    public Result getNotes(@PathVariable String email) {

        HolidayVO holidayVO = new HolidayVO(
                "事假",
                "1",
                "2024-11-11",
                "2024-11-11",
                1
        );
        HolidayVO holidayVO2 = new HolidayVO(
                "事假",
                "1",
                "2024-11-11",
                "2024-11-11",
                1
        ); HolidayVO holidayVO3 = new HolidayVO(
                "事假",
                "1",
                "2024-11-11",
                "2024-11-11",
                1
        );

        List<HolidayVO> list = new ArrayList<>();
        list.add(holidayVO);
        list.add(holidayVO2);
        list.add(holidayVO3);

        return Result.ok().addData("data", list);
    }


    // 提交请假申请
    @PostMapping("/Save")
    public Result saveHoliday(@RequestBody HolidayDTO holiday) {
        // holidayService.saveHoliday(holiday);
        return Result.ok();
    }
}
