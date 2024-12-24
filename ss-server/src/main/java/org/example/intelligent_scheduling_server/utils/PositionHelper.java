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
        trees.addAll(MenuEntityList);
        return trees;
    }

}
