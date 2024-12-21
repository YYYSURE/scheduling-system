package org.example.intelligent_scheduling_server.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.SchedulingRule;
import org.example.utils.PageUtils;
import org.example.vo.enterprise.SchedulingRuleVo;

import java.util.Map;

/**
 * 门店规则中间表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-23 21:34:22
 */
public interface SchedulingRuleService extends IService<SchedulingRule> {

    PageUtils queryPage(Map<String, Object> params);

    SchedulingRuleVo getSchedulingRuleVoByStoreId(long storeId);

    SchedulingRule getSchedulingRuleVoByStoreIdAndType(Long storeId, int type);

    SchedulingRuleVo getSchedulingRuleVoByRuleId(Long ruleId);

    void saveRule(SchedulingRule schedulingRule, Long storeId);
}

