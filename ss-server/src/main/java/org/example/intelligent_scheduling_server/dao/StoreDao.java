package org.example.intelligent_scheduling_server.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.example.entity.Store;

/**
 * 门店表
 * 
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-09 11:17:26
 */
@Mapper
public interface StoreDao extends BaseMapper<Store> {
	
}
