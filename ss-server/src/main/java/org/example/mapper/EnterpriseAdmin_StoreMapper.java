
package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Store;

@Mapper
public interface EnterpriseAdmin_StoreMapper extends BaseMapper<Store> {

    @Select("SELECT * FROM store WHERE id = #{storeId}")
    Store selectById(Long storeId);
    @Delete("DELETE FROM store WHERE id = #{storeId}")
    Boolean removeById(Long storeId);

}