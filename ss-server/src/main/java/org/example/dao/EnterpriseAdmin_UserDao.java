package org.example.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.entity.User;

import java.util.List;

/**
 * 用户表//改成管理员表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-06 15:50:29
 */
@Mapper
public interface EnterpriseAdmin_UserDao extends BaseMapper<User> {

    List<User> getUserListWithoutPosition(@Param("storeId") long storeId);

    List<String> listAllMailByUserIdList(@Param("userIdList") List<Long> userIdList);
}
