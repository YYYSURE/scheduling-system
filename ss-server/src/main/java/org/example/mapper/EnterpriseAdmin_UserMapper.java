package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Leave;
import org.example.entity.User;

import java.util.List;

@Mapper
public interface EnterpriseAdmin_UserMapper extends BaseMapper<Leave> {

    @Select("SELECT * FROM user WHERE store_id = #{storeId}")
    List<User> selectByStoreId(Long storeId);
}