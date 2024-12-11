package org.example.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.entity.User;

import java.util.List;

@Mapper
public interface UserDao extends BaseMapper<User> {
//    List<User> getUserListWithoutPosition(@Param("storeId") long storeId);
//
//    List<String> listAllMailByUserIdList(@Param("userIdList") List<Long> userIdList);
}
