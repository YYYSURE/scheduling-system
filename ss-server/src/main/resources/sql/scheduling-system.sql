drop database scheduling_system;

create database scheduling_system;

create table if not exists scheduling_system.admin
(
    id          int auto_increment
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null,
    update_time datetime default CURRENT_TIMESTAMP not null invisible,
    name        varchar(50)                        not null,
    phone       varchar(11)                        not null,
    store_id    int                                null,
    username    varchar(30)                        null,
    password    varchar(255)                       not null,
    gender      tinyint  default 0                 null,
    age         int                                null,
    type        tinyint                            not null,
    id_card     varchar(255)                       not null

);

create table if not exists scheduling_system.employee
(
    id                               bigint auto_increment comment '主键'
        primary key,
    create_time                      datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time                      datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted                       tinyint  default 0                 null comment '是否删除 0：未删除 1：已删除',
    phone                            varchar(11)                        null comment '电话',
    store_id                         bigint                             null comment '门店ID',
    position_id                      mediumtext                         not null comment '职位编号',
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

create table if not exists scheduling_system.festival
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

create table if not exists scheduling_system.leave_requests
(
    id           int auto_increment
        primary key,
    employee_id  int          not null,
    leave_type   varchar(30)  not null comment '事假,病假,调休',
    start_time   varchar(30)  null comment '开始时间,格式2024-06-01 09:00:00',
    end_time     varchar(30)  null comment '结束时间,格式2024-06-01 09:00:00',
    reason       varchar(500) null,
    status       int          null comment '0 待审批,1已审批,2已驳回',
    apply_time   varchar(100) null comment '申请时间',
    approve_time varchar(100) null comment '审批时间',
    admin_id     int          null
);

create table if not exists scheduling_system.login_log
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

create table if not exists scheduling_system.message
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

create table if not exists scheduling_system.operation_log
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

create table if not exists scheduling_system.position
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    name        varchar(30)                        null comment '名称',
    description text                               null comment '职位描述',
    store_id    bigint                             null
)
    comment '职位表' charset = utf8mb3
                     row_format = DYNAMIC;

create table if not exists scheduling_system.scheduling_date
(
    id              bigint auto_increment comment '主键ID'
        primary key,
    create_time     datetime default CURRENT_TIMESTAMP null comment '创建时间',
    update_time     datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间',
    date            datetime                           null comment '日期',
    is_need_work    int                                null comment '是否需要工作 0：休假 1：工作',
    start_work_time varchar(5)                         null comment '上班时间（8:00）',
    end_work_time   varchar(5)                         null comment '下班时间（21:00）',
    store_id        bigint                             null comment '门店id',
    task_id         bigint                             null comment '任务id',
    is_have_shift   int      default 0                 null comment '当天是否含有班次'
)
    comment '排班日期表' charset = utf8mb3;

create table if not exists scheduling_system.scheduling_rule
(
    id                           bigint auto_increment comment '主键'
        primary key,
    create_time                  datetime default (now()) null comment '创建时间',
    update_time                  datetime default (now()) null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted                   tinyint  default 0       null comment '是否删除 0：未删除 1：已删除',
    store_id                     bigint                   null,
    store_work_time_frame        varchar(500)             null comment '门店工作时间段',
    most_work_hour_in_one_day    decimal(10, 4)           null comment '员工一天最多工作几小时',
    most_work_hour_in_one_week   decimal(10, 4)           null comment '员工一周最多工作几小时',
    min_shift_minute             int                      null comment '一个班次的最少时间（分钟为单位）',
    max_shift_minute             int                      null comment '一个班次的最大时间（分钟为单位）',
    rest_minute                  int                      null comment '休息时间长度（分钟为单位）',
    maximum_continuous_work_time decimal(10, 4)           null comment '员工最长连续工作时间',
    open_store_rule              varchar(500)             null comment '开店规则',
    close_store_rule             varchar(500)             null comment '关店规则',
    normal_rule                  varchar(500)             null comment '正常班规则',
    no_passenger_rule            varchar(500)             null comment '无客流量值班规则',
    minimum_shift_num_in_one_day int                      null comment '每天最少班次',
    normal_shift_rule            varchar(500)             null comment '正常班次规则',
    lunch_time_rule              varchar(100)             null comment '午餐时间规则',
    dinner_time_rule             varchar(100)             null comment '晚餐时间规则',
    rule_type                    tinyint                  null comment '规则类型 0：主规则 1：从规则'
)
    comment '排班规则表' charset = utf8mb3
                         row_format = DYNAMIC;

create table if not exists scheduling_system.scheduling_shift
(
    id                 bigint auto_increment comment '主键'
        primary key,
    create_time        datetime default (now()) null comment '创建时间',
    update_time        datetime default (now()) null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted         tinyint  default 0       not null comment '是否删除(0-未删, 1-已删)',
    start_date         datetime                 null comment '班次开始时间 2023-02-27 07:00:00',
    end_date           datetime                 null comment '班次结束时间 2023-02-27 10:30:00',
    scheduling_date_id bigint                   null comment '对应排班工作日的id',
    meal_start_date    datetime                 null comment '吃饭开始时间',
    meal_end_date      datetime                 null comment '吃饭结束时间',
    meal_type          tinyint                  null comment '0：午餐 1：晚餐 2：不安排用餐',
    total_minute       int                      null comment '总时间',
    shift_type         tinyint                  null comment '班次类型 0：正常班 1：开店 2：收尾',
    user_id            mediumtext               null
)
    comment '排班班次表' charset = utf8mb3
                         row_format = DYNAMIC;

create table if not exists scheduling_system.scheduling_task
(
    id                 bigint auto_increment comment '主键'
        primary key,
    create_time        datetime default (now()) null comment '创建时间',
    update_time        datetime default (now()) null on update CURRENT_TIMESTAMP comment '更新时间',
    scheduling_rule_id bigint                   null comment '排班规则id',
    store_id           bigint                   null comment '门店id',
    start_date         varchar(50)              null comment '排班开始日期（UTC时间，比北京时间慢8小时）',
    end_date           varchar(50)              null comment '排班结束日期（UTC时间，比北京时间慢8小时）',
    is_publish         tinyint                  null comment '是否发布任务 0：未发布 1：已经发布'
)
    comment '排班任务表' charset = utf8mb3
                         row_format = DYNAMIC;

create index storeId
    on scheduling_system.scheduling_task (store_id);

create table if not exists scheduling_system.shift_user
(
    id          bigint auto_increment comment '主键'
        primary key,
    create_time datetime default (now()) null comment '创建时间',
    update_time datetime default (now()) null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted  tinyint  default 0       not null comment '是否删除(0-未删, 1-已删)',
    shift_id    bigint                   null comment '班次id',
    user_id     bigint                   null comment '用户id',
    position_id bigint                   null comment '记录用户当时的职位，可能后面升职了'
)
    comment '班次_用户中间表' charset = utf8mb3
                              row_format = DYNAMIC;

create index shiftId
    on scheduling_system.shift_user (shift_id);

create index userId
    on scheduling_system.shift_user (user_id);

create table if not exists scheduling_system.store
(
    id          bigint auto_increment comment '主键',
    create_time datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    name        varchar(30)                        not null comment '名称',
    province    varchar(30)                        null comment '省',
    city        varchar(30)                        null comment '市',
    region      varchar(30)                        null comment '区',
    address     varchar(50)                        null comment '详细地址',
    size        decimal(10, 4)                     null comment '工作场所面积',
    status      tinyint  default 0                 not null comment '0：营业中 1：休息中（默认0）',
    primary key (id, status)
)
    comment '门店表' charset = utf8mb3
                     row_format = DYNAMIC;

create table if not exists scheduling_system.store_flow
(
    id          bigint auto_increment
        primary key,
    store_id    int                                not null,
    year        int                                not null,
    month       int                                not null,
    day         int                                not null,
    flow        varchar(10000)                     not null,
    create_time datetime default CURRENT_TIMESTAMP not null,
    update_time datetime default CURRENT_TIMESTAMP not null
);

create table if not exists scheduling_system.system_scheduled_notice
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

create table if not exists scheduling_system.user_message
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


INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '269', '郗淑', '123456', 0, 60, '1|3|4|5|6|7', '10:00~12:00|17:00~20:20', '8:30', '46:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '270', '柳之', '123456', 0, 22, '1|2|3|4|5|6|7', '09:20~12:40|16:20~19:40', '8:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '275', '夏侯之', '123456', 0, 25, '1|3|5|6|7', '09:40~11:50|14:20~17:30|17:50~20:40', '10:0', '48:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '273', '吉滢', '123456', 0, 30, '1|2|3|4|5', '12:50~15:10|16:10~18:30|18:50~22:40', '9:0', '43:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '273', '独孤杰', '123456', 0, 24, '2|4|5|6|7', '15:10~19:00|19:00~21:40', '8:30', '42:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '274', '蒙飘', '123456', 0, 44, '1|2|4|5|6', '14:50~17:10|18:50~22:40', '9:0', '46:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '274', '卫柔', '123456', 0, 58, '1|4|5|6|7', '08:30~11:50|14:50~18:20|18:50~21:20', '9:30', '47:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:59:13', 0, '12345678900', 1, '276', '白育', '123456', 0, 55, '1|2|3|4|5|6|7', '10:00~12:00|17:10~19:10', '10:0', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678908', 1, '274', '张伟', '123456', 0, 30, '1|2|3|4|5|6|7', '09:00~11:00|14:00~17:00', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678909', 1, '274', '王芳', '123456', 1, 28, '1|3|5', '08:30~11:30|16:00~18:30', '7:00', '38:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678910', 1, '274', '李明', '123456', 0, 35, '2|4|6', '10:00~12:30|17:00~20:00', '8:00', '42:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678911', 1, '274', '赵莉', '123456', 1, 26, '1|5|7', '09:30~12:00|14:00~17:00', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678912', 1, '274', '孙强', '123456', 0, 40, '2|3|4', '08:00~10:00|15:00~18:00', '8:30', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678913', 1, '274', '周艳', '123456', 1, 32, '1|2|6', '10:00~12:00|14:30~18:00', '7:00', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678914', 1, '274', '吴刚', '123456', 0, 38, '3|5|7', '08:30~11:00|13:00~15:30', '8:00', '42:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678915', 1, '274', '郑慧', '123456', 1, 27, '2|4|6', '09:30~12:30|15:30~18:00', '7:30', '39:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678916', 1, '274', '王涛', '123456', 0, 45, '1|3|5', '09:00~11:30|16:00~19:00', '8:30', '43:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678917', 1, '274', '李娜', '123456', 1, 30, '2|4|6|7', '08:30~11:30|14:00~17:00', '8:00', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678918', 1, '274', '刘丽', '123456', 0, 33, '1|3|5', '09:00~12:00|16:00~19:00', '7:30', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678919', 1, '274', '张婷', '123456', 1, 28, '3|4|7', '09:30~12:00|15:00~17:30', '8:00', '39:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678920', 1, '274', '陈敏', '123456', 0, 31, '1|5|6', '10:00~12:30|14:30~18:00', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678921', 1, '274', '杨洁', '123456', 1, 29, '2|3|5', '09:00~11:00|13:30~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678922', 1, '274', '刘翔', '123456', 0, 37, '1|4|6', '10:00~12:00|16:30~19:00', '8:30', '42:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678923', 1, '274', '蔡鑫', '123456', 1, 26, '2|3|4', '09:00~11:30|15:00~18:00', '7:00', '38:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678924', 1, '274', '高峰', '123456', 0, 43, '1|2|5', '10:30~12:00|14:00~17:30', '8:00', '44:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678925', 1, '274', '邹阳', '123456', 1, 25, '3|4|6', '09:30~11:00|14:30~17:00', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678926', 1, '274', '蒋梅', '123456', 0, 32, '1|2|4', '10:00~12:00|15:00~17:00', '8:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678927', 1, '274', '冯雪', '123456', 1, 29, '1|2|3|5', '09:00~11:30|14:00~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678928', 1, '274', '何晨', '123456', 0, 33, '2|4|6', '09:30~11:00|16:00~18:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678929', 1, '274', '高彬', '123456', 0, 36, '1|3|5|7', '08:30~11:30|14:00~17:00', '8:30', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678930', 1, '274', '李娜', '123456', 1, 34, '1|2|4', '10:00~12:30|14:00~17:30', '7:30', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678931', 1, '274', '吴芳', '123456', 1, 31, '3|5|6', '09:00~12:00|16:00~19:00', '8:00', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678932', 1, '274', '邵天', '123456', 0, 37, '2|4|7', '09:30~12:00|14:00~16:30', '8:00', '42:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678933', 1, '274', '唐雯', '123456', 1, 29, '1|3|6', '10:00~12:00|16:00~19:00', '7:30', '39:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678934', 1, '274', '周婷', '123456', 0, 35, '2|4|5', '09:30~12:00|14:30~17:30', '8:00', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678935', 1, '274', '许涛', '123456', 0, 28, '1|3|5|7', '08:00~10:30|16:00~19:00', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678936', 1, '274', '潘华', '123456', 1, 32, '2|3|4', '09:00~12:00|15:30~18:00', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678937', 1, '274', '石磊', '123456', 0, 40, '1|4|7', '09:30~12:00|14:00~17:00', '8:00', '42:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678938', 1, '274', '刘丽', '123456', 1, 27, '2|3|5', '10:00~12:30|14:30~17:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678939', 1, '274', '陈超', '123456', 0, 34, '1|2|4', '09:30~12:00|16:00~18:30', '7:30', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678940', 1, '274', '杜红', '123456', 1, 30, '3|4|6', '08:30~11:00|15:00~17:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678941', 1, '274', '蒋婷', '123456', 0, 26, '2|4|5', '09:00~11:30|14:30~17:00', '7:30', '38:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678942', 1, '274', '魏杰', '123456', 1, 28, '1|3|7', '10:00~12:30|16:00~19:00', '8:00', '39:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678943', 1, '274', '黄明', '123456', 0, 33, '1|2|5', '08:30~11:30|14:00~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678944', 1, '274', '贾丽', '123456', 1, 27, '2|4|6', '09:30~12:00|14:00~17:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678945', 1, '274', '张扬', '123456', 0, 28, '1|2|4', '09:00~11:30|15:00~17:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678946', 1, '274', '刘强', '123456', 1, 30, '3|5|7', '10:00~12:00|14:30~17:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678947', 1, '274', '王珊', '123456', 0, 32, '2|3|5', '09:30~12:00|16:00~18:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678948', 1, '274', '周宇', '123456', 1, 34, '1|2|3', '08:00~10:30|14:00~16:30', '7:30', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678949', 1, '274', '冯涛', '123456', 0, 27, '2|4|6', '09:00~11:30|16:00~18:00', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678950', 1, '274', '谢莉', '123456', 1, 29, '3|5|7', '08:00~11:30|14:30~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678951', 1, '274', '张敏', '123456', 0, 33, '1|3|5', '09:00~12:00|14:00~17:00', '8:00', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678952', 1, '274', '杨青', '123456', 1, 35, '2|4|6', '08:00~10:30|15:00~17:30', '7:30', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678953', 1, '274', '赵莉', '123456', 0, 31, '1|3|5', '09:00~12:00|14:30~17:00', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678954', 1, '274', '李磊', '123456', 1, 38, '2|4|6', '10:00~12:30|15:30~18:00', '8:00', '42:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678955', 1, '274', '邓丽', '123456', 0, 27, '1|2|4', '09:30~11:00|14:00~16:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678956', 1, '274', '王超', '123456', 1, 31, '3|5|7', '08:30~11:30|14:00~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678957', 1, '274', '陈霞', '123456', 0, 32, '1|2|3', '09:00~12:00|14:30~17:00', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678958', 1, '274', '胡静', '123456', 1, 33, '1|4|5', '10:00~12:30|14:30~17:30', '8:00', '40:30');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678959', 1, '274', '贾铭', '123456', 0, 29, '2|3|5', '08:30~11:00|14:00~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678960', 1, '274', '高虹', '123456', 1, 31, '1|3|7', '09:00~12:00|14:30~17:00', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678961', 1, '274', '唐晓', '123456', 0, 34, '2|4|6', '09:30~12:00|15:00~17:30', '8:00', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678962', 1, '274', '程雪', '123456', 1, 28, '1|3|5', '08:00~11:00|14:30~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678963', 1, '274', '宋莉', '123456', 0, 32, '2|3|5', '09:00~11:30|15:30~18:00', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678964', 1, '274', '杜悦', '123456', 0, 27, '1|3|5', '09:00~11:30|14:00~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678965', 1, '274', '何亮', '123456', 1, 30, '2|4|6', '08:30~11:00|14:00~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678966', 1, '274', '梁阳', '123456', 0, 29, '3|5|7', '09:00~12:00|14:30~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678967', 1, '274', '傅琳', '123456', 1, 28, '1|3|5', '09:00~11:30|14:30~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678968', 1, '274', '罗婷', '123456', 0, 33, '2|4|6', '08:00~11:30|14:00~16:30', '8:00', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678969', 1, '274', '毛健', '123456', 1, 31, '1|3|5', '09:00~12:00|14:30~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678970', 1, '274', '唐志', '123456', 0, 27, '3|5|7', '08:00~10:30|14:30~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678971', 1, '274', '霍洋', '123456', 1, 29, '1|4|6', '09:00~11:30|14:00~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678972', 1, '274', '蒋婷', '123456', 0, 32, '2|4|6', '08:00~11:00|14:30~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678973', 1, '274', '郑伟', '123456', 1, 34, '3|5|7', '09:00~12:00|14:00~16:30', '8:00', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678974', 1, '274', '郭雪', '123456', 0, 28, '1|2|5', '08:00~10:30|14:30~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678975', 1, '274', '杜玲', '123456', 1, 30, '3|4|5', '09:00~12:00|14:30~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678976', 1, '274', '彭嘉', '123456', 0, 29, '1|2|6', '08:00~11:00|14:00~16:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678977', 1, '274', '谢慧', '123456', 1, 33, '3|4|5', '09:00~12:00|14:00~16:30', '8:00', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678978', 1, '274', '刘芳', '123456', 0, 31, '1|2|7', '08:30~11:00|14:30~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678979', 1, '274', '王建', '123456', 1, 32, '2|3|6', '09:00~11:30|14:30~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678980', 1, '274', '李琳', '123456', 0, 30, '1|4|6', '09:30~12:00|14:00~16:30', '8:00', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678981', 1, '274', '陈丽', '123456', 1, 27, '3|4|5', '08:30~11:30|14:30~16:30', '7:30', '39:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678982', 1, '274', '邓宇', '123456', 0, 29, '1|2|6', '09:00~11:30|14:00~16:30', '8:00', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678983', 1, '274', '沈婷', '123456', 1, 30, '2|3|5', '08:00~11:00|14:30~16:30', '7:30', '40:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678984', 1, '274', '程明', '123456', 0, 32, '3|4|5', '09:00~12:00|14:30~16:30', '8:00', '41:0');
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week) VALUES ('2024-12-22 11:35:40', '2024-12-22 11:35:40', 0, '12345678985', 1, '274', '彭雪', '123456', 1, 31, '1|4|6', '08:00~11:30|14:30~16:30', '7:30', '40:0');

INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '门店经理', '门店经理', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '门店副经理', '门店副经理', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '收银', '收银', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '导购', '导购', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '库房', '库房', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '测试', '', 1);


INSERT INTO scheduling_system.scheduling_rule (create_time, update_time, is_deleted, store_id, store_work_time_frame, most_work_hour_in_one_day, most_work_hour_in_one_week, min_shift_minute, max_shift_minute, rest_minute, maximum_continuous_work_time, open_store_rule, close_store_rule, normal_rule, no_passenger_rule, minimum_shift_num_in_one_day, normal_shift_rule, lunch_time_rule, dinner_time_rule, rule_type) VALUES ('2024-12-22 16:53:01', '2024-12-22 16:53:01', 0, 1, '{"Mon":["09:00","21:00"],"Tue":["09:00","21:00"],"Wed":["09:00","21:00"],"Thur":["09:00","21:00"],"Fri":["09:00","21:00"],"Sat":["10:00","22:00"],"Sun":["10:00","22:00"]}', 8.0000, 40.0000, 120, 240, 30, 240.0000, '{"variableParam":50,"prepareMinute":30,"positionIdArr":[270,273,274,275,276]}', '{"variableParam1":50,"variableParam2":2,"closeMinute":30,"positionIdArr":[269,270,273,274,275,276]}', '{"variableParam":3.8,"positionIdArr":[269,270,273,274,275,276]}', '{"staffNum":2}', 3, '{"variableParam":3.8,"positionIdArr":[]}', '{"timeFrame":["11:30","13:30"],"needMinute":30}', '{"timeFrame":["17:00","19:00"],"needMinute":30}', 0);

INSERT INTO scheduling_system.store (create_time, update_time, name, province, city, region, address, size, status) VALUES ('2024-12-22 11:47:58', '2024-12-22 11:47:58', '智能排班系统官方店——城阳分店', '浙江省', '杭州市', '西湖区', '人才广场', 100.0000, 0);
INSERT INTO scheduling_system.store (create_time, update_time, name, province, city, region, address, size, status) VALUES ('2024-12-22 11:47:58', '2024-12-22 11:47:58', '智能排班系统官方店——电白分店', '浙江省', '杭州市', '西湖区', '水东镇', 58.0000, 0);

INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 1, '[
    {
        "date": "2024/06/01",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 152.80627740778223
    },
    {
        "date": "2024/06/01",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 154.24658035578085
    },
    {
        "date": "2024/06/01",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 162.87356539401924
    },
    {
        "date": "2024/06/01",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 109.94683865660637
    },
    {
        "date": "2024/06/01",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 134.31916919019392
    },
    {
        "date": "2024/06/01",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 163.68153844134864
    },
    {
        "date": "2024/06/01",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 132.55287503529925
    },
    {
        "date": "2024/06/01",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 175.8813471663057
    },
    {
        "date": "2024/06/01",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 125.5682353819579
    },
    {
        "date": "2024/06/01",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 158.9180491444815
    },
    {
        "date": "2024/06/01",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 128.37190229513234
    },
    {
        "date": "2024/06/01",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 144.72907396998767
    },
    {
        "date": "2024/06/01",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 164.94377490799081
    },
    {
        "date": "2024/06/01",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 139.31199725271253
    },
    {
        "date": "2024/06/01",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 176.2549976385908
    },
    {
        "date": "2024/06/01",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 122.84303531786354
    },
    {
        "date": "2024/06/01",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 153.9217933891846
    },
    {
        "date": "2024/06/01",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 106.89997453641271
    },
    {
        "date": "2024/06/01",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 119.9384769413346
    },
    {
        "date": "2024/06/01",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 143.7791334415699
    },
    {
        "date": "2024/06/01",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 149.13832520722337
    },
    {
        "date": "2024/06/01",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 117.95371585862944
    },
    {
        "date": "2024/06/01",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 170.40771926414038
    },
    {
        "date": "2024/06/01",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 110.44963039551934
    },
    {
        "date": "2024/06/01",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 133.86517269504012
    },
    {
        "date": "2024/06/01",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 123.69296261083154
    },
    {
        "date": "2024/06/01",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 156.9565953620082
    },
    {
        "date": "2024/06/01",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 123.14565960328656
    },
    {
        "date": "2024/06/01",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 114.46177454330262
    },
    {
        "date": "2024/06/01",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 129.9835308692234
    },
    {
        "date": "2024/06/01",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 123.41129525220084
    },
    {
        "date": "2024/06/01",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 146.3307203845901
    },
    {
        "date": "2024/06/01",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 111.94080498131976
    },
    {
        "date": "2024/06/01",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 141.1508618340661
    },
    {
        "date": "2024/06/01",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 134.12981770798456
    },
    {
        "date": "2024/06/01",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 169.1669219375252
    },
    {
        "date": "2024/06/01",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 133.26052499116616
    },
    {
        "date": "2024/06/01",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 166.75537438340058
    },
    {
        "date": "2024/06/01",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 147.97001806196735
    },
    {
        "date": "2024/06/01",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 112.60794249813735
    },
    {
        "date": "2024/06/01",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 174.94475441142407
    },
    {
        "date": "2024/06/01",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 147.1044089474655
    },
    {
        "date": "2024/06/01",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 114.91320218481695
    },
    {
        "date": "2024/06/01",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 163.5774809056897
    },
    {
        "date": "2024/06/01",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 157.93176647706275
    },
    {
        "date": "2024/06/01",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 117.41662035630311
    },
    {
        "date": "2024/06/01",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 155.8369664221193
    },
    {
        "date": "2024/06/01",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 106.64922432669754
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 2, '[
    {
        "date": "2024/06/02",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 125.16625426926547
    },
    {
        "date": "2024/06/02",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 157.90815282014395
    },
    {
        "date": "2024/06/02",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 163.8500666436945
    },
    {
        "date": "2024/06/02",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 133.75413132917856
    },
    {
        "date": "2024/06/02",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 140.77396000884045
    },
    {
        "date": "2024/06/02",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 145.63596680048218
    },
    {
        "date": "2024/06/02",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 176.83377382627577
    },
    {
        "date": "2024/06/02",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 108.36307899048244
    },
    {
        "date": "2024/06/02",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 156.09639688881157
    },
    {
        "date": "2024/06/02",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 113.3121944891048
    },
    {
        "date": "2024/06/02",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 122.97829210677267
    },
    {
        "date": "2024/06/02",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 157.52770218263296
    },
    {
        "date": "2024/06/02",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 175.41351383125362
    },
    {
        "date": "2024/06/02",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 156.8944296278306
    },
    {
        "date": "2024/06/02",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 158.55948772961324
    },
    {
        "date": "2024/06/02",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 107.10953095827865
    },
    {
        "date": "2024/06/02",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 150.44505489021546
    },
    {
        "date": "2024/06/02",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 123.1603346231911
    },
    {
        "date": "2024/06/02",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 109.17025606757933
    },
    {
        "date": "2024/06/02",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 114.88724897797452
    },
    {
        "date": "2024/06/02",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 131.296712191577
    },
    {
        "date": "2024/06/02",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 139.8910242030647
    },
    {
        "date": "2024/06/02",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 174.10258579163448
    },
    {
        "date": "2024/06/02",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 139.80423258098995
    },
    {
        "date": "2024/06/02",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 125.20510039721005
    },
    {
        "date": "2024/06/02",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 167.91615555592597
    },
    {
        "date": "2024/06/02",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 119.77042881079021
    },
    {
        "date": "2024/06/02",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 163.00322687661028
    },
    {
        "date": "2024/06/02",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 111.23597670960561
    },
    {
        "date": "2024/06/02",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 138.9146624131945
    },
    {
        "date": "2024/06/02",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 141.9701872887675
    },
    {
        "date": "2024/06/02",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 134.2923295415131
    },
    {
        "date": "2024/06/02",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 118.20296279913839
    },
    {
        "date": "2024/06/02",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 142.71864336621883
    },
    {
        "date": "2024/06/02",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 125.19473483456207
    },
    {
        "date": "2024/06/02",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 138.2961938958515
    },
    {
        "date": "2024/06/02",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 176.89950684980064
    },
    {
        "date": "2024/06/02",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 118.53385873130922
    },
    {
        "date": "2024/06/02",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 162.5485550543443
    },
    {
        "date": "2024/06/02",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 106.96863685139425
    },
    {
        "date": "2024/06/02",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 164.67461441484386
    },
    {
        "date": "2024/06/02",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 161.16886607447748
    },
    {
        "date": "2024/06/02",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 133.2557015421949
    },
    {
        "date": "2024/06/02",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 142.5776022793615
    },
    {
        "date": "2024/06/02",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 141.23336208212376
    },
    {
        "date": "2024/06/02",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 141.25579470666185
    },
    {
        "date": "2024/06/02",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 115.1089255421376
    },
    {
        "date": "2024/06/02",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 148.52069467347943
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 3, '[
    {
        "date": "2024/06/03",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 109.7060219842872
    },
    {
        "date": "2024/06/03",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 132.34930974059475
    },
    {
        "date": "2024/06/03",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 152.47748620878804
    },
    {
        "date": "2024/06/03",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 127.58925746524221
    },
    {
        "date": "2024/06/03",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 173.7050591318763
    },
    {
        "date": "2024/06/03",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 163.706306346819
    },
    {
        "date": "2024/06/03",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 150.67274074345946
    },
    {
        "date": "2024/06/03",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 144.97126085349657
    },
    {
        "date": "2024/06/03",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 152.87714859760445
    },
    {
        "date": "2024/06/03",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 120.27740910389237
    },
    {
        "date": "2024/06/03",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 140.96483134721979
    },
    {
        "date": "2024/06/03",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 133.1679874240418
    },
    {
        "date": "2024/06/03",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 149.95773371755837
    },
    {
        "date": "2024/06/03",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 119.78235384638153
    },
    {
        "date": "2024/06/03",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 122.9503411815452
    },
    {
        "date": "2024/06/03",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 119.29680785727916
    },
    {
        "date": "2024/06/03",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 136.34855295499096
    },
    {
        "date": "2024/06/03",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 109.89485397894806
    },
    {
        "date": "2024/06/03",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 115.89001152155751
    },
    {
        "date": "2024/06/03",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 161.562095997782
    },
    {
        "date": "2024/06/03",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 155.56394914458292
    },
    {
        "date": "2024/06/03",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 127.32854920556437
    },
    {
        "date": "2024/06/03",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 123.66718580071081
    },
    {
        "date": "2024/06/03",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 114.19857413905468
    },
    {
        "date": "2024/06/03",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 136.52965632459612
    },
    {
        "date": "2024/06/03",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 157.79420962989144
    },
    {
        "date": "2024/06/03",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 120.76183702975904
    },
    {
        "date": "2024/06/03",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 174.92617202484755
    },
    {
        "date": "2024/06/03",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 110.86818163631874
    },
    {
        "date": "2024/06/03",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 176.9892742905854
    },
    {
        "date": "2024/06/03",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 129.09165428149865
    },
    {
        "date": "2024/06/03",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 111.90275293503987
    },
    {
        "date": "2024/06/03",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 122.76772989432617
    },
    {
        "date": "2024/06/03",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 153.58444974463148
    },
    {
        "date": "2024/06/03",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 119.34077908627611
    },
    {
        "date": "2024/06/03",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 154.32078831925327
    },
    {
        "date": "2024/06/03",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 112.40708534284099
    },
    {
        "date": "2024/06/03",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 166.38799600171657
    },
    {
        "date": "2024/06/03",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 109.87850234680964
    },
    {
        "date": "2024/06/03",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 150.5663648152583
    },
    {
        "date": "2024/06/03",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 145.7966829072604
    },
    {
        "date": "2024/06/03",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 134.69692493406902
    },
    {
        "date": "2024/06/03",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 115.16426346388245
    },
    {
        "date": "2024/06/03",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 176.24367864166638
    },
    {
        "date": "2024/06/03",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 130.49656005134858
    },
    {
        "date": "2024/06/03",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 169.28529896842198
    },
    {
        "date": "2024/06/03",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 133.24203139274965
    },
    {
        "date": "2024/06/03",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 106.56537641527912
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 4, '[
    {
        "date": "2024/06/04",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 129.18469636406184
    },
    {
        "date": "2024/06/04",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 132.73335746524037
    },
    {
        "date": "2024/06/04",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 176.1462272928991
    },
    {
        "date": "2024/06/04",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 126.41895679826187
    },
    {
        "date": "2024/06/04",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 127.47471873611464
    },
    {
        "date": "2024/06/04",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 139.06722186489304
    },
    {
        "date": "2024/06/04",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 145.77302243664423
    },
    {
        "date": "2024/06/04",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 116.44163963835106
    },
    {
        "date": "2024/06/04",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 124.71976949456023
    },
    {
        "date": "2024/06/04",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 175.5574110009999
    },
    {
        "date": "2024/06/04",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 132.21496223959082
    },
    {
        "date": "2024/06/04",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 175.0709074521658
    },
    {
        "date": "2024/06/04",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 121.18978377444219
    },
    {
        "date": "2024/06/04",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 175.21545838299
    },
    {
        "date": "2024/06/04",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 134.1135215635041
    },
    {
        "date": "2024/06/04",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 151.9852005621031
    },
    {
        "date": "2024/06/04",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 140.37225490445283
    },
    {
        "date": "2024/06/04",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 166.63140442764208
    },
    {
        "date": "2024/06/04",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 147.6533392894068
    },
    {
        "date": "2024/06/04",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 111.20895867616089
    },
    {
        "date": "2024/06/04",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 160.82201687900715
    },
    {
        "date": "2024/06/04",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 162.71097150332238
    },
    {
        "date": "2024/06/04",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 174.80351051086132
    },
    {
        "date": "2024/06/04",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 111.62855814279791
    },
    {
        "date": "2024/06/04",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 153.97342058674104
    },
    {
        "date": "2024/06/04",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 159.59973067559625
    },
    {
        "date": "2024/06/04",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 130.7054547093742
    },
    {
        "date": "2024/06/04",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 111.55035580888807
    },
    {
        "date": "2024/06/04",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 129.02868994551588
    },
    {
        "date": "2024/06/04",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 160.8226047840243
    },
    {
        "date": "2024/06/04",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 114.71354693575277
    },
    {
        "date": "2024/06/04",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 109.82940665377714
    },
    {
        "date": "2024/06/04",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 164.64912261636454
    },
    {
        "date": "2024/06/04",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 147.8205406470761
    },
    {
        "date": "2024/06/04",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 137.91377606278292
    },
    {
        "date": "2024/06/04",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 156.60712501567315
    },
    {
        "date": "2024/06/04",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 151.70121294358233
    },
    {
        "date": "2024/06/04",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 174.23222928543663
    },
    {
        "date": "2024/06/04",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 127.97742963131626
    },
    {
        "date": "2024/06/04",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 168.21845830361934
    },
    {
        "date": "2024/06/04",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 151.74763885017586
    },
    {
        "date": "2024/06/04",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 134.64725051831164
    },
    {
        "date": "2024/06/04",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 125.15084103799785
    },
    {
        "date": "2024/06/04",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 138.5638898988037
    },
    {
        "date": "2024/06/04",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 148.7234540073111
    },
    {
        "date": "2024/06/04",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 151.94801248775752
    },
    {
        "date": "2024/06/04",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 156.2389516092305
    },
    {
        "date": "2024/06/04",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 158.38887944314857
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 5, '[
    {
        "date": "2024/06/05",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 111.90073531819277
    },
    {
        "date": "2024/06/05",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 135.16145204778599
    },
    {
        "date": "2024/06/05",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 176.20957055700148
    },
    {
        "date": "2024/06/05",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 174.47307311576753
    },
    {
        "date": "2024/06/05",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 121.2203029708548
    },
    {
        "date": "2024/06/05",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 156.75734940237635
    },
    {
        "date": "2024/06/05",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 150.72679156795454
    },
    {
        "date": "2024/06/05",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 155.90392256428416
    },
    {
        "date": "2024/06/05",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 150.1570172107737
    },
    {
        "date": "2024/06/05",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 131.75876886057318
    },
    {
        "date": "2024/06/05",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 162.71627371805357
    },
    {
        "date": "2024/06/05",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 160.39409224287357
    },
    {
        "date": "2024/06/05",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 168.88558155307504
    },
    {
        "date": "2024/06/05",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 170.07103537643852
    },
    {
        "date": "2024/06/05",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 149.57163251055218
    },
    {
        "date": "2024/06/05",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 108.39931018241734
    },
    {
        "date": "2024/06/05",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 123.22663245514607
    },
    {
        "date": "2024/06/05",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 165.28923464769164
    },
    {
        "date": "2024/06/05",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 143.23038546552837
    },
    {
        "date": "2024/06/05",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 168.60307393025005
    },
    {
        "date": "2024/06/05",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 169.078312928995
    },
    {
        "date": "2024/06/05",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 147.51023925389435
    },
    {
        "date": "2024/06/05",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 161.87954167952188
    },
    {
        "date": "2024/06/05",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 145.55692062773815
    },
    {
        "date": "2024/06/05",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 120.57639719347
    },
    {
        "date": "2024/06/05",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 123.95374099807889
    },
    {
        "date": "2024/06/05",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 136.69500873880472
    },
    {
        "date": "2024/06/05",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 121.69966340807387
    },
    {
        "date": "2024/06/05",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 129.07645441967304
    },
    {
        "date": "2024/06/05",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 108.68782843502176
    },
    {
        "date": "2024/06/05",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 130.97570320992418
    },
    {
        "date": "2024/06/05",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 115.22636717977207
    },
    {
        "date": "2024/06/05",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 113.2143884733185
    },
    {
        "date": "2024/06/05",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 155.05813871461964
    },
    {
        "date": "2024/06/05",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 117.90233733584196
    },
    {
        "date": "2024/06/05",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 168.73749506261254
    },
    {
        "date": "2024/06/05",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 116.57712872073422
    },
    {
        "date": "2024/06/05",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 133.13562612522063
    },
    {
        "date": "2024/06/05",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 125.33252870070802
    },
    {
        "date": "2024/06/05",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 133.67100421801558
    },
    {
        "date": "2024/06/05",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 162.10308770528727
    },
    {
        "date": "2024/06/05",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 164.4265355843222
    },
    {
        "date": "2024/06/05",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 109.13799379073966
    },
    {
        "date": "2024/06/05",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 161.8048826793944
    },
    {
        "date": "2024/06/05",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 107.23243577364276
    },
    {
        "date": "2024/06/05",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 152.02914123754505
    },
    {
        "date": "2024/06/05",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 144.59625029305516
    },
    {
        "date": "2024/06/05",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 132.41493019538478
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 6, '[
    {
        "date": "2024/06/06",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 117.84011650610742
    },
    {
        "date": "2024/06/06",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 142.77536337655192
    },
    {
        "date": "2024/06/06",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 118.2683759084506
    },
    {
        "date": "2024/06/06",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 118.38228821457423
    },
    {
        "date": "2024/06/06",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 176.50988966747127
    },
    {
        "date": "2024/06/06",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 151.0613644272999
    },
    {
        "date": "2024/06/06",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 149.42602620315478
    },
    {
        "date": "2024/06/06",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 154.26757121997116
    },
    {
        "date": "2024/06/06",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 168.1456458444685
    },
    {
        "date": "2024/06/06",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 173.24977339195166
    },
    {
        "date": "2024/06/06",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 116.0350425634362
    },
    {
        "date": "2024/06/06",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 174.10313982433505
    },
    {
        "date": "2024/06/06",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 135.66655159772708
    },
    {
        "date": "2024/06/06",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 143.11715859064225
    },
    {
        "date": "2024/06/06",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 162.75963323066384
    },
    {
        "date": "2024/06/06",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 124.40237337923175
    },
    {
        "date": "2024/06/06",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 138.19552802044169
    },
    {
        "date": "2024/06/06",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 124.82392542344118
    },
    {
        "date": "2024/06/06",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 121.42023398793867
    },
    {
        "date": "2024/06/06",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 176.6445511558789
    },
    {
        "date": "2024/06/06",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 136.52593439255648
    },
    {
        "date": "2024/06/06",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 136.69982200798123
    },
    {
        "date": "2024/06/06",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 166.21981891785532
    },
    {
        "date": "2024/06/06",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 176.4661933946193
    },
    {
        "date": "2024/06/06",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 139.3392213181875
    },
    {
        "date": "2024/06/06",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 115.96672259441044
    },
    {
        "date": "2024/06/06",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 127.6475576841588
    },
    {
        "date": "2024/06/06",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 151.17452265236884
    },
    {
        "date": "2024/06/06",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 176.64671429031287
    },
    {
        "date": "2024/06/06",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 131.36140996173805
    },
    {
        "date": "2024/06/06",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 170.27535148313328
    },
    {
        "date": "2024/06/06",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 153.39593525832112
    },
    {
        "date": "2024/06/06",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 152.64156477535457
    },
    {
        "date": "2024/06/06",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 160.27458067304917
    },
    {
        "date": "2024/06/06",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 114.6819314935068
    },
    {
        "date": "2024/06/06",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 124.28215419282671
    },
    {
        "date": "2024/06/06",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 135.7723281163153
    },
    {
        "date": "2024/06/06",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 118.28831652159982
    },
    {
        "date": "2024/06/06",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 146.47085339144442
    },
    {
        "date": "2024/06/06",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 106.31900081256677
    },
    {
        "date": "2024/06/06",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 116.18746710634107
    },
    {
        "date": "2024/06/06",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 113.87275320536233
    },
    {
        "date": "2024/06/06",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 128.59281970472486
    },
    {
        "date": "2024/06/06",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 147.41747461190133
    },
    {
        "date": "2024/06/06",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 151.35052688535762
    },
    {
        "date": "2024/06/06",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 152.6937503294286
    },
    {
        "date": "2024/06/06",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 164.93947198279778
    },
    {
        "date": "2024/06/06",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 163.41412355071822
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 7, '[
    {
        "date": "2024/06/07",
        "startTime": "0:0",
        "endTime": "0:30",
        "passengerFlow": 120.38857830034955
    },
    {
        "date": "2024/06/07",
        "startTime": "0:30",
        "endTime": "1:0",
        "passengerFlow": 141.68681847334986
    },
    {
        "date": "2024/06/07",
        "startTime": "1:0",
        "endTime": "1:30",
        "passengerFlow": 142.64484898653845
    },
    {
        "date": "2024/06/07",
        "startTime": "1:30",
        "endTime": "2:0",
        "passengerFlow": 174.96741583800855
    },
    {
        "date": "2024/06/07",
        "startTime": "2:0",
        "endTime": "2:30",
        "passengerFlow": 167.41192863522076
    },
    {
        "date": "2024/06/07",
        "startTime": "2:30",
        "endTime": "3:0",
        "passengerFlow": 157.56861926448738
    },
    {
        "date": "2024/06/07",
        "startTime": "3:0",
        "endTime": "3:30",
        "passengerFlow": 106.91244611886484
    },
    {
        "date": "2024/06/07",
        "startTime": "3:30",
        "endTime": "4:0",
        "passengerFlow": 140.70912880805122
    },
    {
        "date": "2024/06/07",
        "startTime": "4:0",
        "endTime": "4:30",
        "passengerFlow": 120.83099896388688
    },
    {
        "date": "2024/06/07",
        "startTime": "4:30",
        "endTime": "5:0",
        "passengerFlow": 167.3858596434221
    },
    {
        "date": "2024/06/07",
        "startTime": "5:0",
        "endTime": "5:30",
        "passengerFlow": 140.6798447741458
    },
    {
        "date": "2024/06/07",
        "startTime": "5:30",
        "endTime": "6:0",
        "passengerFlow": 106.99450607219181
    },
    {
        "date": "2024/06/07",
        "startTime": "6:0",
        "endTime": "6:30",
        "passengerFlow": 128.3966441552532
    },
    {
        "date": "2024/06/07",
        "startTime": "6:30",
        "endTime": "7:0",
        "passengerFlow": 127.24239399351075
    },
    {
        "date": "2024/06/07",
        "startTime": "7:0",
        "endTime": "7:30",
        "passengerFlow": 109.63963123639157
    },
    {
        "date": "2024/06/07",
        "startTime": "7:30",
        "endTime": "8:0",
        "passengerFlow": 134.0922059739755
    },
    {
        "date": "2024/06/07",
        "startTime": "8:0",
        "endTime": "8:30",
        "passengerFlow": 153.50308801612425
    },
    {
        "date": "2024/06/07",
        "startTime": "8:30",
        "endTime": "9:0",
        "passengerFlow": 117.09891087895899
    },
    {
        "date": "2024/06/07",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 173.05436381767854
    },
    {
        "date": "2024/06/07",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 111.9648545837995
    },
    {
        "date": "2024/06/07",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 112.41803898781603
    },
    {
        "date": "2024/06/07",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 142.5055322789225
    },
    {
        "date": "2024/06/07",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 157.63506022993272
    },
    {
        "date": "2024/06/07",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 163.51323642110358
    },
    {
        "date": "2024/06/07",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 143.34244015930312
    },
    {
        "date": "2024/06/07",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 165.1062413996698
    },
    {
        "date": "2024/06/07",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 153.09678936949751
    },
    {
        "date": "2024/06/07",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 158.89197142276203
    },
    {
        "date": "2024/06/07",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 140.95269112412785
    },
    {
        "date": "2024/06/07",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 122.34500503716647
    },
    {
        "date": "2024/06/07",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 154.66157987009228
    },
    {
        "date": "2024/06/07",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 144.05175065039072
    },
    {
        "date": "2024/06/07",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 113.9410900400937
    },
    {
        "date": "2024/06/07",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 136.60702124910068
    },
    {
        "date": "2024/06/07",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 170.94803570589622
    },
    {
        "date": "2024/06/07",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 113.22299937207474
    },
    {
        "date": "2024/06/07",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 127.64560407979718
    },
    {
        "date": "2024/06/07",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 175.4445023279458
    },
    {
        "date": "2024/06/07",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 129.3686428172864
    },
    {
        "date": "2024/06/07",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 131.02807681029404
    },
    {
        "date": "2024/06/07",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 137.14800555657396
    },
    {
        "date": "2024/06/07",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 143.1649486654633
    },
    {
        "date": "2024/06/07",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 136.94993637259176
    },
    {
        "date": "2024/06/07",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 140.09391357279566
    },
    {
        "date": "2024/06/07",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 163.4197479591063
    },
    {
        "date": "2024/06/07",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 166.70086501384657
    },
    {
        "date": "2024/06/07",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 174.39730706973768
    },
    {
        "date": "2024/06/07",
        "startTime": "23:30",
        "endTime": "24:0",
        "passengerFlow": 166.83423035162377
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');