package org.example.intelligent_scheduling_server.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.entity.SchedulingDate;

import java.util.Date;
import java.util.List;

/**
 * 排班日期表
 * 
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-04 14:30:17
 */
@Mapper
public interface SchedulingDateDao extends BaseMapper<SchedulingDate> {
    List<SchedulingDate> listDateBetweenStartDateAndEndDate(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("storeId") long storeId, @Param("taskId") Long taskId);

    Integer judgeOneDateIsRest(@Param("storeId") Long storeId, @Param("workDate") Date workDate);
}
