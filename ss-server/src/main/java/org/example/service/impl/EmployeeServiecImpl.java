package org.example.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.dao.UserDao;
import org.example.entity.User;
import org.example.mapper.UserMapper;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiecImpl extends ServiceImpl<UserDao, User> implements EmployeeService {

    @Autowired
    private UserMapper userMapper;


    @Override
    public User getByName(String name) {
        return userMapper.getByUsername(name);
    }


}
