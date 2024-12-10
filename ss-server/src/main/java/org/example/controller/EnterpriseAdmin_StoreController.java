package org.example.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.result.Result;
import org.example.vo.enterprise.StoreVo;
import org.example.service.EnterpriseAdmin_ProvinceCityRegionService;
import org.example.utils.PageUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import org.example.entity.Store;
import org.example.service.EnterpriseAdmin_StoreService;

/**
 * 门店表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-09 11:17:26
 */
@RestController
@RequestMapping("EnterpriseAdmin_store")
public class EnterpriseAdmin_StoreController {
    @Autowired
    private EnterpriseAdmin_StoreService enterpriseAdminStoreService;
    @Autowired
    private EnterpriseAdmin_ProvinceCityRegionService enterpriseAdminProvinceCityRegionService;
    private static final String title = "门店管理";

    /**
     * 查询所有门店
     *
     * @return
     */
    @RequestMapping("/listAllStores")
    @PreAuthorize("hasAuthority('bnt.store.list')")
    public Result listAllStores() {
        QueryWrapper<Store> wrapper = new QueryWrapper<>();
        List<Store> list = enterpriseAdminStoreService.list(wrapper); // 查询所有门店，不再过滤

        return Result.ok().addData("list", list);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    @PreAuthorize("hasAuthority('bnt.store.list')")
    public Result list(@RequestParam Map<String, Object> params) {
        //构建查询wrapper
        QueryWrapper<Store> wrapper = new QueryWrapper<>();

        PageUtils page = enterpriseAdminStoreService.queryPage(params, wrapper);

        //封装vo数据
        List<?> list = page.getList();
        List<StoreVo> storeVoList = list.stream().map(item -> {
            String json = JSON.toJSONString(item);
            Store store = JSON.parseObject(json, Store.class);
            StoreVo storeVo = new StoreVo();
            BeanUtils.copyProperties(store, storeVo);
            //查询名字省市区的名字
            storeVo.setProvinceName(enterpriseAdminProvinceCityRegionService.getById(store.getProvinceId()).getName());
            storeVo.setCityName(enterpriseAdminProvinceCityRegionService.getById(store.getCityId()).getName());
            storeVo.setRegionName(enterpriseAdminProvinceCityRegionService.getById(store.getRegionId()).getName());
            return storeVo;
        }).collect(Collectors.toList());
        page.setList(storeVoList);
        return Result.ok().addData("page", page);
    }

    /**
     * 获取系统的门店数量
     *
     * @return int count
     */
    @RequestMapping("/getAllStoreNum")
    public Result getAllStoreNum() {
        long count = enterpriseAdminStoreService.count(new QueryWrapper<Store>()); // 查询所有门店数量
        return Result.ok().addData("count", count);
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id) {
        Store store = enterpriseAdminStoreService.getById(id);

        return Result.ok().addData("store", store);
    }

    /**
     * 根据门店 ID 集合查询门店，并封装成字典
     *
     * @return
     */
    @PostMapping("/getStoreMapByIdList")
    public Result getStoreMapByIdList(@RequestBody List<Long> storeIdList) {
        Map<Long, Store> idAndStoreMap = new HashMap<>();
        if (storeIdList.size() > 0) {
            List<Store> storeList = enterpriseAdminStoreService.list(new QueryWrapper<Store>().in("id", storeIdList));
            for (Store store : storeList) {
                idAndStoreMap.put(store.getId(), store);
            }
        }
        return Result.ok().addData("idAndStoreMap", idAndStoreMap);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAuthority('bnt.store.add')")
    //@OperationLog(title = StoreController.title, businessType = BusinessTypeEnum.INSERT, detail = "新增门店")
    public Result save(@RequestBody Store store) {
        enterpriseAdminStoreService.save(store);

        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAuthority('bnt.store.update')")
  //  @OperationLog(title = StoreController.title, businessType = BusinessTypeEnum.UPDATE, detail = "修改门店信息")
    public Result update(@RequestBody Store store) {
        enterpriseAdminStoreService.updateById(store);

        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/deleteBatch")
    @PreAuthorize("hasAuthority('bnt.store.delete')")
 //   @OperationLog(title = StoreController.title, businessType = BusinessTypeEnum.UPDATE, detail = "删除门店")
    public Result delete(@RequestBody Long[] ids) {
        enterpriseAdminStoreService.removeByIds(Arrays.asList(ids));

        return Result.ok();
    }
}