package org.example.intelligent_scheduling_server.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.example.entity.SchedulingTask;
import org.example.vo.TimeVo;
import org.example.vo.scheduling_calculate_service.DateVo;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 排班任务表
 * 
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-01 13:58:33
 */
@Mapper
public interface SchedulingTaskDao extends BaseMapper<SchedulingTask> {
    List<TimeVo> listDataVo(@Param("storeId") long storeId);

    SchedulingTask selectMaxEndDate(@Param("storeId") long storeId);
}
