create table admin
(
    id          int auto_increment
        primary key,
    create_time datetime default CURRENT_TIMESTAMP not null,
    update_time datetime default CURRENT_TIMESTAMP not null invisible,
    phone       varchar(11)                        not null,
    store_id    int                                null,
    username    varchar(30)                        null,
    password    varchar(255)                       not null,
    gender      tinyint  default 0                 null,
    age         int                                null,
    type        tinyint                            not null
);

create table employee
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
    shift_length_preference_one_week varchar(20)                        null comment '每周班次时长偏好',
    address                          varchar(20)                        null,
    id_card                          varchar(20)                        null
)
    comment '用户表' collate = utf8mb4_bin
                     row_format = DYNAMIC;

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

create table leave_requests
(
    id            int auto_increment
        primary key,
    employee_id   int          not null,
    employee_name varchar(30)  null,
    leave_type    varchar(30)  not null comment '事假,病假,调休',
    start_time    varchar(30)  null comment '开始时间,格式2024-06-01 09:00:00',
    end_time      varchar(30)  null comment '结束时间,格式2024-06-01 09:00:00',
    reason        varchar(500) null,
    status        int          null comment '0 待审批,1已审批,2已驳回',
    apply_time    varchar(100) null comment '申请时间',
    approve_time  varchar(100) null comment '审批时间',
    admin_id      int          null
);

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
    description text                               null comment '职位描述',
    store_id    bigint                             null
)
    comment '职位表' charset = utf8mb3
                     row_format = DYNAMIC;

create table scheduling_date
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

create table scheduling_rule
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

create table scheduling_shift
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

create table scheduling_task
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
    on scheduling_task (store_id);

create table shift_user
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
    on shift_user (shift_id);

create index userId
    on shift_user (user_id);

create table store
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

create table store_flow
(
    id          bigint auto_increment
        primary key,
    store_id    int      default 1                 not null,
    year        int      default 2025              not null,
    month       int      default 1                 not null,
    day         int                                not null,
    flow        varchar(10000)                     null,
    create_time datetime default CURRENT_TIMESTAMP not null,
    update_time datetime default CURRENT_TIMESTAMP not null
);

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

INSERT INTO scheduling_system.admin (create_time, phone, store_id, username, password, gender, age, type) VALUES ('2024-12-26 19:06:37', '4567891230', 1, '张三', '123456', 0, null, 0);
INSERT INTO scheduling_system.admin (create_time, phone, store_id, username, password, gender, age, type) VALUES ('2024-12-26 19:28:16', '1237894560', null, '李四', '123456', 0, null, 1);

INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-28 14:10:46', 0, '9876543210', 1, '5', '夏侯之', '123456', 0, 25, '1|3|5|6|7', '09:40~11:50|14:20~17:30|17:50~20:40', '8:30', '48:0', '111', null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678900', 1, '3', '吉滢', '123456', 0, 30, '1|2|3|4|5', '12:50~15:10|16:10~18:30|18:50~22:40', '9:0', '43:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-27 16:12:25', '2024-12-27 16:12:26', 0, '0123456789', 1, '3', '独孤杰', '123456', 0, 24, '2|4|5|6|7', '15:10~19:00|19:00~21:40', '8:30', '42:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678900', 1, '4', '蒙飘', '123456', 0, 44, '1|2|4|5|6', '14:50~17:10|18:50~22:40', '9:0', '46:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678900', 1, '4', '卫柔', '123456', 0, 58, '1|4|5|6|7', '08:30~11:50|14:50~18:20|18:50~21:20', '9:30', '47:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678908', 1, '4', '张伟', '123456', 0, 30, '1|2|3|4|5|6|7', '09:00~11:00|14:00~17:00', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678909', 1, '4', '王芳', '123456', 1, 28, '1|3|5', '08:30~11:30|16:00~18:30', '7:00', '38:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678910', 1, '4', '李明', '123456', 0, 35, '2|4|6', '10:00~12:30|17:00~20:00', '8:00', '42:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678911', 1, '4', '赵莉', '123456', 1, 26, '1|5|7', '09:30~12:00|14:00~17:00', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678912', 1, '4', '孙强', '123456', 0, 40, '2|3|4', '08:00~10:00|15:00~18:00', '8:30', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678913', 1, '4', '周艳', '123456', 1, 32, '1|2|6', '10:00~12:00|14:30~18:00', '7:00', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678914', 1, '4', '吴刚', '123456', 0, 38, '3|5|7', '08:30~11:00|13:00~15:30', '8:00', '42:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678915', 1, '4', '郑慧', '123456', 1, 27, '2|4|6', '09:30~12:30|15:30~18:00', '7:30', '39:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678916', 1, '4', '王涛', '123456', 0, 45, '1|3|5', '09:00~11:30|16:00~19:00', '8:30', '43:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678917', 1, '4', '李娜', '123456', 1, 30, '2|4|6|7', '08:30~11:30|14:00~17:00', '8:00', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678918', 1, '4', '刘丽', '123456', 0, 33, '1|3|5', '09:00~12:00|16:00~19:00', '7:30', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678919', 1, '4', '张婷', '123456', 1, 28, '3|4|7', '09:30~12:00|15:00~17:30', '8:00', '39:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678920', 1, '4', '陈敏', '123456', 0, 31, '1|5|6', '10:00~12:30|14:30~18:00', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678921', 1, '4', '杨洁', '123456', 1, 29, '2|3|5', '09:00~11:00|13:30~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678922', 1, '4', '刘翔', '123456', 0, 37, '1|4|6', '10:00~12:00|16:30~19:00', '8:30', '42:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678923', 1, '4', '蔡鑫', '123456', 1, 26, '2|3|4', '09:00~11:30|15:00~18:00', '7:00', '38:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678924', 1, '4', '高峰', '123456', 0, 43, '1|2|5', '10:30~12:00|14:00~17:30', '8:00', '44:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678925', 1, '4', '邹阳', '123456', 1, 25, '3|4|6', '09:30~11:00|14:30~17:00', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678926', 1, '4', '蒋梅', '123456', 0, 32, '1|2|4', '10:00~12:00|15:00~17:00', '8:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678927', 1, '4', '冯雪', '123456', 1, 29, '1|2|3|5', '09:00~11:30|14:00~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678928', 1, '4', '何晨', '123456', 0, 33, '2|4|6', '09:30~11:00|16:00~18:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678929', 1, '4', '高彬', '123456', 0, 36, '1|3|5|7', '08:30~11:30|14:00~17:00', '8:30', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678930', 1, '4', '李娜', '123456', 1, 34, '1|2|4', '10:00~12:30|14:00~17:30', '7:30', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678931', 1, '4', '吴芳', '123456', 1, 31, '3|5|6', '09:00~12:00|16:00~19:00', '8:00', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678932', 1, '4', '邵天', '123456', 0, 37, '2|4|7', '09:30~12:00|14:00~16:30', '8:00', '42:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678933', 1, '4', '唐雯', '123456', 1, 29, '1|3|6', '10:00~12:00|16:00~19:00', '7:30', '39:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678934', 1, '4', '周婷', '123456', 0, 35, '2|4|5', '09:30~12:00|14:30~17:30', '8:00', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678935', 1, '4', '许涛', '123456', 0, 28, '1|3|5|7', '08:00~10:30|16:00~19:00', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678936', 1, '4', '潘华', '123456', 1, 32, '2|3|4', '09:00~12:00|15:30~18:00', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678937', 1, '4', '石磊', '123456', 0, 40, '1|4|7', '09:30~12:00|14:00~17:00', '8:00', '42:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678938', 1, '4', '刘丽', '123456', 1, 27, '2|3|5', '10:00~12:30|14:30~17:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678939', 1, '4', '陈超', '123456', 0, 34, '1|2|4', '09:30~12:00|16:00~18:30', '7:30', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678940', 1, '4', '杜红', '123456', 1, 30, '3|4|6', '08:30~11:00|15:00~17:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678941', 1, '4', '蒋婷', '123456', 0, 26, '2|4|5', '09:00~11:30|14:30~17:00', '7:30', '38:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678942', 1, '4', '魏杰', '123456', 1, 28, '1|3|7', '10:00~12:30|16:00~19:00', '8:00', '39:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678943', 1, '4', '黄明', '123456', 0, 33, '1|2|5', '08:30~11:30|14:00~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678944', 1, '4', '贾丽', '123456', 1, 27, '2|4|6', '09:30~12:00|14:00~17:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678945', 1, '4', '张扬', '123456', 0, 28, '1|2|4', '09:00~11:30|15:00~17:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678946', 1, '4', '刘强', '123456', 1, 30, '3|5|7', '10:00~12:00|14:30~17:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678947', 1, '4', '王珊', '123456', 0, 32, '2|3|5', '09:30~12:00|16:00~18:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678948', 1, '4', '周宇', '123456', 1, 34, '1|2|3', '08:00~10:30|14:00~16:30', '7:30', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678949', 1, '4', '冯涛', '123456', 0, 27, '2|4|6', '09:00~11:30|16:00~18:00', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678950', 1, '4', '谢莉', '123456', 1, 29, '3|5|7', '08:00~11:30|14:30~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678951', 1, '4', '张敏', '123456', 0, 33, '1|3|5', '09:00~12:00|14:00~17:00', '8:00', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678952', 1, '4', '杨青', '123456', 1, 35, '2|4|6', '08:00~10:30|15:00~17:30', '7:30', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678953', 1, '4', '赵莉', '123456', 0, 31, '1|3|5', '09:00~12:00|14:30~17:00', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678954', 1, '4', '李磊', '123456', 1, 38, '2|4|6', '10:00~12:30|15:30~18:00', '8:00', '42:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678955', 1, '4', '邓丽', '123456', 0, 27, '1|2|4', '09:30~11:00|14:00~16:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678956', 1, '4', '王超', '123456', 1, 31, '3|5|7', '08:30~11:30|14:00~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678957', 1, '4', '陈霞', '123456', 0, 32, '1|2|3', '09:00~12:00|14:30~17:00', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678958', 1, '4', '胡静', '123456', 1, 33, '1|4|5', '10:00~12:30|14:30~17:30', '8:00', '40:30', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678959', 1, '4', '贾铭', '123456', 0, 29, '2|3|5', '08:30~11:00|14:00~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678960', 1, '4', '高虹', '123456', 1, 31, '1|3|7', '09:00~12:00|14:30~17:00', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678961', 1, '4', '唐晓', '123456', 0, 34, '2|4|6', '09:30~12:00|15:00~17:30', '8:00', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678962', 1, '4', '程雪', '123456', 1, 28, '1|3|5', '08:00~11:00|14:30~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678963', 1, '4', '宋莉', '123456', 0, 32, '2|3|5', '09:00~11:30|15:30~18:00', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678964', 1, '4', '杜悦', '123456', 0, 27, '1|3|5', '09:00~11:30|14:00~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678965', 1, '4', '何亮', '123456', 1, 30, '2|4|6', '08:30~11:00|14:00~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678966', 1, '4', '梁阳', '123456', 0, 29, '3|5|7', '09:00~12:00|14:30~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678967', 1, '4', '傅琳', '123456', 1, 28, '1|3|5', '09:00~11:30|14:30~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678968', 1, '4', '罗婷', '123456', 0, 33, '2|4|6', '08:00~11:30|14:00~16:30', '8:00', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678969', 1, '4', '毛健', '123456', 1, 31, '1|3|5', '09:00~12:00|14:30~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678970', 1, '4', '唐志', '123456', 0, 27, '3|5|7', '08:00~10:30|14:30~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678971', 1, '4', '霍洋', '123456', 1, 29, '1|4|6', '09:00~11:30|14:00~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678972', 1, '4', '蒋婷', '123456', 0, 32, '2|4|6', '08:00~11:00|14:30~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678973', 1, '4', '郑伟', '123456', 1, 34, '3|5|7', '09:00~12:00|14:00~16:30', '8:00', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678974', 1, '4', '郭雪', '123456', 0, 28, '1|2|5', '08:00~10:30|14:30~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678975', 1, '4', '杜玲', '123456', 1, 30, '3|4|5', '09:00~12:00|14:30~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678976', 1, '4', '彭嘉', '123456', 0, 29, '1|2|6', '08:00~11:00|14:00~16:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678977', 1, '4', '谢慧', '123456', 1, 33, '3|4|5', '09:00~12:00|14:00~16:30', '8:00', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678978', 1, '4', '刘芳', '123456', 0, 31, '1|2|7', '08:30~11:00|14:30~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678979', 1, '4', '王建', '123456', 1, 32, '2|3|6', '09:00~11:30|14:30~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678980', 1, '4', '李琳', '123456', 0, 30, '1|4|6', '09:30~12:00|14:00~16:30', '8:00', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678981', 1, '4', '陈丽', '123456', 1, 27, '3|4|5', '08:30~11:30|14:30~16:30', '7:30', '39:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678982', 1, '4', '邓宇', '123456', 0, 29, '1|2|6', '09:00~11:30|14:00~16:30', '8:00', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678983', 1, '4', '沈婷', '123456', 1, 30, '2|3|5', '08:00~11:00|14:30~16:30', '7:30', '40:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:21', 0, '12345678984', 1, '4', '程明', '123456', 0, 32, '3|4|5', '09:00~12:00|14:30~16:30', '8:00', '41:0', null, null);
INSERT INTO scheduling_system.employee (create_time, update_time, is_deleted, phone, store_id, position_id, username, password, gender, age, work_day_preference, work_time_preference, shift_length_preference_one_day, shift_length_preference_one_week, address, id_card) VALUES ('2024-12-22 11:35:40', '2024-12-25 12:37:22', 0, '12345678985', 1, '4', '彭雪', '123456', 1, 31, '1|4|6', '08:00~11:30|14:30~16:30', '7:30', '40:0', null, null);

INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (2, null, '调休', '2024-12-26', '2024-12-31', '', 1, null, null, null);
INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (2, null, '病假', '2024-12-26', '2024-12-28', '', 2, null, null, null);
INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (3, '夏侯之', '调休', '2024-12-26', '2024-12-28', '', 1, null, null, null);
INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (3, '夏侯之', '调休', '2024-12-27', '2024-12-28', '', 1, null, null, null);
INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (3, '夏侯之', '调休', '2024-12-27', '2024-12-28', '', 1, null, null, null);
INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (3, '夏侯之', '调休', '2024-12-28', '2024-12-29', '', 1, null, null, null);
INSERT INTO scheduling_system.leave_requests (employee_id, employee_name, leave_type, start_time, end_time, reason, status, apply_time, approve_time, admin_id) VALUES (3, '夏侯之', '调休', '2024-12-28', '2024-12-30', '', 0, null, null, null);

INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '门店经理', '门店经理', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '门店副经理', '门店副经理', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '收银', '收银', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '导购', '导购', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '库房', '库房', 1);
INSERT INTO scheduling_system.position (create_time, update_time, name, description, store_id) VALUES ('2024-12-22 11:56:40', '2024-12-22 11:56:40', '测试', '', 1);

INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-01 00:00:00', 1, '10:00', '22:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-02 00:00:00', 1, '10:00', '22:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-03 00:00:00', 1, '09:00', '21:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-04 00:00:00', 1, '09:00', '21:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-05 00:00:00', 1, '09:00', '21:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-06 00:00:00', 1, '09:00', '21:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 15:04:55', '2024-06-07 00:00:00', 1, '09:00', '21:00', 1, 16, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-23 00:00:00', 1, '09:00', '21:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-24 00:00:00', 1, '09:00', '21:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-25 00:00:00', 1, '09:00', '21:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-26 00:00:00', 1, '09:00', '21:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-27 00:00:00', 1, '09:00', '21:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-28 00:00:00', 1, '10:00', '22:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES (null, '2024-12-25 20:16:17', '2024-12-29 00:00:00', 1, '10:00', '22:00', 1, 18, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2024-12-30 00:00:00', 1, '09:00', '21:00', 1, 35, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2024-12-31 00:00:00', 1, '09:00', '21:00', 1, 35, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2025-01-01 00:00:00', 1, '09:00', '21:00', 1, 35, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2025-01-02 00:00:00', 1, '09:00', '21:00', 1, 35, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2025-01-03 00:00:00', 1, '09:00', '21:00', 1, 35, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2025-01-04 00:00:00', 1, '10:00', '22:00', 1, 35, 0);
INSERT INTO scheduling_system.scheduling_date (create_time, update_time, date, is_need_work, start_work_time, end_work_time, store_id, task_id, is_have_shift) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', '2025-01-05 00:00:00', 1, '10:00', '22:00', 1, 35, 0);

INSERT INTO scheduling_system.scheduling_rule (create_time, update_time, is_deleted, store_id, store_work_time_frame, most_work_hour_in_one_day, most_work_hour_in_one_week, min_shift_minute, max_shift_minute, rest_minute, maximum_continuous_work_time, open_store_rule, close_store_rule, normal_rule, no_passenger_rule, minimum_shift_num_in_one_day, normal_shift_rule, lunch_time_rule, dinner_time_rule, rule_type) VALUES ('2024-12-22 16:53:01', '2024-12-25 20:16:10', 0, 1, '{"Mon":["09:00","21:00"],"Tue":["09:00","21:00"],"Wed":["09:00","21:00"],"Thur":["09:00","21:00"],"Fri":["09:00","21:00"],"Sat":["10:00","22:00"],"Sun":["10:00","22:00"]}', 8.0000, 40.0000, 120, 240, 30, 240.0000, '{"variableParam":50,"prepareMinute":30,"positionIdArr":[2,3,4,5,6]}', '{"variableParam1":50,"variableParam2":2,"closeMinute":30,"positionIdArr":[1,2,3,4,5,6]}', '{"variableParam":3.8,"positionIdArr":[1,2,3,4,5,6]}', '{"staffNum":2}', 3, '{"variableParam":3.8,"positionIdArr":[]}', '{"timeFrame":["12:00","14:00"],"needMinute":30}', '{"timeFrame":["17:30","19:30"],"needMinute":30}', 0);

INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 14:00:00', '2024-06-01 18:00:00', 106, null, null, 2, 240, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 14:00:00', '2024-06-01 18:00:00', 106, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 12:00:00', '2024-06-01 12:30:00', 0, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:30:00', '2024-06-01 15:30:00', 106, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 11:00:00', '2024-06-01 11:30:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 12:30:00', '2024-06-01 13:00:00', 0, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 12:00:00', '2024-06-01 12:30:00', 0, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 12:00:00', '2024-06-01 16:00:00', 106, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 12:00:00', '2024-06-01 16:00:00', 106, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 14:00:00', '2024-06-01 18:00:00', 106, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 14:00:00', '2024-06-01 18:00:00', 106, null, null, 2, 240, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 12:00:00', '2024-06-01 12:30:00', 0, 210, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 12:30:00', '2024-06-01 13:00:00', 0, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 12:00:00', '2024-06-01 16:00:00', 106, null, null, 2, 240, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 12:30:00', '2024-06-01 16:30:00', 106, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:46:33', 0, '2024-06-01 09:30:00', '2024-06-01 13:30:00', 106, '2024-06-01 12:30:00', '2024-06-01 13:00:00', 0, 210, 1, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 09:30:00', '2024-06-01 13:30:00', 106, '2024-06-01 12:00:00', '2024-06-01 12:30:00', 0, 210, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 11:00:00', '2024-06-01 11:30:00', 0, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 12:30:00', '2024-06-01 13:00:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 12:00:00', '2024-06-01 12:30:00', 0, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 14:00:00', 106, '2024-06-01 11:00:00', '2024-06-01 11:30:00', 0, 210, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:30:00', '2024-06-01 14:30:00', 106, '2024-06-01 11:00:00', '2024-06-01 11:30:00', 0, 210, 0, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 13:00:00', 106, '2024-06-01 11:00:00', '2024-06-01 11:30:00', 0, 150, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 13:00:00', 106, '2024-06-01 12:30:00', '2024-06-01 13:00:00', 0, 150, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 13:00:00', 106, '2024-06-01 12:00:00', '2024-06-01 12:30:00', 0, 150, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:00:00', '2024-06-01 11:30:00', 0, 210, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:30:00', '2024-06-01 12:00:00', 0, 210, 0, '62');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 18:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:30:00', '2024-06-01 12:00:00', 0, 210, 0, '66');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:30:00', '2024-06-01 12:00:00', 0, 210, 0, '69');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:30:00', '2024-06-01 12:00:00', 0, 210, 0, '72');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:30:00', '2024-06-01 12:00:00', 0, 210, 0, '73');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 11:00:00', '2024-06-01 15:00:00', 106, '2024-06-01 11:30:00', '2024-06-01 12:00:00', 0, 210, 0, '77');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 16:30:00', '2024-06-01 17:00:00', 1, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 18:00:00', '2024-06-01 18:30:00', 1, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 17:30:00', '2024-06-01 18:00:00', 1, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 16:00:00', '2024-06-01 20:00:00', 106, '2024-06-01 16:30:00', '2024-06-01 17:00:00', 1, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 16:30:00', '2024-06-01 19:30:00', 106, '2024-06-01 17:00:00', '2024-06-01 17:30:00', 1, 150, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 18:00:00', '2024-06-01 18:30:00', 1, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 17:30:00', '2024-06-01 18:00:00', 1, 210, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 14:00:00', '2024-06-01 18:00:00', 106, null, null, 2, 240, 0, '80');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 18:00:00', '2024-06-01 18:30:00', 1, 210, 0, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 10:00:00', '2024-06-01 13:00:00', 106, '2024-06-01 12:30:00', '2024-06-01 13:00:00', 0, 150, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 17:30:00', '2024-06-01 18:00:00', 1, 210, 0, '81');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 15:00:00', '2024-06-01 19:00:00', 106, '2024-06-01 16:30:00', '2024-06-01 17:00:00', 1, 210, 0, '83');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 16:30:00', '2024-06-01 20:30:00', 106, '2024-06-01 17:00:00', '2024-06-01 17:30:00', 1, 210, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 16:30:00', '2024-06-01 20:30:00', 106, '2024-06-01 17:00:00', '2024-06-01 17:30:00', 1, 210, 0, '62');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 19:00:00', '2024-06-01 22:00:00', 106, null, null, 2, 180, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 20:30:00', '2024-06-01 22:30:00', 106, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 20:30:00', '2024-06-01 22:30:00', 106, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 20:30:00', '2024-06-01 22:30:00', 106, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-01 20:30:00', '2024-06-01 22:30:00', 106, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 09:30:00', '2024-06-02 13:30:00', 107, '2024-06-02 11:00:00', '2024-06-02 11:30:00', 0, 210, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 14:00:00', '2024-06-02 18:00:00', 107, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 14:00:00', 107, '2024-06-02 12:30:00', '2024-06-02 13:00:00', 0, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 14:00:00', 107, '2024-06-02 12:00:00', '2024-06-02 12:30:00', 0, 210, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 14:00:00', 107, '2024-06-02 11:00:00', '2024-06-02 11:30:00', 0, 210, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 17:30:00', '2024-06-02 21:30:00', 107, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 14:00:00', 107, '2024-06-02 12:00:00', '2024-06-02 12:30:00', 0, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 14:00:00', 107, '2024-06-02 12:30:00', '2024-06-02 13:00:00', 0, 210, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:30:00', '2024-06-02 14:30:00', 107, '2024-06-02 12:00:00', '2024-06-02 12:30:00', 0, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 16:30:00', '2024-06-02 17:00:00', 1, 210, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 18:00:00', '2024-06-02 18:30:00', 1, 210, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 17:30:00', '2024-06-02 18:00:00', 1, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 16:30:00', '2024-06-02 17:00:00', 1, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 18:00:00', '2024-06-02 18:30:00', 1, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 17:30:00', '2024-06-02 18:00:00', 1, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 14:00:00', 107, '2024-06-02 11:00:00', '2024-06-02 11:30:00', 0, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:30:00', '2024-06-02 15:30:00', 107, null, null, 2, 240, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 12:00:00', '2024-06-02 16:00:00', 107, null, null, 2, 240, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 12:00:00', '2024-06-02 16:00:00', 107, null, null, 2, 240, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 12:30:00', '2024-06-02 16:30:00', 107, null, null, 2, 240, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 14:00:00', '2024-06-02 18:00:00', 107, null, null, 2, 240, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 09:30:00', '2024-06-02 13:30:00', 107, '2024-06-02 12:30:00', '2024-06-02 13:00:00', 0, 210, 1, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:30:00', '2024-06-02 12:00:00', 0, 210, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:30:00', '2024-06-02 12:00:00', 0, 210, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 14:00:00', '2024-06-02 18:00:00', 107, null, null, 2, 240, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:30:00', '2024-06-02 12:00:00', 0, 210, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:30:00', '2024-06-02 12:00:00', 0, 210, 0, '79');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 17:00:00', '2024-06-02 21:00:00', 107, null, null, 2, 240, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 17:00:00', '2024-06-02 21:00:00', 107, null, null, 2, 240, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 17:00:00', '2024-06-02 17:30:00', 1, 210, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 17:00:00', '2024-06-02 17:30:00', 1, 210, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:00:00', '2024-06-02 20:00:00', 107, '2024-06-02 18:00:00', '2024-06-02 18:30:00', 1, 210, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:00:00', '2024-06-02 20:00:00', 107, '2024-06-02 17:30:00', '2024-06-02 18:00:00', 1, 210, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:30:00', '2024-06-02 18:30:00', 107, '2024-06-02 16:30:00', '2024-06-02 17:00:00', 1, 150, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:00:00', '2024-06-02 19:00:00', 107, '2024-06-02 16:30:00', '2024-06-02 17:00:00', 1, 150, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 15:30:00', '2024-06-02 18:30:00', 107, '2024-06-02 18:00:00', '2024-06-02 18:30:00', 1, 150, 0, '79');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 13:00:00', 107, '2024-06-02 12:30:00', '2024-06-02 13:00:00', 0, 150, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 13:00:00', 107, '2024-06-02 12:00:00', '2024-06-02 12:30:00', 0, 150, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 20:30:00', '2024-06-02 22:30:00', 107, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 13:00:00', 107, '2024-06-02 11:00:00', '2024-06-02 11:30:00', 0, 150, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 13:00:00', 107, '2024-06-02 12:30:00', '2024-06-02 13:00:00', 0, 150, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 13:00:00', 107, '2024-06-02 12:00:00', '2024-06-02 12:30:00', 0, 150, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 10:00:00', '2024-06-02 13:00:00', 107, '2024-06-02 11:00:00', '2024-06-02 11:30:00', 0, 150, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:00:00', '2024-06-02 11:30:00', 0, 210, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:30:00', '2024-06-02 12:00:00', 0, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:00:00', '2024-06-02 15:00:00', 107, '2024-06-02 11:30:00', '2024-06-02 12:00:00', 0, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 11:30:00', '2024-06-02 15:30:00', 107, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 16:30:00', '2024-06-02 17:00:00', 1, 210, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 17:00:00', '2024-06-02 17:30:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 17:30:00', '2024-06-02 18:00:00', 1, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 17:00:00', '2024-06-02 17:30:00', 1, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 16:30:00', '2024-06-02 20:30:00', 107, '2024-06-02 17:00:00', '2024-06-02 17:30:00', 1, 210, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 20:30:00', '2024-06-02 22:30:00', 107, null, null, 2, 120, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 20:30:00', '2024-06-02 22:30:00', 107, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 20:30:00', '2024-06-02 22:30:00', 107, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 20:30:00', '2024-06-02 22:30:00', 107, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-02 20:30:00', '2024-06-02 22:30:00', 107, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 08:30:00', '2024-06-03 12:30:00', 108, null, null, 2, 240, 1, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 08:30:00', '2024-06-03 12:30:00', 108, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 13:30:00', '2024-06-03 17:30:00', 108, null, null, 2, 240, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:00:00', '2024-06-03 13:00:00', 108, '2024-06-03 12:00:00', '2024-06-03 12:30:00', 0, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:00:00', '2024-06-03 13:00:00', 108, '2024-06-03 11:00:00', '2024-06-03 11:30:00', 0, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:30:00', '2024-06-03 15:30:00', 108, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:00:00', '2024-06-03 16:00:00', 108, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:00:00', '2024-06-03 16:00:00', 108, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:00:00', '2024-06-03 16:00:00', 108, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:00:00', '2024-06-03 16:00:00', 108, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:30:00', '2024-06-03 16:30:00', 108, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:30:00', '2024-06-03 16:30:00', 108, null, null, 2, 240, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 12:30:00', '2024-06-03 16:30:00', 108, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:00:00', '2024-06-03 13:00:00', 108, '2024-06-03 12:30:00', '2024-06-03 13:00:00', 0, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:00:00', '2024-06-03 15:00:00', 108, '2024-06-03 11:30:00', '2024-06-03 12:00:00', 0, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 13:30:00', '2024-06-03 17:30:00', 108, null, null, 2, 240, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 13:00:00', '2024-06-03 17:00:00', 108, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 13:00:00', '2024-06-03 17:00:00', 108, null, null, 2, 240, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 10:30:00', '2024-06-03 14:30:00', 108, '2024-06-03 11:00:00', '2024-06-03 11:30:00', 0, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 13:00:00', '2024-06-03 17:00:00', 108, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 10:00:00', '2024-06-03 14:00:00', 108, '2024-06-03 12:30:00', '2024-06-03 13:00:00', 0, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:00:00', '2024-06-03 15:00:00', 108, '2024-06-03 11:30:00', '2024-06-03 12:00:00', 0, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 17:00:00', '2024-06-03 17:30:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 10:00:00', '2024-06-03 14:00:00', 108, '2024-06-03 12:00:00', '2024-06-03 12:30:00', 0, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:30:00', '2024-06-03 13:30:00', 108, '2024-06-03 12:30:00', '2024-06-03 13:00:00', 0, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:00:00', '2024-06-03 15:00:00', 108, '2024-06-03 11:30:00', '2024-06-03 12:00:00', 0, 210, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 17:00:00', '2024-06-03 17:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 10:30:00', '2024-06-03 14:30:00', 108, '2024-06-03 12:00:00', '2024-06-03 12:30:00', 0, 210, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:00:00', '2024-06-03 13:00:00', 108, '2024-06-03 12:00:00', '2024-06-03 12:30:00', 0, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:00:00', '2024-06-03 13:00:00', 108, '2024-06-03 11:00:00', '2024-06-03 11:30:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:30:00', '2024-06-03 13:30:00', 108, '2024-06-03 11:00:00', '2024-06-03 11:30:00', 0, 210, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 17:00:00', '2024-06-03 21:00:00', 108, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:00:00', '2024-06-03 15:00:00', 108, '2024-06-03 11:30:00', '2024-06-03 12:00:00', 0, 210, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 09:00:00', '2024-06-03 13:00:00', 108, '2024-06-03 12:30:00', '2024-06-03 13:00:00', 0, 210, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 15:00:00', '2024-06-03 18:00:00', 108, null, null, 2, 180, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:00:00', '2024-06-03 20:00:00', 108, '2024-06-03 17:30:00', '2024-06-03 18:00:00', 1, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 18:00:00', '2024-06-03 18:30:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 17:30:00', '2024-06-03 18:00:00', 1, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 16:30:00', '2024-06-03 17:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:00:00', '2024-06-03 20:00:00', 108, '2024-06-03 16:30:00', '2024-06-03 17:00:00', 1, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 13:30:00', '2024-06-03 17:30:00', 108, null, null, 2, 240, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 17:00:00', '2024-06-03 17:30:00', 1, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 15:30:00', '2024-06-03 18:30:00', 108, '2024-06-03 18:00:00', '2024-06-03 18:30:00', 1, 150, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 15:30:00', '2024-06-03 18:30:00', 108, '2024-06-03 17:30:00', '2024-06-03 18:00:00', 1, 150, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:00:00', '2024-06-03 14:00:00', 108, '2024-06-03 11:00:00', '2024-06-03 11:30:00', 0, 150, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 11:00:00', '2024-06-03 14:00:00', 108, '2024-06-03 11:30:00', '2024-06-03 12:00:00', 0, 150, 0, '56');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:30:00', '2024-06-03 20:30:00', 108, '2024-06-03 16:30:00', '2024-06-03 17:00:00', 1, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 17:30:00', '2024-06-03 20:30:00', 108, null, null, 2, 180, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 16:00:00', '2024-06-03 18:00:00', 108, null, null, 2, 120, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-03 19:30:00', '2024-06-03 21:30:00', 108, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 08:30:00', '2024-06-04 12:30:00', 109, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 08:30:00', '2024-06-04 12:30:00', 109, null, null, 2, 240, 1, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 13:30:00', '2024-06-04 17:30:00', 109, null, null, 2, 240, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:00:00', '2024-06-04 13:00:00', 109, '2024-06-04 12:00:00', '2024-06-04 12:30:00', 0, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:00:00', '2024-06-04 13:00:00', 109, '2024-06-04 11:00:00', '2024-06-04 11:30:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:30:00', '2024-06-04 15:30:00', 109, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:00:00', '2024-06-04 13:00:00', 109, '2024-06-04 12:30:00', '2024-06-04 13:00:00', 0, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:00:00', '2024-06-04 16:00:00', 109, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:00:00', '2024-06-04 16:00:00', 109, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:30:00', '2024-06-04 16:30:00', 109, null, null, 2, 240, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 13:00:00', '2024-06-04 17:00:00', 109, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:00:00', '2024-06-04 16:00:00', 109, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:30:00', '2024-06-04 16:30:00', 109, null, null, 2, 240, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:30:00', '2024-06-04 16:30:00', 109, null, null, 2, 240, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:00:00', '2024-06-04 15:00:00', 109, '2024-06-04 11:30:00', '2024-06-04 12:00:00', 0, 210, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 13:30:00', '2024-06-04 17:30:00', 109, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 13:00:00', '2024-06-04 17:00:00', 109, null, null, 2, 240, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 13:00:00', '2024-06-04 17:00:00', 109, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 10:30:00', '2024-06-04 14:30:00', 109, '2024-06-04 11:00:00', '2024-06-04 11:30:00', 0, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 12:00:00', '2024-06-04 16:00:00', 109, null, null, 2, 240, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 10:00:00', '2024-06-04 14:00:00', 109, '2024-06-04 12:30:00', '2024-06-04 13:00:00', 0, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:00:00', '2024-06-04 15:00:00', 109, '2024-06-04 11:30:00', '2024-06-04 12:00:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 17:00:00', '2024-06-04 17:30:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 10:00:00', '2024-06-04 14:00:00', 109, '2024-06-04 12:00:00', '2024-06-04 12:30:00', 0, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:30:00', '2024-06-04 13:30:00', 109, '2024-06-04 12:30:00', '2024-06-04 13:00:00', 0, 210, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:00:00', '2024-06-04 15:00:00', 109, '2024-06-04 11:30:00', '2024-06-04 12:00:00', 0, 210, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 17:00:00', '2024-06-04 17:30:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 10:30:00', '2024-06-04 14:30:00', 109, '2024-06-04 12:00:00', '2024-06-04 12:30:00', 0, 210, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:00:00', '2024-06-04 13:00:00', 109, '2024-06-04 12:00:00', '2024-06-04 12:30:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:00:00', '2024-06-04 13:00:00', 109, '2024-06-04 11:00:00', '2024-06-04 11:30:00', 0, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:30:00', '2024-06-04 13:30:00', 109, '2024-06-04 11:00:00', '2024-06-04 11:30:00', 0, 210, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 17:00:00', '2024-06-04 21:00:00', 109, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:00:00', '2024-06-04 15:00:00', 109, '2024-06-04 11:30:00', '2024-06-04 12:00:00', 0, 210, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 09:00:00', '2024-06-04 13:00:00', 109, '2024-06-04 12:30:00', '2024-06-04 13:00:00', 0, 210, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 15:00:00', '2024-06-04 18:00:00', 109, null, null, 2, 180, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:00:00', '2024-06-04 20:00:00', 109, '2024-06-04 17:30:00', '2024-06-04 18:00:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 18:00:00', '2024-06-04 18:30:00', 1, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 17:30:00', '2024-06-04 18:00:00', 1, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 16:30:00', '2024-06-04 17:00:00', 1, 210, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:00:00', '2024-06-04 20:00:00', 109, '2024-06-04 16:30:00', '2024-06-04 17:00:00', 1, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 13:30:00', '2024-06-04 17:30:00', 109, null, null, 2, 240, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 17:00:00', '2024-06-04 17:30:00', 1, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 15:30:00', '2024-06-04 18:30:00', 109, '2024-06-04 18:00:00', '2024-06-04 18:30:00', 1, 150, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 15:30:00', '2024-06-04 18:30:00', 109, '2024-06-04 17:30:00', '2024-06-04 18:00:00', 1, 150, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:00:00', '2024-06-04 14:00:00', 109, '2024-06-04 11:00:00', '2024-06-04 11:30:00', 0, 150, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 11:00:00', '2024-06-04 14:00:00', 109, '2024-06-04 11:30:00', '2024-06-04 12:00:00', 0, 150, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:30:00', '2024-06-04 20:30:00', 109, '2024-06-04 16:30:00', '2024-06-04 17:00:00', 1, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 17:30:00', '2024-06-04 20:30:00', 109, null, null, 2, 180, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 16:00:00', '2024-06-04 18:00:00', 109, null, null, 2, 120, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-04 19:30:00', '2024-06-04 21:30:00', 109, null, null, 2, 120, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 08:30:00', '2024-06-05 12:30:00', 110, null, null, 2, 240, 1, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 12:30:00', '2024-06-05 16:30:00', 110, null, null, 2, 240, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 10:30:00', '2024-06-05 14:30:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 12:30:00', '2024-06-05 16:30:00', 110, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:30:00', '2024-06-05 13:00:00', 0, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 210, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 12:30:00', '2024-06-05 13:00:00', 0, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 12:00:00', '2024-06-05 16:00:00', 110, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 12:30:00', '2024-06-05 16:30:00', 110, null, null, 2, 240, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 210, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 210, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:30:00', '2024-06-05 15:30:00', 110, null, null, 2, 240, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:30:00', '2024-06-05 15:30:00', 110, null, null, 2, 240, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:30:00', '2024-06-05 12:00:00', 0, 210, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 16:30:00', '2024-06-05 20:30:00', 110, '2024-06-05 17:30:00', '2024-06-05 18:00:00', 1, 210, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 16:30:00', '2024-06-05 20:30:00', 110, '2024-06-05 17:00:00', '2024-06-05 17:30:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 10:30:00', '2024-06-05 14:30:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 08:30:00', '2024-06-05 12:30:00', 110, null, null, 2, 240, 1, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 10:30:00', '2024-06-05 14:30:00', 110, '2024-06-05 12:30:00', '2024-06-05 13:00:00', 0, 210, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:30:00', '2024-06-05 13:30:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 210, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 16:30:00', '2024-06-05 20:30:00', 110, '2024-06-05 16:30:00', '2024-06-05 17:00:00', 1, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:30:00', '2024-06-05 13:00:00', 0, 210, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 210, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:30:00', '2024-06-05 13:00:00', 0, 210, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 11:00:00', '2024-06-05 15:00:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 16:30:00', '2024-06-05 20:30:00', 110, '2024-06-05 17:00:00', '2024-06-05 17:30:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 10:00:00', '2024-06-05 13:00:00', 110, '2024-06-05 12:00:00', '2024-06-05 12:30:00', 0, 150, 0, '58');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 19:00:00', 110, '2024-06-05 18:00:00', '2024-06-05 18:30:00', 1, 210, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:00:00', '2024-06-05 21:00:00', 110, null, null, 2, 120, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:30:00', '2024-06-05 13:30:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '60');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 10:00:00', '2024-06-05 14:00:00', 110, '2024-06-05 11:00:00', '2024-06-05 11:30:00', 0, 210, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 16:30:00', '2024-06-05 20:30:00', 110, '2024-06-05 17:00:00', '2024-06-05 17:30:00', 1, 210, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 18:00:00', 110, null, null, 2, 180, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:00:00', '2024-06-05 21:00:00', 110, null, null, 2, 120, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 09:30:00', '2024-06-05 13:30:00', 110, '2024-06-05 12:30:00', '2024-06-05 13:00:00', 0, 210, 0, '63');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 19:00:00', 110, '2024-06-05 16:30:00', '2024-06-05 17:00:00', 1, 210, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 19:00:00', 110, '2024-06-05 16:30:00', '2024-06-05 17:00:00', 1, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 19:00:00', 110, '2024-06-05 18:00:00', '2024-06-05 18:30:00', 1, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 19:00:00', 110, '2024-06-05 17:30:00', '2024-06-05 18:00:00', 1, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:00:00', '2024-06-05 21:00:00', 110, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:00:00', '2024-06-05 21:00:00', 110, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 17:00:00', 110, null, null, 2, 120, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 15:00:00', '2024-06-05 17:00:00', 110, null, null, 2, 120, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:00:00', '2024-06-05 21:00:00', 110, null, null, 2, 120, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:00:00', '2024-06-05 21:00:00', 110, null, null, 2, 120, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-05 19:30:00', '2024-06-05 21:30:00', 110, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 08:30:00', '2024-06-06 12:30:00', 111, null, null, 2, 240, 1, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 08:30:00', '2024-06-06 12:30:00', 111, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 10:30:00', '2024-06-06 14:30:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 12:30:00', '2024-06-06 16:30:00', 111, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:30:00', '2024-06-06 13:00:00', 0, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:30:00', '2024-06-06 13:00:00', 0, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 12:00:00', '2024-06-06 16:00:00', 111, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 12:30:00', '2024-06-06 16:30:00', 111, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:30:00', '2024-06-06 13:30:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:30:00', '2024-06-06 13:30:00', 111, '2024-06-06 12:30:00', '2024-06-06 13:00:00', 0, 210, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:30:00', '2024-06-06 15:30:00', 111, null, null, 2, 240, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:30:00', '2024-06-06 13:30:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:30:00', '2024-06-06 13:00:00', 0, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:30:00', '2024-06-06 15:30:00', 111, null, null, 2, 240, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 16:30:00', '2024-06-06 20:30:00', 111, '2024-06-06 17:30:00', '2024-06-06 18:00:00', 1, 210, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 10:00:00', '2024-06-06 14:00:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 10:30:00', '2024-06-06 14:30:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 210, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 12:30:00', '2024-06-06 16:30:00', 111, null, null, 2, 240, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 10:30:00', '2024-06-06 14:30:00', 111, '2024-06-06 12:30:00', '2024-06-06 13:00:00', 0, 210, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 12:30:00', '2024-06-06 13:00:00', 0, 210, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '56');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 09:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 11:00:00', '2024-06-06 11:30:00', 0, 210, 0, '59');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 11:00:00', '2024-06-06 15:00:00', 111, '2024-06-06 11:30:00', '2024-06-06 12:00:00', 0, 210, 0, '62');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 19:00:00', 111, '2024-06-06 16:30:00', '2024-06-06 17:00:00', 1, 210, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 19:00:00', 111, '2024-06-06 18:00:00', '2024-06-06 18:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 16:30:00', '2024-06-06 20:30:00', 111, '2024-06-06 17:00:00', '2024-06-06 17:30:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 16:30:00', '2024-06-06 20:30:00', 111, '2024-06-06 16:30:00', '2024-06-06 17:00:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 19:00:00', 111, '2024-06-06 18:00:00', '2024-06-06 18:30:00', 1, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 19:00:00', 111, '2024-06-06 17:30:00', '2024-06-06 18:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 19:00:00', 111, '2024-06-06 16:30:00', '2024-06-06 17:00:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:00:00', '2024-06-06 21:00:00', 111, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:00:00', '2024-06-06 21:00:00', 111, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 18:00:00', 111, null, null, 2, 180, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 10:00:00', '2024-06-06 13:00:00', 111, '2024-06-06 12:00:00', '2024-06-06 12:30:00', 0, 150, 0, '66');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 16:30:00', '2024-06-06 20:30:00', 111, '2024-06-06 17:00:00', '2024-06-06 17:30:00', 1, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 16:30:00', '2024-06-06 20:30:00', 111, '2024-06-06 17:00:00', '2024-06-06 17:30:00', 1, 210, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 17:00:00', 111, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 15:00:00', '2024-06-06 17:00:00', 111, null, null, 2, 120, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:00:00', '2024-06-06 21:00:00', 111, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:00:00', '2024-06-06 21:00:00', 111, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:00:00', '2024-06-06 21:00:00', 111, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:00:00', '2024-06-06 21:00:00', 111, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-06 19:30:00', '2024-06-06 21:30:00', 111, null, null, 2, 120, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 15:00:00', 112, null, null, 2, 180, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:30:00', '2024-06-07 16:30:00', 112, null, null, 2, 240, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 11:00:00', 112, null, null, 2, 120, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 11:00:00', 112, null, null, 2, 120, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 08:30:00', '2024-06-07 10:30:00', 112, null, null, 2, 120, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 08:30:00', '2024-06-07 10:30:00', 112, null, null, 2, 120, 1, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 11:00:00', 112, null, null, 2, 120, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 11:00:00', 112, null, null, 2, 120, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 11:00:00', 112, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 13:00:00', 112, '2024-06-07 12:00:00', '2024-06-07 12:30:00', 0, 210, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 13:00:00', 112, '2024-06-07 11:30:00', '2024-06-07 12:00:00', 0, 210, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 20:00:00', 112, '2024-06-07 16:30:00', '2024-06-07 17:00:00', 1, 210, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 14:00:00', 112, null, null, 2, 120, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 14:00:00', 112, null, null, 2, 120, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 14:00:00', 112, null, null, 2, 120, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 15:00:00', 112, null, null, 2, 180, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 15:00:00', 112, null, null, 2, 180, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 16:00:00', 112, null, null, 2, 240, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 09:00:00', '2024-06-07 13:00:00', 112, '2024-06-07 11:00:00', '2024-06-07 11:30:00', 0, 210, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:30:00', '2024-06-07 20:30:00', 112, '2024-06-07 17:00:00', '2024-06-07 17:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 12:00:00', '2024-06-07 15:00:00', 112, null, null, 2, 180, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:00:00', '2024-06-07 21:00:00', 112, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 16:00:00', '2024-06-07 18:00:00', 112, null, null, 2, 120, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:30:00', '2024-06-07 21:30:00', 112, null, null, 2, 120, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:30:00', '2024-06-07 21:30:00', 112, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:30:00', '2024-06-07 21:30:00', 112, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 15:04:55', 0, '2024-06-07 19:30:00', '2024-06-07 21:30:00', 112, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 08:30:00', '2024-12-23 12:30:00', 120, null, null, 2, 240, 1, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 08:30:00', '2024-12-23 12:30:00', 120, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 09:00:00', '2024-12-23 13:00:00', 120, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 09:00:00', '2024-12-23 13:00:00', 120, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 09:00:00', '2024-12-23 13:00:00', 120, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 09:00:00', '2024-12-23 13:00:00', 120, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 09:30:00', '2024-12-23 13:30:00', 120, '2024-12-23 11:30:00', '2024-12-23 12:00:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 12:00:00', '2024-12-23 16:00:00', 120, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 12:00:00', '2024-12-23 16:00:00', 120, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 12:00:00', '2024-12-23 16:00:00', 120, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 12:30:00', '2024-12-23 16:30:00', 120, null, null, 2, 240, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 12:30:00', '2024-12-23 16:30:00', 120, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:00:00', '2024-12-23 15:00:00', 120, '2024-12-23 12:30:00', '2024-12-23 13:00:00', 0, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:00:00', '2024-12-23 15:00:00', 120, '2024-12-23 13:00:00', '2024-12-23 13:30:00', 0, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 12:30:00', '2024-12-23 16:30:00', 120, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 21:00:00', 120, '2024-12-23 17:00:00', '2024-12-23 17:30:00', 1, 210, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 13:00:00', '2024-12-23 17:00:00', 120, null, null, 2, 240, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 21:00:00', 120, '2024-12-23 17:30:00', '2024-12-23 18:00:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:30:00', '2024-12-23 15:30:00', 120, '2024-12-23 12:00:00', '2024-12-23 12:30:00', 0, 210, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 10:00:00', '2024-12-23 14:00:00', 120, '2024-12-23 13:00:00', '2024-12-23 13:30:00', 0, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 13:00:00', '2024-12-23 17:00:00', 120, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 13:00:00', '2024-12-23 17:00:00', 120, null, null, 2, 240, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 10:00:00', '2024-12-23 14:00:00', 120, '2024-12-23 12:30:00', '2024-12-23 13:00:00', 0, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:00:00', '2024-12-23 14:00:00', 120, '2024-12-23 11:30:00', '2024-12-23 12:00:00', 0, 150, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 10:30:00', '2024-12-23 13:30:00', 120, '2024-12-23 12:30:00', '2024-12-23 13:00:00', 0, 150, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:30:00', '2024-12-23 15:30:00', 120, '2024-12-23 12:00:00', '2024-12-23 12:30:00', 0, 210, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 09:30:00', '2024-12-23 13:30:00', 120, '2024-12-23 13:00:00', '2024-12-23 13:30:00', 0, 210, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 10:00:00', '2024-12-23 14:00:00', 120, '2024-12-23 11:30:00', '2024-12-23 12:00:00', 0, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 21:00:00', 120, '2024-12-23 17:30:00', '2024-12-23 18:00:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 13:00:00', '2024-12-23 17:00:00', 120, null, null, 2, 240, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 13:00:00', '2024-12-23 17:00:00', 120, null, null, 2, 240, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:30:00', '2024-12-23 20:30:00', 120, null, null, 2, 180, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 18:00:00', '2024-12-23 21:00:00', 120, null, null, 2, 180, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 18:00:00', '2024-12-23 21:00:00', 120, null, null, 2, 180, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 15:30:00', '2024-12-23 18:30:00', 120, null, null, 2, 180, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 16:30:00', '2024-12-23 19:30:00', 120, '2024-12-23 17:00:00', '2024-12-23 17:30:00', 1, 150, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 16:30:00', '2024-12-23 19:30:00', 120, '2024-12-23 18:30:00', '2024-12-23 19:00:00', 1, 150, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 20:00:00', 120, '2024-12-23 18:30:00', '2024-12-23 19:00:00', 1, 150, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 19:00:00', 120, '2024-12-23 18:00:00', '2024-12-23 18:30:00', 1, 90, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:30:00', '2024-12-23 14:30:00', 120, '2024-12-23 11:30:00', '2024-12-23 12:00:00', 0, 150, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:30:00', '2024-12-23 15:30:00', 120, '2024-12-23 12:00:00', '2024-12-23 12:30:00', 0, 210, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 11:30:00', '2024-12-23 15:30:00', 120, '2024-12-23 12:00:00', '2024-12-23 12:30:00', 0, 210, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 15:30:00', '2024-12-23 18:30:00', 120, null, null, 2, 180, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 15:30:00', '2024-12-23 18:30:00', 120, null, null, 2, 180, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 18:00:00', '2024-12-23 21:00:00', 120, null, null, 2, 180, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 16:00:00', '2024-12-23 19:00:00', 120, '2024-12-23 18:00:00', '2024-12-23 18:30:00', 1, 150, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 19:00:00', 120, '2024-12-23 17:00:00', '2024-12-23 17:30:00', 1, 90, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 17:00:00', '2024-12-23 19:00:00', 120, '2024-12-23 17:30:00', '2024-12-23 18:00:00', 1, 90, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 19:30:00', '2024-12-23 21:30:00', 120, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 19:30:00', '2024-12-23 21:30:00', 120, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 19:30:00', '2024-12-23 21:30:00', 120, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-23 19:30:00', '2024-12-23 21:30:00', 120, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 08:30:00', '2024-12-24 12:30:00', 121, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 08:30:00', '2024-12-24 12:30:00', 121, null, null, 2, 240, 1, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 09:00:00', '2024-12-24 13:00:00', 121, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 09:00:00', '2024-12-24 13:00:00', 121, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 09:00:00', '2024-12-24 13:00:00', 121, null, null, 2, 240, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 09:00:00', '2024-12-24 13:00:00', 121, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 12:00:00', '2024-12-24 16:00:00', 121, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 12:00:00', '2024-12-24 16:00:00', 121, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 12:00:00', '2024-12-24 16:00:00', 121, null, null, 2, 240, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 12:30:00', '2024-12-24 16:30:00', 121, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 12:30:00', '2024-12-24 16:30:00', 121, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 20:00:00', 121, '2024-12-24 17:30:00', '2024-12-24 18:00:00', 1, 150, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 13:00:00', '2024-12-24 17:00:00', 121, null, null, 2, 240, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 13:00:00', '2024-12-24 17:00:00', 121, null, null, 2, 240, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 10:30:00', '2024-12-24 13:30:00', 121, '2024-12-24 12:30:00', '2024-12-24 13:00:00', 0, 150, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 21:00:00', 121, '2024-12-24 18:30:00', '2024-12-24 19:00:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 21:00:00', 121, '2024-12-24 18:00:00', '2024-12-24 18:30:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 11:00:00', '2024-12-24 14:00:00', 121, '2024-12-24 13:00:00', '2024-12-24 13:30:00', 0, 150, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 13:00:00', '2024-12-24 17:00:00', 121, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 11:00:00', '2024-12-24 15:00:00', 121, '2024-12-24 12:30:00', '2024-12-24 13:00:00', 0, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 12:30:00', '2024-12-24 16:30:00', 121, null, null, 2, 240, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 10:00:00', '2024-12-24 14:00:00', 121, '2024-12-24 12:30:00', '2024-12-24 13:00:00', 0, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 10:00:00', '2024-12-24 14:00:00', 121, '2024-12-24 11:30:00', '2024-12-24 12:00:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 21:00:00', 121, '2024-12-24 17:00:00', '2024-12-24 17:30:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 09:30:00', '2024-12-24 13:30:00', 121, '2024-12-24 11:30:00', '2024-12-24 12:00:00', 0, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 09:30:00', '2024-12-24 13:30:00', 121, '2024-12-24 13:00:00', '2024-12-24 13:30:00', 0, 210, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 10:00:00', '2024-12-24 14:00:00', 121, '2024-12-24 13:00:00', '2024-12-24 13:30:00', 0, 210, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 15:30:00', '2024-12-24 18:30:00', 121, null, null, 2, 180, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 11:30:00', '2024-12-24 14:30:00', 121, '2024-12-24 12:00:00', '2024-12-24 12:30:00', 0, 150, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 21:00:00', 121, '2024-12-24 17:30:00', '2024-12-24 18:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 11:30:00', '2024-12-24 15:30:00', 121, '2024-12-24 12:00:00', '2024-12-24 12:30:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 21:00:00', 121, '2024-12-24 17:30:00', '2024-12-24 18:00:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 11:30:00', '2024-12-24 15:30:00', 121, '2024-12-24 12:00:00', '2024-12-24 12:30:00', 0, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:30:00', '2024-12-24 20:30:00', 121, null, null, 2, 180, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:00:00', '2024-12-24 18:00:00', 121, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:00:00', '2024-12-24 18:00:00', 121, null, null, 2, 120, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:30:00', '2024-12-24 18:30:00', 121, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:30:00', '2024-12-24 19:30:00', 121, '2024-12-24 17:00:00', '2024-12-24 17:30:00', 1, 150, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 15:30:00', '2024-12-24 18:30:00', 121, null, null, 2, 180, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:30:00', '2024-12-24 19:30:00', 121, '2024-12-24 18:00:00', '2024-12-24 18:30:00', 1, 150, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:30:00', '2024-12-24 19:30:00', 121, '2024-12-24 18:30:00', '2024-12-24 19:00:00', 1, 150, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 11:30:00', '2024-12-24 14:30:00', 121, '2024-12-24 11:30:00', '2024-12-24 12:00:00', 0, 150, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:00:00', '2024-12-24 19:00:00', 121, '2024-12-24 18:30:00', '2024-12-24 19:00:00', 1, 150, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:00:00', '2024-12-24 19:00:00', 121, '2024-12-24 18:00:00', '2024-12-24 18:30:00', 1, 150, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 21:00:00', 121, '2024-12-24 17:30:00', '2024-12-24 18:00:00', 1, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 16:30:00', '2024-12-24 19:30:00', 121, '2024-12-24 17:00:00', '2024-12-24 17:30:00', 1, 150, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 17:00:00', '2024-12-24 19:00:00', 121, '2024-12-24 17:00:00', '2024-12-24 17:30:00', 1, 90, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 19:30:00', '2024-12-24 21:30:00', 121, null, null, 2, 120, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 19:30:00', '2024-12-24 21:30:00', 121, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 19:30:00', '2024-12-24 21:30:00', 121, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-24 19:30:00', '2024-12-24 21:30:00', 121, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 08:30:00', '2024-12-25 12:30:00', 122, null, null, 2, 240, 1, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 08:30:00', '2024-12-25 12:30:00', 122, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 13:00:00', '2024-12-25 17:00:00', 122, null, null, 2, 240, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 09:00:00', '2024-12-25 13:00:00', 122, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 09:00:00', '2024-12-25 13:00:00', 122, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 09:00:00', '2024-12-25 13:00:00', 122, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:00:00', '2024-12-25 16:00:00', 122, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:00:00', '2024-12-25 16:00:00', 122, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:30:00', '2024-12-25 20:30:00', 122, '2024-12-25 18:30:00', '2024-12-25 19:00:00', 1, 210, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:30:00', '2024-12-25 16:30:00', 122, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:30:00', '2024-12-25 16:30:00', 122, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:30:00', '2024-12-25 16:30:00', 122, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 13:00:00', '2024-12-25 17:00:00', 122, null, null, 2, 240, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 13:00:00', '2024-12-25 17:00:00', 122, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:30:00', '2024-12-25 20:30:00', 122, '2024-12-25 18:30:00', '2024-12-25 19:00:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 17:00:00', '2024-12-25 21:00:00', 122, '2024-12-25 17:30:00', '2024-12-25 18:00:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 17:00:00', '2024-12-25 21:00:00', 122, '2024-12-25 17:30:00', '2024-12-25 18:00:00', 1, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 17:00:00', '2024-12-25 21:00:00', 122, '2024-12-25 17:30:00', '2024-12-25 18:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:30:00', '2024-12-25 20:30:00', 122, '2024-12-25 18:00:00', '2024-12-25 18:30:00', 1, 210, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 17:00:00', '2024-12-25 21:00:00', 122, '2024-12-25 17:00:00', '2024-12-25 17:30:00', 1, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:30:00', '2024-12-25 20:30:00', 122, '2024-12-25 18:00:00', '2024-12-25 18:30:00', 1, 210, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:00:00', '2024-12-25 16:00:00', 122, null, null, 2, 240, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 10:30:00', '2024-12-25 14:30:00', 122, '2024-12-25 13:00:00', '2024-12-25 13:30:00', 0, 210, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 12:00:00', '2024-12-25 16:00:00', 122, null, null, 2, 240, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 09:30:00', '2024-12-25 13:30:00', 122, '2024-12-25 11:30:00', '2024-12-25 12:00:00', 0, 210, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:00:00', '2024-12-25 20:00:00', 122, '2024-12-25 17:00:00', '2024-12-25 17:30:00', 1, 210, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 13:00:00', '2024-12-25 17:00:00', 122, null, null, 2, 240, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 09:00:00', '2024-12-25 13:00:00', 122, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 13:30:00', '2024-12-25 17:30:00', 122, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 11:30:00', '2024-12-25 15:30:00', 122, '2024-12-25 12:00:00', '2024-12-25 12:30:00', 0, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 11:00:00', '2024-12-25 14:00:00', 122, '2024-12-25 12:30:00', '2024-12-25 13:00:00', 0, 150, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 11:30:00', '2024-12-25 14:30:00', 122, '2024-12-25 11:30:00', '2024-12-25 12:00:00', 0, 150, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 10:00:00', '2024-12-25 14:00:00', 122, '2024-12-25 12:30:00', '2024-12-25 13:00:00', 0, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 10:00:00', '2024-12-25 14:00:00', 122, '2024-12-25 11:30:00', '2024-12-25 12:00:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 10:00:00', '2024-12-25 14:00:00', 122, '2024-12-25 13:00:00', '2024-12-25 13:30:00', 0, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 15:30:00', '2024-12-25 18:30:00', 122, null, null, 2, 180, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 15:30:00', '2024-12-25 18:30:00', 122, null, null, 2, 180, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 11:30:00', '2024-12-25 14:30:00', 122, '2024-12-25 12:00:00', '2024-12-25 12:30:00', 0, 150, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 11:30:00', '2024-12-25 15:30:00', 122, '2024-12-25 12:30:00', '2024-12-25 13:00:00', 0, 210, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 11:30:00', '2024-12-25 15:30:00', 122, '2024-12-25 12:00:00', '2024-12-25 12:30:00', 0, 210, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:30:00', '2024-12-25 20:30:00', 122, '2024-12-25 17:00:00', '2024-12-25 17:30:00', 1, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 16:00:00', '2024-12-25 18:00:00', 122, null, null, 2, 120, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-25 19:30:00', '2024-12-25 21:30:00', 122, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-26 19:10:32', 0, '2024-12-26 08:30:00', '2024-12-26 12:30:00', 123, null, null, 2, 240, 1, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 08:30:00', '2024-12-26 12:30:00', 123, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-26 19:08:17', 0, '2024-12-26 09:00:00', '2024-12-26 13:00:00', 123, null, null, 2, 240, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 09:00:00', '2024-12-26 13:00:00', 123, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 09:00:00', '2024-12-26 13:00:00', 123, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-26 19:08:46', 0, '2024-12-26 09:00:00', '2024-12-26 13:00:00', 123, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:00:00', '2024-12-26 16:00:00', 123, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:00:00', '2024-12-26 16:00:00', 123, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:00:00', '2024-12-26 16:00:00', 123, null, null, 2, 240, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:30:00', '2024-12-26 16:30:00', 123, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:30:00', '2024-12-26 16:30:00', 123, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:30:00', '2024-12-26 16:30:00', 123, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 13:00:00', '2024-12-26 17:00:00', 123, null, null, 2, 240, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 13:00:00', '2024-12-26 17:00:00', 123, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:30:00', '2024-12-26 20:30:00', 123, '2024-12-26 18:30:00', '2024-12-26 19:00:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 17:00:00', '2024-12-26 21:00:00', 123, '2024-12-26 17:30:00', '2024-12-26 18:00:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 13:00:00', '2024-12-26 17:00:00', 123, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 17:00:00', '2024-12-26 21:00:00', 123, '2024-12-26 17:30:00', '2024-12-26 18:00:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:30:00', '2024-12-26 20:30:00', 123, '2024-12-26 18:00:00', '2024-12-26 18:30:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 17:00:00', '2024-12-26 21:00:00', 123, '2024-12-26 17:00:00', '2024-12-26 17:30:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 10:00:00', '2024-12-26 14:00:00', 123, '2024-12-26 13:00:00', '2024-12-26 13:30:00', 0, 210, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 12:00:00', '2024-12-26 16:00:00', 123, null, null, 2, 240, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 10:30:00', '2024-12-26 14:30:00', 123, '2024-12-26 13:00:00', '2024-12-26 13:30:00', 0, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 10:00:00', '2024-12-26 14:00:00', 123, '2024-12-26 11:30:00', '2024-12-26 12:00:00', 0, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 09:30:00', '2024-12-26 13:30:00', 123, '2024-12-26 11:30:00', '2024-12-26 12:00:00', 0, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 10:00:00', '2024-12-26 14:00:00', 123, '2024-12-26 12:30:00', '2024-12-26 13:00:00', 0, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 17:00:00', '2024-12-26 21:00:00', 123, '2024-12-26 17:30:00', '2024-12-26 18:00:00', 1, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 13:00:00', '2024-12-26 17:00:00', 123, null, null, 2, 240, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 13:30:00', '2024-12-26 17:30:00', 123, null, null, 2, 240, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 11:30:00', '2024-12-26 15:30:00', 123, '2024-12-26 12:00:00', '2024-12-26 12:30:00', 0, 210, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 11:00:00', '2024-12-26 14:00:00', 123, '2024-12-26 12:30:00', '2024-12-26 13:00:00', 0, 150, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 11:30:00', '2024-12-26 14:30:00', 123, '2024-12-26 11:30:00', '2024-12-26 12:00:00', 0, 150, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:00:00', '2024-12-26 20:00:00', 123, '2024-12-26 17:00:00', '2024-12-26 17:30:00', 1, 210, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:30:00', '2024-12-26 20:30:00', 123, '2024-12-26 18:30:00', '2024-12-26 19:00:00', 1, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:30:00', '2024-12-26 20:30:00', 123, '2024-12-26 18:00:00', '2024-12-26 18:30:00', 1, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 15:30:00', '2024-12-26 18:30:00', 123, null, null, 2, 180, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 15:30:00', '2024-12-26 18:30:00', 123, null, null, 2, 180, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 11:30:00', '2024-12-26 14:30:00', 123, '2024-12-26 12:00:00', '2024-12-26 12:30:00', 0, 150, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 11:30:00', '2024-12-26 15:30:00', 123, '2024-12-26 12:30:00', '2024-12-26 13:00:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 11:30:00', '2024-12-26 15:30:00', 123, '2024-12-26 12:00:00', '2024-12-26 12:30:00', 0, 210, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:30:00', '2024-12-26 20:30:00', 123, '2024-12-26 17:00:00', '2024-12-26 17:30:00', 1, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 16:00:00', '2024-12-26 18:00:00', 123, null, null, 2, 120, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-26 19:30:00', '2024-12-26 21:30:00', 123, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 08:30:00', '2024-12-27 12:30:00', 124, null, null, 2, 240, 1, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 08:30:00', '2024-12-27 12:30:00', 124, null, null, 2, 240, 1, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:00:00', '2024-12-27 13:00:00', 124, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:00:00', '2024-12-27 13:00:00', 124, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:00:00', '2024-12-27 13:00:00', 124, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:00:00', '2024-12-27 13:00:00', 124, null, null, 2, 240, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:00:00', '2024-12-27 13:00:00', 124, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:00:00', '2024-12-27 13:00:00', 124, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:30:00', '2024-12-27 13:30:00', 124, '2024-12-27 12:30:00', '2024-12-27 13:00:00', 0, 210, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:30:00', '2024-12-27 13:30:00', 124, '2024-12-27 11:30:00', '2024-12-27 12:00:00', 0, 210, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 09:30:00', '2024-12-27 13:30:00', 124, '2024-12-27 13:00:00', '2024-12-27 13:30:00', 0, 210, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 10:00:00', '2024-12-27 14:00:00', 124, '2024-12-27 12:30:00', '2024-12-27 13:00:00', 0, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 10:00:00', '2024-12-27 14:00:00', 124, '2024-12-27 11:30:00', '2024-12-27 12:00:00', 0, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 17:00:00', '2024-12-27 21:00:00', 124, '2024-12-27 17:30:00', '2024-12-27 18:00:00', 1, 210, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 17:00:00', '2024-12-27 21:00:00', 124, '2024-12-27 17:30:00', '2024-12-27 18:00:00', 1, 210, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:00:00', '2024-12-27 15:00:00', 124, '2024-12-27 11:30:00', '2024-12-27 12:00:00', 0, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 12:30:00', '2024-12-27 16:30:00', 124, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:00:00', '2024-12-27 15:00:00', 124, '2024-12-27 13:00:00', '2024-12-27 13:30:00', 0, 210, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 12:00:00', '2024-12-27 16:00:00', 124, null, null, 2, 240, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 12:00:00', '2024-12-27 12:30:00', 0, 210, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 13:00:00', '2024-12-27 17:00:00', 124, null, null, 2, 240, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 12:30:00', '2024-12-27 13:00:00', 0, 210, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 13:00:00', '2024-12-27 13:30:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 12:00:00', '2024-12-27 12:30:00', 0, 210, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 12:30:00', '2024-12-27 16:30:00', 124, null, null, 2, 240, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 12:00:00', '2024-12-27 12:30:00', 0, 210, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 10:00:00', '2024-12-27 14:00:00', 124, '2024-12-27 13:00:00', '2024-12-27 13:30:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:00:00', '2024-12-27 14:00:00', 124, '2024-12-27 12:30:00', '2024-12-27 13:00:00', 0, 150, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 10:30:00', '2024-12-27 13:30:00', 124, '2024-12-27 11:30:00', '2024-12-27 12:00:00', 0, 150, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 12:30:00', '2024-12-27 16:30:00', 124, null, null, 2, 240, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 12:00:00', '2024-12-27 12:30:00', 0, 210, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 14:30:00', 124, '2024-12-27 11:30:00', '2024-12-27 12:00:00', 0, 150, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 11:30:00', '2024-12-27 15:30:00', 124, '2024-12-27 12:00:00', '2024-12-27 12:30:00', 0, 210, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 15:30:00', '2024-12-27 19:30:00', 124, '2024-12-27 18:00:00', '2024-12-27 18:30:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 16:30:00', '2024-12-27 20:30:00', 124, '2024-12-27 17:00:00', '2024-12-27 17:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 15:30:00', '2024-12-27 19:30:00', 124, '2024-12-27 18:30:00', '2024-12-27 19:00:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 15:30:00', '2024-12-27 19:30:00', 124, '2024-12-27 18:30:00', '2024-12-27 19:00:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 15:30:00', '2024-12-27 19:30:00', 124, '2024-12-27 17:00:00', '2024-12-27 17:30:00', 1, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 15:30:00', '2024-12-27 19:30:00', 124, '2024-12-27 18:00:00', '2024-12-27 18:30:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 10:30:00', '2024-12-27 13:30:00', 124, '2024-12-27 12:30:00', '2024-12-27 13:00:00', 0, 150, 0, '59');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 18:30:00', '2024-12-27 20:30:00', 124, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-27 19:30:00', '2024-12-27 21:30:00', 124, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 12:00:00', '2024-12-28 16:00:00', 125, null, null, 2, 240, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 12:30:00', '2024-12-28 16:30:00', 125, null, null, 2, 240, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 13:00:00', '2024-12-28 13:30:00', 0, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 12:30:00', '2024-12-28 13:00:00', 0, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 12:30:00', '2024-12-28 13:00:00', 0, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 13:00:00', '2024-12-28 13:30:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 11:30:00', '2024-12-28 12:00:00', 0, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 12:30:00', '2024-12-28 13:00:00', 0, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 14:00:00', 125, '2024-12-28 11:30:00', '2024-12-28 12:00:00', 0, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:00:00', '2024-12-28 15:00:00', 125, '2024-12-28 11:30:00', '2024-12-28 12:00:00', 0, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:00:00', '2024-12-28 15:00:00', 125, '2024-12-28 13:00:00', '2024-12-28 13:30:00', 0, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:00:00', '2024-12-28 15:00:00', 125, '2024-12-28 12:30:00', '2024-12-28 13:00:00', 0, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 11:30:00', '2024-12-28 12:00:00', 0, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:00:00', '2024-12-28 12:30:00', 0, 210, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:30:00', '2024-12-28 14:30:00', 125, '2024-12-28 11:30:00', '2024-12-28 12:00:00', 0, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 18:00:00', '2024-12-28 18:30:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 18:30:00', '2024-12-28 19:00:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 09:30:00', '2024-12-28 13:30:00', 125, '2024-12-28 11:30:00', '2024-12-28 12:00:00', 0, 210, 1, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 17:30:00', '2024-12-28 18:00:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 17:00:00', '2024-12-28 17:30:00', 1, 210, 0, '8');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 18:30:00', '2024-12-28 19:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:30:00', '2024-12-28 13:00:00', 0, 210, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 13:00:00', '2024-12-28 13:30:00', 0, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:00:00', '2024-12-28 12:30:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:00:00', '2024-12-28 12:30:00', 0, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:00:00', '2024-12-28 12:30:00', 0, 210, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 09:30:00', '2024-12-28 13:30:00', 125, '2024-12-28 13:00:00', '2024-12-28 13:30:00', 0, 210, 1, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:30:00', '2024-12-28 13:30:00', 125, '2024-12-28 12:30:00', '2024-12-28 13:00:00', 0, 150, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:00:00', '2024-12-28 12:30:00', 0, 210, 0, '62');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 11:30:00', '2024-12-28 15:30:00', 125, '2024-12-28 12:00:00', '2024-12-28 12:30:00', 0, 210, 0, '66');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 13:00:00', 125, null, null, 2, 180, 0, '69');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 13:00:00', 125, null, null, 2, 180, 0, '72');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 13:00:00', 125, null, null, 2, 180, 0, '73');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 13:00:00', 125, null, null, 2, 180, 0, '77');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 10:00:00', '2024-12-28 13:00:00', 125, null, null, 2, 180, 0, '80');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 18:00:00', '2024-12-28 18:30:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 17:30:00', '2024-12-28 18:00:00', 1, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 15:30:00', '2024-12-28 19:30:00', 125, '2024-12-28 17:00:00', '2024-12-28 17:30:00', 1, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 18:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 180, 0, '1');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '2');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 19:30:00', '2024-12-28 21:30:00', 125, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:00:00', '2024-12-28 22:00:00', 125, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-28 20:30:00', '2024-12-28 22:30:00', 125, null, null, 2, 120, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 09:30:00', '2024-12-29 13:30:00', 126, '2024-12-29 12:30:00', '2024-12-29 13:00:00', 0, 210, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 09:30:00', '2024-12-29 13:30:00', 126, '2024-12-29 11:30:00', '2024-12-29 12:00:00', 0, 210, 1, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:30:00', '2024-12-29 16:30:00', 126, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:30:00', '2024-12-29 16:30:00', 126, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 16:00:00', 126, null, null, 2, 240, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 11:30:00', '2024-12-29 15:30:00', 126, '2024-12-29 12:00:00', '2024-12-29 12:30:00', 0, 210, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 14:00:00', 126, null, null, 2, 120, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 14:00:00', 126, null, null, 2, 120, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 14:00:00', 126, null, null, 2, 120, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 15:00:00', 126, null, null, 2, 180, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 20:00:00', 126, '2024-12-29 17:30:00', '2024-12-29 18:00:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 20:00:00', 126, '2024-12-29 17:00:00', '2024-12-29 17:30:00', 1, 210, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 15:00:00', 126, null, null, 2, 180, 0, '79');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:30:00', '2024-12-29 22:30:00', 126, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 180, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 180, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 180, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '79');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 14:00:00', 126, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 15:00:00', 126, null, null, 2, 180, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 12:00:00', '2024-12-29 15:00:00', 126, null, null, 2, 180, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 16:00:00', '2024-12-29 18:00:00', 126, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:00:00', '2024-12-29 21:00:00', 126, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:00:00', '2024-12-29 21:00:00', 126, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 180, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:30:00', '2024-12-29 21:30:00', 126, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 19:30:00', '2024-12-29 21:30:00', 126, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:00:00', '2024-12-29 22:00:00', 126, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:30:00', '2024-12-29 22:30:00', 126, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:30:00', '2024-12-29 22:30:00', 126, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES (null, '2024-12-25 20:16:17', 0, '2024-12-29 20:30:00', '2024-12-29 22:30:00', 126, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 08:30:00', '2024-12-30 12:30:00', 239, null, null, 2, 240, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 08:30:00', '2024-12-30 12:30:00', 239, null, null, 2, 240, 1, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:00:00', '2024-12-30 13:00:00', 239, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:00:00', '2024-12-30 13:00:00', 239, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:00:00', '2024-12-30 13:00:00', 239, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:00:00', '2024-12-30 13:00:00', 239, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:00:00', '2024-12-30 13:00:00', 239, null, null, 2, 240, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:00:00', '2024-12-30 13:00:00', 239, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:30:00', '2024-12-30 13:30:00', 239, '2024-12-30 12:30:00', '2024-12-30 13:00:00', 0, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 12:00:00', '2024-12-30 16:00:00', 239, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 12:00:00', '2024-12-30 16:00:00', 239, null, null, 2, 240, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 12:00:00', '2024-12-30 16:00:00', 239, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 12:30:00', '2024-12-30 16:30:00', 239, null, null, 2, 240, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 12:30:00', '2024-12-30 16:30:00', 239, null, null, 2, 240, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 12:30:00', '2024-12-30 16:30:00', 239, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 13:00:00', '2024-12-30 17:00:00', 239, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 13:00:00', '2024-12-30 17:00:00', 239, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:30:00', '2024-12-30 13:30:00', 239, '2024-12-30 13:00:00', '2024-12-30 13:30:00', 0, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 10:00:00', '2024-12-30 14:00:00', 239, '2024-12-30 12:30:00', '2024-12-30 13:00:00', 0, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 10:00:00', '2024-12-30 14:00:00', 239, '2024-12-30 11:30:00', '2024-12-30 12:00:00', 0, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 10:00:00', '2024-12-30 14:00:00', 239, '2024-12-30 13:00:00', '2024-12-30 13:30:00', 0, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 10:30:00', '2024-12-30 13:30:00', 239, '2024-12-30 12:30:00', '2024-12-30 13:00:00', 0, 150, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:00:00', '2024-12-30 15:00:00', 239, '2024-12-30 12:30:00', '2024-12-30 13:00:00', 0, 210, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 09:30:00', '2024-12-30 13:30:00', 239, '2024-12-30 11:30:00', '2024-12-30 12:00:00', 0, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 21:00:00', 239, '2024-12-30 18:30:00', '2024-12-30 19:00:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 21:00:00', 239, '2024-12-30 17:00:00', '2024-12-30 17:30:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 21:00:00', 239, '2024-12-30 17:30:00', '2024-12-30 18:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 21:00:00', 239, '2024-12-30 17:30:00', '2024-12-30 18:00:00', 1, 210, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 21:00:00', 239, '2024-12-30 17:30:00', '2024-12-30 18:00:00', 1, 210, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:30:00', '2024-12-30 15:30:00', 239, '2024-12-30 12:00:00', '2024-12-30 12:30:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 21:00:00', 239, '2024-12-30 18:00:00', '2024-12-30 18:30:00', 1, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 13:00:00', '2024-12-30 17:00:00', 239, null, null, 2, 240, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 13:00:00', '2024-12-30 17:00:00', 239, null, null, 2, 240, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 13:00:00', '2024-12-30 17:00:00', 239, null, null, 2, 240, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 13:00:00', '2024-12-30 17:00:00', 239, null, null, 2, 240, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:30:00', '2024-12-30 15:30:00', 239, '2024-12-30 12:00:00', '2024-12-30 12:30:00', 0, 210, 0, '56');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:30:00', '2024-12-30 15:30:00', 239, '2024-12-30 12:00:00', '2024-12-30 12:30:00', 0, 210, 0, '58');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 15:30:00', '2024-12-30 19:30:00', 239, '2024-12-30 17:00:00', '2024-12-30 17:30:00', 1, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:30:00', '2024-12-30 20:30:00', 239, null, null, 2, 180, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 18:00:00', '2024-12-30 21:00:00', 239, null, null, 2, 180, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 18:00:00', '2024-12-30 21:00:00', 239, null, null, 2, 180, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:30:00', '2024-12-30 15:30:00', 239, '2024-12-30 11:30:00', '2024-12-30 12:00:00', 0, 210, 0, '59');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:00:00', '2024-12-30 15:00:00', 239, '2024-12-30 11:30:00', '2024-12-30 12:00:00', 0, 210, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:00:00', '2024-12-30 15:00:00', 239, '2024-12-30 13:00:00', '2024-12-30 13:30:00', 0, 210, 0, '63');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 16:30:00', '2024-12-30 19:30:00', 239, '2024-12-30 18:00:00', '2024-12-30 18:30:00', 1, 150, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 20:00:00', 239, '2024-12-30 17:30:00', '2024-12-30 18:00:00', 1, 150, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 16:30:00', '2024-12-30 19:30:00', 239, '2024-12-30 18:30:00', '2024-12-30 19:00:00', 1, 150, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 11:30:00', '2024-12-30 15:30:00', 239, '2024-12-30 12:00:00', '2024-12-30 12:30:00', 0, 210, 0, '65');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 15:00:00', '2024-12-30 19:00:00', 239, '2024-12-30 17:00:00', '2024-12-30 17:30:00', 1, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 15:30:00', '2024-12-30 18:30:00', 239, null, null, 2, 180, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 15:30:00', '2024-12-30 18:30:00', 239, null, null, 2, 180, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:30:00', '2024-12-30 20:30:00', 239, null, null, 2, 180, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 16:00:00', '2024-12-30 19:00:00', 239, '2024-12-30 18:30:00', '2024-12-30 19:00:00', 1, 150, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 16:00:00', '2024-12-30 19:00:00', 239, '2024-12-30 18:00:00', '2024-12-30 18:30:00', 1, 150, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 17:00:00', '2024-12-30 19:00:00', 239, '2024-12-30 17:00:00', '2024-12-30 17:30:00', 1, 90, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 19:30:00', '2024-12-30 21:30:00', 239, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 19:30:00', '2024-12-30 21:30:00', 239, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 19:30:00', '2024-12-30 21:30:00', 239, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-30 19:30:00', '2024-12-30 21:30:00', 239, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 08:30:00', '2024-12-31 12:30:00', 240, null, null, 2, 240, 1, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 08:30:00', '2024-12-31 12:30:00', 240, null, null, 2, 240, 1, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:00:00', '2024-12-31 13:00:00', 240, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:00:00', '2024-12-31 13:00:00', 240, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:00:00', '2024-12-31 13:00:00', 240, null, null, 2, 240, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:00:00', '2024-12-31 13:00:00', 240, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:00:00', '2024-12-31 13:00:00', 240, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:00:00', '2024-12-31 13:00:00', 240, null, null, 2, 240, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 12:00:00', '2024-12-31 16:00:00', 240, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 12:00:00', '2024-12-31 16:00:00', 240, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 12:30:00', '2024-12-31 16:30:00', 240, null, null, 2, 240, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 12:30:00', '2024-12-31 16:30:00', 240, null, null, 2, 240, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 12:30:00', '2024-12-31 16:30:00', 240, null, null, 2, 240, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 12:30:00', '2024-12-31 16:30:00', 240, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 13:00:00', '2024-12-31 17:00:00', 240, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 13:00:00', '2024-12-31 17:00:00', 240, null, null, 2, 240, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:30:00', '2024-12-31 13:30:00', 240, '2024-12-31 13:00:00', '2024-12-31 13:30:00', 0, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:30:00', '2024-12-31 13:30:00', 240, '2024-12-31 11:30:00', '2024-12-31 12:00:00', 0, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 10:00:00', '2024-12-31 14:00:00', 240, '2024-12-31 11:30:00', '2024-12-31 12:00:00', 0, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 10:00:00', '2024-12-31 14:00:00', 240, '2024-12-31 13:00:00', '2024-12-31 13:30:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 10:00:00', '2024-12-31 14:00:00', 240, '2024-12-31 12:30:00', '2024-12-31 13:00:00', 0, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 13:00:00', '2024-12-31 17:00:00', 240, null, null, 2, 240, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 10:30:00', '2024-12-31 13:30:00', 240, '2024-12-31 13:00:00', '2024-12-31 13:30:00', 0, 150, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 09:30:00', '2024-12-31 13:30:00', 240, '2024-12-31 12:30:00', '2024-12-31 13:00:00', 0, 210, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 18:00:00', '2024-12-31 18:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 18:30:00', '2024-12-31 19:00:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 17:00:00', '2024-12-31 17:30:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 17:30:00', '2024-12-31 18:00:00', 1, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 18:00:00', '2024-12-31 18:30:00', 1, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:00:00', '2024-12-31 15:00:00', 240, '2024-12-31 11:30:00', '2024-12-31 12:00:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 17:30:00', '2024-12-31 18:00:00', 1, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:30:00', '2024-12-31 14:30:00', 240, '2024-12-31 11:30:00', '2024-12-31 12:00:00', 0, 150, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:30:00', '2024-12-31 15:30:00', 240, '2024-12-31 12:00:00', '2024-12-31 12:30:00', 0, 210, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:30:00', '2024-12-31 15:30:00', 240, '2024-12-31 12:30:00', '2024-12-31 13:00:00', 0, 210, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:30:00', '2024-12-31 15:30:00', 240, '2024-12-31 12:00:00', '2024-12-31 12:30:00', 0, 210, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:30:00', '2024-12-31 15:30:00', 240, '2024-12-31 12:00:00', '2024-12-31 12:30:00', 0, 210, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 11:30:00', '2024-12-31 15:30:00', 240, '2024-12-31 12:00:00', '2024-12-31 12:30:00', 0, 210, 0, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 17:30:00', '2024-12-31 18:00:00', 1, 210, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 17:30:00', '2024-12-31 18:00:00', 1, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 21:00:00', 240, '2024-12-31 17:30:00', '2024-12-31 18:00:00', 1, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:30:00', '2024-12-31 20:30:00', 240, null, null, 2, 180, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 15:30:00', '2024-12-31 18:30:00', 240, null, null, 2, 180, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 15:30:00', '2024-12-31 18:30:00', 240, null, null, 2, 180, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 15:30:00', '2024-12-31 18:30:00', 240, null, null, 2, 180, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:30:00', '2024-12-31 19:30:00', 240, '2024-12-31 17:00:00', '2024-12-31 17:30:00', 1, 150, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:00:00', '2024-12-31 19:00:00', 240, '2024-12-31 18:30:00', '2024-12-31 19:00:00', 1, 150, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:30:00', '2024-12-31 19:30:00', 240, '2024-12-31 18:30:00', '2024-12-31 19:00:00', 1, 150, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:30:00', '2024-12-31 19:30:00', 240, '2024-12-31 18:00:00', '2024-12-31 18:30:00', 1, 150, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 15:30:00', '2024-12-31 18:30:00', 240, null, null, 2, 180, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 15:30:00', '2024-12-31 18:30:00', 240, null, null, 2, 180, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:00:00', '2024-12-31 19:00:00', 240, '2024-12-31 17:00:00', '2024-12-31 17:30:00', 1, 150, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 17:00:00', '2024-12-31 20:00:00', 240, '2024-12-31 17:00:00', '2024-12-31 17:30:00', 1, 150, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:00:00', '2024-12-31 19:00:00', 240, '2024-12-31 18:00:00', '2024-12-31 18:30:00', 1, 150, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:30:00', '2024-12-31 19:30:00', 240, '2024-12-31 17:00:00', '2024-12-31 17:30:00', 1, 150, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 16:30:00', '2024-12-31 19:30:00', 240, '2024-12-31 18:30:00', '2024-12-31 19:00:00', 1, 150, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 19:30:00', '2024-12-31 21:30:00', 240, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 19:30:00', '2024-12-31 21:30:00', 240, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 19:30:00', '2024-12-31 21:30:00', 240, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2024-12-31 19:30:00', '2024-12-31 21:30:00', 240, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 08:30:00', '2025-01-01 12:30:00', 241, null, null, 2, 240, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 08:30:00', '2025-01-01 12:30:00', 241, null, null, 2, 240, 1, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:00:00', '2025-01-01 13:00:00', 241, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:00:00', '2025-01-01 13:00:00', 241, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:00:00', '2025-01-01 13:00:00', 241, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:00:00', '2025-01-01 13:00:00', 241, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:00:00', '2025-01-01 13:00:00', 241, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:00:00', '2025-01-01 13:00:00', 241, null, null, 2, 240, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:00:00', '2025-01-01 16:00:00', 241, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:30:00', '2025-01-01 16:30:00', 241, null, null, 2, 240, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:00:00', '2025-01-01 17:00:00', 241, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:30:00', '2025-01-01 16:30:00', 241, null, null, 2, 240, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:30:00', '2025-01-01 16:30:00', 241, null, null, 2, 240, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:30:00', '2025-01-01 16:30:00', 241, null, null, 2, 240, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:00:00', '2025-01-01 16:00:00', 241, null, null, 2, 240, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:00:00', '2025-01-01 16:00:00', 241, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 12:00:00', '2025-01-01 16:00:00', 241, null, null, 2, 240, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:30:00', '2025-01-01 20:30:00', 241, '2025-01-01 17:00:00', '2025-01-01 17:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:30:00', '2025-01-01 13:30:00', 241, '2025-01-01 11:30:00', '2025-01-01 12:00:00', 0, 210, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:30:00', '2025-01-01 20:30:00', 241, '2025-01-01 18:30:00', '2025-01-01 19:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:00:00', '2025-01-01 17:00:00', 241, null, null, 2, 240, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:00:00', '2025-01-01 17:00:00', 241, null, null, 2, 240, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 09:30:00', '2025-01-01 13:30:00', 241, '2025-01-01 12:30:00', '2025-01-01 13:00:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 18:00:00', '2025-01-01 18:30:00', 1, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 18:30:00', '2025-01-01 19:00:00', 1, 210, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 17:00:00', '2025-01-01 17:30:00', 1, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 10:30:00', '2025-01-01 14:30:00', 241, '2025-01-01 13:00:00', '2025-01-01 13:30:00', 0, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 10:30:00', '2025-01-01 14:30:00', 241, '2025-01-01 12:30:00', '2025-01-01 13:00:00', 0, 210, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 17:00:00', '2025-01-01 17:30:00', 1, 210, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 17:30:00', '2025-01-01 18:00:00', 1, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:00:00', '2025-01-01 17:00:00', 241, null, null, 2, 240, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:00:00', '2025-01-01 17:00:00', 241, null, null, 2, 240, 0, '49');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:00:00', '2025-01-01 17:00:00', 241, null, null, 2, 240, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 13:30:00', '2025-01-01 17:30:00', 241, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 10:00:00', '2025-01-01 14:00:00', 241, '2025-01-01 12:30:00', '2025-01-01 13:00:00', 0, 210, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 17:30:00', '2025-01-01 18:00:00', 1, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 17:30:00', '2025-01-01 18:00:00', 1, 210, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 10:00:00', '2025-01-01 14:00:00', 241, '2025-01-01 11:30:00', '2025-01-01 12:00:00', 0, 210, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 11:00:00', '2025-01-01 14:00:00', 241, '2025-01-01 13:00:00', '2025-01-01 13:30:00', 0, 150, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:00:00', '2025-01-01 19:00:00', 241, '2025-01-01 18:00:00', '2025-01-01 18:30:00', 1, 150, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 11:30:00', '2025-01-01 14:30:00', 241, '2025-01-01 11:30:00', '2025-01-01 12:00:00', 0, 150, 0, '58');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 17:00:00', '2025-01-01 21:00:00', 241, '2025-01-01 17:30:00', '2025-01-01 18:00:00', 1, 210, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 11:30:00', '2025-01-01 15:30:00', 241, '2025-01-01 12:00:00', '2025-01-01 12:30:00', 0, 210, 0, '60');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 15:30:00', '2025-01-01 17:30:00', 241, null, null, 2, 120, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:00:00', '2025-01-01 18:00:00', 241, null, null, 2, 120, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 11:30:00', '2025-01-01 15:30:00', 241, '2025-01-01 12:00:00', '2025-01-01 12:30:00', 0, 210, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 11:30:00', '2025-01-01 15:30:00', 241, '2025-01-01 12:00:00', '2025-01-01 12:30:00', 0, 210, 0, '63');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:30:00', '2025-01-01 20:30:00', 241, '2025-01-01 18:00:00', '2025-01-01 18:30:00', 1, 210, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:30:00', '2025-01-01 20:30:00', 241, '2025-01-01 17:00:00', '2025-01-01 17:30:00', 1, 210, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:00:00', '2025-01-01 19:00:00', 241, '2025-01-01 18:30:00', '2025-01-01 19:00:00', 1, 150, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 16:30:00', '2025-01-01 18:30:00', 241, null, null, 2, 120, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-01 19:30:00', '2025-01-01 21:30:00', 241, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 08:30:00', '2025-01-02 12:30:00', 242, null, null, 2, 240, 1, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 08:30:00', '2025-01-02 12:30:00', 242, null, null, 2, 240, 1, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:00:00', '2025-01-02 13:00:00', 242, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:00:00', '2025-01-02 13:00:00', 242, null, null, 2, 240, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:00:00', '2025-01-02 13:00:00', 242, null, null, 2, 240, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:00:00', '2025-01-02 13:00:00', 242, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:00:00', '2025-01-02 13:00:00', 242, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:00:00', '2025-01-02 13:00:00', 242, null, null, 2, 240, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:00:00', '2025-01-02 16:00:00', 242, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:30:00', '2025-01-02 16:30:00', 242, null, null, 2, 240, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:00:00', '2025-01-02 17:00:00', 242, null, null, 2, 240, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:30:00', '2025-01-02 16:30:00', 242, null, null, 2, 240, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:30:00', '2025-01-02 16:30:00', 242, null, null, 2, 240, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:30:00', '2025-01-02 16:30:00', 242, null, null, 2, 240, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:00:00', '2025-01-02 16:00:00', 242, null, null, 2, 240, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:00:00', '2025-01-02 16:00:00', 242, null, null, 2, 240, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 12:00:00', '2025-01-02 16:00:00', 242, null, null, 2, 240, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 10:00:00', '2025-01-02 14:00:00', 242, '2025-01-02 12:30:00', '2025-01-02 13:00:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:30:00', '2025-01-02 13:30:00', 242, '2025-01-02 11:30:00', '2025-01-02 12:00:00', 0, 210, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 10:00:00', '2025-01-02 14:00:00', 242, '2025-01-02 11:30:00', '2025-01-02 12:00:00', 0, 210, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:00:00', '2025-01-02 17:00:00', 242, null, null, 2, 240, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:00:00', '2025-01-02 17:00:00', 242, null, null, 2, 240, 0, '40');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 09:30:00', '2025-01-02 13:30:00', 242, '2025-01-02 12:30:00', '2025-01-02 13:00:00', 0, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 18:00:00', '2025-01-02 18:30:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 18:30:00', '2025-01-02 19:00:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 17:00:00', '2025-01-02 17:30:00', 1, 210, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 10:30:00', '2025-01-02 14:30:00', 242, '2025-01-02 13:00:00', '2025-01-02 13:30:00', 0, 210, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 10:30:00', '2025-01-02 14:30:00', 242, '2025-01-02 12:30:00', '2025-01-02 13:00:00', 0, 210, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 17:00:00', '2025-01-02 17:30:00', 1, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 17:30:00', '2025-01-02 18:00:00', 1, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:00:00', '2025-01-02 17:00:00', 242, null, null, 2, 240, 0, '46');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:00:00', '2025-01-02 17:00:00', 242, null, null, 2, 240, 0, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:00:00', '2025-01-02 17:00:00', 242, null, null, 2, 240, 0, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 13:30:00', '2025-01-02 17:30:00', 242, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 17:30:00', '2025-01-02 18:00:00', 1, 210, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 17:30:00', '2025-01-02 18:00:00', 1, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:30:00', '2025-01-02 20:30:00', 242, '2025-01-02 17:00:00', '2025-01-02 17:30:00', 1, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:30:00', '2025-01-02 20:30:00', 242, '2025-01-02 18:30:00', '2025-01-02 19:00:00', 1, 210, 0, '31');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 11:00:00', '2025-01-02 14:00:00', 242, '2025-01-02 13:00:00', '2025-01-02 13:30:00', 0, 150, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:00:00', '2025-01-02 19:00:00', 242, '2025-01-02 18:00:00', '2025-01-02 18:30:00', 1, 150, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 11:30:00', '2025-01-02 14:30:00', 242, '2025-01-02 11:30:00', '2025-01-02 12:00:00', 0, 150, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 17:00:00', '2025-01-02 21:00:00', 242, '2025-01-02 17:30:00', '2025-01-02 18:00:00', 1, 210, 0, '27');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 11:30:00', '2025-01-02 15:30:00', 242, '2025-01-02 12:00:00', '2025-01-02 12:30:00', 0, 210, 0, '56');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 15:30:00', '2025-01-02 17:30:00', 242, null, null, 2, 120, 0, '37');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:00:00', '2025-01-02 18:00:00', 242, null, null, 2, 120, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 11:30:00', '2025-01-02 15:30:00', 242, '2025-01-02 12:00:00', '2025-01-02 12:30:00', 0, 210, 0, '59');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 11:30:00', '2025-01-02 15:30:00', 242, '2025-01-02 12:00:00', '2025-01-02 12:30:00', 0, 210, 0, '62');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:30:00', '2025-01-02 20:30:00', 242, '2025-01-02 18:00:00', '2025-01-02 18:30:00', 1, 210, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:30:00', '2025-01-02 20:30:00', 242, '2025-01-02 17:00:00', '2025-01-02 17:30:00', 1, 210, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:00:00', '2025-01-02 19:00:00', 242, '2025-01-02 18:30:00', '2025-01-02 19:00:00', 1, 150, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 16:30:00', '2025-01-02 18:30:00', 242, null, null, 2, 120, 0, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-02 19:30:00', '2025-01-02 21:30:00', 242, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 08:30:00', '2025-01-03 12:30:00', 243, null, null, 2, 240, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 08:30:00', '2025-01-03 12:30:00', 243, null, null, 2, 240, 1, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:00:00', '2025-01-03 13:00:00', 243, null, null, 2, 240, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:30:00', '2025-01-03 13:30:00', 243, '2025-01-03 12:30:00', '2025-01-03 13:00:00', 0, 210, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:30:00', '2025-01-03 13:30:00', 243, '2025-01-03 11:30:00', '2025-01-03 12:00:00', 0, 210, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 09:30:00', '2025-01-03 13:30:00', 243, '2025-01-03 13:00:00', '2025-01-03 13:30:00', 0, 210, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 12:00:00', '2025-01-03 16:00:00', 243, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 17:00:00', '2025-01-03 21:00:00', 243, '2025-01-03 17:30:00', '2025-01-03 18:00:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 17:00:00', '2025-01-03 21:00:00', 243, '2025-01-03 18:00:00', '2025-01-03 18:30:00', 1, 210, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 17:00:00', '2025-01-03 21:00:00', 243, '2025-01-03 17:30:00', '2025-01-03 18:00:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:00:00', '2025-01-03 15:00:00', 243, '2025-01-03 11:30:00', '2025-01-03 12:00:00', 0, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 12:30:00', '2025-01-03 16:30:00', 243, null, null, 2, 240, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:00:00', '2025-01-03 15:00:00', 243, '2025-01-03 13:00:00', '2025-01-03 13:30:00', 0, 210, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 12:30:00', '2025-01-03 16:30:00', 243, null, null, 2, 240, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 17:00:00', '2025-01-03 21:00:00', 243, '2025-01-03 17:00:00', '2025-01-03 17:30:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 12:30:00', '2025-01-03 16:30:00', 243, null, null, 2, 240, 0, '39');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 12:30:00', '2025-01-03 16:30:00', 243, null, null, 2, 240, 0, '42');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 15:30:00', 243, '2025-01-03 12:00:00', '2025-01-03 12:30:00', 0, 210, 0, '44');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 14:30:00', 243, '2025-01-03 11:30:00', '2025-01-03 12:00:00', 0, 150, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 15:30:00', 243, '2025-01-03 12:00:00', '2025-01-03 12:30:00', 0, 210, 0, '48');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 15:30:00', 243, '2025-01-03 12:00:00', '2025-01-03 12:30:00', 0, 210, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 15:30:00', 243, '2025-01-03 12:00:00', '2025-01-03 12:30:00', 0, 210, 0, '52');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 14:30:00', 243, '2025-01-03 12:00:00', '2025-01-03 12:30:00', 0, 150, 0, '54');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:30:00', '2025-01-03 15:30:00', 243, '2025-01-03 12:30:00', '2025-01-03 13:00:00', 0, 210, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 17:00:00', '2025-01-03 21:00:00', 243, '2025-01-03 17:30:00', '2025-01-03 18:00:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 11:00:00', '2025-01-03 14:00:00', 243, '2025-01-03 12:30:00', '2025-01-03 13:00:00', 0, 150, 0, '59');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 13:00:00', '2025-01-03 17:00:00', 243, null, null, 2, 240, 0, '60');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 13:00:00', '2025-01-03 17:00:00', 243, null, null, 2, 240, 0, '63');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 13:00:00', '2025-01-03 17:00:00', 243, null, null, 2, 240, 0, '64');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 13:00:00', '2025-01-03 17:00:00', 243, null, null, 2, 240, 0, '65');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 16:30:00', '2025-01-03 20:30:00', 243, '2025-01-03 18:00:00', '2025-01-03 18:30:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 15:30:00', '2025-01-03 19:30:00', 243, '2025-01-03 17:00:00', '2025-01-03 17:30:00', 1, 210, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 10:00:00', '2025-01-03 14:00:00', 243, '2025-01-03 13:00:00', '2025-01-03 13:30:00', 0, 210, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 15:30:00', '2025-01-03 19:30:00', 243, '2025-01-03 18:30:00', '2025-01-03 19:00:00', 1, 210, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 15:30:00', '2025-01-03 19:30:00', 243, '2025-01-03 18:00:00', '2025-01-03 18:30:00', 1, 210, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 10:30:00', '2025-01-03 13:30:00', 243, '2025-01-03 12:30:00', '2025-01-03 13:00:00', 0, 150, 0, '68');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 10:00:00', '2025-01-03 14:00:00', 243, '2025-01-03 11:30:00', '2025-01-03 12:00:00', 0, 210, 0, '70');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 16:30:00', '2025-01-03 20:30:00', 243, '2025-01-03 17:00:00', '2025-01-03 17:30:00', 1, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 16:30:00', '2025-01-03 20:30:00', 243, '2025-01-03 18:30:00', '2025-01-03 19:00:00', 1, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 10:30:00', '2025-01-03 13:30:00', 243, '2025-01-03 11:30:00', '2025-01-03 12:00:00', 0, 150, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 10:30:00', '2025-01-03 13:30:00', 243, '2025-01-03 13:00:00', '2025-01-03 13:30:00', 0, 150, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 18:30:00', '2025-01-03 20:30:00', 243, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '13');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '24');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-03 19:30:00', '2025-01-03 21:30:00', 243, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 12:30:00', '2025-01-04 16:30:00', 244, null, null, 2, 240, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 14:30:00', '2025-01-04 18:30:00', 244, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 13:00:00', '2025-01-04 13:30:00', 0, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 12:30:00', '2025-01-04 13:00:00', 0, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 17:00:00', '2025-01-04 21:00:00', 244, '2025-01-04 17:30:00', '2025-01-04 18:00:00', 1, 210, 0, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 12:30:00', '2025-01-04 13:00:00', 0, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 13:00:00', '2025-01-04 13:30:00', 0, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:00:00', '2025-01-04 19:00:00', 244, '2025-01-04 18:30:00', '2025-01-04 19:00:00', 1, 210, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:00:00', '2025-01-04 15:00:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:00:00', '2025-01-04 15:00:00', 244, '2025-01-04 13:00:00', '2025-01-04 13:30:00', 0, 210, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:00:00', '2025-01-04 15:00:00', 244, '2025-01-04 12:30:00', '2025-01-04 13:00:00', 0, 210, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 12:00:00', '2025-01-04 16:00:00', 244, null, null, 2, 240, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 12:30:00', '2025-01-04 16:30:00', 244, null, null, 2, 240, 0, '41');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 09:30:00', '2025-01-04 13:30:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 1, '45');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 09:30:00', '2025-01-04 13:30:00', 244, '2025-01-04 13:00:00', '2025-01-04 13:30:00', 0, 210, 1, '50');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 17:00:00', '2025-01-04 17:30:00', 1, 210, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 18:30:00', '2025-01-04 19:00:00', 1, 210, 0, '9');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 18:00:00', '2025-01-04 18:30:00', 1, 210, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 17:30:00', '2025-01-04 18:00:00', 1, 210, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 12:30:00', '2025-01-04 13:00:00', 0, 210, 0, '53');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:30:00', '2025-01-04 14:30:00', 244, '2025-01-04 12:30:00', '2025-01-04 13:00:00', 0, 210, 0, '55');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:30:00', '2025-01-04 14:30:00', 244, '2025-01-04 11:30:00', '2025-01-04 12:00:00', 0, 210, 0, '62');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '66');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '69');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:30:00', '2025-01-04 13:00:00', 0, 210, 0, '72');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '73');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '77');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '80');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '81');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 11:30:00', '2025-01-04 15:30:00', 244, '2025-01-04 12:00:00', '2025-01-04 12:30:00', 0, 210, 0, '83');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:30:00', '2025-01-04 14:30:00', 244, '2025-01-04 13:00:00', '2025-01-04 13:30:00', 0, 210, 0, '86');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 17:00:00', '2025-01-04 17:30:00', 1, 210, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 18:00:00', '2025-01-04 18:30:00', 1, 210, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 16:30:00', '2025-01-04 20:30:00', 244, '2025-01-04 17:00:00', '2025-01-04 17:30:00', 1, 210, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 15:30:00', '2025-01-04 19:30:00', 244, '2025-01-04 17:30:00', '2025-01-04 18:00:00', 1, 210, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 18:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 180, 0, '29');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 18:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 180, 0, '32');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 13:00:00', 244, null, null, 2, 180, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 13:00:00', 244, null, null, 2, 180, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 13:00:00', 244, null, null, 2, 180, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 13:00:00', 244, null, null, 2, 180, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 13:00:00', 244, null, null, 2, 180, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 10:00:00', '2025-01-04 14:00:00', 244, '2025-01-04 13:00:00', '2025-01-04 13:30:00', 0, 210, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '4');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 19:30:00', '2025-01-04 21:30:00', 244, null, null, 2, 120, 0, '22');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:00:00', '2025-01-04 22:00:00', 244, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:00:00', '2025-01-04 22:00:00', 244, null, null, 2, 120, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '28');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '34');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '35');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-04 20:30:00', '2025-01-04 22:30:00', 244, null, null, 2, 120, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-05 09:30:00', '2025-01-05 13:30:00', 245, '2025-01-05 12:30:00', '2025-01-05 13:00:00', 0, 210, 1, '3');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-05 09:30:00', '2025-01-05 13:30:00', 245, '2025-01-05 11:30:00', '2025-01-05 12:00:00', 0, 210, 1, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-05 12:30:00', '2025-01-05 16:30:00', 245, null, null, 2, 240, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-05 12:30:00', '2025-01-05 16:30:00', 245, null, null, 2, 240, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:22', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '30');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '33');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '38');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '47');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '51');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '57');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 16:00:00', 245, null, null, 2, 240, 0, '61');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 11:30:00', '2025-01-05 15:30:00', 245, '2025-01-05 12:00:00', '2025-01-05 12:30:00', 0, 210, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 14:00:00', 245, null, null, 2, 120, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 15:00:00', 245, null, null, 2, 180, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 15:00:00', 245, null, null, 2, 180, 0, '79');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 20:00:00', 245, '2025-01-05 17:00:00', '2025-01-05 17:30:00', 1, 210, 0, '67');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:30:00', '2025-01-05 20:30:00', 245, '2025-01-05 17:30:00', '2025-01-05 18:00:00', 1, 210, 0, '5');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:30:00', '2025-01-05 22:30:00', 245, null, null, 2, 120, 0, '7');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '71');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '74');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '79');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '36');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '43');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 14:00:00', 245, null, null, 2, 120, 0, '6');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 14:00:00', 245, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 14:00:00', 245, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 14:00:00', 245, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 15:00:00', 245, null, null, 2, 180, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 12:00:00', '2025-01-05 15:00:00', 245, null, null, 2, 180, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 16:00:00', '2025-01-05 18:00:00', 245, null, null, 2, 120, 0, '26');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 21:00:00', 245, null, null, 2, 120, 0, '10');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 21:00:00', 245, null, null, 2, 120, 0, '11');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '12');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '14');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '15');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '17');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 180, 0, '18');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 19:30:00', '2025-01-05 21:30:00', 245, null, null, 2, 120, 0, '16');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 120, 0, '19');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 120, 0, '20');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:00:00', '2025-01-05 22:00:00', 245, null, null, 2, 120, 0, '21');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:30:00', '2025-01-05 22:30:00', 245, null, null, 2, 120, 0, '23');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:30:00', '2025-01-05 22:30:00', 245, null, null, 2, 120, 0, '25');
INSERT INTO scheduling_system.scheduling_shift (create_time, update_time, is_deleted, start_date, end_date, scheduling_date_id, meal_start_date, meal_end_date, meal_type, total_minute, shift_type, user_id) VALUES ('2024-12-28 14:34:23', '2024-12-28 14:34:23', 0, '2025-01-05 20:30:00', '2025-01-05 22:30:00', 245, null, null, 2, 120, 0, '26');

INSERT INTO scheduling_system.scheduling_task (create_time, update_time, scheduling_rule_id, store_id, start_date, end_date, is_publish) VALUES ('2024-12-25 15:04:55', '2024-12-25 15:04:55', 1, 1, 'Sat Jun 01 00:00:00 CST 2024', 'Fri Jun 07 00:00:00 CST 2024', 0);
INSERT INTO scheduling_system.scheduling_task (create_time, update_time, scheduling_rule_id, store_id, start_date, end_date, is_publish) VALUES ('2024-12-25 20:16:17', '2024-12-25 20:16:17', 1, 1, 'Mon Dec 23 00:00:00 CST 2024', 'Sun Dec 29 00:00:00 CST 2024', 0);
INSERT INTO scheduling_system.scheduling_task (create_time, update_time, scheduling_rule_id, store_id, start_date, end_date, is_publish) VALUES ('2024-12-28 14:34:22', '2024-12-28 14:34:22', 1, 1, 'Mon Dec 30 00:00:00 CST 2024', 'Sun Jan 05 00:00:00 CST 2025', 0);

INSERT INTO scheduling_system.store (create_time, update_time, name, province, city, region, address, size, status) VALUES ('2024-12-22 11:47:58', '2024-12-22 11:47:58', '智能排班系统官方店——城阳分店', '浙江省', '杭州市', '西湖区', '人才广场', 100.0000, 0);
INSERT INTO scheduling_system.store (create_time, update_time, name, province, city, region, address, size, status) VALUES ('2024-12-22 11:47:58', '2024-12-22 11:47:58', '智能排班系统官方店——电白分店', '浙江省', '杭州市', '西湖区', '水东镇', 58.0000, 0);

INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 1, '[
    {
        "date": "2024/06/01",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/06/01",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/06/01",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/01",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/01",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/06/01",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/06/01",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 80.0
    },
    {
        "date": "2024/06/01",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 85.0
    },
    {
        "date": "2024/06/01",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 90.0
    },
    {
        "date": "2024/06/01",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 85.0
    },
    {
        "date": "2024/06/01",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/06/01",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/06/01",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/06/01",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/01",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/01",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/01",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/06/01",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/01",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/01",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/01",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/06/01",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/06/01",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/06/01",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/06/01",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/06/01",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/06/01",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/06/01",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/06/01",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 30.0
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 2, '[
    {
        "date": "2024/06/02",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/06/02",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/06/02",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/02",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/02",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/02",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/06/02",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/06/02",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 80.0
    },
    {
        "date": "2024/06/02",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/06/02",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/06/02",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/02",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/02",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/02",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/02",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/02",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/02",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/06/02",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/06/02",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/02",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/02",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/06/02",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/06/02",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/06/02",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/06/02",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/06/02",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 20.0
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 3, '[
    {
        "date": "2024/06/03",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/03",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/03",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/03",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/03",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/03",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/03",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/06/03",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 80
    },
    {
        "date": "2024/06/03",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2024/06/03",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 90
    },
    {
        "date": "2024/06/03",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/06/03",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 65
    },
    {
        "date": "2024/06/03",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/03",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/03",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/03",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/03",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/03",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/03",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/03",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/03",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/03",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/03",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/03",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/03",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/03",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 45
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 4, '[
    {
        "date": "2024/06/04",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/04",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/04",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/04",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/04",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/04",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/04",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/06/04",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 80
    },
    {
        "date": "2024/06/04",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2024/06/04",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 90
    },
    {
        "date": "2024/06/04",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/06/04",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 65
    },
    {
        "date": "2024/06/04",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/04",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/04",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/04",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/04",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/04",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/04",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/04",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/04",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/04",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/04",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/04",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/04",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/04",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 45
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 5, '[
    {
        "date": "2024/06/05",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/05",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/05",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/05",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 70
    },
    {
        "date": "2024/06/05",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 80
    },
    {
        "date": "2024/06/05",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 90
    },
    {
        "date": "2024/06/05",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 95
    },
    {
        "date": "2024/06/05",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 100
    },
    {
        "date": "2024/06/05",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2024/06/05",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75
    },
    {
        "date": "2024/06/05",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65
    },
    {
        "date": "2024/06/05",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/05",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/05",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/05",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/05",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/05",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/05",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/05",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/05",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/05",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/05",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/05",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/05",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/05",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/05",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 40
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 6, '[
    {
        "date": "2024/06/06",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/06",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/06",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/06",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 70
    },
    {
        "date": "2024/06/06",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 80
    },
    {
        "date": "2024/06/06",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 90
    },
    {
        "date": "2024/06/06",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 95
    },
    {
        "date": "2024/06/06",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 100
    },
    {
        "date": "2024/06/06",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2024/06/06",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75
    },
    {
        "date": "2024/06/06",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65
    },
    {
        "date": "2024/06/06",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/06/06",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/06",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/06",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/06",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/06",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/06",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/06",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/06/06",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/06/06",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/06/06",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/06/06",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/06",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2024/06/06",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/06/06",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 40
    }
]
', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 6, 7, '[
    {
        "date": "2024/06/07",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/06/07",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 85.0
    },
    {
        "date": "2024/06/07",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 92.0
    },
    {
        "date": "2024/06/07",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 82.0
    },
    {
        "date": "2024/06/07",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/06/07",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 72.0
    },
    {
        "date": "2024/06/07",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 62.0
    },
    {
        "date": "2024/06/07",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 56.0
    },
    {
        "date": "2024/06/07",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 53.0
    },
    {
        "date": "2024/06/07",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/06/07",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/06/07",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 0
    },
    {
        "date": "2024/06/07",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 0
    },
    {
        "date": "2024/06/07",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 0
    },
    {
        "date": "2024/06/07",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 0
    },
    {
        "date": "2024/06/07",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/06/07",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/06/07",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/06/07",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/06/07",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/06/07",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 35.0
    }
]', '2024-12-22 14:06:27', '2024-12-22 14:06:27');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 23, '[
    {
        "date": "2024/12/23",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/12/23",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/23",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/23",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/23",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/23",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/23",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/12/23",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/12/23",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 80.0
    },
    {
        "date": "2024/12/23",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/12/23",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/23",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/23",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/23",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/23",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/23",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/23",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/23",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/23",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/23",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/23",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/23",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/23",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/12/23",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/12/23",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/12/23",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 15.0
    },
    {
        "date": "2024/12/23",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 10.0
    },
    {
        "date": "2024/12/23",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 15.0
    },
    {
        "date": "2024/12/23",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 20.0
    }
]
', '2024-12-25 20:01:47', '2024-12-25 20:01:47');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 24, '[
    {
        "date": "2024/12/24",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/12/24",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/24",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/24",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/24",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/24",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/24",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/24",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/12/24",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/24",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/24",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/24",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/24",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/24",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/24",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/24",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/24",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/24",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/24",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/24",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/24",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/24",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/24",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/12/24",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/12/24",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 15.0
    },
    {
        "date": "2024/12/24",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 10.0
    }
]
', '2024-12-25 20:10:55', '2024-12-25 20:10:55');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 25, '[
    {
        "date": "2024/12/25",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/25",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/25",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/25",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/25",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/25",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/25",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 65
    },
    {
        "date": "2024/12/25",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 70
    },
    {
        "date": "2024/12/25",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/12/25",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 80
    },
    {
        "date": "2024/12/25",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65
    },
    {
        "date": "2024/12/25",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 55
    },
    {
        "date": "2024/12/25",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/25",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/25",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/25",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/25",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/25",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/25",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/25",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/25",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/25",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/25",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/25",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/25",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/25",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 35
    }
]
', '2024-12-25 20:12:34', '2024-12-25 20:12:34');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 26, '[
    {
        "date": "2024/12/26",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/26",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/26",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/26",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/26",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/26",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/26",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 65
    },
    {
        "date": "2024/12/26",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 70
    },
    {
        "date": "2024/12/26",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/12/26",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 80
    },
    {
        "date": "2024/12/26",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65
    },
    {
        "date": "2024/12/26",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 55
    },
    {
        "date": "2024/12/26",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/26",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/26",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/26",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/26",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/26",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/26",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/26",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/26",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/26",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/26",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/26",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/26",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/26",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 35
    }
]
', '2024-12-25 20:12:34', '2024-12-25 20:12:34');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 27, '[
    {
        "date": "2024/12/27",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/27",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/27",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/27",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/12/27",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 70
    },
    {
        "date": "2024/12/27",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 80
    },
    {
        "date": "2024/12/27",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 85
    },
    {
        "date": "2024/12/27",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 90
    },
    {
        "date": "2024/12/27",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/12/27",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 65
    },
    {
        "date": "2024/12/27",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/12/27",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/27",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/27",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/27",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/27",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/27",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/27",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/27",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/27",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/27",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/27",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/27",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/27",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/27",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/27",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 30
    }
]
', '2024-12-25 20:12:34', '2024-12-25 20:12:34');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 28, '[
    {
        "date": "2024/12/28",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/28",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/28",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/28",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 60
    },
    {
        "date": "2024/12/28",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 70
    },
    {
        "date": "2024/12/28",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 80
    },
    {
        "date": "2024/12/28",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 85
    },
    {
        "date": "2024/12/28",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 90
    },
    {
        "date": "2024/12/28",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 75
    },
    {
        "date": "2024/12/28",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 65
    },
    {
        "date": "2024/12/28",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 55
    },
    {
        "date": "2024/12/28",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 50
    },
    {
        "date": "2024/12/28",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/28",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/28",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/28",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/28",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/28",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/28",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 20
    },
    {
        "date": "2024/12/28",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 25
    },
    {
        "date": "2024/12/28",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 30
    },
    {
        "date": "2024/12/28",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 35
    },
    {
        "date": "2024/12/28",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/28",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 45
    },
    {
        "date": "2024/12/28",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 40
    },
    {
        "date": "2024/12/28",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 30
    }
]
', '2024-12-25 20:12:34', '2024-12-25 20:12:34');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 29, '[
    {
        "date": "2024/12/29",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/12/29",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/12/29",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 82.0
    },
    {
        "date": "2024/12/29",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 72.0
    },
    {
        "date": "2024/12/29",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/29",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 62.0
    },
    {
        "date": "2024/12/29",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 52.0
    },
    {
        "date": "2024/12/29",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 46.0
    },
    {
        "date": "2024/12/29",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 43.0
    },
    {
        "date": "2024/12/29",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/29",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/29",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 0
    },
    {
        "date": "2024/12/29",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 0
    },
    {
        "date": "2024/12/29",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 0
    },
    {
        "date": "2024/12/29",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 0
    },
    {
        "date": "2024/12/29",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/29",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/29",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/29",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/29",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/29",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 25.0
    }
]
', '2024-12-25 20:12:34', '2024-12-25 20:12:34');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 30, '[
    {
        "date": "2024/12/30",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/30",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/30",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/30",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/30",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/30",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/12/30",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 80.0
    },
    {
        "date": "2024/12/30",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 85.0
    },
    {
        "date": "2024/12/30",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 90.0
    },
    {
        "date": "2024/12/30",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 85.0
    },
    {
        "date": "2024/12/30",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/12/30",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/12/30",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/30",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/30",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/30",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/30",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/30",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/30",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/30",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/30",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/30",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/30",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/30",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/30",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/30",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/12/30",
        "startTime": "22:0",
        "endTime": "22:30",
        "passengerFlow": 20.0
    },
    {
        "date": "2024/12/30",
        "startTime": "22:30",
        "endTime": "23:0",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/12/30",
        "startTime": "23:0",
        "endTime": "23:30",
        "passengerFlow": 30.0
    }
]
', '2024-12-25 20:20:41', '2024-12-25 20:20:41');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2024, 12, 31, '[
    {
        "date": "2024/12/31",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/31",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/31",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/31",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/31",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/31",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/31",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/12/31",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 80.0
    },
    {
        "date": "2024/12/31",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 75.0
    },
    {
        "date": "2024/12/31",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/12/31",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/31",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/31",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/31",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/31",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55.0
    },
    {
        "date": "2024/12/31",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/31",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 65.0
    },
    {
        "date": "2024/12/31",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 70.0
    },
    {
        "date": "2024/12/31",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2024/12/31",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 50.0
    },
    {
        "date": "2024/12/31",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 45.0
    },
    {
        "date": "2024/12/31",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 40.0
    },
    {
        "date": "2024/12/31",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2024/12/31",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 30.0
    },
    {
        "date": "2024/12/31",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 25.0
    },
    {
        "date": "2024/12/31",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 20.0
    }
]
', '2024-12-25 20:20:41', '2024-12-25 20:20:41');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2025, 1, 1, '[
    {
        "date": "2025/01/01",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/01",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/01",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/01",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/01",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/01",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/01",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75
    },
    {
        "date": "2025/01/01",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 80
    },
    {
        "date": "2025/01/01",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2025/01/01",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 90
    },
    {
        "date": "2025/01/01",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 75
    },
    {
        "date": "2025/01/01",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 65
    },
    {
        "date": "2025/01/01",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/01",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/01",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/01",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/01",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/01",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/01",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/01",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/01",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/01",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/01",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/01",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/01",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/01",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 45
    }
]
', '2024-12-25 20:23:41', '2024-12-25 20:23:41');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2025, 1, 2, '[
    {
        "date": "2025/01/02",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/02",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/02",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/02",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/02",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/02",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/02",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 75
    },
    {
        "date": "2025/01/02",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 80
    },
    {
        "date": "2025/01/02",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2025/01/02",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 90
    },
    {
        "date": "2025/01/02",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 75
    },
    {
        "date": "2025/01/02",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 65
    },
    {
        "date": "2025/01/02",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/02",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/02",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/02",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/02",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/02",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/02",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/02",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/02",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/02",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/02",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/02",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/02",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/02",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 45
    }
]
', '2024-12-25 20:23:41', '2024-12-25 20:23:41');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2025, 1, 3, '[
    {
        "date": "2025/01/03",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/03",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/03",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/03",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 70
    },
    {
        "date": "2025/01/03",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 80
    },
    {
        "date": "2025/01/03",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 90
    },
    {
        "date": "2025/01/03",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 95
    },
    {
        "date": "2025/01/03",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 100
    },
    {
        "date": "2025/01/03",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2025/01/03",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75
    },
    {
        "date": "2025/01/03",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65
    },
    {
        "date": "2025/01/03",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/03",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/03",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/03",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/03",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/03",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/03",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/03",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/03",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/03",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/03",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/03",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/03",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/03",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/03",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 40
    }
]
', '2024-12-25 20:23:41', '2024-12-25 20:23:41');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2025, 1, 4, '[
    {
        "date": "2025/01/04",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/04",
        "startTime": "9:30",
        "endTime": "10:0",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/04",
        "startTime": "10:0",
        "endTime": "10:30",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/04",
        "startTime": "10:30",
        "endTime": "11:0",
        "passengerFlow": 70
    },
    {
        "date": "2025/01/04",
        "startTime": "11:0",
        "endTime": "11:30",
        "passengerFlow": 80
    },
    {
        "date": "2025/01/04",
        "startTime": "11:30",
        "endTime": "12:0",
        "passengerFlow": 90
    },
    {
        "date": "2025/01/04",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 95
    },
    {
        "date": "2025/01/04",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 100
    },
    {
        "date": "2025/01/04",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 85
    },
    {
        "date": "2025/01/04",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75
    },
    {
        "date": "2025/01/04",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 65
    },
    {
        "date": "2025/01/04",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 60
    },
    {
        "date": "2025/01/04",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/04",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/04",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/04",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/04",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/04",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/04",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 30
    },
    {
        "date": "2025/01/04",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 35
    },
    {
        "date": "2025/01/04",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40
    },
    {
        "date": "2025/01/04",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45
    },
    {
        "date": "2025/01/04",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/04",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 55
    },
    {
        "date": "2025/01/04",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 50
    },
    {
        "date": "2025/01/04",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 40
    }
]
', '2024-12-25 20:23:41', '2024-12-25 20:23:41');
INSERT INTO scheduling_system.store_flow (store_id, year, month, day, flow, create_time, update_time) VALUES (1, 2025, 1, 5, '[
    {
        "date": "2025/01/05",
        "startTime": "9:0",
        "endTime": "9:30",
        "passengerFlow": 35.0
    },
    {
        "date": "2025/01/05",
        "startTime": "12:0",
        "endTime": "12:30",
        "passengerFlow": 85.0
    },
    {
        "date": "2025/01/05",
        "startTime": "12:30",
        "endTime": "13:0",
        "passengerFlow": 92.0
    },
    {
        "date": "2025/01/05",
        "startTime": "13:0",
        "endTime": "13:30",
        "passengerFlow": 82.0
    },
    {
        "date": "2025/01/05",
        "startTime": "13:30",
        "endTime": "14:0",
        "passengerFlow": 75.0
    },
    {
        "date": "2025/01/05",
        "startTime": "14:0",
        "endTime": "14:30",
        "passengerFlow": 72.0
    },
    {
        "date": "2025/01/05",
        "startTime": "14:30",
        "endTime": "15:0",
        "passengerFlow": 62.0
    },
    {
        "date": "2025/01/05",
        "startTime": "15:0",
        "endTime": "15:30",
        "passengerFlow": 56.0
    },
    {
        "date": "2025/01/05",
        "startTime": "15:30",
        "endTime": "16:0",
        "passengerFlow": 53.0
    },
    {
        "date": "2025/01/05",
        "startTime": "16:0",
        "endTime": "16:30",
        "passengerFlow": 60.0
    },
    {
        "date": "2025/01/05",
        "startTime": "16:30",
        "endTime": "17:0",
        "passengerFlow": 55.0
    },
    {
        "date": "2025/01/05",
        "startTime": "17:0",
        "endTime": "17:30",
        "passengerFlow": 0
    },
    {
        "date": "2025/01/05",
        "startTime": "17:30",
        "endTime": "18:0",
        "passengerFlow": 0
    },
    {
        "date": "2025/01/05",
        "startTime": "18:0",
        "endTime": "18:30",
        "passengerFlow": 0
    },
    {
        "date": "2025/01/05",
        "startTime": "18:30",
        "endTime": "19:0",
        "passengerFlow": 0
    },
    {
        "date": "2025/01/05",
        "startTime": "19:0",
        "endTime": "19:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2025/01/05",
        "startTime": "19:30",
        "endTime": "20:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2025/01/05",
        "startTime": "20:0",
        "endTime": "20:30",
        "passengerFlow": 50.0
    },
    {
        "date": "2025/01/05",
        "startTime": "20:30",
        "endTime": "21:0",
        "passengerFlow": 45.0
    },
    {
        "date": "2025/01/05",
        "startTime": "21:0",
        "endTime": "21:30",
        "passengerFlow": 40.0
    },
    {
        "date": "2025/01/05",
        "startTime": "21:30",
        "endTime": "22:0",
        "passengerFlow": 35.0
    }
]', '2024-12-25 20:23:41', '2024-12-25 20:23:41');

