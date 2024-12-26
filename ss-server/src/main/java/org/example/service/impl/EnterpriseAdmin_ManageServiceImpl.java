package org.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.Employee;
import org.example.mapper.ManageMapper;
import org.example.service.EnterpriseAdmin_ManageService;
import org.example.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service
public class EnterpriseAdmin_ManageServiceImpl extends ServiceImpl<ManageMapper, Employee> implements EnterpriseAdmin_ManageService {
    @Autowired
    private ManageMapper enterpriseAdminMapper;
    @Override
    public Employee getMyEmployee(String phone) {

        return enterpriseAdminMapper.getMyEmployee(phone);

    }
    @Override
    public PageUtils queryPage(Map<String, Object> params, QueryWrapper<Employee> wrapper) {
        System.out.println( "params: " + params);
        // 手动解析分页参数
        long current = Long.parseLong(params.getOrDefault("current", "1").toString());
        long size = Long.parseLong(params.getOrDefault("size", "10").toString());

        // 创建分页对象
        Page<Employee> pageable = new Page<>(current, size);

        // 执行分页查询
        IPage<Employee> page = this.page(pageable, wrapper);
//        IPage<Employee> page = this.page(
//                new Query<Employee>().getPage(params),
//                wrapper
//        );
// 添加日志输出以确认总记录数
        System.out.println("Total Count from DB: " + page.getTotal());
        System.out.println("Current Page: " + page.getCurrent());
        System.out.println("Page Size: " + page.getSize());
        System.out.println("record: " +page.getRecords());
        System.out.println(page);

        return new PageUtils(page);
    }
    @Override
    public String getNameById(Long employeeId) {


        return enterpriseAdminMapper.getEmployeeName(employeeId);
    }


}