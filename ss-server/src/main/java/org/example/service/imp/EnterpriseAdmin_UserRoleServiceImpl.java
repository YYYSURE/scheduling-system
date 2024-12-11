package org.example.service.imp;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.utils.PageUtils;
import org.example.utils.Query;

import org.example.dao.EnterpriseAdmin_UserRoleDao;
import org.example.entity.UserRole;
import org.example.service.EnterpriseAdmin_UserRoleService;


@Service("userRoleService")
public class EnterpriseAdmin_UserRoleServiceImpl extends ServiceImpl<EnterpriseAdmin_UserRoleDao, UserRole> implements EnterpriseAdmin_UserRoleService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<UserRole> page = this.page(
                new Query<UserRole>().getPage(params),
                new QueryWrapper<UserRole>()
        );

        return new PageUtils(page);
    }

}