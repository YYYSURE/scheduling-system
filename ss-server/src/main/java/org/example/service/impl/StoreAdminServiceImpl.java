package org.example.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.constant.MessageConstant;
import org.example.dto.Account;
import org.example.entity.EnterpriseAdmin;
import org.example.entity.StoreAdmin;
import org.example.exception.AccountNotFoundException;
import org.example.mapper.StoreAdminMapper;
import org.example.service.StoreAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreAdminServiceImpl extends ServiceImpl<StoreAdminMapper, StoreAdmin> implements StoreAdminService {
    @Autowired
    private StoreAdminMapper StoreAdminMapper;

    @Override
    public StoreAdmin getByIdCard(String idCard) {
        return StoreAdminMapper.getByIdCard(idCard);
    }
    @Override
    public  int updatePasswordByIdCard(String idCard, String password) {
        return StoreAdminMapper.updatePasswordByIdCard(idCard,password);
    }

    @Override
    public StoreAdmin login(Account account) {
        String phone = account.getEmail();
        String password = account.getPassword();

        //1、根据用户名查询数据库中的数据
        StoreAdmin StoreAdmin = StoreAdminMapper.getByUserPhone(phone);

        //2、处理各种异常情况（用户名不存在、密码不对、账号被锁定）
        if (StoreAdmin == null) {
            //账号不存在
            throw new AccountNotFoundException(MessageConstant.ACCOUNT_NOT_FOUND);
        }

        //密码比对
        // TODO 后期需要进行md5加密，然后再进行比对
//        if (!password.equals(StoreAdmin.getPassword())) {
//            //密码错误
//            throw new PasswordErrorException(MessageConstant.PASSWORD_ERROR);
//        }

        //3、返回实体对象
        return StoreAdmin;
    }
}
