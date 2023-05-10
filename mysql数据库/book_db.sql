/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.6
 Source Server Type    : MySQL
 Source Server Version : 50620
 Source Host           : localhost:3306
 Source Schema         : book_db

 Target Server Type    : MySQL
 Target Server Version : 50620
 File Encoding         : 65001

 Date: 02/02/2021 18:43:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book`  (
  `barcode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'barcode',
  `bookName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书名称',
  `bookTypeObj` int(11) NOT NULL COMMENT '图书所在类别',
  `price` float NOT NULL COMMENT '图书价格',
  `count` int(11) NOT NULL COMMENT '库存',
  `publishDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版日期',
  `publish` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `bookPhoto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书图片',
  `hitNum` int(11) NOT NULL COMMENT '浏览量',
  `bookDesc` varchar(8000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书简介',
  `bookFile` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书文件',
  PRIMARY KEY (`barcode`) USING BTREE,
  INDEX `bookTypeObj`(`bookTypeObj`) USING BTREE,
  CONSTRAINT `t_book_ibfk_1` FOREIGN KEY (`bookTypeObj`) REFERENCES `t_booktype` (`bookTypeId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES ('1111', 'fafa', 1, 1, 1414, '2020-12-19', NULL, 'upload/a2510659-bfe3-41bd-824b-f9142185061c.jpg', 12, '<p>发发发</p>', '');
INSERT INTO `t_book` VALUES ('2222', '333', 1, 44, 11, '2021-01-16', NULL, 'upload/47f669f1-5627-4f7b-b0be-b1eb09e9ee15.jpg', 11, '<p>&nbsp;沙发沙发上飞机阿什拉夫爱上两个姜辣素费拉拉是glass拉嘎拉嘎假乱收费拉屎冯老师冯老师过啦就是节流阀上来看官方爱上了国家爱丽丝攻击力散&nbsp;<br/></p><p><img src=\"http://localhost:8080/JavaWebProject/upload/20210202/1612261600601007535.jpg\" title=\"1612261600601007535.jpg\" alt=\"13.jpg\" width=\"386\" height=\"372\"/></p>', 'upload/6edeb8c8-a4d5-4af1-a774-1df8df303b57.doc');
INSERT INTO `t_book` VALUES ('TS001', '1', 3, 2, 3, '2021-01-05', NULL, 'upload/NoImage.jpg', 5, '<p>a</p>22', '');
INSERT INTO `t_book` VALUES ('TS003', 'gadfasfa', 3, 23.5, 23, '2020-12-07', NULL, 'upload/NoImage.jpg', 1234, '   gsasfasfasfasfa阿傻师傅奥拉夫案例过啦发啦发啦浪费阿里山旮旯是刚开始过啦三连发时间浪费家里施工方姜辣素过啦结果来看奥利给啦古拉拉法发啦发啦阿发  阿帆奥利给拉法基啦机构来说寄过来浪费按理说拉屎老嘎双良股份阿什拉夫案例aaa bajl fa llaflalsfaf alglasglas fasl f aslf 1111', 'upload/25e2b678-91c3-4e00-826f-fd7fad2b1a1f.docx');
INSERT INTO `t_book` VALUES ('TS004', '1aabb', 1, 1, 2, '2021-01-14', NULL, 'upload/NoImage.jpg', 1, '<p>fafa</p>', '');
INSERT INTO `t_book` VALUES ('TS006', '11aa', 3, 11, 1, '2021-01-04', NULL, 'upload/NoImage.jpg', 1, '<p>faf</p>', '');
INSERT INTO `t_book` VALUES ('TS007', '1', 1, 2, 3, '2021-01-05', '4', 'upload/NoImage.jpg', 5, '<p>5</p>', '');
INSERT INTO `t_book` VALUES ('TS008', '测试图书', 1, 12.5, 12, '2021-01-16', NULL, 'upload/06ae5e4c-b1bb-4dd8-883b-4c6365d9d1a1.jpg', 20, '<p><span style=\"color: rgb(0, 112, 192);\"><em><span style=\"text-decoration: underline;\">非常好的一本书哦！<br/><span style=\"color: rgb(0, 112, 192);\"><em><span style=\"text-decoration: underline;\">非常好的一本书哦！</span></em></span><br/><span style=\"color: rgb(0, 112, 192);\"><em><span style=\"text-decoration: underline;\">非常好的一本书哦！</span></em></span></span></em></span></p>', 'upload/1c5b11a1-125d-4cee-87c7-ed6b3567f9b9.jpg');
INSERT INTO `t_book` VALUES ('TS009', '11', 1, 1, 2, '2021-01-11', '3', 'upload/NoImage.jpg', 4, '<p>法法</p>', '');
INSERT INTO `t_book` VALUES ('TS010', '11', 3, 32, 22, '2021-01-12', 'fsafas', 'upload/NoImage.jpg', 12, '<p>fafaf</p>', '');
INSERT INTO `t_book` VALUES ('TS011', '1414', 1, 12, 341, '2021-01-12', NULL, 'upload/NoImage.jpg', 141, '<p>啊发顺丰<img src=\"http://localhost:8080/JavaWebProject/upload/20210202/1612260265428076694.jpg\" title=\"1612260265428076694.jpg\" alt=\"1.jpg\" width=\"223\" height=\"146\"/></p>', '');
INSERT INTO `t_book` VALUES ('TS012', '1412', 3, 12, 141, '2021-01-04', '1412', 'upload/NoImage.jpg', 14, '<p>faf&nbsp;</p>', '');

-- ----------------------------
-- Table structure for t_booktype
-- ----------------------------
DROP TABLE IF EXISTS `t_booktype`;
CREATE TABLE `t_booktype`  (
  `bookTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '图书类别id',
  `bookTypeName` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类别名称',
  `days` int(11) NOT NULL COMMENT '可借阅天数',
  PRIMARY KEY (`bookTypeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_booktype
-- ----------------------------
INSERT INTO `t_booktype` VALUES (1, '计算机类', 3);
INSERT INTO `t_booktype` VALUES (3, '历史类', 20);
INSERT INTO `t_booktype` VALUES (4, '1', 1);
INSERT INTO `t_booktype` VALUES (5, '2', 2);
INSERT INTO `t_booktype` VALUES (6, '3', 3);
INSERT INTO `t_booktype` VALUES (7, '4', 4);
INSERT INTO `t_booktype` VALUES (8, '5', 5);

-- ----------------------------
-- Table structure for t_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo`  (
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'user_name',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `birthDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
  `userPhoto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `address` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `regTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册时间',
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('13688886666', '123456', '汪哥哥', '男', '2020-12-21', 'images/avatar/avatar14.png', '13688886666', 'dashen@126.com', 'hongxingl', '2021-02-02 18:21:56', '--');
INSERT INTO `t_userinfo` VALUES ('18888888888', '123456', '小明名', '男', '2020-12-21', 'images/avatar/avatar12.png', '18888888888', 'dashen@126.com', '成都市红星路10号 ', '2020-12-23 17:24:38', '--');

SET FOREIGN_KEY_CHECKS = 1;
