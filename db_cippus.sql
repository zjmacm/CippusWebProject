/*
Navicat MySQL Data Transfer

Source Server         : 123
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : db_cippus

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2015-09-17 07:50:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for db_news
-- ----------------------------
DROP TABLE IF EXISTS `db_news`;
CREATE TABLE `db_news` (
  `news_id` varchar(32) NOT NULL,
  `publish_time` date NOT NULL,
  `publish_name` varchar(20) NOT NULL,
  `focus` int(5) NOT NULL,
  `title` varchar(50) NOT NULL,
  `type` int(1) NOT NULL,
  `attachment` int(1) NOT NULL,
  `content` longtext,
  `file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_news
-- ----------------------------
INSERT INTO `db_news` VALUES ('543A2C43C62747FA85D384C548ADE20F', '2015-05-19', '张明宇', '1', '123', '9', '0', '123', null);
INSERT INTO `db_news` VALUES ('B0720C148037493484C174B546EFA586', '2015-05-19', '陆慧', '2', '1314', '9', '0', '1314', null);
INSERT INTO `db_news` VALUES ('EAC54F2AB1CB44DFBF6E3789D23652FD', '2015-05-19', '张明宇', '1', '111', '2', '0', '111', null);

-- ----------------------------
-- Table structure for db_project
-- ----------------------------
DROP TABLE IF EXISTS `db_project`;
CREATE TABLE `db_project` (
  `project_id` varchar(32) NOT NULL,
  `project_name` varchar(50) NOT NULL,
  `project_group` varchar(20) NOT NULL,
  `remark1` varchar(100) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `remark2` varchar(255) DEFAULT NULL,
  `update_time` date DEFAULT NULL,
  `project_link` varchar(255) DEFAULT NULL,
  `upload_user` varchar(32) NOT NULL,
  `project_status` int(1) NOT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_project
-- ----------------------------

-- ----------------------------
-- Table structure for db_resources
-- ----------------------------
DROP TABLE IF EXISTS `db_resources`;
CREATE TABLE `db_resources` (
  `resources_id` varchar(32) NOT NULL,
  `resources_name` varchar(50) NOT NULL,
  `resources_type2` int(3) NOT NULL COMMENT '0为视频，1为文档，2为源代码',
  `upload_user` varchar(20) NOT NULL,
  `upload_time` date DEFAULT NULL,
  `upload_group` varchar(20) DEFAULT NULL,
  `resources_type1` int(3) DEFAULT '0' COMMENT '从1到7，按顺序来',
  `remark` varchar(255) DEFAULT NULL,
  `link_name` varchar(50) DEFAULT NULL,
  `link_address` varchar(255) DEFAULT NULL,
  `link_file` int(1) NOT NULL,
  `file_name` varchar(50) DEFAULT NULL,
  `real_name` varchar(50) DEFAULT NULL,
  `resources_status` int(1) NOT NULL,
  PRIMARY KEY (`resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_resources
-- ----------------------------
INSERT INTO `db_resources` VALUES ('1CA7914EE99E44A487DD31FC93D639DA', '12334', '1', '张明宇', '2015-07-17', '花旗俱乐部', '6', '124456の而发生地方', null, null, '1', 'psb1', '20150717162720_777864.jpg', '1');
INSERT INTO `db_resources` VALUES ('3A08EB8213EC4012990578D4AF1AEA3A', '111', '1', '张明宇', '2015-06-16', '花旗俱乐部', '6', '123', null, null, '1', '数据库', '20150616094606_599830.xlsx', '1');

-- ----------------------------
-- Table structure for db_user
-- ----------------------------
DROP TABLE IF EXISTS `db_user`;
CREATE TABLE `db_user` (
  `user_id` varchar(32) NOT NULL,
  `number` varchar(9) NOT NULL DEFAULT '',
  `name` varchar(10) NOT NULL DEFAULT '',
  `tel` varchar(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `self_intro` varchar(255) DEFAULT NULL,
  `prize` varchar(255) DEFAULT NULL,
  `picture` blob COMMENT '个人照片',
  `user_type` int(1) DEFAULT NULL COMMENT '0为普通组员，1位组长，2位超级管理员',
  `good_at` varchar(255) DEFAULT NULL,
  `user_group` varchar(20) DEFAULT NULL,
  `birthday` varchar(10) DEFAULT NULL,
  `password` varchar(25) DEFAULT NULL,
  `user_status` int(1) DEFAULT NULL COMMENT '0为尚未通过申请，1为正式成员',
  `register_time` date NOT NULL,
  `month_score` double(5,1) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_user
-- ----------------------------
INSERT INTO `db_user` VALUES ('123456', '000000000', '陆慧', '18604266461', '1518302968@qq.com', null, null, null, '2', null, null, null, '111111', '1', '2015-02-02', '0.0');
INSERT INTO `db_user` VALUES ('12345678', '201293192', '李洪超', '13342273678', '477756151@qq.com', null, null, null, '1', null, null, null, '123456', '1', '2015-05-27', '0.0');
INSERT INTO `db_user` VALUES ('12345678901234567890123456789012', '201292339', '张明宇', '18604266461', '1518302968@qq.com', '去玩儿体育ii', '亲亲亲爱惜对方vf', null, '1', '无法vujbrfcrfr分单位耳朵', '花旗俱乐部', '1993-08-08', '123456', '1', '2015-01-01', '6.0');
