package org.example.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.example.dto.intelligent_scheduling.Employee;
import org.example.entity.User;
import org.example.result.Result;
import org.example.service.EnterpriseAdmin_UserService;
import org.example.utils.PageUtils;
import org.example.vo.employee.EmployeeInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.server.PathParam;
import java.util.List;
import java.util.*;
import java.math.BigDecimal;

/**
 * 人员管理控制器
 */
@RestController
@RequestMapping("/users")
public class EnterpriseAdmin_UserController {
    @Autowired
    private EnterpriseAdmin_UserService userService;

    /**
     * 获取员工分页列表
     */
//    @GetMapping("/pages")
//    public Result getEmployeePages(
//            @RequestParam("val") int currentPage,
//            @RequestParam("selected") Long storeId,
//            @RequestParam("input") String employeeName,
//            HttpServletRequest request) {
//
//        Long userId = (Long) request.getAttribute("userId"); // 假设从请求中获取用户ID
//        int userType = (int) request.getAttribute("userType"); // 假设从请求中获取用户类型
//
//        if (userType == 0) { // 企业管理员
//            return Result.ok().addData("page", userService.getEmployeePages(currentPage, null, employeeName,null));
//        } else if (userType == 1) { // 门店管理员
//            return Result.ok().addData("page", userService.getEmployeePages(currentPage, storeId, employeeName,null));
//        } else { // 员工
//            return Result.ok().addData("page", userService.getEmployeePages(currentPage, null, employeeName, userId));
//        }
//    }
    @GetMapping("/pages/{val}&{selected}&{input}")
    public Result getEmployeePages(
            @PathVariable("val") String val,
            @PathVariable(value = "selected",required = false) Long selected, // selected 参数可选
            @PathVariable(value = "input",required = false) String input
            ) {

        System.out.println("当前页：" + val);
//
//        // 获取 userId 和 userType 属性，并进行 null 检查
//        Object userIdObj = request.getAttribute("userId");
//        Object userTypeObj = request.getAttribute("userType");
//
//        if (userIdObj == null || !(userIdObj instanceof Long)) {
//            return Result.error("用户ID为空或类型不正确");
//        }
//
//        if (userTypeObj == null || !(userTypeObj instanceof Integer)) {
//            return Result.error("用户类型为空或类型不正确");
//        }
//
//        Long userId = (Long) userIdObj;
//        int userType = ((Integer) userTypeObj).intValue();

        // 创建分页对象
        Page<EmployeeInfoVo> fixedPage = new Page<>();
        fixedPage.setCurrent(Long.parseLong(val));
        fixedPage.setSize(10); // 每页显示10条记录
        fixedPage.setTotal(30); // 总共30条记录

        // 创建员工列表
        List<EmployeeInfoVo> employeeList = new ArrayList<>();
        employeeList.add(new EmployeeInfoVo("Employee 1", "nan", "Position 1", "Store 1", 0, "1234567890", null, null, null, null, null));
        employeeList.add(new EmployeeInfoVo("Employee 2", "nv", "Position 2", "Store 1", 0, "0987654321", null, null, null, null, null));

        // 进一步处理...
        // 将员工列表设置到分页对象中
        fixedPage.setRecords(employeeList);

        return Result.ok().addData("data",employeeList);
    }




    /**
     * 修改员工信息
     */
    @PutMapping("/employee")
    public Result updateEmployee(@RequestBody User user, HttpServletRequest request) {
//        Long userId = (Long) request.getAttribute("userId");
//        int userType = (int) request.getAttribute("userType");
//
//        if (userType == 0) { // 企业管理员
//            userService.updateById(user);
//            return Result.ok();
//        } else if (userType == 1) { // 门店管理员
//            if (!user.getStoreId().equals(request.getAttribute("storeId"))) {
//                return Result.error("无权限修改其他门店员工信息");
//            }
//            userService.updateById(user);
//            return Result.ok();
//        } else {
////            if (!user.getId().equals(userId)) {
////                return Result.error("无权限修改其他员工信息");
////            }
////            userService.updateById(user);
//            return Result.ok();
//        }
        System.out.println("user 123 "+user);
        return Result.ok();
    }

    /**
     * 删除员工
     */
    @DeleteMapping("/{id}")
    public Result deleteEmployee(@PathVariable("id") Long id, HttpServletRequest request) {
//        Long userId = (Long) request.getAttribute("userId");
//        int userType = (int) request.getAttribute("userType");
//
//        if (userType == 0) { // 企业管理员
//            userService.removeById(id);
//            return Result.ok();
//        } else if (userType == 1) { // 门店管理员
//            User user = userService.getById(id);
//            if (!user.getStoreId().equals(request.getAttribute("storeId"))) {
//                return Result.error("无权限删除其他门店员工");
//            }
//            userService.removeById(id);
//            return Result.ok();
//        } else {
////            if (!id.equals(userId)) {
////                return Result.error("无权限删除其他员工");
////            }
////            userService.removeById(id);
//            return Result.ok();
//        }
        System.out.println("id 123 "+id);
        return Result.ok();
    }

    /**
     * 添加员工
     */
    @PostMapping("/")
    public Result addEmployee(@RequestBody User user, HttpServletRequest request) {
//        int userType = (int) request.getAttribute("userType");
//
//        if (userType == 0) { // 企业管理员
//            userService.save(user);
//            return Result.ok();
//        } else if (userType == 1) { // 门店管理员
//            user.setStoreId((Long) request.getAttribute("storeId")); // 设置门店ID
//            userService.save(user);
//            return Result.ok();
//        } else {
//            return Result.error("无权限添加员工");
//        }
        System.out.println("its adduser  "+user);
        return Result.ok();
    }

    /**
     * 导入文件添加员工
     */
    @PostMapping("/uploadExcel")
    public Result uploadExcel(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        int userType = (int) request.getAttribute("userType");

        if (userType == 0) { // 企业管理员
            userService.uploadExcel(file);
            return Result.ok();
        } else {
            return Result.error("无权限导入员工");
        }
    }
}