package org.example.controller;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.result.Result;
import org.example.vo.enterprise.StoreVo;

import org.example.utils.PageUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import org.example.entity.Store;
import org.example.service.EnterpriseAdmin_StoreService;

import javax.servlet.http.HttpServletRequest;

/**
 * 门店表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-09 11:17:26
 */
@RestController
@RequestMapping("/Store")
public class EnterpriseAdmin_StoreController {
    @Autowired
    private EnterpriseAdmin_StoreService enterpriseAdminStoreService;

    private static final String title = "门店管理";

    /**
     * 查询所有门店
     *
     * @return
     */
//    @GetMapping("/stores")
//    public Result listAllStores() {
//        QueryWrapper<Store> wrapper = new QueryWrapper<>();
//        List<Store> storeList = enterpriseAdminStoreService.list(wrapper);
//
//        return Result.ok().addData("storeList", storeList);
//
//    }
    @GetMapping("/store/{email}")
    public Result listMyStores(@PathVariable("email") String email) {
        System.out.println("email"+email);
        QueryWrapper<Store> wrapper1 = new QueryWrapper<>();
        wrapper1.eq("email", email);
        QueryWrapper<Store> wrapper2 = new QueryWrapper<>();
        List<Store> storeList = enterpriseAdminStoreService.list(wrapper1);
        StoreVo store = new StoreVo(
                "Store 1",
                4L,
                6L,
                1L, "Province 1",
                101L, "City 1",
                10101L, "Region 1",
                "Address 1, Street 1",
                new BigDecimal("1000.50"),
                0
        );



        // return Result.ok().addData("storeList", storeList);
        return Result.ok().addData("data",store);
    }

    /**
     * 获取指定门店信息
     */
    @GetMapping("/stores/{id}")
    public Result getStoreById(@PathVariable("id") Long id) {
//        Store store = enterpriseAdminStoreService.getById(id);
//        return Result.ok().addData("store", store);
        System.out.println("id"+id);
        List<StoreVo> storeList = new ArrayList<>();
        // 创建几个 StoreVo 对象实例并添加到列表中
        storeList.add(new StoreVo(
                "Store 1",
                2L,
                1L,
                1L, "Province 1",
                101L, "City 1",
                10101L, "Region 1",
                "Address 1, Street 1",
                new BigDecimal("1000.50"),
                0
        ));

        storeList.add(new StoreVo(
                "Store 2",
                1L,
                4L,
                2L, "Province 2",
                202L, "City 2",
                20202L, "Region 2",
                "Address 2, Street 2",
                new BigDecimal("1500.75"),
                1
        ));

        storeList.add(new StoreVo(
                "Store 3",
                3L,
                11L,
                3L, "Province 3",
                303L, "City 3",
                30303L, "Region 3",
                "Address 3, Street 3",
                new BigDecimal("2000.00"),
                0
        ));

        // return Result.ok().addData("storeList", storeList);
        return Result.ok().addData("data", storeList);
    }

    /**
     * 获取当前用户门店信息
     */
    @GetMapping("/info")
    public Result getStoreInfo(HttpServletRequest request) {
        // 从 Cookie 中获取 storeId
        Long storeId = getStoreIdFromCookie(request.getCookies());

        if (storeId == null) {
           // return Result.error().setMessage("未找到有效的 storeId");
        }

        // 根据 storeId 获取门店信息
        Store store = enterpriseAdminStoreService.getStoreById(storeId);
        return Result.ok().addData("store", store);
    }

    /**
     * 从 Cookie 中获取 storeId
     *
     * @param cookies 请求中的所有 Cookie
     * @return storeId 如果找到；否则返回 null
     */
    private Long getStoreIdFromCookie(javax.servlet.http.Cookie[] cookies) {
        if (cookies != null) {
            for (javax.servlet.http.Cookie cookie : cookies) {
                if ("storeId".equals(cookie.getName())) {
                    try {
                        return Long.parseLong(cookie.getValue());
                    } catch (NumberFormatException e) {
                        // 处理无效的 storeId
                        return null;
                    }
                }
            }
        }
        return null;
    }

    /**
     * 删除门店
     */
    @DeleteMapping("/stores/{i}")
    public Result deleteStore(@PathVariable("i") Long i) {
//        enterpriseAdminStoreService.removeById(id);
//        return Result.ok().addData("message", "门店删除成功");
        System.out.println("i="+i);
        return Result.ok();
    }

    /**
     * 添加门店
     */
//    @PostMapping("/stores")
//    public Result addStore(@RequestBody Store store) {
//        enterpriseAdminStoreService.save(store);
//        return Result.ok().addData("message", "门店添加成功");
//    }
    @PostMapping("/stores")
    public Result addStore(@RequestBody StoreDTO store) {
        // 打印传入的 Store 对象
        System.out.println(store);

        // 或者使用日志框架（假设你已经配置了 SLF4J）
        // logger.info("Received Store data: {}", JSON.toJSONString(store));

        // 注释掉数据库保存操作
        // enterpriseAdminStoreService.save(store);

        return Result.ok().addData("message", "门店添加成功");
    }
    /**
     * change门店
     */
    @PutMapping("/stores")
    public Result changeStore(@RequestBody StoreDTO myStore) {
//        enterpriseAdminStoreService.save(store);
//        return Result.ok().addData("message", "门店添加成功");
        System.out.println(myStore);
        return Result.ok();
    }

}