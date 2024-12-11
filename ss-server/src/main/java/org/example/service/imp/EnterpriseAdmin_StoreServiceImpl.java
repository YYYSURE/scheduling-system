package org.example.service.imp;

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

    @Override
    public PageUtils queryPage(Map<String, Object> params, QueryWrapper<Store> wrapper) {
        IPage<Store> page = this.page(
                new Query<Store>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

}