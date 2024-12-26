package org.example.service;

import org.example.dto.Account;
import org.example.dto.EmployeeInfoDTO;
import org.example.dto.HolidayDTO;
import org.example.entity.Employee;
import org.example.entity.Store;
import org.example.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.leaveRequest;
import org.example.vo.holiday.HolidayVO;

import java.util.List;

public interface EmployeeService {
    /**
     * 根据用户名返回用户
     * @param username
     * @return
     */
    Employee getByUserName(String username);

    /**
     * 登录
     * @param account
     * @return
     */

    Employee login(Account account);

    /**
     * 根据 idCard 更新密码
     * @param idCard
     * @param password
     */

    void updatePassword(String idCard, String password);

    /**
     * 根据 phone 获取用户
     * @param phone
     * @return
     */

    Employee getByPhone(String phone);

    /**
     * 更新用户信息
     * @param employee
     */

    void update(EmployeeInfoDTO employeeInfoDTO, String email);

    /**
     * 根据门店 id 获取门店名称
     * @param storeId
     * @return
     */
    Store getStore(Long storeId);

    /**
     * 根据 员工 id 获取职位名称
     * @param id
     * @return
     */
    String getPosts(Long id);

    /**
     * 获取员工请假记录
     * @return
     */
    List<leaveRequest> getHoidayRecord(int id);

    /**
     * 保存请假记录
     * @param holiday
     */
    void saveHolidayRecord(HolidayDTO holiday);
}
