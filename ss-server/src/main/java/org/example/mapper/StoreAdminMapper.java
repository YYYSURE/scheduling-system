package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.dto.intelligent_scheduling.Employee;
import org.example.entity.StoreAdmin;

@Mapper
public interface StoreAdminMapper extends BaseMapper<StoreAdmin> {
    @Select("select * from admin where username = #{username}")
    StoreAdmin getByUserName(String username);

    @Select("select * from admin where phone = #{phone}")
    StoreAdmin getByUserPhone(String phone);


    void updatePassword(String idCard, String password);
}
