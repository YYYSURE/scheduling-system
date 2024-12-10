
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- -- ----------------------------
-- -- Table structure for enterprise
-- -- ----------------------------
-- DROP TABLE IF EXISTS `enterprise`;
-- CREATE TABLE `enterprise`  (
--   `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
--   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
--   `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
--   `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
--   `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
--   `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
--   `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '企业logo',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '企业表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for festival
-- ----------------------------
DROP TABLE IF EXISTS `festival`;
CREATE TABLE `festival`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '节日名称',
  `start_date` datetime(0) NOT NULL COMMENT '起始日期',
  `end_date` datetime(0) NOT NULL COMMENT '截止日期',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '0：农历 1：新历',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '门店节日表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of festival
-- ----------------------------

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `msg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息',-- 1
  `access_time` datetime(0) NULL DEFAULT NULL COMMENT '登录时间',
  `browser` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',-- 1
  `os` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',-- 1
  `enterprise_id` bigint(0) NULL DEFAULT NULL COMMENT '企业id',-- 1
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 584 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '登录日志表' ROW_FORMAT = Dynamic;



-- -- ----------------------------
-- -- Table structure for menu
-- -- ----------------------------
-- DROP TABLE IF EXISTS `menu`;
-- CREATE TABLE `menu`  (
--   `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
--   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
--   `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
--   `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
--   `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '父id',
--   `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
--   `type` tinyint(0) NULL DEFAULT NULL COMMENT '菜单类型',
--   `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由地址',
--   `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
--   `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
--   `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
--   `sort` int(0) NULL DEFAULT 0 COMMENT '排序字段',
--   `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT ' 0:正常 1:禁用',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '通知类型(0-企业公开,1-门店公开，2-指定用户可以看)',
  `subject` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '通知主题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '通知内容',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  `enterprise_id` bigint(0) NULL DEFAULT NULL COMMENT '企业id',-- 1
  `is_publish` tinyint(0) NULL DEFAULT 0 COMMENT '是否发布（0：未发布；1：已发布）',
  `publish_time` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `create_user_id` bigint(0) NULL DEFAULT NULL COMMENT '创建人id',
  `publish_user_id` bigint(0) NULL DEFAULT NULL COMMENT '发布人id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2465 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '模块标题',
  `business_type` tinyint(0) NULL DEFAULT NULL COMMENT '业务类型 (0其它 1新增 2修改 3删除)',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '方法名称',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '说明',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '请求方式',
  `operator_type` tinyint(0) NULL DEFAULT NULL COMMENT '操作类别(0其它 1后台用户 2手机端用户)',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '操作人员',
  `enterprise_id` bigint(0) NOT NULL COMMENT '企业id',-- 1
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '操作地点',
  `oper_param` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '请求参数',
  `json_result` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '返回参数',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '操作状态 (0正常 1异常)',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '错误消息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 987 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '职位描述',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '所有关联的门店,每个门店所设置的职位不一定一样',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '没有父元素设置为-1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 269 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '职位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for province_city_region
-- ----------------------------
DROP TABLE IF EXISTS `province_city_region`;
CREATE TABLE `province_city_region`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '类型 0：省 1：市 2：区',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '没有父元素设置为0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5852 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '省-市-区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- -- Table structure for qrtz_blob_triggers
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_blob_triggers`;
-- CREATE TABLE `qrtz_blob_triggers`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `BLOB_DATA` blob NULL,
--   PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
--   CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Table structure for qrtz_calendars
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_calendars`;
-- CREATE TABLE `qrtz_calendars`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `CALENDAR` blob NOT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;


-- -- ----------------------------
-- -- Table structure for qrtz_cron_triggers
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_cron_triggers`;
-- CREATE TABLE `qrtz_cron_triggers`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `CRON_EXPRESSION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
--   CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Table structure for qrtz_fired_triggers
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_fired_triggers`;
-- CREATE TABLE `qrtz_fired_triggers`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `FIRED_TIME` bigint(0) NOT NULL,
--   `SCHED_TIME` bigint(0) NOT NULL,
--   `PRIORITY` int(0) NOT NULL,
--   `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Table structure for qrtz_job_details
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_job_details`;
-- CREATE TABLE `qrtz_job_details`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `JOB_DATA` blob NULL,
--   PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Table structure for qrtz_locks
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_locks`;
-- CREATE TABLE `qrtz_locks`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;


-- -- ----------------------------
-- -- Table structure for qrtz_paused_trigger_grps
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
-- CREATE TABLE `qrtz_paused_trigger_grps`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Records of qrtz_paused_trigger_grps
-- -- ----------------------------

-- -- ----------------------------
-- -- Table structure for qrtz_scheduler_state
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_scheduler_state`;
-- CREATE TABLE `qrtz_scheduler_state`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `LAST_CHECKIN_TIME` bigint(0) NOT NULL,
--   `CHECKIN_INTERVAL` bigint(0) NOT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Records of qrtz_scheduler_state
-- -- ----------------------------

-- -- ----------------------------
-- -- Table structure for qrtz_simple_triggers
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_simple_triggers`;
-- CREATE TABLE `qrtz_simple_triggers`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `REPEAT_COUNT` bigint(0) NOT NULL,
--   `REPEAT_INTERVAL` bigint(0) NOT NULL,
--   `TIMES_TRIGGERED` bigint(0) NOT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
--   CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Records of qrtz_simple_triggers
-- -- ----------------------------

-- -- ----------------------------
-- -- Table structure for qrtz_simprop_triggers
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
-- CREATE TABLE `qrtz_simprop_triggers`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `INT_PROP_1` int(0) NULL DEFAULT NULL,
--   `INT_PROP_2` int(0) NULL DEFAULT NULL,
--   `LONG_PROP_1` bigint(0) NULL DEFAULT NULL,
--   `LONG_PROP_2` bigint(0) NULL DEFAULT NULL,
--   `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
--   `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
--   `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
--   CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Records of qrtz_simprop_triggers
-- -- ----------------------------

-- -- ----------------------------
-- -- Table structure for qrtz_triggers
-- -- ----------------------------
-- DROP TABLE IF EXISTS `qrtz_triggers`;
-- CREATE TABLE `qrtz_triggers`  (
--   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `NEXT_FIRE_TIME` bigint(0) NULL DEFAULT NULL,
--   `PREV_FIRE_TIME` bigint(0) NULL DEFAULT NULL,
--   `PRIORITY` int(0) NULL DEFAULT NULL,
--   `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
--   `START_TIME` bigint(0) NOT NULL,
--   `END_TIME` bigint(0) NULL DEFAULT NULL,
--   `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
--   `MISFIRE_INSTR` smallint(0) NULL DEFAULT NULL,
--   `JOB_DATA` blob NULL,
--   PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
--   INDEX `SCHED_NAME`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
--   CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
-- ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  -- `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '角色描述',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '角色类型（0：系统角色 1：企业角色 2：门店角色）',
  -- `enterprise_id` bigint(0) NULL DEFAULT NULL COMMENT '企业id',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- -- ----------------------------
-- -- Table structure for role_menu
-- -- ----------------------------
-- DROP TABLE IF EXISTS `role_menu`;
-- CREATE TABLE `role_menu`  (
--   `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
--   `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
--   `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
--   `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
--   `role_id` bigint(0) NULL DEFAULT NULL COMMENT '角色id',
--   `menu_id` bigint(0) NULL DEFAULT NULL COMMENT '菜单id',
--   PRIMARY KEY (`id`) USING BTREE
-- ) ENGINE = InnoDB AUTO_INCREMENT = 718 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'role_menu中间表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for scheduling_date
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_date`;
CREATE TABLE `scheduling_date`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `date` datetime(0) NULL DEFAULT NULL COMMENT '日期',
  `is_need_work` tinyint(0) NULL DEFAULT NULL COMMENT '是否需要工作 0：休假 1：工作',
  `start_work_time` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上班时间（8:00）',
  `end_work_time` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下班时间（21:00）',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  -- `task_id` bigint(0) NULL DEFAULT NULL COMMENT '任务id',
  PRIMARY KEY (`id`) USING BTREE
  INDEX `taskId`(`task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '排班日期表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for scheduling_rule
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_rule`;
CREATE TABLE `scheduling_rule`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `store_id` bigint(0) NULL DEFAULT NULL,
  `store_work_time_frame` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '门店工作时间段',
  `most_work_hour_in_one_day` decimal(10, 4) NULL DEFAULT NULL COMMENT '员工一天最多工作几小时',
  `most_work_hour_in_one_week` decimal(10, 4) NULL DEFAULT NULL COMMENT '员工一周最多工作几小时',
  `min_shift_minute` int(0) NULL DEFAULT NULL COMMENT '一个班次的最少时间（分钟为单位）',
  `max_shift_minute` int(0) NULL DEFAULT NULL COMMENT '一个班次的最大时间（分钟为单位）',
  `rest_minute` int(0) NULL DEFAULT NULL COMMENT '休息时间长度（分钟为单位）',
  `maximum_continuous_work_time` decimal(10, 4) NULL DEFAULT NULL COMMENT '员工最长连续工作时间',
  `open_store_rule` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开店规则',
  `close_store_rule` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关店规则',
  `normal_rule` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正常班规则',
  `no_passenger_rule` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '无客流量值班规则',
  `minimum_shift_num_in_one_day` int(0) NULL DEFAULT NULL COMMENT '每天最少班次',
  `normal_shift_rule` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '正常班次规则',
  `lunch_time_rule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '午餐时间规则',
  `dinner_time_rule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '晚餐时间规则',
  `rule_type` tinyint(0) NULL DEFAULT NULL COMMENT '规则类型 0：主规则 1：从规则',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '排班规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for scheduling_shift
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_shift`;
CREATE TABLE `scheduling_shift`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `start_date` datetime(0) NULL DEFAULT NULL COMMENT '班次开始时间 2023-02-27 07:00:00',
  `end_date` datetime(0) NULL DEFAULT NULL COMMENT '班次结束时间 2023-02-27 10:30:00',
  `scheduling_date_id` bigint(0) NULL DEFAULT NULL COMMENT '对应排班工作日的id',
  `meal_start_date` datetime(0) NULL DEFAULT NULL COMMENT '吃饭开始时间',
  `meal_end_date` datetime(0) NULL DEFAULT NULL COMMENT '吃饭结束时间',
  `meal_type` tinyint(0) NULL DEFAULT NULL COMMENT '0：午餐 1：晚餐 2：不安排用餐',
  `total_minute` int(0) NULL DEFAULT NULL COMMENT '总时间',
  `shift_type` tinyint(0) NULL DEFAULT NULL COMMENT '班次类型 0：正常班 1：开店 2：收尾',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `schedulingDateId`(`scheduling_date_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1012438 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '排班班次表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for scheduling_task
-- ----------------------------
DROP TABLE IF EXISTS `scheduling_task`;
CREATE TABLE `scheduling_task`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名',
  `total_minute` int(0) NULL DEFAULT NULL COMMENT '班次总时长（分钟）',
  `total_assigned_minute` int(0) NULL DEFAULT NULL COMMENT '已分配班次的总时间（分钟）',
  `allocation_ratio` decimal(10, 6) NULL DEFAULT NULL COMMENT '分配比率',
  `status` tinyint(0) NULL DEFAULT 0 COMMENT '任务状态 0：新创建 1：计算中 2：计算完成 3：计算失败',
  `scheduling_rule_id` bigint(0) NULL DEFAULT NULL COMMENT '排班规则id',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  `duration` int(0) NULL DEFAULT NULL COMMENT '以多少分钟为一段',
  `intervalC` int(0) NULL DEFAULT NULL COMMENT '以多少段为一个时间单位来进行排班',
  `dateVoList` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '排班工作日及其客流量',
  `calculate_time` decimal(10, 0) NULL DEFAULT NULL COMMENT '计算时间',
  `start_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排班开始日期（UTC时间，比北京时间慢8小时）',
  `end_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排班结束日期（UTC时间，比北京时间慢8小时）',
  `step_one_alg` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第一阶段算法',
  `step_two_alg` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第二阶段算法',
  `step_two_alg_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第二阶段算法参数',
  `type` tinyint(0) NULL DEFAULT 0 COMMENT '任务类型 0：真实任务 1：虚拟任务',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '父任务id 虚拟任务才有父id',
  `is_publish` tinyint(0) NULL DEFAULT NULL COMMENT '是否发布任务 0：未发布 1：已经发布',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `storeId`(`store_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1452 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '排班任务表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for shift_user
-- ----------------------------
DROP TABLE IF EXISTS `shift_user`;
CREATE TABLE `shift_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `shift_id` bigint(0) NULL DEFAULT NULL COMMENT '班次id',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户id',
  `position_id` bigint(0) NULL DEFAULT NULL COMMENT '记录用户当时的职位，可能后面升职了',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `shiftId`(`shift_id`) USING BTREE,
  INDEX `userId`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 784192 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '班次_用户中间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  -- `enterprise_id` bigint(0) NULL DEFAULT NULL COMMENT '企业id',
  `province_id` bigint(0) NULL DEFAULT NULL COMMENT '省',
  `city_id` bigint(0) NULL DEFAULT NULL COMMENT '市',
  `region_id` bigint(0) NULL DEFAULT NULL COMMENT '区',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `size` decimal(10, 4) NULL DEFAULT NULL COMMENT '工作场所面积',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0：营业中 1：休息中（默认0）',
  PRIMARY KEY (`id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '门店表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for system_scheduled_notice
-- ----------------------------
DROP TABLE IF EXISTS `system_scheduled_notice`;
CREATE TABLE `system_scheduled_notice`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店id',
  `work_notice_use` tinyint(0) NULL DEFAULT NULL COMMENT '门店是否启用上班通知提醒',
  `work_notice_time` datetime(0) NULL DEFAULT NULL COMMENT '上班通知提醒时间，如每天晚上八点提醒相关人员第二天是否需要上班',
  `work_notice_type` tinyint(0) NULL DEFAULT NULL COMMENT '工作通知方式 0：系统发送消息 1：发送邮件 2：系统发送消息及发送邮件',
  `holiday_notice_use` tinyint(0) NULL DEFAULT NULL COMMENT '门店是否启用休假通知提醒',
  `holiday_notice_time` datetime(0) NULL DEFAULT NULL COMMENT '休假通知提醒时间，如每天晚上八点提醒相关人员第二天是否需要上班',
  `holiday_notice_type` tinyint(0) NULL DEFAULT NULL COMMENT '休假通知方式 0：系统发送消息 1：发送邮件 2：系统发送消息及发送邮件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统定时通知' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '电话',
  --`mail` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  -- `enterprise_id` bigint(0) NULL DEFAULT NULL,
  `store_id` bigint(0) NULL DEFAULT NULL COMMENT '门店ID',
  `type` tinyint(0) NOT NULL COMMENT '用户类型0：系统管理员 1：门店管理员 10：普通用户',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
  --`openid` varchar(28) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信登录所提供的id',
  --`wechat_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信名',
  --`wechat_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信头像',
  --`qq` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户所绑定的qq',
  --`nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '昵称（注册时默认设置用户名）',
  `gender` tinyint(0) NULL DEFAULT 0 COMMENT '性别 0：男 1：女',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  --`avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像（用户不设置就给一个默认头像）',
  --`status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '用户状态 0：正常状态 1：封禁状态',
  `work_day_preference` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '工作日偏好（喜欢星期几工作1|3|4喜欢星期一、三、四工作），缺省为全部 ',
  `work_time_preference` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '工作时间偏好（1:00~3.00|5.00~8.00|17.00~21.00），缺省为全部） ',
  `shift_length_preference_one_day` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '每天班次时长偏好',
  `shift_length_preference_one_week` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '每周班次时长偏好',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6642 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户id',
  `message_id` bigint(0) NULL DEFAULT NULL COMMENT '消息id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4808 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户-消息中间表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for user_position
-- ----------------------------
DROP TABLE IF EXISTS `user_position`;
CREATE TABLE `user_position`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户id',
  `position_id` bigint(0) NULL DEFAULT NULL COMMENT '职位id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20059 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'user_position中间表' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0：未删除 1：已删除',
  `role_id` bigint(0) NULL DEFAULT NULL COMMENT '角色id',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'user_role中间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
