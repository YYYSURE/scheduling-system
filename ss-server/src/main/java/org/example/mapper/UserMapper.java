package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Employee;

import java.util.List;

@Mapper
public interface UserMapper {


    @Select("select * from employee where store_id = #{storeId} ")
    List<Employee> list(Long storeId);
}
