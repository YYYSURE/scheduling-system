package org.example.service.impl;

import org.example.constant.MessageConstant;
import org.example.dto.UserLoginDTO;
import org.example.entity.Employee;
import org.example.exception.AccountNotFoundException;
import org.example.exception.PasswordErrorException;
import org.example.intelligent_scheduling_server.mapper.PositionMapper;
import org.example.mapper.UserMapper;
import org.example.service.UserService;
import org.example.utils.StringUtils;
import org.example.vo.system.UserInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private PositionMapper positionMapper;


    @Override
    public List<UserInfoVo> listUserByStoreId(Long storeId) {
        List<Employee> list = userMapper.list(storeId);

        //存储所有门店Id
        HashSet<Long> storeIdSet = new HashSet<>();
        //存储所有用户Id
        List<Long> userIdList = new ArrayList<>();
        //存储封装的用户信息集合
        List<UserInfoVo> userInfoVoList = new ArrayList<>();

        ////初始化数据
        for (Employee userEntity : list) {
            userIdList.add(userEntity.getId());
            storeIdSet.add(userEntity.getStoreId());
            //复制基本信息
            UserInfoVo userInfoVo = new UserInfoVo();
            BeanUtils.copyProperties(userEntity, userInfoVo);
            userInfoVo.setPositionId(userEntity.getPositionId());
            //工作日偏好数据处理
            List<Integer> workDayPreferenceList = new ArrayList<>();
            if (!StringUtils.isEmpty(userEntity.getWorkDayPreference())) {
                String[] wordDayList = userEntity.getWorkDayPreference().split("\\|");
                for (String s : wordDayList) {
                    workDayPreferenceList.add(Integer.parseInt(s));
                }
            }
            userInfoVo.setWorkDayPreferenceList(workDayPreferenceList);
            userInfoVoList.add(userInfoVo);
        }

        //TODO 门店信息
/*        ////查询门店信息
        //查询门店名称
        //2.每一个线程都共享之前的请求数据
        if (storeIdSet.size() > 0) {
            System.out.println("查询门店信息");
                for (UserInfoVo userInfoVo : userInfoVoList) {
                    if (userInfoVo.getStoreId() != null && idAndStoreEntityMap.get(userInfoVo.getStoreId()) != null) {
                        userInfoVo.setStoreName(idAndStoreEntityMap.get(userInfoVo.getStoreId()).getName());
                    } else {
                        userInfoVo.setStoreName(null);
                    }
                }
        }*/

        return userInfoVoList;
    }
}
