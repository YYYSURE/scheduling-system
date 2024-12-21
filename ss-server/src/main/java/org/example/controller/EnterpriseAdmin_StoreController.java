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
    @GetMapping("/stores")
    public Result listAllStores() {
        QueryWrapper<Store> wrapper = new QueryWrapper<>();
        List<Store> storeList = enterpriseAdminStoreService.list(wrapper);
       // return Result.ok().addData("storeList", storeList);
        return Result.ok();
    }

    /**
     * 获取指定门店信息
     */
    @GetMapping("/stores/{id}")
    public Result getStoreById(@PathVariable("id") Long id) {
        Store store = enterpriseAdminStoreService.getById(id);
        return Result.ok().addData("store", store);
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
    @DeleteMapping("/stores/{id}")
    public Result deleteStore(@PathVariable("id") Long id) {
        enterpriseAdminStoreService.removeById(id);
        return Result.ok().addData("message", "门店删除成功");
    }

    /**
     * 添加门店
     */
    @PostMapping("/stores")
    public Result addStore(@RequestBody Store store) {
        enterpriseAdminStoreService.save(store);
        return Result.ok().addData("message", "门店添加成功");
    }
}