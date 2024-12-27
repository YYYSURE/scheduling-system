package org.example.controller.EnterpriseAdmin;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.example.entity.Employee;
import org.example.entity.User;
import org.example.mapper.EnterpriseAdmin_StoreMapper;
import org.example.mapper.ManageMapper;
import org.example.result.Result;
import org.example.service.EnterpriseAdmin_ManageService;
import org.example.utils.PageUtils;
import org.example.vo.employee.EmployeeInfoVo;
import org.example.vo.enterprise.EmployeeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 人员管理控制器
 */
@RestController
@RequestMapping("/employee")
public class ManageController {
    @Autowired
    private EnterpriseAdmin_ManageService userService;
    @Autowired
    private ManageMapper manageMapper;
    @Autowired
    private EnterpriseAdmin_StoreMapper enterpriseAdminStoreMapper;

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
        long pageSize = 7; // 每页显示8条记录

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

        PageUtils pageUtils = userService.queryPage(params, wrapper);
        System.out.println("pageUtils: " + pageUtils);

        // 获取员工列表
        // 获取员工列表并转换为 EmployeeVo 列表
        List<Employee> employeeList = (List<Employee>) pageUtils.getList();
        System.out.println("employeeList: " + employeeList);
        List<EmployeeVo> employees = new ArrayList<>();
        for (Employee employee : employeeList) {
            EmployeeVo employeeVo = convertToEmployeeVo(employee);
            employees.add(employeeVo);
        }

        // 为每个员工添加 position_name
        for (EmployeeVo employeeVo : employees) {
            Long positionId = employeeVo.getPositionId();
            if (positionId != null) {
                String positionName = manageMapper.selectPositionNameById(positionId);
                employeeVo.setPositionName(positionName);// 假设 EmployeeVo 类中有 setPositionName 方法
            }
        }
        System.out.println("employees: " + employees);

        // 将转换后的 EmployeeVo 列表设置回 pageUtils
        pageUtils.setList(employees);

        return Result.ok().addData("data", pageUtils);
    }


    @GetMapping("/myEmployee/{email}")
    public Result getMyEmployee(@PathVariable("email") String email) {
        //userService.getMyEmployee(email);
        System.out.println("email "+email);
        System.out.println(userService.getMyEmployee(email));
        Employee employee = userService.getMyEmployee(email);
        String myStoreName=enterpriseAdminStoreMapper.selectNameById(employee.getStoreId());
        String positonName=manageMapper.selectPositionNameById(employee.getPositionId());
        System.out.println("employee"+employee);
        System.out.println("myStoreName"+myStoreName);

        return  Result.ok().addData("data", employee).addData("myStoreName",myStoreName).addData("posts",positonName);
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
        Boolean isUpdate = userService.saveOrUpdate(changeEmployee);
        System.out.println("user 123 "+changeEmployee);
        System.out.println("isUpdate "+isUpdate);
        if(isUpdate)return Result.ok().addData("msg", "修改成功");
        else return Result.error(400, "修改失败");
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

    public static EmployeeVo convertToEmployeeVo(Employee employee) {
        EmployeeVo employeeVo = new EmployeeVo();
        // 假设 Employee 和 EmployeeVo 的字段基本一致，这里进行一一赋值
        employeeVo.setId(employee.getId());
        employeeVo.setPhone(employee.getPhone());
        employeeVo.setUsername(employee.getUsername());
        employeeVo.setPositionId(employee.getPositionId());

        // 添加其他需要设置的字段
        employeeVo.setStoreId(employee.getStoreId());
        employeeVo.setAddress(employee.getAddress());
        employeeVo.setIdCard(employee.getIdCard());
        employeeVo.setUsername(employee.getUsername());
        employeeVo.setPassword(employee.getPassword());
        employeeVo.setGender(employee.getGender());
        employeeVo.setAge(employee.getAge());
        employeeVo.setWorkDayPreference(employee.getWorkDayPreference());
        employeeVo.setWorkTimePreference(employee.getWorkTimePreference());
        employeeVo.setShiftLengthPreferenceOneDay(employee.getShiftLengthPreferenceOneDay());
        employeeVo.setShiftLengthPreferenceOneWeek(employee.getShiftLengthPreferenceOneWeek());

        return employeeVo;
    }

}