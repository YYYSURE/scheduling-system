package org.example.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.example.dto.Account;
import org.example.entity.EnterpriseAdmin;
import org.example.entity.StoreAdmin;

public interface StoreAdminService extends IService<StoreAdmin> {


    StoreAdmin login(Account account);
    StoreAdmin getByIdCard(String idCard);
    int updatePasswordByIdCard(String idCard, String password);


}
