package org.example.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.entity.User;
import org.example.result.Result;
import org.example.service.EnterpriseAdmin_UserService;
import org.example.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

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
    @GetMapping("/pages")
    public Result getEmployeePages(
            @RequestParam("val") int currentPage,
            @RequestParam("selected") Long storeId,
            @RequestParam("input") String employeeName,
            HttpServletRequest request) {

        Long userId = (Long) request.getAttribute("userId"); // 假设从请求中获取用户ID
        int userType = (int) request.getAttribute("userType"); // 假设从请求中获取用户类型

        if (userType == 0) { // 企业管理员
            return Result.ok().addData("page", userService.getEmployeePages(currentPage, null, employeeName,null));
        } else if (userType == 1) { // 门店管理员
            return Result.ok().addData("page", userService.getEmployeePages(currentPage, storeId, employeeName,null));
        } else { // 员工
            return Result.ok().addData("page", userService.getEmployeePages(currentPage, null, employeeName, userId));
        }
    }

    /**
     * 修改员工信息
     */
    @PutMapping("/employee")
    public Result updateEmployee(@RequestBody User user, HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        int userType = (int) request.getAttribute("userType");

        if (userType == 0) { // 企业管理员
            userService.updateById(user);
            return Result.ok();
        } else if (userType == 1) { // 门店管理员
            if (!user.getStoreId().equals(request.getAttribute("storeId"))) {
                return Result.error("无权限修改其他门店员工信息");
            }
            userService.updateById(user);
            return Result.ok();
        } else {
//            if (!user.getId().equals(userId)) {
//                return Result.error("无权限修改其他员工信息");
//            }
//            userService.updateById(user);
            return Result.ok();
        }
    }

    /**
     * 删除员工
     */
    @DeleteMapping("/")
    public Result deleteEmployee(@RequestParam("id") Long id, HttpServletRequest request) {
        Long userId = (Long) request.getAttribute("userId");
        int userType = (int) request.getAttribute("userType");

        if (userType == 0) { // 企业管理员
            userService.removeById(id);
            return Result.ok();
        } else if (userType == 1) { // 门店管理员
            User user = userService.getById(id);
            if (!user.getStoreId().equals(request.getAttribute("storeId"))) {
                return Result.error("无权限删除其他门店员工");
            }
            userService.removeById(id);
            return Result.ok();
        } else {
//            if (!id.equals(userId)) {
//                return Result.error("无权限删除其他员工");
//            }
//            userService.removeById(id);
            return Result.ok();
        }
    }

    /**
     * 添加员工
     */
    @PostMapping("/")
    public Result addEmployee(@RequestBody User user, HttpServletRequest request) {
        int userType = (int) request.getAttribute("userType");

        if (userType == 0) { // 企业管理员
            userService.save(user);
            return Result.ok();
        } else if (userType == 1) { // 门店管理员
            user.setStoreId((Long) request.getAttribute("storeId")); // 设置门店ID
            userService.save(user);
            return Result.ok();
        } else {
            return Result.error("无权限添加员工");
        }
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