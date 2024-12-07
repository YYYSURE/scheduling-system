create table festival
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted  tinyint  default 0                 null comment '是否删除 0：未删除 1：已删除',
    name        varchar(30)                        not null comment '节日名称',
    start_date  datetime                           not null comment '起始日期',
    end_date    datetime                           not null comment '截止日期',
    type        tinyint                            null comment '0：农历 1：新历',
    store_id    bigint                             null comment '门店id'
)
    comment '门店节日表' collate = utf8mb4_bin
                         row_format = DYNAMIC;

create table login_log
(
    id          bigint auto_increment comment '主键'
        primary key,
    is_deleted  tinyint default 0 not null comment '是否删除(0-未删, 1-已删)',
    username    varchar(50)       null comment '用户名',
    ipaddr      varchar(50)       null comment 'ip地址',
    status      varchar(50)       null comment '状态',
    access_time datetime          null comment '登录时间'
)
    comment '登录日志表' charset = utf8mb3
                         row_format = DYNAMIC;

create table message
(
    id             bigint auto_increment comment '主键'
        primary key,
    create_time    datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time    datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    create_user_id bigint                             null comment '创建人id',
    is_deleted     tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    is_publish     tinyint  default 0                 null comment '是否发布（0：未发布；1：已发布）',
    subject        varchar(200)                       null comment '通知主题',
    content        longtext                           null comment '通知内容',
    store_id       bigint                             null comment '门店id',
    publish_time   datetime                           null comment '发布时间'
)
    comment '通知表' collate = utf8mb4_bin
                     row_format = DYNAMIC;

create table operation_log
(
    id            bigint auto_increment comment '主键'
        primary key,
    create_time   datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted    tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    business_type tinyint                            null comment '业务类型 (0其它 1新增 2修改 3删除)',
    user_id       bigint                             null comment '操作人员',
    oper_ip       varchar(128)                       null comment '主机地址',
    status        tinyint                            null comment '操作状态 (0正常 1异常)',
    error_msg     varchar(2000)                      null comment '错误消息'
)
    comment '操作日志表' collate = utf8mb4_bin
                         row_format = DYNAMIC;

create table position
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    name        varchar(30)                        null comment '名称',
    description text                               null comment '职位描述'
)
    comment '职位表' charset = utf8mb3
                     row_format = DYNAMIC;

create table province_city_region
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    name        varchar(50)                        null comment '名称',
    type        tinyint                            null comment '类型 0：省 1：市 2：区',
    parent_id   bigint                             null comment '没有父元素设置为0'
)
    comment '省-市-区表' charset = utf8mb3
                         row_format = DYNAMIC;

create table scheduling_date
(
    id              bigint auto_increment comment '主键'
        primary key,
    create_time     datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time     datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted      tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    date            datetime                           null comment '日期',
    is_need_work    tinyint                            null comment '是否需要工作 0：休假 1：工作',
    start_work_time varchar(5)                         null comment '上班时间（8:00）',
    end_work_time   varchar(5)                         null comment '下班时间（21:00）',
    store_id        bigint                             null comment '门店id'
)
    comment '排班日期表' charset = utf8mb3
                         row_format = DYNAMIC;

create table scheduling_rule
(
    id                           bigint auto_increment comment '主键'
        primary key,
    create_time                  datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                  datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted                   tinyint  default 0                 null comment '是否删除 0：未删除 1：已删除',
    store_id                     bigint                             null,
    store_work_time_frame        varchar(500)                       null comment '门店工作时间段',
    most_work_hour_in_one_day    decimal(10, 4)                     null comment '员工一天最多工作几小时',
    most_work_hour_in_one_week   decimal(10, 4)                     null comment '员工一周最多工作几小时',
    min_shift_minute             int                                null comment '一个班次的最少时间（分钟为单位）',
    max_shift_minute             int                                null comment '一个班次的最大时间（分钟为单位）',
    rest_minute                  int                                null comment '休息时间长度（分钟为单位）',
    maximum_continuous_work_time decimal(10, 4)                     null comment '员工最长连续工作时间',
    open_store_rule              varchar(500)                       null comment '开店规则',
    close_store_rule             varchar(500)                       null comment '关店规则',
    normal_rule                  varchar(500)                       null comment '正常班规则',
    no_passenger_rule            varchar(500)                       null comment '无客流量值班规则',
    minimum_shift_num_in_one_day int                                null comment '每天最少班次',
    normal_shift_rule            varchar(500)                       null comment '正常班次规则',
    lunch_time_rule              varchar(100)                       null comment '午餐时间规则',
    dinner_time_rule             varchar(100)                       null comment '晚餐时间规则',
    rule_type                    tinyint                            null comment '规则类型 0：主规则 1：从规则'
)
    comment '排班规则表' charset = utf8mb3
                         row_format = DYNAMIC;

create table scheduling_shift
(
    id                 bigint auto_increment comment '主键'
        primary key,
    create_time        datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time        datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted         tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    start_date         datetime                           null comment '班次开始时间 2023-02-27 07:00:00',
    end_date           datetime                           null comment '班次结束时间 2023-02-27 10:30:00',
    scheduling_date_id bigint                             null comment '对应排班工作日的id',
    meal_start_date    datetime                           null comment '吃饭开始时间',
    meal_end_date      datetime                           null comment '吃饭结束时间',
    meal_type          tinyint                            null comment '0：午餐 1：晚餐 2：不安排用餐',
    total_minute       int                                null comment '总时间',
    shift_type         tinyint                            null comment '班次类型 0：正常班 1：开店 2：收尾'
)
    comment '排班班次表' charset = utf8mb3
                         row_format = DYNAMIC;

create index schedulingDateId
    on scheduling_shift (scheduling_date_id);

create table scheduling_task
(
    id                    bigint auto_increment comment '主键'
        primary key,
    create_time           datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time           datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted            tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    name                  varchar(50)                        null comment '任务名',
    total_minute          int                                null comment '班次总时长（分钟）',
    total_assigned_minute int                                null comment '已分配班次的总时间（分钟）',
    allocation_ratio      decimal(10, 6)                     null comment '分配比率',
    status                tinyint  default 0                 null comment '任务状态 0：新创建 1：计算中 2：计算完成 3：计算失败',
    scheduling_rule_id    bigint                             null comment '排班规则id',
    store_id              bigint                             null comment '门店id',
    duration              int                                null comment '以多少分钟为一段',
    intervalC             int                                null comment '以多少段为一个时间单位来进行排班',
    dateVoList            longtext                           null comment '排班工作日及其客流量',
    calculate_time        decimal                            null comment '计算时间',
    start_date            varchar(50)                        null comment '排班开始日期（UTC时间，比北京时间慢8小时）',
    end_date              varchar(50)                        null comment '排班结束日期（UTC时间，比北京时间慢8小时）',
    step_one_alg          varchar(100)                       null comment '第一阶段算法',
    step_two_alg          varchar(100)                       null comment '第二阶段算法',
    step_two_alg_param    varchar(2000)                      null comment '第二阶段算法参数',
    type                  tinyint  default 0                 null comment '任务类型 0：真实任务 1：虚拟任务',
    parent_id             bigint                             null comment '父任务id 虚拟任务才有父id',
    is_publish            tinyint                            null comment '是否发布任务 0：未发布 1：已经发布'
)
    comment '排班任务表' charset = utf8mb3
                         row_format = DYNAMIC;

create index storeId
    on scheduling_task (store_id);

create table shift_user
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted  tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    shift_id    bigint                             null comment '班次id',
    user_id     bigint                             null comment '用户id',
    position_id bigint                             null comment '记录用户当时的职位，可能后面升职了'
)
    comment '班次_用户中间表' charset = utf8mb3
                              row_format = DYNAMIC;

create index shiftId
    on shift_user (shift_id);

create index userId
    on shift_user (user_id);

create table store
(
    id          bigint auto_increment comment '主键',
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    name        varchar(30)                        not null comment '名称',
    province_id bigint                             null comment '省',
    city_id     bigint                             null comment '市',
    region_id   bigint                             null comment '区',
    address     varchar(50)                        null comment '详细地址',
    size        decimal(10, 4)                     null comment '工作场所面积',
    status      tinyint  default 0                 not null comment '0：营业中 1：休息中（默认0）',
    primary key (id, status)
)
    comment '门店表' charset = utf8mb3
                     row_format = DYNAMIC;

create table system_scheduled_notice
(
    id                  bigint auto_increment comment '主键'
        primary key,
    create_time         datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time         datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    store_id            bigint                             null comment '门店id',
    work_notice_time    datetime                           null comment '上班通知提醒时间，如每天晚上八点提醒相关人员第二天是否需要上班',
    work_notice_type    tinyint                            null comment '工作通知方式 0：系统发送消息 1：发送邮件 2：系统发送消息及发送邮件',
    holiday_notice_time datetime                           null comment '休假通知提醒时间，如每天晚上八点提醒相关人员第二天是否需要上班',
    holiday_notice_type tinyint                            null comment '休假通知方式 0：系统发送消息 1：发送邮件 2：系统发送消息及发送邮件'
)
    comment '系统定时通知' collate = utf8mb4_bin
                           row_format = DYNAMIC;

create table user
(
    id                               bigint auto_increment comment '主键'
        primary key,
    create_time                      datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                      datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted                       tinyint  default 0                 null comment '是否删除 0：未删除 1：已删除',
    name                             varchar(50)                        null comment '姓名',
    phone                            varchar(11)                        null comment '电话',
    store_id                         bigint                             null comment '门店ID',
    type                             tinyint                            not null comment '用户类型0：系统管理员 1：门店管理员 10：普通用户',
    username                         varchar(30)                        null comment '用户名',
    password                         varchar(255)                       not null comment '密码',
    gender                           tinyint  default 0                 null comment '性别 0：男 1：女',
    age                              int                                null comment '年龄',
    work_day_preference              varchar(20)                        null comment '工作日偏好（喜欢星期几工作1|3|4喜欢星期一、三、四工作），缺省为全部 ',
    work_time_preference             varchar(256)                       null comment '工作时间偏好（1:00~3.00|5.00~8.00|17.00~21.00），缺省为全部） ',
    shift_length_preference_one_day  varchar(20)                        null comment '每天班次时长偏好',
    shift_length_preference_one_week varchar(20)                        null comment '每周班次时长偏好'
)
    comment '用户表' collate = utf8mb4_bin
                     row_format = DYNAMIC;

create table user_message
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted  tinyint  default 0                 not null comment '是否删除(0-未删, 1-已删)',
    user_id     bigint                             null comment '用户id',
    message_id  bigint                             null comment '消息id'
)
    comment '用户-消息中间表' collate = utf8mb4_bin
                              row_format = DYNAMIC;

create table user_position
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted  tinyint  default 0                 null comment '是否删除 0：未删除 1：已删除',
    user_id     bigint                             null comment '用户id',
    position_id bigint                             null comment '职位id'
)
    comment 'user_position中间表' charset = utf8mb3
                                  row_format = DYNAMIC;

