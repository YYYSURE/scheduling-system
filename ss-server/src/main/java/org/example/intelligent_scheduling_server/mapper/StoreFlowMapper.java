package org.example.intelligent_scheduling_server.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface StoreFlowMapper {

    @Select("SELECT flow from store_flow where store_id = #{storeId} and year = #{year} and month = #{month} and day = #{day}")
    public String queruByTime(Long storeId,int year, int month,int day);
}
