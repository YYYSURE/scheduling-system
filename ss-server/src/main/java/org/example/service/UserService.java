package org.example.service;

import org.example.vo.system.UserInfoVo;

import java.util.List;
import java.util.Map;

public interface UserService {


    List<UserInfoVo> listUserByStoreId(Long storeId);
}
