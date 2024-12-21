package org.example.intelligent_scheduling_server.service.impl;

import org.example.entity.Store;
import org.example.intelligent_scheduling_server.dao.StoreDao;
import org.example.intelligent_scheduling_server.service.StoreService;
import org.example.utils.PageUtils;

import org.example.utils.Query;
import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

@Service
public class StoreServiceImpl extends ServiceImpl<StoreDao, Store> implements StoreService {


    @Override
    public PageUtils queryPage(Map<String, Object> params, QueryWrapper<Store> wrapper) {
        IPage<Store> page = this.page(
                new Query<Store>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }


}