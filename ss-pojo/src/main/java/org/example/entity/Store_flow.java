package org.example.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("store_flow")
public class Store_flow {

    private long store_id;

    private int year;

    private int month;

    private String flow;
}
