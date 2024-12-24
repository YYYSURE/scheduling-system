package org.example.controller;

import org.example.dto.Account;
import org.example.dto.ResetDTO;
import org.example.dto.UserLoginDTO;
import org.example.dto.UserRegistDTO;
import org.example.dto.intelligent_scheduling.Employee;
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
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

import static org.example.enums.ResultCodeEnum.ACCOUNT_ERROR;

@RestController
@RequestMapping("/accounts")
public class LoginController {
//    @Autowired
//    private UserService userService;
    @Autowired
    private EmployeeService employeeService;

    // 用户登录
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {

        System.out.println(account);

//        boolean admin = account.isAdmin();
        int type = account.getType();
        System.out.println(type);

        Map<String, Object> map = new HashMap<>();

//        if (admin) {
//            // admin
//            Admin admin = adminService.login(account);
//            map.put("name", admin.getName());
//            map.put("id", admin.getId());
//            map.put("store", admin.getStoreId());
//            return Result.ok().addData("data", map);
//        }

         // Employee employee = employeeService.login(account);


        // TODO:
//        map.put("name", employee.getName());
//        map.put("id", employee.getId());
//        map.put("store", employee.getStoreId());


        map.put("name", "hhh");
        map.put("id", 12345);
        map.put("store", 1);
        return Result.ok().addData("data", map);
    }

    @PostMapping("/reset")
    public Result reset(@RequestBody ResetDTO resetDTO) {

        System.out.println(resetDTO);



        String idCard = resetDTO.getIdCard();
        String phone = resetDTO.getAccount().getEmail();
        String password = resetDTO.getAccount().getPassword();

        return Result.ok();

//        Employee employee = employeeService.getByPhone(phone);
//        if (employee != null) {
//            if (employee.getIdCard() != idCard) {
//                return Result.error(ACCOUNT_ERROR);
//            }
//            // update password
//            employeeService.updatePassword(idCard, password);
//
//            return Result.ok();
//        }

//        Admin admin = adminService.getByIdCard(idCard);
//        if (admin != null) {
//            return Result.ok();
//        }

//        return Result.error(ACCOUNT_ERROR);




    }


    // TODO:
    // 用户注册
//    @PostMapping("/regist")
//    public Result regist(@RequestBody UserRegistDTO userRegistDTO) {
//
//        if (StringUtils.isEmpty(userRegistDTO.getUsername())) {
//            return Result.error(ResultCodeEnum.ACCOUNT_ERROR);
//        }
//        if (StringUtils.isEmpty(userRegistDTO.getPassword())) {
//            return Result.error(ResultCodeEnum.PASSWORD_ERROR);
//        }
//        if (!CheckPasswordUtil.passwordCheck(userRegistDTO.getPassword())) {
//            return Result.error(ResultCodeEnum.PASSWORD_WRONGFUL);
//        }
//
//        User user = userService.getByName(userRegistDTO.getName());
//        if (user == null) {
//            User userentity = new User();
//            BeanUtils.copyProperties(userRegistDTO, userentity);
//            // TODO: 加密密码
//            // 新注册的用户统一为员工
//            userentity.setType(10);
//            employeeService.save(userentity);
//            return Result.ok();
//        }
//        else {
//            //用户名已经存在
//            return Result.error(ResultCodeEnum.ACCOUNT_EXIST_ERROR.getCode(), ResultCodeEnum.ACCOUNT_EXIST_ERROR.getMessage());
//        }
//
//    }



}
