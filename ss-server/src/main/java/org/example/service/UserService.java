package org.example.service;

import org.example.dto.UserLoginDTO;
import org.example.entity.User;

import java.util.Map;

public interface UserService {
    /**
     * 用户登录
     * @param userLoginDTO
     * @return
     */
    User login(UserLoginDTO userLoginDTO);
    /**
     * 根据用户名返回用户
     * @param name
     * @return
     */
    User getByName(String name);

}
