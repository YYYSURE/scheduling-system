package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.entity.leaveRequest;

import java.util.Date;
import java.util.List;

@Mapper
public interface LeaveMapper extends BaseMapper<leaveRequest> {

    @Update("UPDATE leave_requests SET status = #{status} WHERE id = #{id}")
    int updateStatusById(Long id, Long status);


    @Select("select employee_id from leave_requests where start_time < #{end} and end_time > #{start}")
    List<Long> getByTimeRange(Date start, Date end);
}