package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.Leave;

import java.util.Date;
import java.util.List;

@Mapper
public interface LeaveMapper extends BaseMapper<Leave> {

    @Select("SELECT * FROM leave_requests WHERE email = #{email}")
    List<Leave> selectByEmail(String email);

    @Select("SELECT * FROM leave_requests WHERE state = 0")
    List<Leave> selectPendingLeaves();

    @Select("SELECT * FROM leave_requests WHERE id = #{id}")
    Leave selectById(Long id);

    @Select("select employee_id from leave_requests where start_time < #{end} and end_time > #{start}")
    List<Long> getByTimeRange(Date start, Date end);
}