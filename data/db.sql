-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2013 年 03 月 28 日 01:13
-- 服务器版本: 5.1.50
-- PHP 版本: 5.2.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `duxcms`
--

-- --------------------------------------------------------

--
-- 表的结构 `dc_admin`
--

DROP TABLE IF EXISTS `dc_admin`;
CREATE TABLE IF NOT EXISTS `dc_admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gid` int(10) NOT NULL DEFAULT '1',
  `user` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `nicename` varchar(20) DEFAULT NULL,
  `regtime` int(10) DEFAULT NULL,
  `logintime` int(10) DEFAULT NULL,
  `ip` varchar(15) DEFAULT '未知',
  `status` int(1) unsigned DEFAULT '1',
  `loginnum` int(10) DEFAULT '1',
  `keep` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='管理员信息表' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `dc_admin`
--

INSERT INTO `dc_admin` (`id`, `gid`, `user`, `password`, `nicename`, `regtime`, `logintime`, `ip`, `status`, `loginnum`, `keep`) VALUES
(1, 1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'duxcms', 1350138971, 1363157195, '127.0.0.1', 1, 80, 1);

-- --------------------------------------------------------

--
-- 表的结构 `dc_admin_group`
--

DROP TABLE IF EXISTS `dc_admin_group`;
CREATE TABLE IF NOT EXISTS `dc_admin_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `menu_power` text,
  `model_power` text,
  `class_power` text,
  `form_power` text,
  `grade` tinyint(1) DEFAULT '3',
  `keep` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `power_value` (`model_power`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `dc_admin_group`
--

INSERT INTO `dc_admin_group` (`id`, `name`, `model_power`, `class_power`, `form_power`, `grade`, `keep`) VALUES
(1, '超级管理组', '', '','', 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `dc_admin_log`
--

DROP TABLE IF EXISTS `dc_admin_log`;
CREATE TABLE IF NOT EXISTS `dc_admin_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  `ip` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_admin_log`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_admin_menu`
--

DROP TABLE IF EXISTS `dc_admin_menu`;
CREATE TABLE IF NOT EXISTS `dc_admin_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `module` varchar(250) DEFAULT NULL,
  `status` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `module` (`module`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=100 ;

--
-- 转存表中的数据 `dc_admin_menu`
--

INSERT INTO `dc_admin_menu` (`id`, `pid`, `name`, `module`, `status`) VALUES
(1, 0, '首页', NULL, 1),
(3, 1, '系统设置', 'setting', 1),
(4, 1, '模型管理', 'model_manage', 1),
(10, 0, '扩展', NULL, 1),
(11, 10, '扩展模型', 'expand_model', 1),
(12, 10, '自定义变量', 'fragment', 1),
(13, 10, '内容替换', 'replace', 1),
(14, 10, 'TAG管理', 'tags', 1),
(15, 10, '推荐位管理', 'position', 1),
(16, 10, '附件管理', 'upload_file', 1),
(20, 0, '用户', NULL, 1),
(21, 20, '管理组管理', 'user_group', 1),
(22, 20, '管理员管理', 'user', 1),
(23, 20, '后台登录记录', 'log', 1),
(24, 1, '插件管理', 'plugin', 1),
(25, 1, '程序升级', 'upgrade', 1),
(26, 1, '语言管理', 'lang', 1),
(30, 0, '栏目', NULL, 1),
(31, 30, '栏目管理', 'category', 1),
(40, 0, '内容', '', 1),
(41, 40, '内容管理', 'content', 1),
(50, 0, '表单', '', 1),
(51, 50, '表单设置', 'form', 1);

-- --------------------------------------------------------

--
-- 表的结构 `dc_admin_power`
--

DROP TABLE IF EXISTS `dc_admin_power`;
CREATE TABLE IF NOT EXISTS `dc_admin_power` (
  `sequence` int(10) DEFAULT NULL,
  `action` varchar(250) DEFAULT NULL,
  `pid` int(10) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_admin_power`
--

INSERT INTO `dc_admin_power` (`sequence`, `action`, `pid`, `name`) VALUES
(1, 'visit', 3, '浏览'),
(2, 'edit', 3, '保存'),
(1, 'visit', 4, '浏览'),
(2, 'in', 4, '导入'),
(3, 'out', 4, '导出'),
(4, 'config', 4, '配置'),
(5, 'del', 4, '删除'),
(3, 'status', 24, '状态'),
(2, 'install', 24, '安装'),
(4, 'out', 24, '导出'),
(5, 'uninstall', 24, '卸载'),
(2, 'upgrade', 25, '升级'),
(1, 'add', 26, '添加'),
(2, 'edit', 26, '修改'),
(3, 'del', 26, '删除'),
(2, 'add', 31, '添加'),
(3, 'edit', 31, '修改'),
(4, 'del', 31, '删除'),
(2, 'add', 41, '添加'),
(3, 'edit', 41, '编辑'),
(4, 'del', 41, '删除'),
(5, 'past', 41, '审核通过'),
(6, 'cancel', 41, '取消审核'),
(1, 'visit', 11, '浏览'),
(1, 'visit', 24, '浏览'),
(1, 'visit', 25, '浏览'),
(1, 'visit', 26, '浏览'),
(1, 'visit', 31, '浏览'),
(1, 'visit', 41, '浏览'),
(6, 'in', 11, '导入'),
(7, 'out', 11, '导出'),
(3, 'add', 11, '添加'),
(4, 'edit', 11, '编辑'),
(5, 'del', 11, '删除'),
(1, 'visit', 12, '浏览'),
(2, 'add', 12, '添加'),
(3, 'edit', 12, '编辑'),
(4, 'del', 12, '删除'),
(1, 'visit', 13, '浏览'),
(2, 'add', 13, '添加'),
(3, 'edit', 13, '编辑'),
(4, 'del', 13, '删除'),
(2, 'del', 14, '删除'),
(3, 'class', 14, '分组'),
(1, 'visit', 15, '浏览'),
(2, 'add', 15, '添加'),
(3, 'edit', 15, '编辑'),
(4, 'del', 15, '删除'),
(1, 'visit', 14, '浏览'),
(1, 'visit', 16, '浏览'),
(2, 'del', 16, '删除'),
(1, 'visit', 21, '浏览'),
(2, 'add', 21, '添加'),
(3, 'edit', 21, '编辑'),
(4, 'del', 21, '删除'),
(1, 'visit', 22, '浏览'),
(2, 'add', 22, '添加'),
(3, 'edit', 22, '编辑'),
(4, 'current', 22, '只显示自己'),
(1, 'visit', 23, '浏览'),
(4, 'class_config', 14, '分组管理'),
(1, 'visit', 51, '浏览'),
(2, 'add', 51, '添加'),
(3, 'edit', 51, '编辑'),
(4, 'del', 51, '删除'),
(5, 'in', 51, '导入'),
(6, 'out', 51, '导出'),
(7, 'field', 51, '字段管理'),
(5, 'info', 22, '资料修改');

-- --------------------------------------------------------

--
-- 表的结构 `dc_category`
--

DROP TABLE IF EXISTS `dc_category`;
CREATE TABLE IF NOT EXISTS `dc_category` (
  `cid` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL DEFAULT '0',
  `mid` int(10) NOT NULL DEFAULT '1',
  `sequence` int(10) NOT NULL DEFAULT '0',
  `show` int(10) NOT NULL DEFAULT '1',
  `type` int(11) NOT NULL DEFAULT '1',
  `name` varchar(250) DEFAULT NULL,
  `urlname` varchar(250) DEFAULT NULL,
  `subname` varchar(250) DEFAULT NULL,
  `image` varchar(250) DEFAULT NULL,
  `class_tpl` varchar(250) DEFAULT NULL,
  `content_tpl` varchar(250) DEFAULT NULL,
  `page` int(10) DEFAULT NULL,
  `keywords` varchar(250) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `seo_content` text,
  `content_order` varchar(250) DEFAULT NULL,
  `lang` int(10) NOT NULL DEFAULT '1',
  `expand` int(10) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `urlname` USING BTREE (`urlname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_category`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_category_jump`
--

DROP TABLE IF EXISTS `dc_category_jump`;
CREATE TABLE IF NOT EXISTS `dc_category_jump` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(11) unsigned NOT NULL DEFAULT '0',
  `url` varchar(250) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章栏目分类' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_category_jump`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_category_page`
--

DROP TABLE IF EXISTS `dc_category_page`;
CREATE TABLE IF NOT EXISTS `dc_category_page` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(11) unsigned NOT NULL DEFAULT '0',
  `content` mediumtext COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章栏目分类' AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_category_page`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_content`
--

DROP TABLE IF EXISTS `dc_content`;
CREATE TABLE IF NOT EXISTS `dc_content` (
  `aid` int(10) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `cid` int(10) DEFAULT NULL COMMENT '栏目ID',
  `title` varchar(250) DEFAULT NULL COMMENT '标题',
  `urltitle` varchar(250) DEFAULT NULL COMMENT 'URL路径',
  `subtitle` varchar(250) DEFAULT NULL COMMENT '短标题',
  `font_color` varchar(250) DEFAULT NULL COMMENT '颜色',
  `font_bold` int(1) DEFAULT NULL COMMENT '加粗',
  `keywords` varchar(250) DEFAULT NULL COMMENT '关键词',
  `description` varchar(250) DEFAULT NULL COMMENT '描述',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `inputtime` int(10) DEFAULT NULL COMMENT '发布时间',
  `image` varchar(250) DEFAULT NULL COMMENT '封面图',
  `url` varchar(250) DEFAULT NULL COMMENT '跳转',
  `sequence` int(10) DEFAULT NULL COMMENT '排序',
  `tpl` varchar(250) DEFAULT NULL COMMENT '模板',
  `status` int(10) DEFAULT NULL COMMENT '状态',
  `copyfrom` varchar(250) DEFAULT NULL COMMENT '来源',
  `views` int(10) NOT NULL DEFAULT '0' COMMENT '浏览数',
  `position` varchar(250) DEFAULT NULL,
  `taglink` int(10) NOT NULL DEFAULT '0' COMMENT 'TAG链接',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `urltitle` USING BTREE (`urltitle`),
  KEY `title` USING BTREE (`title`),
  KEY `description` (`copyfrom`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_content`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_content_data`
--

DROP TABLE IF EXISTS `dc_content_data`;
CREATE TABLE IF NOT EXISTS `dc_content_data` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_content_data`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_expand_model`
--

DROP TABLE IF EXISTS `dc_expand_model`;
CREATE TABLE IF NOT EXISTS `dc_expand_model` (
  `mid` int(10) NOT NULL AUTO_INCREMENT,
  `table` varchar(250) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_expand_model`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_expand_model_field`
--

DROP TABLE IF EXISTS `dc_expand_model_field`;
CREATE TABLE IF NOT EXISTS `dc_expand_model_field` (
  `fid` int(10) NOT NULL AUTO_INCREMENT,
  `mid` int(10) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `field` varchar(250) DEFAULT NULL,
  `type` int(10) DEFAULT '1',
  `property` int(10) DEFAULT NULL,
  `len` int(10) DEFAULT NULL,
  `decimal` int(10) DEFAULT NULL,
  `default` varchar(250) DEFAULT NULL,
  `sequence` int(10) DEFAULT '0',
  `tip` varchar(250) DEFAULT NULL,
  `must` int(10) DEFAULT '0',
  `config` text,
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_expand_model_field`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_form`
--

DROP TABLE IF EXISTS `dc_form`;
CREATE TABLE IF NOT EXISTS `dc_form` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `table` varchar(20) DEFAULT NULL,
  `display` int(10) NOT NULL DEFAULT '0',
  `page` int(10) NOT NULL DEFAULT '10',
  `tpl` varchar(250) DEFAULT NULL,
  `alone_tpl` int(10) NOT NULL DEFAULT '0',
  `order` varchar(20) DEFAULT NULL,
  `where` varchar(250) DEFAULT NULL,
  `return_type` int(10) NOT NULL DEFAULT '0',
  `return_msg` varchar(250) DEFAULT NULL,
  `return_url` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `dc_form`
--

INSERT INTO `dc_form` (`id`, `name`, `table`, `display`, `page`, `tpl`, `alone_tpl`, `order`, `where`, `return_type`, `return_msg`) VALUES
(2, '留言板', 'guestbook', 1, 10, 'guestbook.html', 0, 'id desc', 'status=1',0,'表单提交成功！');

-- --------------------------------------------------------

--
-- 表的结构 `dc_form_data_guestbook`
--

DROP TABLE IF EXISTS `dc_form_data_guestbook`;
CREATE TABLE IF NOT EXISTS `dc_form_data_guestbook` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `content` text,
  `time` int(10) DEFAULT NULL,
  `http` varchar(250) DEFAULT NULL,
  `reply` text,
  `status` int(1) DEFAULT NULL,
  `lang` int(10) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `dc_form_data_guestbook`
--

INSERT INTO `dc_form_data_guestbook` (`id`, `name`, `email`, `content`, `time`, `http`, `reply`, `status`,`lang`) VALUES
(1, 'duxcms', '244328880@QQ.COM', '欢迎使用duxcms网站内容管理系统', 1363144151, '', '', 1,1);

-- --------------------------------------------------------

--
-- 表的结构 `dc_form_field`
--

DROP TABLE IF EXISTS `dc_form_field`;
CREATE TABLE IF NOT EXISTS `dc_form_field` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `fid` int(10) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `field` varchar(250) DEFAULT NULL,
  `type` int(10) DEFAULT '1',
  `property` int(10) DEFAULT NULL,
  `len` int(10) DEFAULT NULL,
  `decimal` int(10) DEFAULT NULL,
  `default` varchar(250) DEFAULT NULL,
  `sequence` int(10) DEFAULT '0',
  `tip` varchar(250) DEFAULT NULL,
  `config` text,
  `must` int(10) DEFAULT '0',
  `admin_display` int(10) DEFAULT NULL,
  `admin_html` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `dc_form_field`
--

INSERT INTO `dc_form_field` (`id`, `fid`, `name`, `field`, `type`, `property`, `len`, `decimal`, `default`, `sequence`, `tip`, `config`, `must`, `admin_display`, `admin_html`) VALUES
(4, 2, '昵称', 'name', 1, 1, 250, 0, '', 1, '', '', 1, 1, ''),
(5, 2, '邮箱', 'email', 1, 1, 250, 0, '', 2, '', '', 1, 1, ''),
(6, 2, '内容', 'content', 3, 3, 0, 0, '', 3, '', '', 1, 1, ''),
(7, 2, '时间', 'time', 7, 2, 10, 0, '', 4, '', '', 1, 1, 'echo date(''Y-m-d H:i:s'',{content});'),
(12, 2, '网址', 'http', 1, 1, 250, 0, '', 0, '', '', 0, 0, ''),
(13, 2, '管理员回复', 'reply', 2, 3, 0, 0, '', 0, '', '', 0, 0, ''),
(14, 2, '审核', 'status', 8, 2, 1, 0, '0', 0, '', '审核|1\n未审核|0', 0, 1, 'if({content}==1){\necho ''审核'';\n}else{\necho ''未审核'';\n}\n');

-- --------------------------------------------------------

--
-- 表的结构 `dc_fragment`
--

DROP TABLE IF EXISTS `dc_fragment`;
CREATE TABLE IF NOT EXISTS `dc_fragment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `content` text,
  `title` varchar(250) DEFAULT NULL,
  `sign` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sign` (`sign`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文章信息表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `dc_fragment`
--

INSERT INTO `dc_fragment` (`id`, `content`, `title`, `sign`) VALUES
(1, '欢迎使用DUXCMS网站管理系统，DUXCMS是一款针对中小企业所开发的专业网站管理系统。&lt;br /&gt;\n进入后台请在网之后加admin,后台默认帐号密码均为:admin&lt;br /&gt;\n网站上线后请更改后台密码以免影响您的安全', '简介', 'info'),
(2, '版权所有：DUXCMS 地址：中国.独享网络小组 电话：+86-000000000 &amp;nbsp;传真：\r\n+86-0000000', '底部信息', 'dibu');

-- --------------------------------------------------------

--
-- 表的结构 `dc_lang`
--

DROP TABLE IF EXISTS `dc_lang`;
CREATE TABLE IF NOT EXISTS `dc_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `lang` varchar(255) DEFAULT NULL,
  `protection` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `dc_lang`
--

INSERT INTO `dc_lang` (`id`, `name`, `lang`, `protection`) VALUES
(1, '中文', 'zh', 1),
(2, 'english', 'en', 0);

-- --------------------------------------------------------

--
-- 表的结构 `dc_model`
--

DROP TABLE IF EXISTS `dc_model`;
CREATE TABLE IF NOT EXISTS `dc_model` (
  `mid` int(10) NOT NULL AUTO_INCREMENT,
  `model` varchar(250) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `admin_category` varchar(250) DEFAULT NULL,
  `admin_content` varchar(250) DEFAULT NULL,
  `module_category` varchar(250) DEFAULT NULL,
  `module_content` varchar(250) DEFAULT NULL,
  `url_category` varchar(250) DEFAULT NULL,
  `url_category_page` varchar(250) DEFAULT NULL,
  `url_content` varchar(250) DEFAULT NULL,
  `url_content_page` varchar(250) DEFAULT NULL,
  `table` text,
  `file` text,
  `config` text,
  `befrom` text,
  PRIMARY KEY (`mid`),
  KEY `model` (`model`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `dc_model`
--

INSERT INTO `dc_model` (`mid`, `model`, `name`, `admin_category`, `admin_content`, `module_category`, `module_content`, `url_category`, `url_category_page`, `url_content`, `url_content_page`, `table`, `file`, `config`, `befrom`) VALUES
(1, 'content', '新闻', 'content_category', 'content', 'category', 'content', '{CDIR}/', '{CDIR}/index-{P}{EXT}', '{CDIR}/{YYYY}/{M}-{D}/{AID}{EXT}', '{CDIR}/{YYYY}/{M}-{D}/{AID}-{P}{EXT}', NULL, NULL, NULL, 'DUXCMS'),
(3, 'jump', '跳转', 'jump_category', NULL, 'jump', NULL, '{CDIR}/', '{CDIR}/index-{P}{EXT}', '{CDIR}/{YYYY}/{M}-{D}/{AID}{EXT}', '{CDIR}/{YYYY}/{M}-{D}/{AID}{EXT}', NULL, NULL, NULL, 'DUXCMS'),
(2, 'pages', '页面', 'pages_category', NULL, 'pages', NULL, '{CDIR}/', '{CDIR}/index-{P}{EXT}', '{CDIR}/{YYYY}/{M}-{D}/{AID}{EXT}', '{CDIR}/{YYYY}/{M}-{D}/{AID}{EXT}', NULL, NULL, NULL, 'DUXCMS');

-- --------------------------------------------------------

--
-- 表的结构 `dc_plugin`
--

DROP TABLE IF EXISTS `dc_plugin`;
CREATE TABLE IF NOT EXISTS `dc_plugin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `file` varchar(250) DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `mid` int(10) DEFAULT NULL,
  `ver` int(11) DEFAULT NULL,
  `author` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_plugin`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_position`
--

DROP TABLE IF EXISTS `dc_position`;
CREATE TABLE IF NOT EXISTS `dc_position` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `sequence` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `dc_position`
--

INSERT INTO `dc_position` (`id`, `name`, `sequence`) VALUES
(1, '首页推荐', 1),
(3, '幻灯片', 0),
(4, '栏目推荐', 0);

-- --------------------------------------------------------

--
-- 表的结构 `dc_position_relation`
--

DROP TABLE IF EXISTS `dc_position_relation`;
CREATE TABLE IF NOT EXISTS `dc_position_relation` (
  `aid` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  KEY `aid` (`aid`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_position_relation`
--

INSERT INTO `dc_position_relation` (`aid`, `pid`) VALUES
(43, 4),
(45, 3);

-- --------------------------------------------------------

--
-- 表的结构 `dc_replace`
--

DROP TABLE IF EXISTS `dc_replace`;
CREATE TABLE IF NOT EXISTS `dc_replace` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(250) DEFAULT NULL,
  `content` varchar(250) DEFAULT NULL,
  `num` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_replace`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_tags`
--

DROP TABLE IF EXISTS `dc_tags`;
CREATE TABLE IF NOT EXISTS `dc_tags` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cid` int(10) DEFAULT '0',
  `name` varchar(20) NOT NULL,
  `click` int(10) DEFAULT '1',
  `lang` int(10) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` USING BTREE (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_tags`
--

-- --------------------------------------------------------

--
-- 表的结构 `dc_tags_category`
--

DROP TABLE IF EXISTS `dc_tags_category`;
CREATE TABLE IF NOT EXISTS `dc_tags_category` (
  `cid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `lang` int(10) DEFAULT '1',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_tags_category`
--

-- --------------------------------------------------------

--
-- 表的结构 `dc_tags_relation`
--

DROP TABLE IF EXISTS `dc_tags_relation`;
CREATE TABLE IF NOT EXISTS `dc_tags_relation` (
  `aid` int(10) DEFAULT NULL,
  `tid` int(10) DEFAULT NULL,
  KEY `aid` (`aid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_tags_relation`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_upload`
--

DROP TABLE IF EXISTS `dc_upload`;
CREATE TABLE IF NOT EXISTS `dc_upload` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file` varchar(250) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `folder` varchar(250) DEFAULT NULL,
  `ext` varchar(20) DEFAULT NULL,
  `size` int(10) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` USING BTREE (`type`),
  KEY `ext` USING BTREE (`ext`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `dc_upload`
--


--
-- 表的结构 `dc_upload_category`
--

DROP TABLE IF EXISTS `dc_upload_category`;
CREATE TABLE IF NOT EXISTS `dc_upload_category` (
  `id` int(10) DEFAULT NULL,
  `file_id` int(10) DEFAULT NULL,
  KEY `id` (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_upload_category`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_upload_content`
--

DROP TABLE IF EXISTS `dc_upload_content`;
CREATE TABLE IF NOT EXISTS `dc_upload_content` (
  `id` int(10) DEFAULT NULL,
  `file_id` int(10) DEFAULT NULL,
  KEY `id` (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_upload_content`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_upload_form`
--

DROP TABLE IF EXISTS `dc_upload_form`;
CREATE TABLE IF NOT EXISTS `dc_upload_form` (
  `id` int(10) DEFAULT NULL,
  `file_id` int(10) DEFAULT NULL,
  KEY `id` (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_upload_form`
--


-- --------------------------------------------------------

--
-- 表的结构 `dc_upload_plus`
--

DROP TABLE IF EXISTS `dc_upload_plus`;
CREATE TABLE IF NOT EXISTS `dc_upload_plus` (
  `id` int(10) DEFAULT NULL,
  `file_id` int(10) DEFAULT NULL,
  KEY `id` (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_upload_plus`
--
