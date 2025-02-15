package org.example.service.impl;

import org.example.entity.EnterpriseAdmin;
import org.example.mapper.EnterpriseAdminMapper;
import org.example.mapper.EnterpriseAdmin_StoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.utils.PageUtils;
import org.example.utils.Query;

import org.example.dao.EnterpriseAdmin_StoreDao;
import org.example.entity.Store;
import org.example.service.EnterpriseAdmin_StoreService;


@Service("storeService")
public class EnterpriseAdmin_StoreServiceImpl extends ServiceImpl<EnterpriseAdmin_StoreDao, Store> implements EnterpriseAdmin_StoreService {
    @Autowired
    private EnterpriseAdmin_StoreMapper enterpriseAdmin_StoreMapper;
    @Autowired
    private EnterpriseAdminMapper enterpriseAdminMapper;



    @Override
    public int getEmployeeCountByStoreId(Long storeId) {
        return enterpriseAdmin_StoreMapper.getEmployeeCountByStoreId(storeId);
    }
    @Override
    public PageUtils queryPage(Map<String, Object> params, QueryWrapper<Store> wrapper) {
        IPage<Store> page = this.page(
                new Query<Store>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }
    @Override
    public Store getStoreById(Long id) {
        return enterpriseAdmin_StoreMapper.selectById(id);
    }
    @Override
    public Store getStoreByUserPhone(String phone) {
         EnterpriseAdmin enterpriseAdmin =  enterpriseAdminMapper.getByUserPhone(phone);
       // System.out.println(enterpriseAdmin);
         return enterpriseAdmin_StoreMapper.selectById(enterpriseAdmin.getStoreId());
    }

}