package org.example.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.EnterpriseAdmin;
import org.example.entity.Store;
import org.example.utils.PageUtils;

import java.util.Map;
//门店管理
/**
 * 门店表
 *
 */
public interface EnterpriseAdmin_StoreService extends IService<Store> {

    ;
    PageUtils queryPage(Map<String, Object> params, QueryWrapper<Store> wrapper);
    Store getStoreById(Long id);
    //Store getStoreByName(String name);
    Store getStoreByUserPhone(String phone);
    int getEmployeeCountByStoreId(Long storeId);
}

