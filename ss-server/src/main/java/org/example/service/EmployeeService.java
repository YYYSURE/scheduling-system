package org.example.service;

import org.example.dto.Account;
import org.example.dto.UserLoginDTO;
import org.example.dto.intelligent_scheduling.Employee;
import org.example.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

public interface EmployeeService extends IService<User> {
    /**
     * 根据用户名返回用户
     * @param username
     * @return
     */
    Employee getByUserName(String username);

    Employee login(Account account);

    void updatePassword(String idCard, String password);

    Employee getByPhone(String phone);
}
