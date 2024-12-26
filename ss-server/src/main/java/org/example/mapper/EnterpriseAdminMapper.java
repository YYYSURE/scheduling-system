package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.EnterpriseAdmin;


@Mapper
public interface EnterpriseAdminMapper extends BaseMapper<EnterpriseAdmin> {
    @Select("select * from admin where username = #{username}")
    EnterpriseAdmin getByUserName(String username);

    @Select("select * from admin where phone = #{phone}")
    EnterpriseAdmin getByUserPhone(String phone);



    void updatePassword(String idCard, String password);
}
