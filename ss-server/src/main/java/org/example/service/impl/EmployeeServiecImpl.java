package org.example.service.impl;

import org.example.constant.MessageConstant;
import org.example.dto.Account;
import org.example.dto.EmployeeInfoDTO;
import org.example.dto.HolidayDTO;
import org.example.entity.Employee;
import org.example.entity.Store;
import org.example.entity.leaveRequest;
import org.example.exception.AccountNotFoundException;
import org.example.exception.PasswordErrorException;
import org.example.mapper.EmployeeMapper;
import org.example.service.EmployeeService;
import org.example.vo.holiday.HolidayVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiecImpl implements EmployeeService {

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
        if (!password.equals(employee.getPassword())) {
            //密码错误
            throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
        }

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

    @Override
    public void update(EmployeeInfoDTO employeeInfoDTO, String email) {
        employeeMapper.update(employeeInfoDTO, email);
    }

    @Override
    public Store getStore(Long storeId) {
        return employeeMapper.getStore(storeId);
    }

    @Override
    public String getPosts(Long id) {
        return employeeMapper.getPosts(id);
    }

    @Override
    public List<leaveRequest> getHoidayRecord(int id) {
        return employeeMapper.getHoliDayRecord(id);
    }

    @Override
    public void saveHolidayRecord(HolidayDTO holiday) {
        employeeMapper.saveHolidayRecord(holiday);
    }

}
