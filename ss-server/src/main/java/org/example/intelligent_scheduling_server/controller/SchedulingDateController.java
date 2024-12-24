package org.example.intelligent_scheduling_server.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.example.constant.RedisConstant;
import org.example.entity.SchedulingDate;
import org.example.entity.SchedulingTask;
import org.example.intelligent_scheduling_server.service.SchedulingDateService;
import org.example.intelligent_scheduling_server.service.SchedulingShiftService;
import org.example.intelligent_scheduling_server.service.SchedulingTaskService;
import org.example.intelligent_scheduling_server.service.ShiftUserService;
import org.example.result.Result;
import org.example.utils.JwtUtil;
import org.example.utils.PageUtils;
import org.example.utils.TimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;


/**
 * 排班日期表
 *
 */
@RestController
@RequestMapping("/scheduling/schedulingdate")
public class SchedulingDateController {
    @Autowired
    private SchedulingDateService schedulingDateService;
    @Autowired
    private SchedulingShiftService schedulingShiftService;
    @Autowired
    private ShiftUserService shiftUserService;
    @Autowired
    private SchedulingTaskService schedulingTaskService;

}
