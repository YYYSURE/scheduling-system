package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Employee;

import java.util.List;

@Mapper
public interface EmployeeXyMapper {

    @Select("select username from employee where id = #{id} ")
    String getNameById(Long id);

    @Select("select * from employee where store_id = #{storeId} ")
    List<Employee> getByStoreId(Long storeId);
}
