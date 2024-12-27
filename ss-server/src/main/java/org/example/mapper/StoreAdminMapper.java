package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.dto.intelligent_scheduling.Employee;
import org.example.entity.EnterpriseAdmin;
import org.example.entity.StoreAdmin;

@Mapper
public interface StoreAdminMapper extends BaseMapper<StoreAdmin> {
    @Select("select * from admin where username = #{username}")
    StoreAdmin getByUserName(String username);

    @Select("select * from admin where phone = #{phone}")
    StoreAdmin getByUserPhone(String phone);

    @Select("select * from admin where id_card = #{idCard}")
    StoreAdmin getByIdCard(String idCard);
    @Update("update admin set password = #{password} where id_card = #{idCard}")
    int updatePasswordByIdCard(String idCard,  String password);

    void updatePassword(String idCard, String password);
}
