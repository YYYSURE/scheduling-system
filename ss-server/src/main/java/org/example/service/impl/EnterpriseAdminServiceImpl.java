package org.example.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.constant.MessageConstant;
import org.example.dto.Account;
//import org.example.dto.intelligent_scheduling.EnterpriseAdmin;
import org.example.entity.EnterpriseAdmin;
import org.example.exception.AccountNotFoundException;
import org.example.mapper.EnterpriseAdminMapper;
import org.example.service.EnterpriseAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("EnterpriseAdminService")
public class EnterpriseAdminServiceImpl extends ServiceImpl<EnterpriseAdminMapper, EnterpriseAdmin> implements EnterpriseAdminService {
    @Autowired
    private EnterpriseAdminMapper enterpriseAdminMapper;

    @Override
    public  EnterpriseAdmin getByIdCard(String idCard) {
        return enterpriseAdminMapper.getByIdCard(idCard);
    }


    @Override
    public EnterpriseAdmin login(Account account) {
        String phone = account.getEmail();
        String password = account.getPassword();

        //1、根据用户名查询数据库中的数据
        EnterpriseAdmin EnterpriseAdmin = enterpriseAdminMapper.getByUserPhone(phone);

        //2、处理各种异常情况（用户名不存在、密码不对、账号被锁定）
        if (EnterpriseAdmin == null) {
            //账号不存在
            throw new AccountNotFoundException(MessageConstant.ACCOUNT_NOT_FOUND);
        }

        //密码比对
        // TODO 后期需要进行md5加密，然后再进行比对
//        if (!password.equals(EnterpriseAdmin.getPassword())) {
//            //密码错误
//            throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
//        }

        //3、返回实体对象
        return EnterpriseAdmin;
    }

}
