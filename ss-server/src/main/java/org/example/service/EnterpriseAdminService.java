package org.example.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.example.dto.Account;
import org.example.entity.EnterpriseAdmin;
import org.example.entity.User;

public interface EnterpriseAdminService extends IService<EnterpriseAdmin> {


    EnterpriseAdmin login(Account account);

    EnterpriseAdmin getByIdCard(String idCard);
}
