package org.example.controller.EnterpriseAdmin;

import java.util.*;

import org.example.dto.StoreDTO;
import org.example.mapper.EnterpriseAdmin_StoreMapper;
import org.example.result.Result;

import org.example.vo.enterprise.StoreVo2;
import org.springframework.beans.factory.annotation.Autowired;
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
@RequestMapping("/Store")
public class StoreController {
    @Autowired
    private EnterpriseAdmin_StoreService enterpriseAdminStoreService;
    @Autowired
    private EnterpriseAdmin_StoreMapper enterpriseAdminStoreMapper;

    private static final String title = "门店管理";

 //获取当前用户所属门店信息
    @GetMapping("/store/{storeId}")
    public Result listMyStores(@PathVariable("storeId") Long storeId) {
        System.out.println("storeId+"+storeId);

//        Store store1=enterpriseAdminStoreService.getStoreByUserPhone(storeId);
//        System.out.println(store1);
        Store store1=enterpriseAdminStoreService.getStoreById(storeId);
        int employeeCount = enterpriseAdminStoreMapper.getEmployeeCountByStoreId(storeId);



        return Result.ok().addData("data",store1).addData("employeeCount", employeeCount);
    }

    //add门店
    @PostMapping("/addStore")
    public Result addStore(@RequestBody Store addStore) {
        System.out.println("addStore "+addStore);
        if (addStore.getCreateTime() == null) {
            addStore.setCreateTime(new Date());
        }

        enterpriseAdminStoreService.save(addStore);




        return Result.ok().addData("msg","添加成功");
    }

    /**
     * 获取所有门店信息
     */
    @GetMapping("/stores")
    public Result getStoreById() {

//        List<Store> storeList = enterpriseAdminStoreService.list(new QueryWrapper<Store>().eq("status", 0));
        List<Store> storeList = enterpriseAdminStoreService.list();
        List<StoreVo2> storeVoList = new ArrayList<>();
        for (Store store : storeList) {
            StoreVo2 storeVo = new StoreVo2();
            storeVo.setId(store.getId());
            storeVo.setName(store.getName());
            storeVo.setSize(store.getSize());
            storeVo.setAddress(store.getAddress());
            storeVo.setStatus(store.getStatus());

            // 获取每个门店对应的人数
            Integer employeeCount = enterpriseAdminStoreMapper.getEmployeeCountByStoreId(store.getId());
            storeVo.setEmployeeCount(employeeCount);

            storeVoList.add(storeVo);
        }
        System.out.println(storeVoList);
        int count = storeVoList.size();
        return Result.ok().addData("data", storeVoList).addData("count", count);
    }


    /**
     * 删除门店
     */
    @DeleteMapping("/deleteStore/{store_id}")
    public Result deleteStore(@PathVariable("store_id") Long storeId) {

       // System.out.println("storeId="+storeId);
        boolean isDeleted = enterpriseAdminStoreMapper.removeById(storeId);

        if (isDeleted) {
            return Result.ok().addData("msg", "删除成功");
        } else {
            return Result.error(400, "删除失败，门店不存在或已被删除");
        }

    }
    /**
     * change门店
     */
    @PutMapping("/modiftyStore")
    public Result changeStore(@RequestBody Store changeStore) {
      //  System.out.println("changeStore "+changeStore);
        if (changeStore.getCreateTime() == null) {
            changeStore.setCreateTime(new Date());
        }
        Boolean isUpdate = enterpriseAdminStoreService.saveOrUpdate(changeStore);
        if (isUpdate)return Result.ok().addData("msg", "修改成功");
        else return Result.error(400, "修改失败");
    }

}