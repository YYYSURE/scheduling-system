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

    /**
     * 查询所有职位的树形结构
     *
     * @return
     */
    @Override
    public List<Position> findNodes(Long storeId, String name, String detail) {
        //获取所有的菜单
        QueryWrapper<Position> wrapper = new QueryWrapper<Position>()
                .eq("store_id", storeId);
        if (!StringUtils.isEmpty(name) && StringUtils.isEmpty(detail)) {
            wrapper.like("name", name);
        }
        if (!StringUtils.isEmpty(detail) && StringUtils.isEmpty(name)) {
            wrapper.like("description", detail);
        }
        if (!StringUtils.isEmpty(detail) && !StringUtils.isEmpty(name)) {
            wrapper.like("name", name).or().like("description", detail);
        }

        List<Position> positionEntityList = baseMapper.selectList(wrapper);
        if (CollectionUtils.isEmpty(positionEntityList)) return null;

        //构建树形数据
        List<Position> result = PositionHelper.buildTree(positionEntityList);
        return result;
    }

    @Override
    public List<PositionVo> buildTree(long storeId) {

        List<PositionVo> positionVoList = new ArrayList<>();

        //查出门店下的所有职位数据
        List<Position> positionEntityList = positionDao.selectList(new QueryWrapper<Position>().eq("store_id", storeId));
        //过滤出所有一级职位
        List<Position> fatherList = positionEntityList.stream().filter(item -> {
            if (item.getParentId() == 0) {
                return true;
            } else {
                return false;
            }
        }).collect(Collectors.toList());
        //给所有一级职位寻找子职位
        for (Position father : fatherList) {
            PositionVo areaItemVo = new PositionVo(father.getId(), father.getName());
            this.searchSon(areaItemVo, positionEntityList);
            positionVoList.add(areaItemVo);
        }
        return positionVoList;
    }

    @Override
    public List<Position> listPositionListByPositionIdList(List<Long> positionIdList) {
        return baseMapper.selectBatchIds(positionIdList);
    }

    /**
     * 查询出所有叶子节点数据
     * 即没有任何数据的parentId是本条数据的id即可
     *
     * @param storeId
     * @return
     */
    @Override
    public List<Position> listAllSonPosition(Long storeId) {
        return baseMapper.listAllSonPosition(storeId);
    }

    /**
     * 将一个门店的规则复制给同企业的其他门店
     *
     * @param storeId
     */
    @Override
    public void copyPositionToOtherStore(Long storeId) {
        Store store = storeService.getById(storeId);
        //查询出企业的其他门店
        List<Store> storeEntityList = storeService.list(new QueryWrapper<Store>().eq("enterprise_id", store.getEnterpriseId()).ne("id", store.getId()));
        //查询当前门店的所有规则
        List<Position> positionEntityList = baseMapper.selectList(new QueryWrapper<Position>().eq("store_id", store.getId()));
        //复制职位给其他门店
        for (Store otherStore : storeEntityList) {
            List<Position> newPositionList = new ArrayList<>();
            for (Position positionEntity : positionEntityList) {
                Position newPosition = new Position();
                BeanUtils.copyProperties(positionEntity, newPosition);
                newPosition.setStoreId(otherStore.getId());
                newPositionList.add(newPosition);
            }
            this.saveBatch(newPositionList);
        }
    }

    private void searchSon(PositionVo father, List<Position> provinceCityRegionEntityList) {
        List<PositionVo> sonList = provinceCityRegionEntityList.stream().filter(item -> {
            if (item.getParentId() == father.getId().intValue()) {
                return true;
            } else {
                return false;
            }
        }).map(item1 -> {
            PositionVo son = new PositionVo(item1.getId(), item1.getName());
            //继续给儿子寻找孙子
            this.searchSon(son, provinceCityRegionEntityList);
            return son;
        }).collect(Collectors.toList());
        father.setChildren(sonList);
    }

}