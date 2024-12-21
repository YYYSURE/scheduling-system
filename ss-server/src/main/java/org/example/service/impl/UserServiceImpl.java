package org.example.service.impl;

import org.example.constant.MessageConstant;
import org.example.dto.UserLoginDTO;
import org.example.entity.User;
import org.example.exception.AccountNotFoundException;
import org.example.exception.PasswordErrorException;
import org.example.mapper.UserMapper;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    public User login(UserLoginDTO userLoginDTO) {
        String username = userLoginDTO.getAccount().getEmail();
        String password = userLoginDTO.getAccount().getPassword();

        //1、根据用户名查询数据库中的数据
        User user = userMapper.getByUsername(username);

        //2、处理各种异常情况（用户名不存在、密码不对、账号被锁定）
        if (user == null) {
            //账号不存在
            throw new AccountNotFoundException(MessageConstant.ACCOUNT_NOT_FOUND);
        }

        //密码比对
        // TODO 后期需要进行md5加密，然后再进行比对
        if (!password.equals(user.getPassword())) {
            //密码错误
            throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
        }

        //3、返回实体对象
        return user;
    }

    @Override
    public User getByName(String name) {
        return userMapper.getByUsername(name);
    }


}
