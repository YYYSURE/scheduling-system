package org.example.controller;

import org.example.entity.UserRole;
import org.example.result.Result;
import org.example.service.EnterpriseAdmin_UserRoleService;
import org.example.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;


/**
 *
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2022-12-03 21:21:06
 */
@RestController
@RequestMapping("system/Admin_userrole")
public class EnterpriseAdmin_UserRoleController {
    @Autowired
    private EnterpriseAdmin_UserRoleService adminUserRoleService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public Result list(@RequestParam Map<String, Object> params){
        PageUtils page = adminUserRoleService.queryPage(params);

        return Result.ok().addData("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id){
        UserRole userRole = adminUserRoleService.getById(id);

        return Result.ok().addData("userRole", userRole);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public Result save(@RequestBody UserRole userRole){
        adminUserRoleService.save(userRole);

        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public Result update(@RequestBody UserRole userRole){
        adminUserRoleService.updateById(userRole);

        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public Result delete(@RequestBody Long[] ids){
        adminUserRoleService.removeByIds(Arrays.asList(ids));

        return Result.ok();
    }

}
