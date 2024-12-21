package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.dto.intelligent_scheduling.Employee;
import org.example.entity.User;

@Mapper
public interface EmployeeMapper {


    @Select("select * from employee where username = #{username}")
    Employee getByUserName(String username);

    @Select("select * from employee where phone = #{phone}")
    Employee getByUserPhone(String phone);


    void updatePassword(String idCard, String password);
}
