package org.example.intelligent_scheduling_server.utils;



import org.example.entity.Position;

import java.util.ArrayList;
import java.util.List;

public class PositionHelper {

    /**
     * 使用递归方法建菜单
     *
     * @param MenuEntityList
     * @return
     */
    public static List<Position> buildTree(List<Position> MenuEntityList) {
        List<Position> trees = new ArrayList<>();
        for (Position positionEntity : MenuEntityList) {
            //对根节点，找子节点
            if (positionEntity.getParentId() == 0) {
                trees.add(findChildren(positionEntity, MenuEntityList));
            }
        }
        return trees;
    }

    /**
     * 递归查找子节点
     *
     * @param treeNodes
     * @return
     */
    public static Position findChildren(Position positionEntity, List<Position> treeNodes) {
        positionEntity.setChildren(new ArrayList<Position>());

        for (Position it : treeNodes) {
            if (positionEntity.getId().equals(it.getParentId())) {
                if (positionEntity.getChildren() == null) {
                    positionEntity.setChildren(new ArrayList<>());
                }
                positionEntity.getChildren().add(findChildren(it, treeNodes));
            }
        }
        return positionEntity;
    }
}
