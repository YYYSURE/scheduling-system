package org.example.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.dto.HolidayDTO;
import org.example.entity.Leave;
import org.example.result.Result;
import org.example.service.LeaveService;
import org.example.vo.holiday.HolidayApprovalVO;
import org.example.vo.holiday.HolidayVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.*;

@RestController
@RequestMapping("/Holiday")
public class LeaveController {

    @Autowired
    private LeaveService leaveService;

    /**
     * 获取用户的请假记录
     */
    @GetMapping("/notes")
    public Result getUserLeaveNotes(@RequestParam String email) {
        QueryWrapper<Leave> wrapper = new QueryWrapper<>();
        wrapper.eq("email", email);
        List<Leave> leaveList = leaveService.list(wrapper);
        return Result.ok().addData("leaveList", leaveList);
    }

//    /**
//     * 获取所有待审批的请假记录
//     */
//    @GetMapping("/trans")
//    public Result getPendingLeaves() {
//        QueryWrapper<Leave> wrapper = new QueryWrapper<>();
//        wrapper.eq("state", 0); // 0表示待处理
//        List<Leave> pendingLeaves = leaveService.list(wrapper);
//        return Result.ok().addData("arr", pendingLeaves);
//    }


    @GetMapping("/trans")
    public Result getPendingLeaves() {
        List<HolidayApprovalVO> pendingLeaves = new ArrayList<>();

        // 写死的数据
        HolidayApprovalVO leave1 = new HolidayApprovalVO();
        leave1.setType("病假");
        leave1.setName("张三");
        leave1.setTime("2023-10-01 至 2023-10-05");
        leave1.setStartTime("2023-10-01");
        leave1.setEndTime("2023-10-05");
        leave1.setState(0);
        pendingLeaves.add(leave1);

        HolidayApprovalVO leave2 = new HolidayApprovalVO();
        leave2.setType("事假");
        leave2.setName("张4");
        leave2.setTime("2023-10-10 至 2023-10-12");
        leave2.setStartTime("2023-10-10");
        leave2.setEndTime("2023-10-12");
        leave2.setState(1);
        pendingLeaves.add(leave2);

        HolidayApprovalVO leave3 = new HolidayApprovalVO();
        leave3.setType("调休");
        leave3.setName("张5");
        leave3.setTime("2023-10-15 至 2023-10-15");
        leave3.setStartTime("2023-10-15");
        leave3.setEndTime("2023-10-15");
        leave3.setState(1);
        pendingLeaves.add(leave3);

        return Result.ok().addData("data", pendingLeaves);
    }

    /**
     * 更新请假记录状态
     */
    @PostMapping("/Update")
    public Result updateLeaveStatus(@RequestBody LeaveUpdateRequest request) {
        //TODO

//        Leave leave = leaveService.getById(request.getLeave().getId());
//        if (leave != null) {
//            leave.setState(request.getLeave().getState());
//            leaveService.updateById(leave);
//            return Result.ok();
//        } else {
//            return Result.error().setMessage("请假记录未找到");
//        }
        return Result.ok();
    }

    // 内部类用于接收更新请求
    public static class LeaveUpdateRequest {
        private Leave leave;

        public Leave getLeave() {
            return leave;
        }

        public void setLeave(Leave leave) {
            this.leave = leave;
        }
    }
}