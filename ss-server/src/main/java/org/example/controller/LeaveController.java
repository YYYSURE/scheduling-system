package org.example.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.entity.Leave;
import org.example.result.Result;
import org.example.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Leave")
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

    /**
     * 获取所有待审批的请假记录
     */
    @GetMapping("/trans")
    public Result getPendingLeaves() {
        QueryWrapper<Leave> wrapper = new QueryWrapper<>();
        wrapper.eq("state", 0); // 0表示待处理
        List<Leave> pendingLeaves = leaveService.list(wrapper);
        return Result.ok().addData("arr", pendingLeaves);
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