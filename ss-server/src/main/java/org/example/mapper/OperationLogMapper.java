package org.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.entity.OperationLog;
import org.example.entity.leaveRequest;

import java.util.List;

@Mapper
public interface OperationLogMapper extends BaseMapper<leaveRequest> {

    @Select("SELECT * FROM operation_log")
    List<OperationLog> selectAllLogs();

    @Insert("INSERT INTO operation_log (operator_id, operation_type, create_time, other_fields) " +
            "VALUES (#{operatorId}, #{operationType}, #{createTime}, #{otherFields})")
    void insert(OperationLog operationLog);
}