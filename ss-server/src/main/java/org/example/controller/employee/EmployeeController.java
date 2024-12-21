package org.example.controller.employee;

import org.example.dto.EmployeeInfoDTO;
import org.example.entity.User;
import org.example.enums.ResultCodeEnum;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.example.service.UserService;
import org.example.utils.JwtUtil;
import org.example.vo.employee.EmployeeInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/users")
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
    @GetMapping("/{email}")
    public Result info(@PathVariable String email) {
//        if (token == null || StringUtils.isEmpty(token)) {
//            return Result.error(ResultCodeEnum.ARGUMENT_VALID_ERROR.getCode(), "传入token为空，请注意");
//        }
//        //获取用户名
//        String username = JwtUtil.getUsername(token);
        //根据用户名来获取用户信息
        // User user = employeeService.getByName(username);


        EmployeeInfoVo employeeInfoVo = new EmployeeInfoVo(
                "hhh",
                "男",
                "员工",
                "杭州店",
                30,
                "12345",
                "1",
                "8点-12点",
                "2",
                "123456789012345678",
                "杭州"
        );

        // TODO:
        // User user = employeeService.getByUserName(email);


        return Result.ok().addData("data", employeeInfoVo);
    }

    /**
     * 更新员工信息
     * @return
     */
    @PutMapping("/info")
    public Result update(@RequestBody EmployeeInfoDTO employeeInfoDTO) {
        // employeeService.updateById(user);
        System.out.println(employeeInfoDTO);

        User user = new User();
        // TODO:
        // 将 employeeInfoDTO copy 到 user

        // employeeService.update(user);

        return Result.ok().addData("msg", "succeed");
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
        return Result.ok();
    }
    /**
     * 提交调整排班申请
     * @return
     */
    // TODO:
    @PostMapping("/adjustScheduling")
    public Result adjustScheduling() {
        //
        //employeeService.adjustScheduling();
        return Result.ok();
    }



}
