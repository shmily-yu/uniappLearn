/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : qiushibk

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-04-30 19:55:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adsense
-- ----------------------------
DROP TABLE IF EXISTS `adsense`;
CREATE TABLE `adsense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 动态轮播图 1个人中心',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adsense
-- ----------------------------
INSERT INTO `adsense` VALUES ('1', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/banner1.jpg', '#', '0', null);
INSERT INTO `adsense` VALUES ('2', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/banner2.jpg', '#', '0', null);
INSERT INTO `adsense` VALUES ('3', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/banner3.jpg', '#', '0', null);
INSERT INTO `adsense` VALUES ('4', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/demo20.jpg', '#', '1', null);

-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `black_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '拉黑id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned NOT NULL DEFAULT '0' COMMENT '发布人',
  `fid` int(20) unsigned NOT NULL DEFAULT '0' COMMENT '回复id',
  `fnum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被回复数',
  `data` varchar(225) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '接受id',
  `from_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发送id',
  `data` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of feedback
-- ----------------------------

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follow_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of follow
-- ----------------------------

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('1', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/1.jpg', null);
INSERT INTO `image` VALUES ('2', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/2.jpg', null);
INSERT INTO `image` VALUES ('3', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/3.jpg', null);
INSERT INTO `image` VALUES ('4', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/4.jpg', null);
INSERT INTO `image` VALUES ('5', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/5.jpg', null);
INSERT INTO `image` VALUES ('6', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/6.jpg', null);
INSERT INTO `image` VALUES ('7', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/7.jpg', null);
INSERT INTO `image` VALUES ('8', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/8.jpg', null);
INSERT INTO `image` VALUES ('9', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/9.jpg', null);
INSERT INTO `image` VALUES ('10', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/datapic/10.jpg', null);

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) unsigned NOT NULL DEFAULT '0' COMMENT '发布人',
  `title` varchar(80) NOT NULL,
  `titlepic` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `sharenum` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 图文 1分享',
  `create_time` datetime DEFAULT NULL,
  `post_class_id` int(11) DEFAULT NULL,
  `share_id` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('1', '12', '测试标题1', '', 'uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。', '0', '广东深圳', '0', null, '1', '0');
INSERT INTO `post` VALUES ('2', '7', '测试2', '', 'uni-app 是一个使用 Vue.js 开发跨平台应用的前端框架，开发者编写一套代码，可编译到iOS、Android、H5、小程序等多个平台。', '0', '广东佛山', '0', null, '1', '1');

-- ----------------------------
-- Table structure for post_class
-- ----------------------------
DROP TABLE IF EXISTS `post_class`;
CREATE TABLE `post_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_class
-- ----------------------------
INSERT INTO `post_class` VALUES ('1', '关注', '1', null);
INSERT INTO `post_class` VALUES ('2', '推荐', '1', null);
INSERT INTO `post_class` VALUES ('3', '体育', '1', null);
INSERT INTO `post_class` VALUES ('4', '热点', '1', null);
INSERT INTO `post_class` VALUES ('5', '财经', '1', null);
INSERT INTO `post_class` VALUES ('6', '娱乐', '1', null);

-- ----------------------------
-- Table structure for post_image
-- ----------------------------
DROP TABLE IF EXISTS `post_image`;
CREATE TABLE `post_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '帖子id',
  `image_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_image
-- ----------------------------
INSERT INTO `post_image` VALUES ('1', '1', '1', null);
INSERT INTO `post_image` VALUES ('2', '1', '2', null);
INSERT INTO `post_image` VALUES ('3', '1', '3', null);
INSERT INTO `post_image` VALUES ('4', '2', '4', null);
INSERT INTO `post_image` VALUES ('5', '2', '5', null);

-- ----------------------------
-- Table structure for support
-- ----------------------------
DROP TABLE IF EXISTS `support`;
CREATE TABLE `support` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布人',
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '帖子id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 顶 1踩',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of support
-- ----------------------------
INSERT INTO `support` VALUES ('2', '12', '1', '0', null);
INSERT INTO `support` VALUES ('3', '7', '1', '0', null);

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `titlepic` varchar(255) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` datetime DEFAULT NULL,
  `topic_class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES ('1', '话题名称哈哈哈', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg', '话题描述', '1', null, '1');
INSERT INTO `topic` VALUES ('2', '话题名称', 'https://tangzhe123-com.oss-cn-shenzhen.aliyuncs.com/Appstatic/qsbk/demo/topicpic/1.jpeg', '话题描述', '1', null, '1');

-- ----------------------------
-- Table structure for topic_class
-- ----------------------------
DROP TABLE IF EXISTS `topic_class`;
CREATE TABLE `topic_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic_class
-- ----------------------------
INSERT INTO `topic_class` VALUES ('1', '关注', '1', null);
INSERT INTO `topic_class` VALUES ('2', '推荐', '1', null);
INSERT INTO `topic_class` VALUES ('3', '体育', '1', null);
INSERT INTO `topic_class` VALUES ('4', '热点', '1', null);
INSERT INTO `topic_class` VALUES ('5', '财经', '1', null);
INSERT INTO `topic_class` VALUES ('6', '娱乐', '1', null);

-- ----------------------------
-- Table structure for topic_post
-- ----------------------------
DROP TABLE IF EXISTS `topic_post`;
CREATE TABLE `topic_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '话题id',
  `post_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '帖子id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic_post
-- ----------------------------
INSERT INTO `topic_post` VALUES ('1', '1', '1', null);
INSERT INTO `topic_post` VALUES ('2', '1', '2', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `userpic` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 禁用 1启用',
  `create_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('7', 'zcmcss', null, '', '13450772003', '123@qq.com', '1', null);
INSERT INTO `user` VALUES ('12', '15817899241', null, '$2y$10$52H0RSuByS9lOh.JTP6BOe31LIHMDjnueLUubmyfM50LzioRaRcea', '13450772007', '1236@qq.com', '1', '1556431201');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `age` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '年龄',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '0 男 1女 2不限',
  `qg` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0不限',
  `job` varchar(10) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------

-- ----------------------------
-- Table structure for user_bind
-- ----------------------------
DROP TABLE IF EXISTS `user_bind`;
CREATE TABLE `user_bind` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `openid` varchar(255) NOT NULL,
  `user_id` int(10) unsigned DEFAULT '0',
  `nickname` varchar(50) DEFAULT NULL,
  `avatarurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_bind
-- ----------------------------
INSERT INTO `user_bind` VALUES ('1', 'weixin', 'oRrdQt3HS3Ns2TFCVLMOyxbR9DcM', '12', '楚绵', 'http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132');
INSERT INTO `user_bind` VALUES ('2', 'sinaweibo', '5385242162', '12', '楚绵', 'http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132');
INSERT INTO `user_bind` VALUES ('3', 'qq', '5385242162', '12', '楚绵', 'http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132');
