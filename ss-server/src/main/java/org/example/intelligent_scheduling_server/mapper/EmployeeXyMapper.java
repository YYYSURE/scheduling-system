package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface EmployeeXyMapper {

    @Select("select username from employee where id = #{id} ")
    String getNameById(Long id);
}
