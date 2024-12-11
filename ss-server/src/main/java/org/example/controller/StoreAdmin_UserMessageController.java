package org.example.controller;

import java.util.Arrays;
import java.util.Map;

import org.example.entity.UserMessage;
import org.example.result.Result;
import org.example.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import org.example.service.StoreAdmin_UserMessageService;



/**
 * 用户-消息中间表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-03-20 15:43:46
 */
@RestController
@RequestMapping("/enterprise/userMessage")
public class StoreAdmin_UserMessageController {
    @Autowired
    private StoreAdmin_UserMessageService storeAdminUserMessageService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    public Result list(@RequestParam Map<String, Object> params){
        PageUtils page = storeAdminUserMessageService.queryPage(params);

        return Result.ok().addData("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id){
        UserMessage userMessage = storeAdminUserMessageService.getById(id);

        return Result.ok().addData("userMessage", userMessage);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public Result save(@RequestBody UserMessage userMessage){
        storeAdminUserMessageService.save(userMessage);

        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public Result update(@RequestBody UserMessage userMessage){
        storeAdminUserMessageService.updateById(userMessage);

        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody Long[] ids){
        storeAdminUserMessageService.removeByIds(Arrays.asList(ids));

        return Result.ok();
    }

}
