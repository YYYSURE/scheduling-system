package org.example.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.example.dto.StoreAdminEmployeeDTO;
import org.example.entity.Employee;
import org.example.exception.SSSException;
import org.example.vo.enterprise.EmployeeVo;
import org.example.vo.system.UserInfoVo;
import org.example.utils.PageUtils;
import org.example.entity.User;
import org.example.vo.system.SysUserQueryVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户表
 *
 */
public interface EnterpriseAdmin_ManageService extends IService<Employee> {



    PageUtils queryPage(Map<String, Object> params, QueryWrapper<Employee> wrapper);
    Employee getMyEmployee(String phone);
    String getNameById(Long employeeId);


}

