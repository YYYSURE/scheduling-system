package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.User;

@Mapper
public interface UserMapper {

    @Select("select * from employee wheter username = #{username}")
    User getByUsername(String username);
}
