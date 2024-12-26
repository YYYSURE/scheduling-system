package org.example.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.dto.EmployeeInfoDTO;
import org.example.dto.HolidayDTO;
import org.example.entity.Employee;
import org.example.entity.Store;
import org.example.entity.leaveRequest;
import org.example.vo.holiday.HolidayVO;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    @Select("select * from employee where id_card = #{idCard}")
    Employee getByIdCard(String idCard);

    @Select("select * from employee where username = #{username}")
    Employee getByUserName(String username);

    @Select("select * from employee where phone = #{phone}")
    Employee getByUserPhone(String phone);


    @Update("update employee set password = #{password} where id_card = #{idCard}")
    void updatePassword(String idCard, String password);

    @Update("update employee set address = #{employeeInfoDTO.address}, phone = #{employeeInfoDTO.phone}, " +
            "work_day_preference = #{employeeInfoDTO.day}, work_time_preference = #{employeeInfoDTO.date}, " +
            "shift_length_preference_one_day = #{employeeInfoDTO.time} where phone = #{email}")
    void update(EmployeeInfoDTO employeeInfoDTO, String email);

    @Select("select * from store where id = #{storeId}")
    Store getStore(Long storeId);

    @Select("select name from position where id = #{id}")
    String getPosts(Long id);

    @Select("select * from leave_requests where employee_id = #{id}")
    List<leaveRequest> getHoliDayRecord(int id);

//    @Insert("insert into leave_requests (employee_id, leave_type, start_time, end_time, reason, status)" +
//            " values (#{holiday.id}, #{holiday.type}, " +
//            "#{holiday.startTime}, #{holiday.endTime}, #{holiday.notes}," +
//            "#{holiday.state})")
//    void saveHolidayRecord(HolidayDTO holiday);

    @Insert("insert into leave_requests (employee_id, leave_type, start_time, end_time, reason, status)" +
            " values (#{id}, #{type}, " +
            "#{startTime}, #{endTime}, #{notes}," +
            "#{state})")
    void saveHolidayRecord(HolidayDTO holiday);
}
