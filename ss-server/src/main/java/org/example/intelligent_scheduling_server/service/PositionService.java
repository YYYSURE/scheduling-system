package org.example.intelligent_scheduling_server.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import org.example.entity.Position;
import org.example.utils.PageUtils;
import org.example.vo.enterprise.PositionVo;

import java.util.List;
import java.util.Map;

/**
 * 职位表
 *
 * @author dam
 * @email 1782067308@qq.com
 * @date 2023-02-09 11:17:26
 */
public interface PositionService extends IService<Position> {

    PageUtils queryPage(Map<String, Object> params, QueryWrapper<Position> wrapper);


    List<PositionVo> buildTree(long storeId);

}

