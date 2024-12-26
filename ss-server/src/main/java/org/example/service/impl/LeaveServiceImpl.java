package org.example.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.leaveRequest;
import org.example.mapper.LeaveMapper;
import org.example.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("leaveService")
public class LeaveServiceImpl extends ServiceImpl<LeaveMapper, leaveRequest> implements LeaveService {

    @Autowired
    private LeaveMapper leaveMapper;

    /*@Override
    public List<Leave> getLeavesByEmail(String email) {
        return leaveMapper.selectByEmail(email);
    }*/

//    @Override
//    public List<Leave> getPendingLeaves() {
//        return leaveMapper.selectPendingLeaves();
//    }
//
//    @Override
//    public Leave getLeaveById(Long id) {
//        return leaveMapper.selectById(id);
//    }
}