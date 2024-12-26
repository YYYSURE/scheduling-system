package org.example.controller.EnterpriseAdmin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.example.entity.Employee;
import org.example.entity.User;
import org.example.result.Result;
import org.example.service.EnterpriseAdmin_ManageService;
import org.example.utils.PageUtils;
import org.example.vo.employee.EmployeeInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 人员管理控制器
 */
@RestController
@RequestMapping("/employee")
public class ManageController {
    @Autowired
    private EnterpriseAdmin_ManageService userService;

    /**
     * 获取员工分页列表
     */
    @GetMapping("/pages/{val}&{selected}&{input}")
    public Result getEmployeePages(
            @PathVariable("val") String val,
            @PathVariable(value = "selected",required = false) Long selected, // selected 参数可选
            @PathVariable(value = "input",required = false) String input
            ) {
        System.out.println("当前页：" + val);
        System.out.println("selected：" + selected);
        System.out.println("input：" + input);

        // 创建分页对象
        long currentPage = Long.parseLong(val);
        long pageSize = 10; // 每页显示10条记录

        // 创建查询条件
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        if (selected != null) {
            wrapper.eq("store_id", selected); // 替换为实际的列名
        }
        if (input != null && !input.isEmpty()) {
            wrapper.like("username", input); // 替换为实际的列名
        }

        // 创建参数 Map
        Map<String, Object> params = new HashMap<>();
        params.put("current", currentPage);
        params.put("size", pageSize);

        // 从服务层获取分页信息
//        System.out.println("params "+params);
//        System.out.println("wrapper "+wrapper);
        PageUtils pageUtils = userService.queryPage(params, wrapper);
        System.out.println("pageUtils"+pageUtils.toString());
//        pageUtils.setTotalPage(10);
//        pageUtils.setTotalCount(80);
        return Result.ok().addData("data", pageUtils);
    }/**
     * 获取当前员工信息
     */
    @GetMapping("/myEmployee/{email}")
    public Result getMyEmployee(@PathVariable("email") String email) {
        //userService.getMyEmployee(email);
        System.out.println("email "+email);
        return  Result.ok().addData("data", userService.getMyEmployee(email));
    }



    /**
     * 修改员工信息
     */
    @PutMapping("/modify")
    public Result updateEmployee(@RequestBody Employee changeEmployee) {
        //  System.out.println("changeStore "+changeStore);
        if (changeEmployee.getCreateTime() == null) {
            changeEmployee.setCreateTime(new Date());
        }
        userService.saveOrUpdate(changeEmployee);
        System.out.println("user 123 "+changeEmployee);
        return Result.ok();
    }

    /**
     * 删除员工
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteEmployee(@PathVariable("id") Long id) {
        boolean isDeleted = userService.removeById(id);

        if (isDeleted) {
            return Result.ok().addData("msg", "删除成功");
        } else {
            return Result.error(400, "删除失败，员工不存在或已被删除");
        }
    }

    /**
     * 添加员工
     */
    @PostMapping("/add")
    public Result addEmployee(@RequestBody Employee addEmployee) {
        System.out.println("addEmployee "+addEmployee);
        if (addEmployee.getCreateTime() == null) {
            addEmployee.setCreateTime(new Date());
        }

        userService.save(addEmployee);
        return Result.ok().addData("msg","添加成功");

    }


}