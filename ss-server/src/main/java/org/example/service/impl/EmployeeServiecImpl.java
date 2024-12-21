package org.example.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.constant.MessageConstant;
import org.example.dao.UserDao;
import org.example.dto.Account;
import org.example.dto.UserLoginDTO;
import org.example.dto.intelligent_scheduling.Employee;
import org.example.entity.User;
import org.example.exception.AccountNotFoundException;
import org.example.exception.PasswordErrorException;
import org.example.mapper.EmployeeMapper;
import org.example.mapper.UserMapper;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeServiecImpl extends ServiceImpl<UserDao, User> implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;


    @Override
    public Employee getByUserName(String username) {
        return employeeMapper.getByUserName(username);
    }

    @Override
    public Employee login(Account account) {
        String phone = account.getEmail();
        String password = account.getPassword();

        //1、根据用户名查询数据库中的数据
        Employee employee = employeeMapper.getByUserPhone(phone);

        //2、处理各种异常情况（用户名不存在、密码不对、账号被锁定）
        if (employee == null) {
            //账号不存在
            throw new AccountNotFoundException(MessageConstant.ACCOUNT_NOT_FOUND);
        }

        //密码比对
        // TODO 后期需要进行md5加密，然后再进行比对
//        if (!password.equals(employee.getPassword())) {
//            //密码错误
//            throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
//        }

        //3、返回实体对象
        return employee;
    }


    @Override
    public void updatePassword(String idCard, String password) {
        employeeMapper.updatePassword(idCard, password);
    }

    @Override
    public Employee getByPhone(String phone) {
        return employeeMapper.getByUserPhone(phone);
    }

}
