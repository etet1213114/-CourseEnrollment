SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '帳號',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密碼',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名稱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '頭貼',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理員訊息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理員', 'http://localhost:9090/files/download/avatar.png', 'ADMIN');

-- ----------------------------
-- Table structure for choice
-- ----------------------------
DROP TABLE IF EXISTS `choice`;
CREATE TABLE `choice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '課程名稱',
  `teacher_id` int NULL DEFAULT NULL COMMENT '授課教師',
  `student_id` int NULL DEFAULT NULL COMMENT '選課學生',
  `course_id` int NULL DEFAULT NULL COMMENT '課程ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '選課訊息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of choice
-- ----------------------------
INSERT INTO `choice` VALUES (5, 'Java基礎', 3, 2, 2);
INSERT INTO `choice` VALUES (6, 'python基礎', 6, 2, 1);
INSERT INTO `choice` VALUES (8, 'Java基礎', 3, 4, 2);
INSERT INTO `choice` VALUES (9, 'Go語言', 3, 4, 4);
INSERT INTO `choice` VALUES (11, 'python基礎', 6, 4, 1);

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '學院名稱',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '學院描述',
  `score` int NULL DEFAULT NULL COMMENT '最低學分',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '學院訊息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES (1, '工程學院', '這是工程學院，厲害', 30);
INSERT INTO `college` VALUES (2, '管理學院', '這是管理學院，厲害厲害', 40);
INSERT INTO `college` VALUES (6, '文學院', '	\n這是文學院，厲害plus', 30);
INSERT INTO `college` VALUES (7, '理學院', '厲害plus', 40);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鑑ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '課程名稱',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '課程介紹',
  `score` int NULL DEFAULT NULL COMMENT '課程學分',
  `teacher_id` int NULL DEFAULT NULL COMMENT '授課講師',
  `num` int NULL DEFAULT NULL COMMENT '開班人數',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上課時間',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上課地點',
  `college_id` int NULL DEFAULT NULL COMMENT '所屬學院',
  `already_num` int NULL DEFAULT 0 COMMENT '已選人數',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '課程訊息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'python基礎', '學習python基礎，充實基礎。', 3, 6, 30, '週二第四大節', '2B202', 7, 2);
INSERT INTO `course` VALUES (2, 'Java基礎', '學習Java基礎，為開發打好基礎。', 3, 3, 30, '週三第四大節', '3B303', 7, 2);
INSERT INTO `course` VALUES (3, 'C语言', '學習C语言', 3, 4, 40, '週五第一大節', '4B404', 7, 0);
INSERT INTO `course` VALUES (4, 'Go语言', '這是Go語言', 4, 3, 40, '週二第三大節', '2B203', 7, 1);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '發佈時間',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告訊息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '關於最新選課通知', '選課快要開始了，大家請準時選課', '2024-07-30 17:20:59');
INSERT INTO `notice` VALUES (2, '學校關於選課作弊的公告', '依據公平公正原則，大家切勿利用任何方式作弊，一但發現，記過處理。', '2024-07-30 17:21:17');
INSERT INTO `notice` VALUES (3, '最新選課管理系統上線啦！', '最新版選課系統成功上線！', '2024-07-30 17:21:34');

-- ----------------------------
-- Table structure for speciality
-- ----------------------------
DROP TABLE IF EXISTS `speciality`;
CREATE TABLE `speciality`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '專業名稱',
  `college_id` int NULL DEFAULT NULL COMMENT '學院ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '專業訊息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of speciality
-- ----------------------------
INSERT INTO `speciality` VALUES (1, '計算機科學', 7);
INSERT INTO `speciality` VALUES (2, '資訊工程', 7);
INSERT INTO `speciality` VALUES (4, '人文哲學', 6);

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '帳號',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密碼',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性別',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '學號',
  `college_id` int NULL DEFAULT NULL COMMENT '學院ID',
  `score` int NULL DEFAULT NULL COMMENT '學分',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '頭貼',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '學生訊息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'zhangsan', '123456', '張三', 'STUDENT', '男', '10000', 7, 0, 'http://localhost:9091/files/download/1722324698822-柴犬.jpeg');
INSERT INTO `student` VALUES (2, 'lisi', '123456', '李四', 'STUDENT', '男', '10001', 7, 0, 'http://localhost:9091/files/download/1722324706756-拉布拉多.jpeg');
INSERT INTO `student` VALUES (3, 'wangwu', '123456', '王五', 'STUDENT', '男', '10002', 7, 0, 'http://localhost:9091/files/download/1722324732342-柯基.jpeg');
INSERT INTO `student` VALUES (4, 'zhaoliu', '123', '趙六', 'STUDENT', '男', '10003', 7, 10, 'http://localhost:9091/files/download/1722329105934-金毛.jpeg');
INSERT INTO `student` VALUES (5, 'liqi', '123456', '李七', 'STUDENT', '女', '10004', 6, 0, 'http://localhost:9091/files/download/1722329141458-柯基.jpeg');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用戶名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密碼',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性別',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '職稱',
  `speciality_id` int NULL DEFAULT NULL COMMENT '專業ID',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '頭貼',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '教師訊息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (3, 'zhang', '123456', '張老師', '女', '教授', 1, 'TEACHER', 'http://localhost:9091/files/download/1722322696451-柴犬.jpeg');
INSERT INTO `teacher` VALUES (4, 'li', '123', '李老師', '男', '副教授', 2, 'TEACHER', 'http://localhost:9091/files/download/1722323069575-柯基.jpeg');
INSERT INTO `teacher` VALUES (6, 'wang', '123456', '王老師', '男', '副教授', 1, 'TEACHER', 'http://localhost:9091/files/download/1722323075913-拉布拉多.jpeg');

SET FOREIGN_KEY_CHECKS = 1;
