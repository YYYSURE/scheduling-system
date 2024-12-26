package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Employee;

@Mapper
public interface ManageMapper extends BaseMapper<Employee> {

    @Select("SELECT username FROM employee WHERE id = #{EmployeeId}")
    String getEmployeeName(Long EmployeeId);
    @Select("SELECT * FROM employee WHERE phone = #{phone}")
    Employee getMyEmployee(String phone);
    IPage<Employee> selectEmployeePage(
            Page<Employee> page,
            @Param("storeId") Long storeId,
            @Param("employeeName") String employeeName
    );
}