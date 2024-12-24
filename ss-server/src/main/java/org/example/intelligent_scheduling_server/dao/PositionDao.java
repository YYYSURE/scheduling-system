package org.example.intelligent_scheduling_server.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.entity.Position;

import java.util.List;

/**
 * 职位表
 * 
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-09 11:17:26
 */
@Mapper
public interface PositionDao extends BaseMapper<Position> {

    List<Position> listAllSonPosition(@Param("storeId") Long storeId);
}
