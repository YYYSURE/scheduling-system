package org.example.intelligent_scheduling_server.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.example.entity.Position;
import org.example.entity.Store;
import org.example.intelligent_scheduling_server.dao.PositionDao;
import org.example.intelligent_scheduling_server.service.PositionService;
import org.example.intelligent_scheduling_server.service.StoreService;
import org.example.intelligent_scheduling_server.utils.PositionHelper;
import org.example.utils.PageUtils;
import org.example.utils.Query;
import org.example.utils.StringUtils;
import org.example.vo.enterprise.PositionVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.util.CollectionUtils;


@Service("positionService")
public class PositionServiceImpl extends ServiceImpl<PositionDao, Position> implements PositionService {
    @Autowired
    private PositionDao positionDao;
    @Autowired
    private StoreService storeService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, QueryWrapper<Position> wrapper) {
        IPage<Position> page = this.page(
                new Query<Position>().getPage(params),
                wrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<PositionVo> buildTree(long storeId) {

        List<PositionVo> positionVoList = new ArrayList<>();
        //查出门店下的所有职位数据
        List<Position> positionEntityList = positionDao.selectList(new QueryWrapper<Position>().eq("store_id", storeId));
        for (Position positionEntity : positionEntityList) {
            PositionVo positionVo = new PositionVo(positionEntity.getId(), positionEntity.getName());
            positionVoList.add(positionVo);
        }
        return positionVoList;
    }



}