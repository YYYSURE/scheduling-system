
package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Leave;
import org.example.entity.Store;

@Mapper
public interface EnterpriseAdmin_StoreMapper extends BaseMapper<Leave> {

    @Select("SELECT * FROM store WHERE store_id = #{storeId}")
    Store selectById(Long storeId);
}