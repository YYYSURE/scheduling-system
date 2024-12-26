package org.example.controller.employee;

import org.example.dto.EmployeeInfoDTO;
//import org.example.entity.User;
import org.example.entity.Employee;
import org.example.entity.Store;
import org.example.enums.ResultCodeEnum;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.example.service.UserService;
import org.example.utils.JwtUtil;
import org.example.vo.employee.EmployeeInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/users")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    /**
     * 获取员工信息
     *
     * @return
     */
    @GetMapping("/{email}")
    public Result info(@PathVariable String email) {
        Employee employee = employeeService.getByPhone(email);
        System.out.println("info: " + employee);
        EmployeeInfoVo employeeInfoVo = new EmployeeInfoVo();
        BeanUtils.copyProperties(employee, employeeInfoVo);

        int gender = employee.getGender();
        if (gender == 0) {
            employeeInfoVo.setGender("男");
        } else {
            employeeInfoVo.setGender("女");
        }

        employeeInfoVo.setDay(employee.getWorkDayPreference());
        employeeInfoVo.setDate(employee.getWorkTimePreference());
        employeeInfoVo.setTime(employee.getShiftLengthPreferenceOneDay());
        employeeInfoVo.setAddress(employee.getAddress());

        Long storeId = employee.getStoreId();
        Store store = employeeService.getStore(storeId);
        employeeInfoVo.setStore(store.getName());
        // employeeInfoVo.setAddress(store.getProvince() + store.getCity() + store.getRegion() + store.getAddress());

        String posts = employeeService.getPosts(employee.getId());
        employeeInfoVo.setPosts(posts);

        System.out.println("info: " + employeeInfoVo);

        return Result.ok().addData("data", employeeInfoVo);
    }

    /**
     * 修改员工信息
     * @return
     */
    @PutMapping("/info/{email}")
    public Result update(@RequestBody EmployeeInfoDTO employeeInfoDTO, @PathVariable String email) {
        System.out.println("upate: " + employeeInfoDTO);
        System.out.println(email);

        employeeService.update(employeeInfoDTO, email);

        return Result.ok().addData("msg", "succeed");
    }




}
