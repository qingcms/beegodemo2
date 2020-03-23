/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80018
Source Host           : localhost:3306
Source Database       : beegodemo

Target Server Type    : MYSQL
Target Server Version : 80018
File Encoding         : 65001

Date: 2020-03-23 11:18:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_auth`;
CREATE TABLE `t_auth` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `auth_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限代码',
  `auth_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限名称',
  `status` int(2) DEFAULT '1' COMMENT '状态：1启用，0禁用',
  `parent_id` int(11) DEFAULT NULL COMMENT '父节点Id',
  `auth_url` varchar(255) DEFAULT NULL,
  `auth_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `auth_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '权限路径',
  `parent_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父节点权限路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_auth
-- ----------------------------
INSERT INTO `t_auth` VALUES ('1', 'root', '所有权限', '1', '0', '', null, 'root', '', '2020-03-17 10:25:18', 'admin', null);
INSERT INTO `t_auth` VALUES ('2', 'sys', '系统管理', '1', '1', null, null, 'root.sys', 'root', '2020-03-17 10:26:50', 'admin', null);
INSERT INTO `t_auth` VALUES ('3', 'user', '用户管理', '1', '2', '/user', null, 'root.sys.user', 'root.sys', '2020-03-17 10:27:18', 'admin', null);
INSERT INTO `t_auth` VALUES ('4', 'role', '角色管理', '1', '2', '/role', null, 'root.sys.role', 'root.sys', '2020-03-17 10:29:13', 'admin', null);
INSERT INTO `t_auth` VALUES ('5', 'auth', '权限管理', '1', '2', '/auth', null, 'root.sys.auth', 'root.sys', '2020-03-17 10:30:04', 'admin', null);
INSERT INTO `t_auth` VALUES ('6', 'customer', '客户管理', '1', '1', '/customer', null, 'root.customer', 'root', null, null, null);
INSERT INTO `t_auth` VALUES ('7', 'authlist', '权限列表', '1', '5', '/auth/list', null, 'root.sys.auth.authlist', 'root.sys.auth', null, null, null);
INSERT INTO `t_auth` VALUES ('8', 'authsetup', '权限分配', '1', '5', '/auth/setup', null, 'root.sys.auth.authsetup', 'root.sys.auth', null, null, null);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色名称',
  `status` int(2) DEFAULT '1' COMMENT '状态 1:启用，0：禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', '管理员1', '1', '2020-03-17 10:24:00', 'admin', null);
INSERT INTO `t_role` VALUES ('2', '管理员2', '1', '2020-03-17 10:24:35', 'admin', null);
INSERT INTO `t_role` VALUES ('3', '管理员3', '1', '2020-03-17 10:24:35', 'admin', null);
INSERT INTO `t_role` VALUES ('4', '管理员4', '1', '2020-03-17 10:24:36', 'admin', null);
INSERT INTO `t_role` VALUES ('5', '管理员5', '1', '2020-03-17 10:24:36', 'admin', null);
INSERT INTO `t_role` VALUES ('6', '管理员6', '1', '2020-03-17 10:24:36', 'admin', null);

-- ----------------------------
-- Table structure for t_role_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_role_auth`;
CREATE TABLE `t_role_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) DEFAULT NULL COMMENT '角色表Id',
  `auth_id` int(11) DEFAULT NULL COMMENT '权限表ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- ----------------------------
-- Records of t_role_auth
-- ----------------------------
INSERT INTO `t_role_auth` VALUES ('1', '1', '1');
INSERT INTO `t_role_auth` VALUES ('2', '1', '2');
INSERT INTO `t_role_auth` VALUES ('3', '1', '3');
INSERT INTO `t_role_auth` VALUES ('4', '1', '4');
INSERT INTO `t_role_auth` VALUES ('5', '1', '5');
INSERT INTO `t_role_auth` VALUES ('6', '2', '1');
INSERT INTO `t_role_auth` VALUES ('7', '2', '2');
INSERT INTO `t_role_auth` VALUES ('10', '1', '6');
INSERT INTO `t_role_auth` VALUES ('11', '1', '7');
INSERT INTO `t_role_auth` VALUES ('12', '1', '8');
INSERT INTO `t_role_auth` VALUES ('13', '2', '3');

-- ----------------------------
-- Table structure for t_role_user
-- ----------------------------
DROP TABLE IF EXISTS `t_role_user`;
CREATE TABLE `t_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '角色用户表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色用户表';

-- ----------------------------
-- Records of t_role_user
-- ----------------------------
INSERT INTO `t_role_user` VALUES ('1', '1', '1');
INSERT INTO `t_role_user` VALUES ('2', '2', '2');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `pass_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `status` int(2) DEFAULT '1' COMMENT '状态：1：启用，0：禁用，-1：删除',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'test1', 'e10adc3949ba59abbe56e057f20f883e', '测试1', '15800210000', '858002100@qq.com', '1', 'admin', null, '2020-03-17 09:31:22');
INSERT INTO `t_user` VALUES ('2', 'test2', 'e10adc3949ba59abbe56e057f20f883e', '测试2222', '15800210000', '858002100@qq.com', '1', 'admin', null, '2020-03-20 03:50:56');
INSERT INTO `t_user` VALUES ('3', 'test3', 'e10adc3949ba59abbe56e057f20f883e', '测试3', '15800210000', '858002100@qq.com', '1', 'admin', null, null);
INSERT INTO `t_user` VALUES ('4', 'test4', 'e10adc3949ba59abbe56e057f20f883e', '测试4', '15800210000', '858002100@qq.com', '1', 'admin', '2020-03-17 09:05:05', null);
INSERT INTO `t_user` VALUES ('5', 'test5', 'e10adc3949ba59abbe56e057f20f883e', '测试5', '15800210000', '858002100@qq.com', '1', 'admin', '2020-03-17 09:27:59', null);
