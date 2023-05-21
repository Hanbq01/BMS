/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : bms

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 21/05/2023 14:14:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `publisher` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `publish_date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202305001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (2305001, '活着', '余华', '作家出版社', '2018-12-01', 25);
INSERT INTO `book` VALUES (2305002, '百年孤独', '加西亚·马尔克斯', '南海出版公司', '2017-06-01', 16);
INSERT INTO `book` VALUES (2305003, '白鹿原', '陈忠实', '人民文学出版社', '2013-03-01', 17);
INSERT INTO `book` VALUES (2305004, '天龙八部', '金庸', '生活·读书·新知三联书店', '2005-02-01', 30);
INSERT INTO `book` VALUES (2305005, '解忧杂货店', '东野圭吾', '南海出版公司', '2014-11-01', 9);
INSERT INTO `book` VALUES (2305006, '哈利·波特与魔法石', 'J.K.罗琳', '人民文学出版社', '2001-06-01', 30);
INSERT INTO `book` VALUES (2305007, '嫌疑人X的献身', '东野圭吾', '南海出版公司', '2008-05-01', 20);
INSERT INTO `book` VALUES (2305008, '平凡的世界', '路遥', '人民文学出版社', '2005-01-01', 15);
INSERT INTO `book` VALUES (2305009, '雪山飞狐', '金庸', '生活·读书·新知三联书店', '2006-08-01', 8);
INSERT INTO `book` VALUES (2305010, '追风筝的人', '卡勒德·胡赛因', '上海人民出版社', '2013-09-01', 22);
INSERT INTO `book` VALUES (2305011, '红楼梦', '曹雪芹', '人民文学出版社', '2010-01-01', 10);
INSERT INTO `book` VALUES (2305012, '水浒传', '施耐庵', '人民文学出版社', '2009-05-10', 5);
INSERT INTO `book` VALUES (2305013, '西游记', '吴承恩', '人民文学出版社', '2008-02-18', 20);
INSERT INTO `book` VALUES (2305014, '三国演义', '罗贯中', '人民文学出版社', '2011-11-11', 15);
INSERT INTO `book` VALUES (2305015, '围城', '钱钟书', '人民文学出版社', '2012-07-30', 8);
INSERT INTO `book` VALUES (2305016, '测试', '测试', '测试出版社', '2023-05-16', 10);
INSERT INTO `book` VALUES (2305017, 'Java编程思想', 'Bruce Eckel', '机械工业出版社', '1998-12-01', 10);
INSERT INTO `book` VALUES (2305018, 'Effective Java', 'Joshua Bloch', 'Addison-Wesley Professional', '2001-05-08', 5);
INSERT INTO `book` VALUES (2305019, '深入浅出MySQL', '李宇飞', '人民邮电出版社', '2010-01-01', 2);
INSERT INTO `book` VALUES (2305020, '高等数学', '郭家维', '高等教育出版社', '2014-09-01', 15);
INSERT INTO `book` VALUES (2305021, '大学物理（上）', '谢承成', '高等教育出版社', '2005-09-01', 8);
INSERT INTO `book` VALUES (2305022, '数据结构（C语言版）', '严蔚敏', '清华大学出版社', '2007-02-01', 12);
INSERT INTO `book` VALUES (2305023, '计算机网络', '谢希仁', '电子工业出版社', '2010-08-01', 5);
INSERT INTO `book` VALUES (2305024, '操作系统概念', 'Abraham Silberschatz', '机械工业出版社', '2013-02-01', 10);

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `bookid` int NOT NULL,
  `bookname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `borrow_date` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of borrow
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `realname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `reg_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'user',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20231002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (20231001, 'admin', 'admin', '韩炳琪', '123456', 'hanbq2037@foxmail.com', '山东省德州市', '2023-05-06 16:57:59', 'admin');
INSERT INTO `users` VALUES (20231002, 'user', 'user', '测试用户', '123456', '123@123.com', '山东省济南市', '2023-05-19 22:22:13', 'user');
INSERT INTO `users` VALUES (20231003, 'Feng', '123456', '冯宇', '123456', 'test@test.com', '山东省菏泽市曹县', '2023-05-21 14:09:14', 'user');
INSERT INTO `users` VALUES (20231004, 'DT', '123456', '邸腾', '123456', 'example@example.com', '山东省潍坊市', '2023-05-21 14:09:57', 'user');

SET FOREIGN_KEY_CHECKS = 1;
