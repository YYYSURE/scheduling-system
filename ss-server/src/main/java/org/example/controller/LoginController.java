package org.example.controller;

import org.example.dto.UserLoginDTO;
import org.example.dto.UserRegistDTO;
import org.example.entity.User;
import org.example.enums.ResultCodeEnum;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.example.service.UserService;
import org.example.utils.CheckPasswordUtil;
import org.example.utils.JwtUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/system/login")
public class LoginController {
    @Autowired
    private UserService userService;
    @Autowired
    private EmployeeService employeeService;

    // 用户登录
    @PostMapping("/login")
    public Result login(@RequestBody UserLoginDTO userLoginDTO) {
        User user = userService.login(userLoginDTO);

        // 生成 jwt 令牌
        String token = JwtUtil.createToken(
                user.getId(),
                user.getUsername(),
                1L,
                user.getStoreId(),
                user.getType()
                );

        Map<String, Object> map = new HashMap<>();
        map.put("token", token);
        return Result.ok().addData("data", map);
    }


    // 用户注册
    @PostMapping("/regist")
    public Result regist(@RequestBody UserRegistDTO userRegistDTO) {

        if (StringUtils.isEmpty(userRegistDTO.getUsername())) {
            return Result.error(ResultCodeEnum.ACCOUNT_ERROR);
        }
        if (StringUtils.isEmpty(userRegistDTO.getPassword())) {
            return Result.error(ResultCodeEnum.PASSWORD_ERROR);
        }
        if (!CheckPasswordUtil.passwordCheck(userRegistDTO.getPassword())) {
            return Result.error(ResultCodeEnum.PASSWORD_WRONGFUL);
        }

        User user = userService.getByName(userRegistDTO.getName());
        if (user == null) {
            User userentity = new User();
            BeanUtils.copyProperties(userRegistDTO, userentity);
            // TODO: 加密密码
            // 新注册的用户统一为员工
            userentity.setType(10);
            employeeService.save(userentity);
            return Result.ok();
        }
        else {
            //用户名已经存在
            return Result.error(ResultCodeEnum.ACCOUNT_EXIST_ERROR.getCode(), ResultCodeEnum.ACCOUNT_EXIST_ERROR.getMessage());
        }

    }



}
