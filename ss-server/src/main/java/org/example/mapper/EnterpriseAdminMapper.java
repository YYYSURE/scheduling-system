package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.entity.EnterpriseAdmin;


@Mapper
public interface EnterpriseAdminMapper extends BaseMapper<EnterpriseAdmin> {
    @Select("select * from admin where username = #{username}")
    EnterpriseAdmin getByUserName(String username);

    @Select("select * from admin where phone = #{phone}")
    EnterpriseAdmin getByUserPhone(String phone);
    @Select("select * from admin where id_card = #{idCard}")
    EnterpriseAdmin getByIdCard(String idCard);
    @Update("update admin set password = #{password} where id_card = #{idCard}")
    int updatePasswordByIdCard(String idCard,  String password);


    void updatePassword(String idCard, String password);
}
