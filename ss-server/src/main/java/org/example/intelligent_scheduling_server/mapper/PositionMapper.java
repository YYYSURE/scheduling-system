package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Position;

@Mapper
public interface PositionMapper {
    @Select("select * from position where id = #{id} ")
    public Position getPositionById(Long id);
}
