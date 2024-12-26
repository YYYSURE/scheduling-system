package org.example.controller.StoreAdmin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.entity.Employee;
import org.example.entity.leaveRequest;
import org.example.mapper.LeaveMapper;
import org.example.result.Result;
import org.example.service.EnterpriseAdmin_ManageService;
import org.example.service.LeaveService;
import org.example.vo.holiday.HolidayApprovalVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/Holiday")
public class LeaveController {

    @Autowired
    private LeaveService leaveService;
    @Autowired
    private LeaveMapper leaveMapper;
    @Autowired
    private EnterpriseAdmin_ManageService userService;

    /**
     * 获取用户的请假记录
     */
    @GetMapping("/trans/{storeId}")
    public Result getUserLeaveNotes(@PathVariable("storeId") Long storeId) {
        System.out.println("storeId:" + storeId);
        // 创建查询条件，获取属于指定 storeId 的 employee_id
        List<Long> employeeIds = userService.list(new QueryWrapper<Employee>()
                .select("id") // 选择 employee 的 id
                .eq("store_id", storeId) // 根据 store_id 过滤
        ).stream().map(Employee::getId).collect(Collectors.toList());

        // 如果没有找到对应的 employee_id，返回空列表
        if (employeeIds.isEmpty()) {
            return Result.ok().addData("leaveList", Collections.emptyList());
        }
        System.out.println(employeeIds);

        // 创建查询条件，查询 leave_request 表
        QueryWrapper<leaveRequest> wrapper = new QueryWrapper<>();
        wrapper.in("employee_id", employeeIds); // 根据 employee_id 过滤

        // 查询请假记录
        List<leaveRequest> leaveList = leaveService.list(wrapper);
        System.out.println("leaveList: " + leaveList);
        // 将 employeeName 添加到每个请假记录中
        for (leaveRequest leave : leaveList) {
            String employeeName = userService.getNameById((long) leave.getEmployeeId()); // 获取对应的 username
            System.out.println("employeeName: " + employeeName);
            leave.setEmployeeName(employeeName); // 假设 LeaveRequest 有 setEmployeeName 方法
        }
        System.out.println("leaveList: " + leaveList);


        return Result.ok().addData("leaveList", leaveList);
    }


    /**
     * 更新请假记录状态
     */
    @PostMapping("/Update/{id}&{status}")
    public Result updateLeaveStatus(@PathVariable("id") String id,
                                    @PathVariable("status") Long status ) {
        System.out.println("id: " + id);
        System.out.println("status: " + status);
        leaveMapper.updateStatusById(Long.parseLong(id), status);
        return Result.ok().addData("msg", "修改成功");
    }

}