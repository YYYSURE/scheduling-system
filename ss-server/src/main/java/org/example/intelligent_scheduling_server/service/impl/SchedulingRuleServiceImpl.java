package org.example.intelligent_scheduling_server.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.SchedulingRule;
import org.example.intelligent_scheduling_server.dao.SchedulingRuleDao;
import org.example.intelligent_scheduling_server.mapper.SchedulingRuleMapper;
import org.example.intelligent_scheduling_server.service.PositionService;
import org.example.intelligent_scheduling_server.service.SchedulingRuleService;
import org.example.intelligent_scheduling_server.service.StoreService;
import org.example.utils.PageUtils;
import org.example.utils.Query;
import org.example.vo.enterprise.SchedulingRuleVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;


@Service("schedulingRuleService")
public class SchedulingRuleServiceImpl extends ServiceImpl<SchedulingRuleDao, SchedulingRule> implements SchedulingRuleService {

    @Autowired
    private SchedulingRuleDao schedulingRuleDao;
    @Autowired
    private StoreService storeService;
    @Autowired
    private PositionService positionService;
    @Autowired
    private SchedulingRuleMapper schedulingRuleMapper;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<SchedulingRule> page = this.page(
                new Query<SchedulingRule>().getPage(params),
                new QueryWrapper<SchedulingRule>()
        );

        return new PageUtils(page);
    }

    @Override
    public SchedulingRuleVo getSchedulingRuleVoByStoreId(long storeId) {
        SchedulingRule schedulingRuleEntity = schedulingRuleDao.selectOne(new QueryWrapper<SchedulingRule>().eq("store_id", storeId).eq("rule_type", 0));
        SchedulingRuleVo schedulingRuleVo = new SchedulingRuleVo();
        if (schedulingRuleEntity != null) {
            BeanUtils.copyProperties(schedulingRuleEntity, schedulingRuleVo);
        }

        ///设置门店面积
        schedulingRuleVo.setStoreSize(storeService.getById(storeId).getSize());

        ///设置职位选择树
        schedulingRuleVo.setPositionSelectTree(positionService.buildTree(storeId));

        return schedulingRuleVo;
    }

    @Override
    public SchedulingRule getSchedulingRuleVoByStoreIdAndType(Long storeId, int type) {
        return schedulingRuleDao.selectOne(new QueryWrapper<SchedulingRule>().eq("store_id", storeId).eq("rule_type", type));
    }

    /**
     * 根据id查询规则
     * @param ruleId
     * @return
     */
    @Override
    public SchedulingRuleVo getSchedulingRuleVoByRuleId(Long ruleId) {
        SchedulingRule schedulingRuleEntity = schedulingRuleDao.selectById(ruleId);
        SchedulingRuleVo schedulingRuleVo = new SchedulingRuleVo();
        if (schedulingRuleEntity != null) {
            BeanUtils.copyProperties(schedulingRuleEntity, schedulingRuleVo);
        }

        ///设置门店面积
        schedulingRuleVo.setStoreSize(storeService.getById(schedulingRuleEntity.getStoreId()).getSize());
        ///设置职位选择树
        schedulingRuleVo.setPositionSelectTree(positionService.buildTree(schedulingRuleEntity.getStoreId()));
        return schedulingRuleVo;
    }

    @Override
    public void saveRule(SchedulingRule schedulingRule, Long storeId) {
//        RLock lock = redissonClient.getLock(RedissonLockConstant.MODULE_ENTERPRISE + ":update:" + storeId);
//        try {
//            // 只有一个线程能获取到锁
//            if (lock.tryLock(0, -1, TimeUnit.MILLISECONDS)) {
//                if (baseMapper.selectCount(new QueryWrapper<SchedulingRule>().eq("store_id", storeId)) > 0) {
//                    throw new SSSException(ResultCodeEnum.FAIL.getCode(),"门店已经设置规则，无法重复设置");
//                } else {
//                    schedulingRule.setStoreId(storeId);
//                    schedulingRule.setRuleType(0);
//                    baseMapper.insert(schedulingRule);
//                }
//            }
//        } catch (InterruptedException e) {
//            System.out.println(e.getMessage());
//        } finally {
//            // 只能释放自己的锁
//            if (lock.isHeldByCurrentThread()) {
//                System.out.println("unLock: " + Thread.currentThread().getId());
//                lock.unlock();
//            }
//        }
    }

    @Override
    public Long queryRuleIdByStoreId(Long storeId) {
        return schedulingRuleMapper.ruleIdByStoreId(storeId);
    }

}