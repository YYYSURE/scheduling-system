package org.example.controller.employee;

import org.example.entity.User;
import org.example.enums.ResultCodeEnum;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.example.service.UserService;
import org.example.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;


// TODO:
@RestController
@RequestMapping("/system/login")
public class EmployeeController {
    @Autowired
    private UserService userService;
    @Autowired
    private EmployeeService employeeService;

    /**
     * 获取员工信息
     *
     * @return
     */
    @GetMapping("/info")
    public Result info(@RequestParam("token") String token) {
        if (token == null || StringUtils.isEmpty(token)) {
            return Result.error(ResultCodeEnum.ARGUMENT_VALID_ERROR.getCode(), "传入token为空，请注意");
        }
        //获取用户名
        String username = JwtUtil.getUsername(token);
        //根据用户名来获取用户信息
        User user = employeeService.getByName(username);

        return Result.ok().addData("data", user);
    }

    /**
     * 修改员工信息
     * @return
     */
    @PostMapping("/update")
    public Result update(@RequestBody User user) {
        employeeService.updateById(user);
        return Result.ok();
    }

    /**
     * 查看排班情况
     * @return
     */
    // TODO:
    @GetMapping("/Scheduling")
    public Result Scheduling(@RequestParam("token") String token) {
        if (token == null || StringUtils.isEmpty(token)) {
            return Result.error(ResultCodeEnum.ARGUMENT_VALID_ERROR.getCode(), "传入token为空，请注意");
        }
        //获取用户名
        String username = JwtUtil.getUsername(token);

        //根据用户名来获取用户排班情况
        // User user = employeeService.getScheduling(username);

        // return Result.ok().addData("data", user);

    }
    /**
     * 提交调整排班申请
     * @return
     */
    // TODO:
    @PostMapping("/adjustScheduling")
    public Result adjustScheduling() {
        //
        employeeService.adjustScheduling();
        return Result.ok();
    }



}
