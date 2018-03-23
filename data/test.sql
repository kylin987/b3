-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2013 年 04 月 13 日 07:29
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
(1, 1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'duxcms', 1350138971, 1365833679, '127.0.0.1', 1, 84, 1);

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

INSERT INTO `dc_admin_group` (`id`, `name`, `model_power`, `class_power`, `form_power`,  `grade`, `keep`) VALUES
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `dc_category`
--

INSERT INTO `dc_category` (`cid`, `pid`, `mid`, `sequence`, `show`, `type`, `name`, `urlname`, `subname`, `image`, `class_tpl`, `content_tpl`, `page`, `keywords`, `description`, `seo_content`, `content_order`, `lang`, `expand`) VALUES
(1, 0, 2, 0, 1, 0, '单页面演示', 'danyemianyanshi', NULL, NULL, 'page.html', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(2, 0, 1, 0, 1, 0, '文章首页演示', 'wenzhangliebiaoyanshi', '', '', 'list_index.html', 'content.html', 15, '', '', '', 'updatetime DESC', 1, 0),
(3, 2, 1, 0, 1, 1, '文章列表演示', 'wenzhangerjiliebiaoyanshi', '', '', 'list.html', 'content.html', 15, '', '', '', 'updatetime DESC', 1, 0),
(4, 2, 1, 0, 1, 1, '图片列表演示', 'tupianliebiaoyanshi', NULL, NULL, 'list.html', 'content.html', 15, NULL, NULL, NULL, 'updatetime DESC', 1, 0),
(5, 0, 1, 0, 1, 1, '扩展模型演示', 'kuozhanmoxingliebiaoyanshi', '', '', 'list_expand.html', 'content_expand.html', 15, '', '', '', 'updatetime DESC', 1, 1),
(6, 1, 2, 0, 1, 0, '二级单页演示1', 'erjidanyeyanshi1', NULL, NULL, 'page.html', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL),
(7, 1, 2, 0, 1, 0, '二级单页演示2', 'erjidanyeyanshi2', NULL, NULL, 'page.html', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文章栏目分类' AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `dc_category_page`
--

INSERT INTO `dc_category_page` (`id`, `cid`, `content`) VALUES
(1, 1, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	凤凰科技讯 北京时间4月11日消息，美国太空网报道，研究人员最近表示，6500万年前导致地球上恐龙灭绝的巨型小行星撞击可能也引发了一场灾难性的全球火焰风暴。大多数科学家认为这场导致地球上80%物种消失的大灭绝，也被称为K-T大灭绝，是因为小行星或者彗星撞击现位于墨西哥的180千米宽的希克苏鲁伯陨石坑所致。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	研究人员对这场灾难建立了新的模型，他们表示小行星撞击可能发射了很多汽化岩石粒子至地球大气层，后者被压缩成砂砾大小的块状物。当再次落回地球表面，炙热的喷射岩石材料在上层大气层产生了大量的热，温度高达1482摄氏度，导致整个天空变成一片红热长达数小时。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	研究人员表示，这种红外“热脉冲”可能像一个烤肉炉，点燃了所有易燃物，并燃烧了所有树枝、树木，以及几乎所有水下和地下的活物。“红外热的总量大约相当于分布在整个地球、彼此相距4英里的重达1百万吨炸弹爆炸。”环境科学合作研究所（CIRES）的研究人员道格拉斯·罗宾逊（Douglas Robertson）这样说道。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	为了让大家更好的理解这种热脉冲释放的巨大能量，研究人员解释称1百万吨氢弹相当于80颗轰炸日本广岛类型的核弹，而撞击希克苏鲁伯陨石坑事件可能产生了1亿兆吨的能量。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	科学家曾经提出过全球火焰风暴理论，但有的人对此表示质疑，他们称大多数密集辐射可能会被地球上降落的岩石材料所阻挡。即使考虑了这种阻挡效应，罗宾逊和他的研究小组建立的模型仍显示天空会被加热到非常高的温度，从而导致全世界范围内的森林着火发生火灾。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	研究小组的最新证据包括在白垩纪和早第三纪边界（大约6500万年前）沉积物里过多的木炭层，这一发现与全球火焰风暴理论相符。其他科学家则认为烟灰可能是撞击本身的残骸。但罗宾逊和同事表示，如果是这样，那么小行星撞击地球产生的木炭也太多了。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“我们的数据与火焰理论完全相符，当时的情况导致了地球上80%的生物100%的灭绝率。” 罗宾逊说道。但目前就希克苏鲁伯陨石坑是否引发K-T大灭绝仍存在不少争论。有的科学家将这场灾难与近日印度的火山活动相联系，而其他人则认为与其它撞击坑有关，例如印度的湿婆陨石坑。\n&lt;/p&gt;'),
(2, 6, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	凤凰科技讯 北京时间4月12日消息，英国每日邮报报道，近日研究人员发现，不可见的“暗雷”可能会规则性的向空中飞行的乘客喷射大量伽马射线。科学家表示这种地球伽马射线发生的高度刚好位于商业飞机经常飞行的高度。这些闪现的伽马射线异常明亮，甚至能够蒙蔽外太空几百千米远的设备。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	美国佛罗里达理工大学的科学家们建立了一种基于物理学的新模型，该模型展示了雷暴是如何产生高能量辐射的。这一模型还计算了当雷暴发生时，恰好位于同一高度的飞机内部的乘客将会受到的辐射量。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	风暴顶部闪现的伽马射线类型往往能够从太空中观测到，它发出的辐射量相当于10次胸透X射线，或者相当于人们在自然环境背景源一年接受到的辐射量。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;&quot; src=&quot;http://y2.ifengimg.com/d4a44fff10624b98/2013/0412/rdn_516748b3a4b91.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	进行“暗雷”模拟的科学家之一约瑟夫·德伊(Joseph Dwyer)\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“风暴中央产生的辐射量可能还要大十倍，相当于病人在医疗手术过程中接受到的最大辐射量，大约相当于一个全身CT扫描。尽管飞机驾驶员会尽全力避免雷暴，但有的时候飞机总是不可避免的位于带电风暴内部。”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“根据模型的计算，在很少的情况下，几百名乘客可能会在不知情的情况下同时受到相当大量的暗雷辐射。”目前研究人员还不知道这种情况发生的频率有多大，但科学家正在对之进行研究，他们表示乘客接受到的辐射量可能并没有之前预估计的到达危险的程度。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	暗雷是如何产生的\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“暗雷产生的辐射还不足以让人们害怕，它还不至于成为人们避免坐飞机的原因。”早在十年前科学家就已经知道雷暴能够产生某些短促但强大的伽马射线爆发，后者也被称为地面伽马射线闪光(TGFs)。这种伽马射线闪光异常明亮，以至于它甚至能够蒙蔽几百千米远位于外太空的设备。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	由于这种伽马射线闪光产生的高度大约相当于商用飞机常飞行的高度，因此科学家试图确定TGFs是否会对飞机里的乘客产生辐射危害。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	在此之前，由于对雷暴究竟是如何产生这些伽马射线的了解知之甚少，科学家一直无法回答这一问题，最初估计产生辐射的危险程度从不安全到非常可怕。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	商用客机的平均飞行高度大约在9150米到12200米。这意味着商用客机每次飞行可能会两次经过潜在危险高度区，也即大约4900米的高处。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;'),
(3, 7, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	新华网合肥４月８日电（记者徐海涛）中国科学技术大学教授张铁龙等人与美国、奥地利科学家合作，于近期在国际上首次发现了金星磁层中存在磁场重联现象。该成果对研究金星的气候演化以及人类如何防范和解决全球气候变暖等延伸问题具有重要意义。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	金星即我国传统文化中的“启明星”，作为太阳系中距离地球最近的一颗行星，因其体积、密度、质量与地球相近而被看做地球的“姊妹星”。科学探测结果表明，金星上没有水，表面温度高达４００摄氏度以上。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	相似的构造，为何金星上的气候却与地球大相径庭？金星上严重的“温室效应”是如何形成的，对人类防范和解决近年出现的全球气候变暖有何借鉴意义？这一系列问题成为近年来国际科学界研究的焦点领域之一。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	在中国国家自然科学基金的支持下，中科大地球和空间科学学院教授张铁龙领导下的行星物理课题组，与美国加州大学洛杉矶分校、奥地利空间研究所等研究机构合作，利用欧洲“金星快车”探测器的观测资料，首次在金星的诱发磁层中发现了磁场重联现象。并进而提出磁场重联是导致金星大气逃逸的重要机制之一，从而造成其严重“温室效应”的产生。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	该成果发表在４月５日出版的国际权威学术期刊《科学》上，并被列为“亮点文章”。该杂志认为，这个发现有可能极大地改变人类对磁场重联以及太阳风与无内禀磁场行星或彗星相互作用的理解。“意味着可能因磁场重联而产生了金星上的极光，并导致大气逃逸，从而使这个４０亿年前富含水分的行星演化成了今天的样子”。\n&lt;/p&gt;');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `dc_content`
--

INSERT INTO `dc_content` (`aid`, `cid`, `title`, `urltitle`, `subtitle`, `font_color`, `font_bold`, `keywords`, `description`, `updatetime`, `inputtime`, `image`, `url`, `sequence`, `tpl`, `status`, `copyfrom`, `views`, `position`) VALUES
(1, 3, '20万台小米2S瞬间售罄 电信版4月16日可购', '20wantaixiaomi2Sshunjianshoudi', NULL, NULL, 0, '小米,用户', '昨晚8点20分，20万台小米2S（【上手评测】【开箱图】）首次开放购买，大概过了2分钟，即显示已售罄，相比之前小米2一机难求的情况，本次开放购买时的网络情况要好很多，但奇怪的是并没有提供版本选择(16GB或32GB)，而是系统直接为你选择版本(笔者被选中的是16GB版本)。需要注意的是：购机成功用户要在当晚10点前下单，下单后2小时内支付;4月16日小米2S将二次开放购买，现在已经可以通过开放购买页面进行预约，但只有16GB/800万像素版本(或许32GB版本供货不多)。此外，昨晚8点30分小米', 1365775948, 1365775948, NULL, NULL, NULL, NULL, 1, 'DUXCMS', 0, '0'),
(2, 3, '手机固话上网卡都将实名 网站泄露信息最高罚3万', 'shoujiguhuashangwangkadujiangs', '', '', 0, '', '', 1365776029, 1365776029, '', '', NULL, '', 1, 'DUXCMS', 0, '1'),
(3, 3, '10日：三星S4到货5400元 4S售3200元返2300元', '10risanxingS4daohuo5400yuan4Ss', '', '', 0, '三星,行货报价,分辨率,代言人', '三星这几年在安卓智能手机上的发展是最迅猛的，似乎三星就成了安卓系统的代言人，每年都推出一部经典手机来几近完美的诠释安卓系统。这款三星I9500（GALAXYSIV/16GB）手机的行货报价为5399元，喜欢的朋友可以详细了解一下。三星GALAXYS4机身正面配备了4.99英寸HDSuperAMOLED屏幕，拥有1920×1080像素分辨率，441ppi。该屏幕也是世界首款FullHDSuperAMOLED显示屏。屏幕设计最大的特色应该就是首次采用的超窄边设计模式，所以这也让屏幕看起来会更“大”一', 1365776050, 1365776050, '', '', NULL, '', 1, 'DUXCMS', 0, '1'),
(4, 3, '史玉柱辞去巨人CEO职务 留任董事会主席', 'shiyuzhuciqujurenCEOzhiwuliure', '', '', 0, '巨人网络,资料图片,史玉柱,新京报', '昨日，史玉柱宣布辞去巨人网络CEO一职。资料图片/CFP新京报讯（记者刘夏）昨日晚间，知名游戏运营商巨人网络CEO史玉柱宣布，因个人原因辞去CEO一职，今后将精力用于慈善方面。这一变化，将从2013年4月19日生效，其继任者也将在当日宣布。不过，史玉柱仍将留任董事会主席。昨日，巨人网络发布了其游戏新品《仙侠世界》。在发布现场，史玉柱意外透露，仙侠世界登场，自己就该退场了。史玉柱说：“网游行业是属于年轻人的。现在我很高兴能够继续担任公司董事会主席一职，并承诺对公司管理团队和研发人才给予全力的支持。', 1365776089, 1365776089, '', '', NULL, '', 1, 'DUXCMS', 0, '1'),
(5, 3, '适合入手机型推荐 iPhone5价格再次暴跌', 'shiherushoujixingtuijianiPhone', '', '', 0, '价格波动,iPhone4,iPhone5', '温度时高时低的首都北京着实是让生活在这个城市的人饱受煎熬，昨天穿衬衫明天就有可能再把羽绒服找出来。近期的手机市场也有这样的状况出现，很多机型的价格浮动很不稳定，搞的人们拿不准时机准确的入手。所以静观其变才是上上策，然而小编深知大家的痛苦，在本期就为大家精心的去准备了一些目前价格合适，而且近些日子也不会再出现大幅度价格波动的机型供大家当作购买参考。正如标题所示，大家一定会不相信自己的眼睛，但这就是事实iPhone5的确是跌破了4000元，曾几何时iPhone4久久居高不下的价格搞的人们硬着头皮充面', 1365776125, 1365776125, '', '', NULL, '', 1, 'DUXCMS', 0, '4'),
(6, 3, '周鸿祎：微信已经从精神上把运营商干掉了', 'zhouhongdaiweixinyijingcongjin', '', '', 0, '', '奇虎360董事长周鸿祎导读：福布斯中文网发表了《福布斯》（中文版）副主编尹生今年2月跟奇虎360董事长周鸿祎之间的一次对话节选，主要内容关于微信以及颠覆。今年2月，我和奇虎360董事长周鸿祎之间有过一次对话，其中的很大一部分篇幅，谈的是微信。一方面，他认为微信已经成为一个无所不在的BigBrother，成为移动互联网的单极世界主导者，另一方面，他也不得不承认，腾讯通过微信一扫过去被视为抄袭者的耻辱，微信的成功已经不仅仅是抄袭者的成功。和最近的风向巧合的是，我们也谈到了微信和运营商的关系，以及运营', 1365776161, 1365776161, '', '', NULL, '', 1, 'DUXCMS', 0, '1'),
(7, 3, '史玉柱谈辞任：巨人数亿美元 我想支100元总裁都不让', 'shiyuzhutancirenjurenshuyimeiy', NULL, NULL, 0, '巨人网络,史玉柱,董事长,年轻人', '北京商报讯（记者张绪旺）效仿好友马云，巨人网络CEO史玉柱昨日晚间宣布辞去CEO职位，将继续保留其巨人网络公司董事会主席的职务，目前新CEO人选尚未公布，史玉柱同时表示“网游行业是属于年轻人的”。史玉柱是在其定位为“屌丝网游”的《仙侠世界》内测发布会上宣布这一决定的，而正式辞职时间定在该游戏上线的4月19日。史玉柱表示，“很早就想辞去CEO职务”，但“心里一直没底”，并称其递交辞呈的时间甚至早于马云，“但董事会直到昨日才同意”。据悉，史玉柱保留巨人网络董事长职位，由于美股上市公司监管政策，CEO', 1365776210, 1365776210, NULL, NULL, NULL, NULL, 1, 'DUXCMS', 0, '0'),
(8, 3, '老外街头救晕倒中国小伙 奇怪他人只拍照不施救', 'laowaijietoujiuyundaozhongguox', '', '', 0, '留学生,地,巴基斯坦,外国人,小伙子', '巴基斯坦留学生哈马德讲述救人经过。记者杨涛摄原标题：小伙子晕倒引来路人围观有的拍照有的拍视频巴基斯坦留学生“闯镜头”救人前天下午，武昌地铁2号线光谷站出口发生感人一幕：一名小伙不幸晕倒在地，正好路过的巴基斯坦来华留学生哈马德见状，毫不犹豫地上前施救，让小伙在现场苏醒过来。小伙晕倒被外国人救醒前天下午3点50分，光谷地铁站C出口，一名年轻小伙突然晕倒在地。目击者马同学说，倒地小伙看起来二十出头，身体十分虚弱。小伙倒地后，周围站满了围观的路人，就在大家犹豫要不要将其扶起时，人群中突然走进来一个皮肤黝', 1365776276, 1365776276, 'http://y0.ifengimg.com/644db11e181e00f8/2013/0412/re_51673177a7ac3.jpg', '', NULL, '', 1, 'DUXCMS', 0, '1'),
(9, 3, '凡客获得“鸟叔”授权 首批“鸟叔”服装5月上市', 'fankehuodeniaoshushouquanshoup', NULL, NULL, 0, '合作协议,合作伙伴', '本报讯（记者任翀）互联网快时尚品牌凡客诚品日前宣布，已正式与“江南style”原唱韩国歌星PSY“鸟叔”签署周边产品联合开发合作协议，凡客也由此成为国内首个“鸟叔”周边产品联合开发合作伙伴。预计首批“鸟叔”形象授权服装将在5月上市。', 1365776373, 1365776373, NULL, NULL, NULL, NULL, 1, 'DUXCMS', 0, '0'),
(10, 3, '独家对话马化腾：微信是社交应用与电信业务无关', 'dujiaduihuamahuatengweixinshis', NULL, NULL, 0, '电信,微信,董事局主席,IT领袖峰会,马化腾', '凤凰科技讯3月31日消息，针对微信是否具有电信业务特征的问题，腾讯董事局主席马化腾今日在IT领袖峰会间隙独家对话凤凰科技时予以否认，马化腾称，微信不是电信业务，是一款社交化应用。自微信推出之后，即有不少业内人士认为微信因为可以传输信息及语音，具有明显的电信基础业务特征。也正因此，有人称腾讯为没有牌照的“虚拟运营商”。不过，马化腾今日在独家对话凤凰科技时表示，微信不是电信业务，是典型的社交应用。有业内人士认为，马化腾如此表态是为了避免“被”成为“虚拟运营商”，否则，腾讯将不可避免的向基础电信运营商', 1365776482, 1365776482, NULL, NULL, NULL, NULL, 1, 'DUXCMS', 1, '0'),
(11, 4, '原浙江省长吕祖善退休后在博物馆当义务讲解员', 'yuanzhejiangshengchanglvzushan', NULL, NULL, 0, '博物馆,浙江省长,浙江诸暨,吕祖善', '吕祖善在浙江省博物馆当义务讲解员原题：吕祖善：当志愿者的老省长为官，吕祖善担任经济大省浙江省长达13年，见证并推动了浙江的经济发展、尤其是民营经济的兴旺发达；为民，他在业余时间担任博物馆义务讲解员，服务乡邻，且自娱自乐2013年春天，常去浙江省博物馆的人经常会看到，一位身板厚实的长者，穿着显然比他的个子小一号的大红色志愿者马甲，给大家当义务讲解员。他不是一般的义务讲解员，而是浙江省前省长、现任全国人大财政经济委员会副主任委员吕祖善。吕祖善祖籍浙江诸暨，是一位“老浙江”。早年从南京航空学院发动机设', 1365776692, 1365776692, 'http://y2.ifengimg.com/1a49d0cd0cb3eb9b/2013/0412/rdn_5167d07dee0d8.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 0, '3'),
(12, 4, '菲律宾海域发生5.4级地震 震源深度103公里', 'feilvbinhaiyufasheng54jidizhen', NULL, NULL, 0, '菲律宾,地震,地质勘探局', '图片来自美国地质勘探局网站。中新网4月12日电据美国地质勘探局网站消息，北京时间4月12日18点34分，菲律宾南部海域发生里氏5.4级地震，震源深度103.2公里。', 1365776756, 1365776756, 'http://img1.cache.netease.com/catchpic/5/55/551D645D57D394F7269393D9DCA338A1.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 1, '0'),
(13, 4, '奥地利科学家称海平面上升将导致大量生物灭绝', 'aodilikexuejiachenghaipingmian', NULL, NULL, 0, '奥地利,太平洋地区,研究报告,生物灭绝', '海平面上升（资料图）奥地利科研人员近日公布研究报告表示，海平面不断上升将吞噬多种生物的存活空间，导致大量生物灭绝。奥地利维也纳兽医大学和美国耶鲁大学的科研人员通过模型计算预测，到本世纪末，东南亚及太平洋地区的海平面将升高约1米。到2500年，这些地区的海平面将升高5.5米。根据模型计算结果，海平面升高1米，东南亚及太平洋地区就将失去约1%的陆地面积，加上潮汐作用的影响，这些地区14.7%的岛屿将被淹没，约三分之一的太平洋地区环礁也将消失。研究人员表示，动物栖息地的减少将严重威胁到当地特有物种和珍', 1365777029, 1365777029, 'http://img1.cache.netease.com/catchpic/0/02/0227F22210FA9AEE19CD086D5867A122.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 1, '3'),
(14, 4, '婴儿游泳馆受家长热捧 卫生及人员配备令人担忧', 'yingeryouyongguanshoujiachangr', '', '', 0, '婴儿游泳馆,天河区', '近年来，婴儿游泳备受家长青睐。然而，近日有家长对婴儿游泳馆的卫生状况、人员配备等问题表示担忧。昨日，记者走访了市内数家婴儿游泳馆，了解到目前婴儿游泳馆卫生监督尚处在灰色地带。家住天河区的李小姐反映，宝宝自去年9月出生后，在医院那几天一直坚持游泳。回到家后，她特意从淘宝上买了充气婴儿游泳池，让宝宝享受游泳的乐趣。“实在是很麻烦。”最让她头疼的是，宝宝游完后，剩下的水成了难题。“直接倒掉实在可惜，但洗衣服、冲马桶，两天都用不完。”无奈之下，李小姐想到了去市面上的婴儿游泳馆消费。“我办了一张500多元', 1365777178, 1365777178, 'http://img2.cache.netease.com/lady/2013/4/11/20130411100209891f0.jpg', '', NULL, '', 1, 'DUXCMS', 3, '1'),
(15, 4, '《北京遇上西雅图》孕产知识靠谱吗？专家来纠错', 'beijingyushangxiyatuyunchanzhi', NULL, NULL, 0, '电影,辽宁省,知识,主演', '《北京遇上西雅图》是近期电影市场上正火的一部电影。电影中，众主演扮演的孕妇可谓是赚足了人们的眼球。很多准妈妈在看完电影后也对其中一些孕产知识颇感兴趣。记者整理了其中的几个剧情，并咨询了相关方面的专家。【剧情一】海清饰演的孕妇在临产前突然羊水破了，而她吓得站在沙发上一动不敢动。辽宁省人民医院妇产科主任医师郑荦说，孕妇羊水破了第一时间一定要平躺下来，同时放松心情。平躺后将枕头放在臀下，尽量保持头低臀高位，防止脐带脱垂，尤其是胎儿臀位和双胎产妇更应该注意。羊水早破意味着分娩的到来，最好马上去医院待产。', 1365777286, 1365777286, 'http://img6.cache.netease.com/lady/2013/4/11/20130411093417d76d0.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 1, '0'),
(16, 4, '范冰冰华鼎奖封后 AngelaBaby火了美乳裙', 'fanbingbinghuadingjiangfenghou', NULL, NULL, 0, 'AngelaBaby,蔡卓妍', '杨颖McqueenAB身着mcqueen2013春夏系列长裙亮相。经典的抹胸长蓬裙款式优雅，搭配古典式编发很有公主范儿；挖空的抹胸成功展现丰乳。但这款裙子不适合搭配钻石配饰，与皮革宽腰带不搭。蔡卓妍AO阿sa身着aliceolivia2013春夏系列长裙亮相。印花蜂腰抹胸长裙款式增加了时尚元素，不至于过于正式，印花也增添活力；夸张的颈饰同样起到减轻厚重感的作用；发型清爽也不失活力。<imgalt="范冰冰华鼎奖封后AngelaBaby火了美乳裙"src="http://img2.ca', 1365777317, 1365777317, 'http://img2.cache.netease.com/lady/2013/4/11/20130411153002c1404.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 5, '3'),
(17, 4, '最高降幅达千元 网购空调热销机型大揭秘', 'zuigaojiangfudaqianyuanwanggou', NULL, NULL, 0, '空调,消费者', '五月将至，空调销售旺季也随之而来。很多商家都会在旺季时节推出不同的促销活动来吸引消费者的眼球，提高关注度，不少朋友也借此次时节精挑细选，为自己选配一款夏季的防暑利器，而身边家装的朋友更是纷纷向笔者咨询究竟要买什么样的空调才物有所值。值得关注的是，在众多询问者中，大多为80后的新婚一组。他们喜欢上网，成天泡在网络上，他们更喜欢在网上购物，显然，网购已然成为这代人的标志，所以，在网络上如果能入手更低价、更超值的家电，自然是不会放过。那么在旺季启动之际，哪些空调在网上火爆销售？又有哪些产品深受消费者喜', 1365777373, 1365777373, 'http://img1.cache.netease.com/catchpic/F/FD/FDF539E6482815E5D795930F407A477B.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 1, '3'),
(18, 4, '让操作更简单 本周最受关注智能电视盘点', 'rangcaozuogengjiandanbenzhouzu', NULL, NULL, 0, '智能电视,消费者,频道', '经过几年的发展，智能电视已经被越来越多的消费者所熟悉，全新的操作流程，炫酷的智能体验，以及更多的人机交互功能，让智能电视走进了更多消费者的家庭。那么，什么样的电视能称之为智能电视呢？我们又该如何选择智能电视呢？接下来，笔者就为大家盘点一下本周网购途径最受欢迎的智能电视，希望能对大家选购智能电视起到一些帮助。让操作更简单本周最受关注智能电视盘点TOP1：海信LED42K520DX3D智能电视海信K520系列智能电视，打破频道界限，同类节目合并呈现。通过直播聚合技术，把同一时段的同类节目汇集在一起，', 1365777442, 1365777442, 'http://img1.cache.netease.com/catchpic/1/13/1383E9844F4CF5B61A35ABBA4509D054.jpg', NULL, NULL, NULL, 1, 'DUXCMS', 2, '1,3'),
(19, 5, ' 佳能SX240 HS', 'jianengSX240HS', '', '', 0, '佳能,处理器,感光度,照片', '佳能SX240HS机身厚约为32.7毫米，光学变焦从广角端到远摄端可覆盖约25-500mm的视角。佳能SX240HS图像感应器有效像素约1210万，并采用了新的DIGIC5数字影像处理器，由此HSSYSTEM得到进化，在昏暗场所使用高ISO感光度也能拍摄出美丽照片，实现了更高画质。', 1365831389, 1365831389, '/upload/2013-04/13/xcxzcxc1.jpg', '', NULL, '', 1, 'DUXCMS', 50, '0');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- 转存表中的数据 `dc_content_data`
--

INSERT INTO `dc_content_data` (`id`, `aid`, `content`) VALUES
(1, 1, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	昨晚8点20分，20万台小米2S（【上手评测】【开箱图】）首次开放购买，大概过了2分钟，即显示已售罄，相比之前小米2一机难求的情况，本次开放购买时的网络情况要好很多，但奇怪的是并没有提供版本选择(16GB或32GB)，而是系统直接为你选择版本(笔者被选中的是16GB版本)。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;20万台小米2S售罄&quot; src=&quot;http://y1.ifengimg.com/719f9cb65353fcc6/2013/0410/ori_5164a76df3ae8.jpeg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	需要注意的是：购机成功用户要在当晚10点前下单，下单后2小时内支付;4月16日小米2S将二次开放购买，现在已经可以通过开放购买页面进行预约，但只有16GB/800万像素版本(或许32GB版本供货不多)。此外，昨晚8点30分小米盒子开放购买，而小米自有品牌配件全场6折、其他品牌配件全场8折，活动限24小时。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;20万台小米2S售罄&quot; src=&quot;http://y1.ifengimg.com/719f9cb65353fcc6/2013/0410/ori_5164a76e5ebec.jpeg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	最后多说一句：现在预约小米2S，除了有16GB标准版外，还有16GB电信版可选，有兴趣的用户可以关注一下。\n&lt;/p&gt;'),
(2, 2, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	晨报讯（记者张璐焦立坤）昨日，工信部起草的《电信和互联网用户个人信息保护规定（征求意见稿）》、《电话用户真实身份信息登记规定（征求意见稿）》在国务院法制办网站公布，向社会征求意见。意见稿规定，电信业务经营者、互联网信息服务提供者泄露、篡改、毁损或出售用户个人信息，将面临1万元至3万元的罚款。而用户如果拒绝出示有效证件，电信业务经营者不得为其办理入网手续。 随着这两个意见稿的公布，我国将出台一系列配套规章推动落实网络信息安全保护、建设网络诚信体系。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	不得泄露个人信息\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	工信部表示，为了保护电信和互联网用户的合法权益，贯彻落实《全国人民代表大会常务委员会关于加强网络信息保护的决定》，促进电信和互联网行业健康发展，工信部起草了《电信和互联网用户个人信息保护规定（征求意见稿）》向社会公开征求意见，时间截至5月15日。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	意见稿明确，未经用户同意，电信业务经营者、互联网信息服务提供者不得收集、使用用户个人信息。电信业务经营者、互联网信息服务提供者及其工作人员对在提供服务过程中收集、使用的用户个人信息应当严格保密，不得泄露、篡改或者毁损，不得出售或者非法向他人提供。违反上述规定，处1万元以上3万元以下的罚款。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	电话入网拟实名制\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	同时，电话实名制的法律空白也即将填补。《电话用户真实身份信息登记规定（征求意见稿）》明确，电话用户真实身份信息登记，是指电信业务经营者为用户办理固定电话、移动电话（含无线上网卡）等入网手续，在与用户签订协议或者确认提供服务时，如实登记用户提供的真实身份信息的活动。用户拒绝出示有效证件，拒绝提供其证件上所记载的身份信息，冒用他人的证件，或者使用伪造、变造的证件的，电信业务经营者不得为其办理入网手续。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	相关专家分析说，这从立法的角度将电话实名制落实下来。此前工信部曾内部发文，要求运营商从2010年9月1日起对新增电话用户实行实名登记。不过从这两年的情况看，手机的实名制还是遇到很多困扰。\n&lt;/p&gt;'),
(3, 3, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星这几年在安卓智能手机上的发展是最迅猛的，似乎三星就成了安卓系统的代言人，每年都推出一部经典手机来几近完美的诠释安卓系统。这款三星 I9500（GALAXY SIV/16GB）手机的行货报价为5399元，喜欢的朋友可以详细了解一下。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://y3.ifengimg.com/719f9cb65353fcc6/2013/0410/re_5164a11b8f488.jpg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星GALAXY S4机身正面配备了4.99英寸HD Super AMOLED屏幕，拥有1920×1080像素分辨率，441 ppi。该屏幕也是世界首款Full HD Super AMOLED显示屏。屏幕设计最大的特色应该就是首次采用的超窄边设计模式，所以这也让屏幕看起来会更“大”一些。三星GALAXY S4屏幕显示效果很细腻，颜色显示效果纯正，并且触控时的响应速度和手感也都达到了较高标准。另外，S4使用了康宁大猩猩玻璃第三代加以保护。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://y3.ifengimg.com/719f9cb65353fcc6/2013/0410/re_5164a11c172af.jpg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星GALAXY S4的机身尺寸为136.6×69.8×7.9毫米，机身重量为130克。此前三星GALAXY S3的厚度为8.6毫米，Note Ⅱ则为9.4毫米，对比来看三星GALAXY S4算是更加超薄了，得益于超窄边，屏幕尺寸的加大并没有带来更大的机身尺寸，并且拿在手中的手感也较为轻盈。如果你之前用过S3那么握住S4时会很适应。此外，在机身侧边配备了拥有金属拉丝涂层的边框，从侧面提高了产品的设计品味。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://y3.ifengimg.com/719f9cb65353fcc6/2013/0410/re_5164a11c83cc4.jpg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星GALAXY S4背部也进行了少许改动，配备了1300W像素后置摄像头(前置摄像头为200万像素)，闪光灯安置在相机下方。后盖依旧采用的是塑料材质，但为了增强视觉感，背部增加了一些颗粒感较强的纹路，塑料机身带来的是更轻的持握体验，并且手感也没有缺失，另外，三星GALAXY S4还配备了一块2600mAh容量的电池。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://y3.ifengimg.com/719f9cb65353fcc6/2013/0410/re_5164a11cda3a4.jpg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	由于发布会上并没有过多提到三星GALAXY S4的硬件配置，这里也和大家重点介绍一下。三星GALAXY S4拥有两种不同的配置，一种是1.9GHz四核处理器版，另外一种则是CES2013上发布的Exynos 5 Octa“八核”处理器版，主频为1.6GHz。该处理器由4个A15架构核心以及4个A7架构核心组成，配备的GPU为PowerVR SGX 544MP3。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://y3.ifengimg.com/719f9cb65353fcc6/2013/0410/re_5164a11d3f319.jpg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星 I9500（GALAXY SIV/16GB）\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;table border=&quot;1&quot;&gt;\n		&lt;tbody&gt;\n			&lt;tr&gt;\n				&lt;td colspan=&quot;2&quot;&gt;\n					三星 I9500（GALAXY SIV/16GB）\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					手机类型\n				&lt;/td&gt;\n				&lt;td&gt;\n					4G手机，3G手机，智能手机，拍照手机\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					主屏尺寸\n				&lt;/td&gt;\n				&lt;td&gt;\n					4.990\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					触摸屏\n				&lt;/td&gt;\n				&lt;td&gt;\n					电容屏，多点触控\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					主屏分辨率\n				&lt;/td&gt;\n				&lt;td&gt;\n					1920x1080像素\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					网络模式\n				&lt;/td&gt;\n				&lt;td&gt;\n					GSM，WCDMA，TD-LTE，FDD-LTE\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					支持频段\n				&lt;/td&gt;\n				&lt;td&gt;\n					2G：GSM 850/900/1800/1900 3G：WCDMA 850/900/1900/2100\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					操作系统\n				&lt;/td&gt;\n				&lt;td&gt;\n					Android OS 4.2\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					CPU型号\n				&lt;/td&gt;\n				&lt;td&gt;\n					三星 Exynos 5410\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					CPU频率\n				&lt;/td&gt;\n				&lt;td&gt;\n					1638\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					扩展容量\n				&lt;/td&gt;\n				&lt;td&gt;\n					64GB\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					机身颜色\n				&lt;/td&gt;\n				&lt;td&gt;\n					黑色，白色\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					手机尺寸\n				&lt;/td&gt;\n				&lt;td&gt;\n					136.6x69.8x7.9mm\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					手机重量\n				&lt;/td&gt;\n				&lt;td&gt;\n					130g\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					GPS导航\n				&lt;/td&gt;\n				&lt;td&gt;\n					内置GPS，支持A-GPS，GLONASS\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					3D加速\n				&lt;/td&gt;\n				&lt;td&gt;\n					支持\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					后置摄像头像素\n				&lt;/td&gt;\n				&lt;td&gt;\n					1300\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					闪光灯\n				&lt;/td&gt;\n				&lt;td&gt;\n					LED补光灯\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					视频拍摄\n				&lt;/td&gt;\n				&lt;td&gt;\n					1080p（1920×1080，30帧/秒）视频录制\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					蓝牙传输\n				&lt;/td&gt;\n				&lt;td&gt;\n					支持蓝牙4.0\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td&gt;\n					数据接口\n				&lt;/td&gt;\n				&lt;td&gt;\n					HDMI，Micro USB v2.0，TV-OUT\n				&lt;/td&gt;\n			&lt;/tr&gt;\n			&lt;tr&gt;\n				&lt;td colspan=&quot;2&quot;&gt;\n					&amp;nbsp;\n				&lt;/td&gt;\n			&lt;/tr&gt;\n		&lt;/tbody&gt;\n	&lt;/table&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星 I9500（GALAXY SIV/16GB）\n&lt;/p&gt;'),
(4, 4, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;img alt=&quot;&quot; src=&quot;http://y3.ifengimg.com/019880eeab20dc41/2013/0410/ori_5164989ae77d1.jpeg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	昨日，史玉柱宣布辞去巨人网络CEO一职。资料图片/CFP\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	新京报讯（记者刘夏）昨日晚间，知名游戏运营商巨人网络CEO史玉柱宣布，因个人原因辞去CEO一职，今后将精力用于慈善方面。这一变化，将从2013年4月19日生效，其继任者也将在当日宣布。不过，史玉柱仍将留任董事会主席。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	昨日，巨人网络发布了其游戏新品《仙侠世界》。在发布现场，史玉柱意外透露，仙侠世界登场，自己就该退场了。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	史玉柱说：“网游行业是属于年轻人的。现在我很高兴能够继续担任公司董事会主席一职，并承诺对公司管理团队和研发人才给予全力的支持。”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	史玉柱是中国民营企业界的传奇人物，在保健品市场凭借脑白金成功掘金的同时，转战网络游戏市场，于2004年11月成立巨人网络公司。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	巨人以网络游戏为发展起点，是集研发、运营、销售为一体的综合性互动娱乐企业。巨人网络凭借游戏《征途》大获成功，2007年，该公司在美国纳斯达克成功上市。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	昨日，史玉柱表示，自己未来的精力将主要放在慈善方面，以后外界会很难见到他。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	在重点“经营”游戏的同时，史玉柱涉足金融行业，成为民生银行的董事，其大举买入民生银行的股票，获利颇丰。随着银行股在去年底以来的上涨，截至今年1月底，史玉柱投资民生银行在13个月的时间里，浮盈约40亿元。\n&lt;/p&gt;'),
(5, 5, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	温度时高时低的首都北京着实是让生活在这个城市的人饱受煎熬，昨天穿衬衫明天就有可能再把羽绒服找出来。近期的手机市场也有这样的状况出现，很多机型的价格浮动很不稳定，搞的人们拿不准时机准确的入手。所以静观其变才是上上策，然而小编深知大家的痛苦，在本期就为大家精心的去准备了一些目前价格合适，而且近些日子也不会再出现大幅度价格波动的机型供大家当作购买参考。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	正如标题所示，大家一定会不相信自己的眼睛，但这就是事实iPhone5的确是跌破了4000元，曾几何时iPhone4久久居高不下的价格搞的人们硬着头皮充面子也要去购买，如今的iPhone5早已没有了iPhone4的光彩，价格一降再降让人看着甚是开心。闲话不多说，下面就揭开正文大幕看看最近都有哪些机型是适合入手的吧！\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	拥有5.5英寸屏幕和1.6GHz主频四核处理器的野兽级强机——三星GALAXYNoteII一定会符合众多喜欢个儿大配置高消费者的胃口，不仅拿在手机非常有面子，使用感受也是让人念念不忘。光说不练假把式，接下来就看看这款5.5英寸巨兽的具体配置吧。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://img002.21cnimg.com/photos/album/20121122/m600/50A5BC353FE9F1801BFE442DDB68D6DB.jpeg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	图为三星GALAXY NoteII 正面\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	三星GALAXYNoteII机身尺寸为：151.1x80.5x9.4mm。在正面搭载了一块硕大的5.0英寸屏幕，分辨率也达到了1280X720。可谓是如虎添翼，使得屏幕整体显示效果相当的惊人。前置摄像头为190万像素，相信这一定是喜欢自拍的朋友们的福音，背部摄像头的像素则为800万像素，在成像效果和色彩还原度的方面都做的很出色。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://img002.21cnimg.com/photos/album/20121122/m600/A7FE00EF9EE4C0B6405191FB2BCA31EF.jpeg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	图为三星GALAXY NoteII 背面\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	硬件配置上，三星GALAXYNoteII采用Android4.1的操作系统，并搭配高达1.6GHz主频的四核处理器，内存为2GB。系统稳定性和实际操作中的流畅性都非常好，3100毫安的电池容量足以保证手机在正常使用下的续航能力。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;点击进入下一页&quot; src=&quot;http://img003.21cnimg.com/photos/album/20121122/m600/61281619272F3D44AE367EE2AB8EFC19.jpeg&quot; title=&quot;点击进入下一页&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	图为三星GALAXY NoteII 侧面\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	编辑点评：三星GALAXYNoteII，在软硬件配置上可以说是现在最高端的，它也一定会续写Note所创下的神话。喜欢大屏幕和超强性能的你来说三星GALAXYNoteII一定是不二之选。如今该款手机的售价已经算得上是超值了。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	商品名称：三星GALAXY NoteII（欧版）\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	商品价格：3199元\n&lt;/p&gt;'),
(6, 6, '&lt;p&gt;\n	&lt;img alt=&quot;&quot; src=&quot;http://y0.ifengimg.com/9306c2a92b63165f/2013/0411/rdn_51660598874b3.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	奇虎360董事长周鸿祎\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	导读：福布斯中文网发表了《福布斯》（中文版）副主编尹生今年2月跟奇虎360董事长周鸿祎之间的一次对话节选，主要内容关于微信以及颠覆。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	今年2月，我和奇虎360董事长周鸿祎之间有过一次对话，其中的很大一部分篇幅，谈的是微信。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	一方面，他认为微信已经成为一个无所不在的Big Brother，成为移动互联网的单极世界主导者，另一方面，他也不得不承认，腾讯通过微信一扫过去被视为抄袭者的耻辱，微信的成功已经不仅仅是抄袭者的成功。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	和最近的风向巧合的是，我们也谈到了微信和运营商的关系，以及运营商可能的救赎。除此之外，我们还谈到了如何从微信的成功中吸取经验，微信、苹果、谷歌等巨头背后的数据大战的可能方式，以及如何在一个有微信存在的移动互联网世界继续寻找颠覆和创新的机会。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	虽然他对微信的看法让人觉得不免有点捧杀的嫌疑，但还是非常值得一读和深思，尤其是对每一个身处微信时代的创业者。下面是对话的部分内容，未经周鸿祎本人确认：\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：你如何评价微信的表现？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：在PC上还有老三强（新浪、网易、搜狐）和新三强（腾讯、阿里巴巴、百度），在无线上有了微信，已经是一个单极世界。微信已经成了《黑客帝国》里无所不在的Big Brother。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：对广大创业者而言，这意味着什么？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：对大多数创业者而言，有两条路：过去在产业链有大中小公司，现在要么成为没有梦想的小公司，独特的内容，游戏，放在微信和苹果应用商店，用户不属于你，Facebook和Zygna的游戏就表明，但Zynga试图脱离Facebook时，你发现就不行。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	第二，在美国每个Big Brother，由于文化，总是有挑战者，比如三星和谷歌，去挑战苹果，但他们不是小公司，要么你是挑战者，要么是靠巨头分账生存的小公司。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	在中国会更加极端，微信已经从精神上把运营商干掉了。运营商忙着做各种花里胡哨的东西，最后发现安身立命的东西，基本需求是通信，沟通，玩游戏是上面的需求，当通信这一基本需求被微信拿走后，运营商就真正成为了管道。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	微信已经控制了所有人的真实性，你的通信记录，你和谁沟通和内容，你到什么地方，你的朋友叫谁，在PC上还是虚拟的。微信加一个功能，可能就会死掉一个公司。你辛苦做了几百万的用户，但微信一升级推出一个相同的新公司，你可能就死掉了。微信本身会成为一个平台，很多小公司寄生在它上面提供各种服务分账。你不要指望成为像它那样的巨头。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：那360会和它合作吗？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：对我们而言，我们面临的局面：现在我们的程序和微博打通，和微信打通，我们承认他们的地位，也会合作，但也不甘心，在这种寡头下，你又不想做一个太小的公司，但你上升的空间又被巨头笼罩住了。我相信百度，优酷等，传统三大门户都有这种感觉。最后还是两条路，还是要想办法找到创新的产品体验或商业模式，其次，希望能找到颠覆式的创新东西，力图在巨头的格局下，找出来几个生存和发展的空间。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：最近大家讨论得比较多的，是移动互联网是否会改变传统的TAB占主导的行业格局，你怎么看？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：阿里是商务公司，依托互联网平台，只要商务做得好，有大量商品和卖家，它的地位相对稳固，它同时也是云端做的很好的公司，无论你用什么终端，都可以去访问它。但是即便是它，也不要小瞧微信对它的挑战，现在人们还通过淘宝或百度APP去买东西，你设想一下，微信知道你每天聊天的内容，你到了那里，它就可以向你推荐商品，微信就可能把你导向它的电商网站。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	技术的革命带来的颠覆怎么考虑都不为过。表面看来微信和百度没有冲突，但今后它可以颠覆搜索，因为微信账号里可能会出现一些语音机器人，你可以向它们发请求，搜索的入口可能就变成了微信，而非搜索框，苹果控制了终端，应用商店入口，百度谷歌占据了搜索流量入口，再加上腾讯把通信入口控制住，腾讯对通信入口的控制的力量要远远超过谷歌和苹果。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：谷歌理论上也能通过对安卓的控制来掌握大量的数据啊？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：理论上可以，理论上任何一个应用都能取你的数据，但我相信谷歌不会这样做。这是一个涉及商业伦理的问题。但是不能这么做，这么做要有两个前提：一是要么有必要，二是，用户要知道。有的游戏应用，也要登录你的通讯录，根本没有必要。谷歌安卓当然可以记录这些，但它不能偷偷传回它的服务器。比如你用微软的邮箱， 从理论上它能知道你每封邮件的内容，因为它是帮助你传输邮件的，但它不能把这些数据回传。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：谷歌还拥有大量的其他数据，这没有用了吗？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：数据和数据不一样，谷歌抓到的是跟用户没有关系的已经存在的网页资料，它最多知道你浏览记录，搜索记录，搜索词，腾讯不一样，它知道的是你的生活行为。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：那阿里掌握了你的交易数据，是不是更厉害？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：我不这样认为，交易数据只是生活中偶一为之的行为。除了极少的购物狂。你一个月去淘宝四次，它当然知道，但这个价值还等同于搜索，但问题是你每天无时无刻不在手机上。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：在PC上还需要通过登录系统，移动互联网上只要用手机就是自动登录了，对不对？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：不对。任何应用都不能不经用户许可去记录用户信息，现在很多应用都是不经你的许可来记录甚至回传你的记录，这些应用都是360要予以查杀的。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	但是微信是个特殊情况，它提供了很多便利，你的很多朋友都在用，但你要用，很自然就要将你的通信录、通话记录等允许他记录，这样通过微信服务器进行中转，它不用刻意去做什么，它要提供服务，就必须记录你的真实身份。即便你不愿意把你的号码给它，但你的朋友的手机里有你的电话号码，腾讯马上知道你是谁，它可以知道你和每个人交流的频次和内容，微信不需要刻意去采集。它并没有刻意搜集。最后微信很自然就拿到一个人的方方面面。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	最近360卫士有一个程序，是隐私安全的，我们就是要把这样做的程序给揪出来。然后让用户知道，什么软件在偷偷干活，很多人在各种应用商店加了一个软件后，你根本不知道它在干什么，包括苹果应用商店，你根本不知道它在干什么，它就是个黑盒子。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	苹果如何获得数据？它也不能回传数据，但它开通了一个iCloud服务，你自愿将你的日历，短信记录邮件记录自动备份在苹果服务器，它的数据分析就成为了合法的。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	谷歌做社交网络，把它的Google+加进来，也是这个原因，人们用得频率最高的是各种社交工具，即时通讯等，社交工具都是云端的，你就会把你的信息传给谷歌服务器，它必须通过你使用各种类似产品来获取数据。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：你一直对颠覆式创新情有独钟，你认为手机还有哪些颠覆机会？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：微信是很好的颠覆机会，颠覆了短信，传统电话，这样的机会不多了。微信的用户体验做得很好，甚至比很多中小创业企业的体验还做得好。它没有百度这样的问题， 从体验上（颠覆它）很难。它也不赚钱，是免费的。它甚至颠覆了运营商，它传照片的体验比彩信还好，微信今天还有高速成长期，没有颠覆的机会。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	目前大格局已经定了后，出现巨头的机会很少，在现在你能看见的领域看不到机会，但在今天大家都没有看到的领域，没有意识到的领域，可能还会出现一些颠覆的机会。比如小米可能通过做设备的方式，这也是一种尝试，也有人试图在电视上创造一种方式，但目前来看不乐观，中小公司要么做内容提供商，做分账，不然做合纵连横。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：运营商有没有可能通过诸如断网损害体验等它们能轻松控制的方式来颠覆掉它？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：没有可能，它今天的用户量已经很大，如果运营商仅仅是通过破坏用户体验的方式，是和用户市场的呼声背道而驰的。谁都不能逆民意。在它没有成气候时，运营商这么做还是有机会的。当年微博刚起来时，饭否还刚刚起来，用户量不大，说关也就关了。但今天你变成新浪微博这么大，要关就难了，那么多人都在用。即便运营商在网络层让其不好用，这不是颠覆思路，这是搞破坏。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	运营商只有一条路，过去因为短信需要收费，一些用户转移去用飞信，今天微信让短信变得没有价值了，运营商应该主动把短信免费掉，要想成功，必先自宫，这样可能还有人愿意用短信，但这也很难做，它的收入最终两三年被微信干掉，也可能是不得不接受的现实。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	福布斯：过去很多人一提起腾讯，立即就想到一个词——抄袭者，微信的成功难道也仅仅是抄袭者的成功吗？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	周鸿祎：微信一开始是模仿，但这个团队没有仅仅在抄袭功能上，今天微信很多功能是腾讯在创新，超越了同行，关键是创造了价值，在PC时代，腾讯做了旋风去抄袭迅雷，用了个管家去抄袭360安全卫士，它做了浏览器，搜索，都不如被抄袭者做得好，也没有给用户创造更多的价值，只是增加了其用户量，利用了其渠道优势，那个时代它是被骂的。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	但是微信确实给用户创造了价值，确实颠覆了运营商，确实给我们的体验超出了我们的预期，已经不是一个简单的抄袭，它的很多功能超越了米聊，腾讯的很多进步是非常大的。\n&lt;/p&gt;'),
(7, 7, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	北京商报讯（记者张绪旺）效仿好友马云，巨人网络CEO史玉柱昨日晚间宣布辞去CEO职位，将继续保留其巨人网络公司董事会主席的职务，目前新CEO人选尚未公布，史玉柱同时表示“网游行业是属于年轻人的”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	史玉柱是在其定位为“屌丝网游”的《仙侠世界》内测发布会上宣布这一决定的，而正式辞职时间定在该游戏上线的4月19日。史玉柱表示，“很早就想辞去CEO职务”，但“心里一直没底”，并称其递交辞呈的时间甚至早于马云，“但董事会直到昨日才同意”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	据悉，史玉柱保留巨人网络董事长职位，由于美股上市公司监管政策，CEO人选将在4月19日才能公布。不过，不同于其他保留老板（董事长）职位的辞职者，史玉柱流露出的退休意味更为强烈，他将未来的退休生活描述为“屌丝”状态。而这种生活首先就是低调，“你们未来很少能够看见我”。针对记者提出“退而不休”的顾虑，史玉柱强调，“保留董事长职位，但基本不管事情，因为美股市场看公司都看CEO”。他进一步举例解释称，“别看巨人网络账面上趴着数亿美元现金，但我想支出100元，刘伟（巨人网络总裁）都不让”。“可以把互联网舞台留给年轻人。”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	从2010年以来，网游行业陷入发展低谷，虽然在回暖但仍引发忧虑，第九城市、盛大游戏等企业估值相对偏低。不过，史玉柱强调：“游戏行业虽然地位不高、声誉不好，但中国互联网行业70%的钱都是网游挣到的。”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	史玉柱也回顾了其职业生涯。“十年前我就从保健品行业退出了，而外界关注的民生银行这类金融投资业务也是长线，三年不卖或者更长时间，”史玉柱认为，只能在一段时间干一件事情。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	事实上，史玉柱是中国家喻户晓的创业人物，其复杂而传奇的“脑白金”、“黄金酒”、网游《征途》、狂投央视广告等创业和营销经历给其冠上“营销天才”称号，也同时引发争议。目前其旗下以网游为主业的巨人网络2007年登陆纽约证券交易所。\n&lt;/p&gt;'),
(8, 8, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;img alt=&quot;&quot; src=&quot;http://y0.ifengimg.com/644db11e181e00f8/2013/0412/re_51673177a7ac3.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	巴基斯坦留学生哈马德讲述救人经过。记者杨涛摄\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	原标题：小伙子晕倒引来路人围观 有的拍照有的拍视频\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	巴基斯坦留学生“闯镜头”救人\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	前天下午，武昌地铁2号线光谷站出口发生感人一幕：一名小伙不幸晕倒在地，正好路过的巴基斯坦来华留学生哈马德见状，毫不犹豫地上前施救，让小伙在现场苏醒过来。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	小伙晕倒被外国人救醒\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	前天下午3点50分，光谷地铁站C出口，一名年轻小伙突然晕倒在地。目击者马同学说，倒地小伙看起来二十出头，身体十分虚弱。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	小伙倒地后，周围站满了围观的路人，就在大家犹豫要不要将其扶起时，人群中突然走进来一个皮肤黝黑的外国男子，他俯下身开始对小伙进行急救。有路人递来一瓶矿泉水，外国男子不断给小伙脸上和脖子上洒清水，试图让其清醒过来。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	大约过了15分钟，小伙渐渐苏醒过来。在另外一名男子的帮助下，两人一起将小伙搀扶到旁边的花坛台阶上坐下。外国男子询问小伙的身份，有没有同伴和亲人，但小伙身体十分虚弱，听得懂大家说话，自己却始终说不出话来。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	因湖北省中医院光谷院区就在光谷附近，有好心市民在路边拦下一辆出租车，两名男子和白衣女子将小伙扶上车，将其送往医院救治，外国男子则悄悄离开了现场。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	救人者是巴基斯坦留学生\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	外国男子究竟是谁？根据马同学提供的信息，昨天下午4点，记者在中南民族大学辗转找到了这位外国男子。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	他叫哈马德（Ahmed waqas），今年31岁，来自巴基斯坦伊斯兰堡。哈马德约1米78的个子，穿着一身休闲运动装，露出一张阳光般的笑脸。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	哈马德开口就说一口流利的中文，他告诉记者，曾在北京学过半年的中文，去年9月再次来到中国，就读于中南民族大学国际教育学院，刚好学的就是汉语言专业，目前正在上大一。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	前天下午3点半，哈马德在校门口乘坐538路公交车前往光谷广场，他下车后看见马路对面的地铁站C出口聚满了围观的人，透过人群看到一名小伙子晕倒在地。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“围观的人群中，有的在拍照，有的在拍视频，还有的在打电话。”哈马德说，让他感到奇怪的是，就是没有一个人上前施救。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	哈马德介绍，小伙身体向左侧倒在地上，还在不断抽搐，但已经处于昏迷状态，鼻孔还流出了血。曾接触过急救知识的他来不及多想，俯下身子按住小伙的脖子，检查其脉搏。同时，他不断给小伙的胸部和手掌心按摩。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	功夫不负有心人，15分钟后，小伙逐渐睁开眼苏醒过来。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	昨天下午，记者来到湖北省中医院光谷院区急诊科，试图找到被救的小伙。由于无法核实其身份信息，医护人员在查阅了接诊记录后，并没有找到这名小伙。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	对话哈马德\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	记者：当时为什么会去施救？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	哈马德：我看到他倒在地上，肯定需要帮助。作为一个普通人，我应该帮助他。其实真的没什么，就是随便救了一下。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	记者：那么多围观的人都不敢贸然上去，你上前施救时是否有顾虑，会担心对方是骗子或者讹诈你吗？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	哈马德：我不担心他会欺骗我。因为有那么多目击者在现场，会有人作证的。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	记者：最初大家都不敢施救，你认为这是什么原因呢？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	哈马德：我也觉得挺奇怪的，为什么会这样？也许大家是因为害怕被欺骗，或者害怕被坏人报复吧。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	记者：施救前是否犹豫过？做出这样的举动，你是怎么想的？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	哈马德：没有时间让我多想，我直接上前就开始施救。这个世界上有好人，也有坏人，但还是好人多。大家遇到这种情况不应该害怕，而应该勇敢帮助别人。要是下次遇到这种情况，我还会这样做。\n&lt;/p&gt;'),
(9, 9, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	本报讯 （记者 任翀）互联网快时尚品牌凡客诚品日前宣布，已正式与“江南style”原唱韩国歌星PSY“鸟叔”签署周边产品联合开发合作协议，凡客也由此成为国内首个“鸟叔”周边产品联合开发合作伙伴。预计首批“鸟叔”形象授权服装将在5月上市。\n&lt;/p&gt;'),
(10, 10, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	凤凰科技讯 3月31日消息，针对微信是否具有电信业务特征的问题，腾讯董事局主席马化腾今日在IT领袖峰会间隙独家对话凤凰科技时予以否认，马化腾称，微信不是电信业务，是一款社交化应用。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	自微信推出之后，即有不少业内人士认为微信因为可以传输信息及语音，具有明显的电信基础业务特征。也正因此，有人称腾讯为没有牌照的“虚拟运营商”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	不过，马化腾今日在独家对话凤凰科技时表示，微信不是电信业务，是典型的社交应用。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	有业内人士认为，马化腾如此表态是为了避免“被”成为“虚拟运营商”，否则，腾讯将不可避免的向基础电信运营商支付网络租用费。（王鹏）\n&lt;/p&gt;');
INSERT INTO `dc_content_data` (`id`, `aid`, `content`) VALUES
(11, 11, '&lt;p&gt;\n	&lt;img alt=&quot;&quot; src=&quot;http://y2.ifengimg.com/1a49d0cd0cb3eb9b/2013/0412/rdn_5167d07dee0d8.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;&quot; src=&quot;http://y1.ifengimg.com/1a49d0cd0cb3eb9b/2013/0412/rdn_5167d0eb19372.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善在浙江省博物馆当义务讲解员\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	原题：吕祖善：当志愿者的老省长\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	为官，吕祖善担任经济大省浙江省长达13年，见证并推动了浙江的经济发展、尤其是民营经济的兴旺发达；为民，他在业余时间担任博物馆义务讲解员，服务乡邻，且自娱自乐\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	2013年春天，常去浙江省博物馆的人经常会看到，一位身板厚实的长者，穿着显然比他的个子小一号的大红色志愿者马甲，给大家当义务讲解员。他不是一般的义务讲解员，而是浙江省前省长、现任全国人大财政经济委员会副主任委员吕祖善。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善祖籍浙江诸暨，是一位“老浙江”。早年从南京航空学院发动机设计专业毕业后，他先后曾在农场、工厂任过职。1993年起，吕祖善开始在中共浙江省委、省政府任职。2003年，吕祖善出任浙江省省长。他先后与张德江、习近平、赵洪祝等三位浙江省委书记搭档，推动了以前店后厂、市场网络、产业集群为特色的“浙江模式”的快速发展。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	从鸡毛换糖到温州模式，敢为天下先的浙江民营企业家把浙江这一资源并不丰富的省份，打造成了中国最具活力的经济大省。改革开放30多年来，浙江GDP增量的70%、工业增加值增量的75%、市政建设项目的50%以上，都是由个体私营经济参与创造的。在浙江民营经济从起步到兴旺发达的过程中，吕祖善既是见证者，也是重要推手之一。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“吕祖善是浙江经济的功臣之一。”浙江大学经济学院院长史晋川评价说，吕祖善推动建立了服务型政府和公正、透明、可预期的体制框架，而这个支持经济自由发展的体制环境，是“浙江模式”获得成功的重要前提。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	浙商评价吕祖善“务实”，老百姓评价吕祖善“民生”。而令吕祖善最得意的，并不是渐江领先于全国的各种统计数字，而是在全国各省区中，浙江的城乡居民收入差距最小。吕祖善说：“先富民，别着急强省，富了民，省肯定会强。”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	2008年，席卷全球的金融海啸对中国影响颇深，浙江首当其冲；当年一季度出口定单合同明显减少，银行贷款减少几百亿。吕祖善在第一时间向中央政府反映经济明显下行的趋势，寻求信贷支持。他拜访了银监会、央行、工农中建总行等六大部门，呼吁中央给浙江增加信贷额度，并更多地向中小企业倾斜。众所周知，自2007年银根收紧以后，吕祖善的要求“不是太合拍”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	2011年8月，65岁的吕祖善辞去浙江省省长一职。如今，身为全国人大财政经济委员会副主任委员的吕祖善依然关心浙江经济的转型——依靠劳动密集型以及低附加值运作的浙江经济发展模式，正遭遇前所未有的挑战。而在业余时间，这位老省长兴致勃勃地在博物馆里当志愿者，依然服务乡亲。他告诉《中国新闻周刊》，对此“很有乐趣”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	能可持续发展那就是高手\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：你几乎经历了浙江经济发展最重要的时期，有不少人称你是浙江的“经济功臣”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：功臣说不上。我在浙江工作了38年，对浙江的情况比较了解。我经历、参与了改革开放以后整个浙江的变化，给我留下很深的烙印。浙江之所以有那么大的发展，关键是改革、是开放。尽管前一段时间遇到金融危机，碰到这样或那样的困难和挑战，但还是要坚定不移地沿着这条路走下去。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：浙江的发展与政府的“无为而治”息息相关。2013年，浙江进一步实施行政审批改革，要打造办事最快的政府。这是不是意味着，浙江仍要进一步深化改革？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：对，审批改革只是一个方面。总体来讲，如果政府对经济管得过多而不是过少，就肯定会出毛病。很多年前我就在讲，政府对经济要抓什么？要抓经济发展的环境，这包括硬环境、软环境、法制环境、办事效率的环境，以及人文环境。市场的主体是企业，不是政府。政府不要把自己估价过高，(管得多)可能往往带来负面影响。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：金融危机余波尚存，对浙江经济未来发展你有哪些建议？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：浙江经济发展到这样的规模，增长速度不是主要的。当“第一”没什么了不起，关键是浙江能不能做到可持续发展，能可持续发展那就是高手。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	可持续发展，则意味着没有大的波动，没有大的折腾。看当前的增长速度，高是不会再高了，而低一点其实没什么可怕的。关键在于结构调整和发展方式的转变，重点是城乡统筹、环境、民生等问题，因为这关系到能不能真正实现可持续发展。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	现在，大家都还在比总量、比速度。但我想，慢慢地大家会把可持续发展作为共识。我以前强调经济发展模式的转型、社会的转型、政府的转型，只有这三个转型做好了，变成可持续了，你即使不要速度，速度也会跟上来。而如果没有做好这三个转型，你就算想要有速度，也只能是眼前的、暂时的速度。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“回归老百姓的本分”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：听说你现在闲暇的时候会去当志愿者？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：我本来就是一个普通老百姓，退下来以后，还是回归老百姓的本分吧，做一些普普通通的事。我不喜欢退下来以后还经常参加这个会那个会，当这个长那个长的。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	另外，在国外也好，在中国的台湾也好，我发现很多公务员退下来之后会去做志愿者，做一些公益事业。我想，我们现在也需要这么一种倡导吧。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：为什么选择当博物馆的义务讲解员呢？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：我就想，该做什么公益呢？那就宣传浙江历史吧。这里是我的家乡，是浙江的山水和父老乡亲们养育了我。浙江是个能干事、能干成事的地方，如果能为浙江人民谋一点福利，为浙江的发展做出一点贡献，我很荣幸。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	浙江省博物馆里，有一个馆的主题是《越地长歌》，讲的是一百万年前从浙江有人类活动开始，到工业革命的这一段历史。我觉得这个内容很好，便选择在这里讲解。一开始，我以为自己对浙江历史多多少少有点了解，但后来愈讲愈发现浙江历史底蕴之深厚，内容之博大，自己之渺小。做志愿者，也是不断丰富自己，不断学习的过程。这一点，想与大家共勉。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：你多长时间去一次？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：每次讲解前，我都会做很多功课。去年(2012年)一年，我讲了十六次，基本上是一个月去一次到两次。今年1月2月，已经讲三次了。一开始我用的是博物馆给的讲稿，到现在，我自己编写了一个一个半小时到两个小时的讲解稿。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：你从中应该也找到不少乐趣吧？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：很有乐趣。我自己也从中学到了许多，对历史多了一份敬畏。南宋吕祖谦是婺学代表，提倡讲实理、育实才、求实用，反对空疏之学，他经世致用、重视史学、教书育人；南宋陈亮，婺州永康人，提倡“道在物中”；南宋叶适，浙江温州人，他反对空谈性理，提倡“事功之学”，重视商业；明代王守仁，余姚人，“心学”创始人，提倡知行合一。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	他们都有一个共同点，就是务实。你看，浙江人务实，是祖先留给我们的基因。要干成一件事，不踏踏实实是干不成的，要力戒浮躁。从历史上看，古人一辈子干一件事，甚至几代人干一件事，都是很平常的。但当代人过于浮躁、急功近利。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中国新闻周刊：你的听众主要是哪些人？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吕祖善：之前我讲解的对象多是学生群体，现在听众人群已经比较广了。我鼓励学生和年轻人多去了解自己家乡、自己国家的历史，这样才能更好地去爱她。我也建议年轻人，去每一座城市，都应该去逛一逛博物馆。以前我去别的城市也逛博物馆，但那个时候还谈不上兴趣。现在，我不光参观博物馆，对有关史料、资料也都很关注。现在的博物馆概念很多，我觉得每一座博物馆都好。此外，艺术馆、图书馆等也都应该多去。\n&lt;/p&gt;'),
(12, 12, '&lt;p&gt;\n	&lt;img src=&quot;http://img1.cache.netease.com/catchpic/5/55/551D645D57D394F7269393D9DCA338A1.jpg&quot; alt=&quot;菲律宾海域发生5.4级地震震源深度103公里（图）&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	图片来自美国地质勘探局网站。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	中新网4月12日电 据美国地质勘探局网站消息，北京时间4月12日18点34分，菲律宾南部海域发生里氏5.4级&lt;a href=&quot;http://news.163.com/special/rbdblhddz/&quot; target=&quot;_blank&quot;&gt;地震&lt;/a&gt;，震源深度103.2公里。\n&lt;/p&gt;'),
(13, 13, '&lt;p&gt;\n	&lt;img src=&quot;http://img1.cache.netease.com/catchpic/0/02/0227F22210FA9AEE19CD086D5867A122.jpg&quot; alt=&quot;科学家称海平面上升将导致大量生物灭绝（图）&quot; /&gt;&lt;br /&gt;\n海平面上升（资料图）\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	奥地利科研人员近日公布研究报告表示，海平面不断上升将吞噬多种生物的存活空间，导致大量生物灭绝。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	奥地利维也纳兽医大学和美国耶鲁大学的科研人员通过模型计算预测，到本世纪末，东南亚及太平洋地区的海平面将升高约1米。到2500年，这些地区的海平面将升高5.5米。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	根据模型计算结果，海平面升高1米，东南亚及太平洋地区就将失去约1%的陆地面积，加上潮汐作用的影响，这些地区14.7%的岛屿将被淹没，约三分之一的太平洋地区环礁也将消失。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	研究人员表示，动物栖息地的减少将严重威胁到当地特有物种和珍稀物种的生存，加快其灭绝速度。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	调查显示，目前东南亚及太平洋地区共有12000多座岛屿，生活着3000多种脊椎动物，包括鸟类、两栖动物、爬行动物和哺乳动物。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;'),
(14, 14, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	近年来，婴儿游泳备受家长青睐。然而，近日有家长对婴儿游泳馆的卫生状况、人员配备等问题表示担忧。昨日，记者走访了市内数家婴儿游泳馆，了解到目前婴儿游泳馆卫生监督尚处在灰色地带。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;婴儿游泳馆受家长热捧 卫生及人员配备令人担忧&quot; src=&quot;http://img2.cache.netease.com/lady/2013/4/11/20130411100209891f0.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	家住天河区的李小姐反映，宝宝自去年9月出生后，在医院那几天一直坚持游泳。回到家后，她特意从淘宝上买了充气婴儿游泳池，让宝宝享受游泳的乐趣。“实在是很麻烦。”最让她头疼的是，宝宝游完后，剩下的水成了难题。“直接倒掉实在可惜，但洗衣服、冲马桶，两天都用不完。”无奈之下，李小姐想到了去市面上的婴儿游泳馆消费。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“我办了一张500多元的12次卡。”李小姐说，这卡的使用期限是60天，可让宝宝定期游泳不是一件简单的事情，“小家伙的心情和身体情况常常让计划泡汤。”一张卡总会浪费一两次，而高峰时段，时常会“一位难求”。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	更让李小姐纠结的是，她不清楚游泳馆内的水质及相关的卫生情况。而游泳馆内的工作人员的护理水平也让她不放心，因此每次宝宝去游泳，她和母亲都严阵以待，带足了洗护用品、毛巾和一次性游泳袋，在水池边寸步不离地守着。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	现场：员工池内冲洗饭碗\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	昨日，在荔湾区一家婴儿游泳馆内，记者看到，不到10平方米的空间里摆放着1张护理台和4个大小不一的婴儿游泳池，空置的角落塞满杂物。虽然玻璃门旁张贴的说明写着“进入恒温室前请换鞋”的字样，但店里的工作人员直接跳过了换鞋的步骤，自由出入。号称“恒温室”的游泳场地内不见空调或其他温度调节设备，又因没有窗户，空气很闷。“游泳池的水温冬天高一点，夏天低一点。”该店工作人员表示，对游泳池内的水并无确切的温度设置，视情况而定。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	记者发现，店内一个未充水的游泳池池底的排水口周围，已经有类似污渍的黑色痕迹。有一个空置的游泳池里铺放着透明大塑料袋，水有一半满，似是上个婴儿游完泳后还未来得及清理。一旁的护理台上，杂乱摆放着婴儿衣物和各种玩具。多数玩具使用痕迹明显，并未得到彻底清洁。期间，一位工作人员径直打开泳池里的热水开关，冲洗她刚用冷水洗过的饭碗。“婴儿游泳前，水池里都会铺上一次性塑料袋。一个孩子一缸水，用完就换。游泳池每日都会进行清洁。”面对记者对此提出的质疑，该店工作人员解释。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	业内：不少游泳馆采用循环水\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	记者走访多家婴儿游泳馆后发现，这些婴儿游泳馆的卫生状况良莠不齐，即使在环境、卫生条件较好的几家游泳馆里，通风情况、泳池消毒手段、玩具清洁等都存在问题。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	据业内人士透露，为了省水，在广州众多婴儿游泳馆中，“一人一池水”的承诺时常是个幌子。“数量可观的婴儿游泳馆采用的是循环水。”他说，循环水是将使用过的泳池里的水进行净化处理，然后再次注入泳池中重复使用。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	资质：护理人员良莠不齐\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“你放心，我们这里的工作人员都是持证上岗的。”一家婴儿游泳馆的负责人说，店内3名工作人员全部持有育婴师资格证。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	在一些母婴论坛上，婴儿游泳馆急招护理师的帖子隔三岔五就会出现。这些帖子上，有些会直接注明“有一定的育儿经验，有相关工作经验者优先”，或是“有爱心有责任心，入职再培训”。记者随机拨打了一家游泳馆的电话咨询招聘事宜，该店工作人员表示，没有任何相关资格证也没有关系，“这里有老师，培训一段时间后，我们总公司就会发放一张证书。”\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	医院：\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	护士会接受再培训\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	市面上的婴儿游泳馆如此，医院的情况又是怎样？广医三院产科陈护士长告诉记者，在医院，他们坚持做到“一用一消毒”。婴儿游泳使用一次性游泳袋，“因为游泳时间不长，水温不高，也不必担心有害物质挥发的问题。”游泳圈在每次使用后都用医用酒精消毒。在游泳池全部使用完毕后，会对所有的游泳池用含氯的消毒液浸泡半小时，最后全场再用紫外线消毒。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	“有专门针对婴儿游泳的资格证书。”陈护士长说，医院婴儿游泳室的护士都是持证上岗。除了婴儿抚触资格证，护士也都接受了有关婴儿游泳的系统培训，并考取了由国家认定的资格证书。在培训中，护理人员要学会观察婴儿在游泳过程中的情况，如哭闹、脸色等等，以及一些突发情况的急救知识，同时也要进行婴儿游泳操的训练，以及实际操作中的一系列注意事项等等。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;'),
(15, 15, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	《北京遇上西雅图》是近期电影市场上正火的一部电影。电影中，众主演扮演的孕妇可谓是赚足了人们的眼球。很多准妈妈在看完电影后也对其中一些孕产知识颇感兴趣。记者整理了其中的几个剧情，并咨询了相关方面的专家。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	【剧情一】 海清饰演的孕妇在临产前突然羊水破了，而她吓得站在沙发上一动不敢动。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;《北京遇上西雅图》孕产知识靠谱吗？专家来纠错&quot; src=&quot;http://img6.cache.netease.com/lady/2013/4/11/20130411093417d76d0.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	辽宁省人民医院妇产科主任医师郑荦说，孕妇羊水破了第一时间一定要平躺下来，同时放松心情。平躺后将枕头放在臀下，尽量保持头低臀高位，防止脐带脱垂，尤其是胎儿臀位和双胎产妇更应该注意。羊水早破意味着分娩的到来，最好马上去医院待产。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	通常来讲，破膜后24小时内孕妇会临产，如果破膜24小时后仍无临产征兆，应注意观察胎儿及产妇的心率、体温、白细胞的变化，及时使用抗生素防止感染。如果孕妇的孕龄＞36周、24小时后未临产者应积极催产，而孕龄＜36周的孕妇在预防感染的前提下应继续妊娠一段时间，以保证胎儿的正常生长发育。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	【剧情二】 吴秀波饰演的Frank带汤唯饰演的文佳佳去做产前检查，嘱咐其一定要做眼底检查。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;《北京遇上西雅图》孕产知识靠谱吗？专家来纠错&quot; src=&quot;http://img4.cache.netease.com/lady/2013/4/11/201304110932352bfb3.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	很多孕妇听到产前要做眼底检查很不解。在妊娠晚期，很多孕妇容易并发妊娠高血压综合征，医生通过对孕妇眼底的检查便可了解到小动脉的病变，甚至观察到因痉挛厉害时出现的视网膜水肿、蛋白渗出和出血斑点，乃至视网膜剥离等情况，以便及时处理调整。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	此外，很多高度近视的孕妇认为自己不能顺产，担心生产时用力造成视网膜脱落。这种情况在临床上极其罕见。不过，如果高度近视的孕妇在产前眼底发生改变，那么，这种情况还是有可能发生的。所以为了安全起见，高度近视的女性最好在孕期和产前及时进行眼底、视网膜检查。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	【剧情三】文佳佳患妊高症昏倒，Frank指责检查医生，称低龄孕产妇也是妊高症的高危人群。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;《北京遇上西雅图》孕产知识靠谱吗？专家来纠错&quot; src=&quot;http://img3.cache.netease.com/lady/2013/4/11/20130411094148fe288.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	妊高症的高危人群并不仅局限于高龄产妇，像年龄过小(小于18岁)、身材过胖、有高血压家族史，有肾炎、糖尿病等慢性病以及多胎妊娠、营养失衡的孕妇也都是妊高症的高危人群。要想有效预防妊高症的发生，孕妇一定要定期产检。另外，像一些产妇动物脂肪、热能摄入太多，蛋白质、各种维生素、无机盐和微量元素摄入不足，都会诱发或加重妊高症。因此，合理安排饮食，对预防和控制妊高症的发生发展非常关键。孕妇平时也要生活规律，经常散步增强抵抗力，保证充足的睡眠，身体不适时要及时看医生。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	【剧情四】 文佳佳的宝宝出生后患有病理性黄疸，在灯光箱照了三天后已无大碍。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;《北京遇上西雅图》孕产知识靠谱吗？专家来纠错&quot; src=&quot;http://img4.cache.netease.com/lady/2013/4/11/20130411094221a387f.jpg&quot; /&gt; \n&lt;/p&gt;'),
(16, 16, '&lt;p&gt;\n	&lt;img alt=&quot;范冰冰华鼎奖封后 AngelaBaby火了美乳裙&quot; src=&quot;http://img2.cache.netease.com/lady/2013/4/11/20130411153002c1404.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	杨颖Mcqueen\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	AB身着mcqueen2013春夏系列长裙亮相。经典的抹胸长蓬裙款式优雅，搭配古典式编发很有公主范儿；挖空的抹胸成功展现丰乳。但这款裙子不适合搭配钻石配饰，与皮革宽腰带不搭。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;范冰冰华鼎奖封后 AngelaBaby火了美乳裙&quot; src=&quot;http://img5.cache.netease.com/lady/2013/4/11/20130411152013cf4cf.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	蔡卓妍AO\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	阿sa身着alice olivia2013春夏系列长裙亮相。印花蜂腰抹胸长裙款式增加了时尚元素，不至于过于正式，印花也增添活力；夸张的颈饰同样起到减轻厚重感的作用；发型清爽也不失活力。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;范冰冰华鼎奖封后 AngelaBaby火了美乳裙&quot; src=&quot;http://img2.cache.netease.com/lady/2013/4/11/20130411152016d69d7.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	范冰冰LV\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	作为当晚最大牌的明星，范冰冰身着LV2013春夏系列连身裙亮相。这条裙子采用白色与绿色的搭配和草叶印花，非常小清新。可范冰冰却用夸张的单边大波浪和黑色超高跟、黑色手包这些成熟优雅的配饰发型来搭配，完全毁掉了小清新，给人不伦不类的感觉。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;范冰冰华鼎奖封后 AngelaBaby火了美乳裙&quot; src=&quot;http://img3.cache.netease.com/lady/2013/4/11/201304111520189193f.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吉克隽逸Kenzo\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	吉克隽逸选择了kenzo2013春夏的印花裙。她这种肤色还是很适合kenzo的东方风情热烈印花；标志性长马尾也增加了民族风情。但衣服上身那里比较怪，不知是太松还是胸太大？妆容太齁，显脏；镶彩钻的超高跟太过火。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;范冰冰华鼎奖封后 AngelaBaby火了美乳裙&quot; src=&quot;http://img1.cache.netease.com/lady/2013/4/11/201304111520211caa6.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	容祖儿Versace\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	容祖儿身着versace2013先秋系列长裙亮相。她穿得相对比较清爽简洁。但这条黑裙似乎是送腰的，完全靠腰带束出腰身（请注意腰带上方的布量冗余），所以容祖儿穿得显老气；耳坠太怪也太黑，不如换成金色复古大耳坠，还能提亮。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img alt=&quot;范冰冰华鼎奖封后 AngelaBaby火了美乳裙&quot; src=&quot;http://img4.cache.netease.com/lady/2013/4/11/20130411152023f1c74.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;'),
(17, 17, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	五月将至，空调销售旺季也随之而来。很多商家都会在旺季时节推出不同的促销活动来吸引消费者的眼球，提高关注度，不少朋友也借此次时节精挑细选，为自己选配一款夏季的防暑利器，而身边家装的朋友更是纷纷向笔者咨询究竟要买什么样的空调才物有所值。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	值得关注的是，在众多询问者中，大多为80后的新婚一组。他们喜欢上网，成天泡在网络上，他们更喜欢在网上购物，显然，网购已然成为这代人的标志，所以，在网络上如果能入手更低价、更超值的家电，自然是不会放过。那么在旺季启动之际，哪些空调在网上火爆销售？又有哪些产品深受消费者喜爱？\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;最高降幅达千元 网购空调爆款机型大揭秘&quot; src=&quot;http://img1.cache.netease.com/catchpic/F/FD/FDF539E6482815E5D795930F407A477B.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	今天，我们就对大家感兴趣的网购低价空调，进行一个集体揭秘，并且也给大家曝光一个真实、可参开的价格。下面，感兴趣的朋友就一起来看看吧。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	好评如潮 奥克斯 KFR-35GW/SQB+2\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	空调采用压缩机静音、电机静音、风机静音、设计静音、管路静音五大静音技术，将空调噪音降低至最科学的分贝数，从而让消费者舒适、安静的使用。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;最高降幅达千元 网购空调爆款机型大揭秘&quot; src=&quot;http://img.ea3w.com/210_500x375/209223.bmp&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	正面展示\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	奥克斯 KFR-35GW/SQB+2空调室外机均采用加厚镀锌钢板，最新防锈型喷漆材料，配合先进的德国瓦格纳双重喷漆设备进行外观加工（钢板几层，镀锌层，粉漆固化层，釉质层），该设备多用于奔驰、宝马汽车基础图层，使得外机使用寿命高达15年。\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;最高降幅达千元 网购空调爆款机型大揭秘&quot; src=&quot;http://img.ea3w.com/210/209224.bmp&quot; /&gt;\n&lt;/p&gt;'),
(18, 18, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	经过几年的发展，智能电视已经被越来越多的消费者所熟悉，全新的操作流程，炫酷的智能体验，以及更多的人机交互功能，让智能电视走进了更多消费者的家庭。那么，什么样的电视能称之为智能电视呢？我们又该如何选择智能电视呢？接下来，笔者就为大家盘点一下本周网购途径最受欢迎的智能电视，希望能对大家选购智能电视起到一些帮助。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;让操作更简单 本周最受关注智能电视盘点&quot; src=&quot;http://img1.cache.netease.com/catchpic/1/13/1383E9844F4CF5B61A35ABBA4509D054.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	让操作更简单 本周最受关注智能电视盘点\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	TOP1：海信LED42K520DX3D智能电视\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	海信K520系列智能电视，打破频道界限，同类节目合并呈现。通过直播聚合技术，把同一时段的同类节目汇集在一起，形成直播导航界面，让您一眼挑中喜爱的节目。用户还可以通过文字、语音搜索，查找自己喜欢的电视节目。 目前，这款电视在京东商城直降1100元，加上节能补贴400元，成交价仅为4199元，喜欢的朋友不要错过。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;海信LED42K520DX3D智能电视&quot; src=&quot;http://img1.cache.netease.com/catchpic/4/41/4166B3AF26EACDDE16731B00532BB853.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	海信LED42K520DX3D智能电视\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	海信K520系列是国内首发的带安卓4.0系统的智能电视，配合Android4.0研发的SAMRTZONE2.2深度优化平台，采用1080P全高清操作界面，简易直观，真正适合电视使用。K520系列内置双核处理器（2CPU+2GPU），运行速度超流畅。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;背部特写&quot; src=&quot;http://img1.cache.netease.com/catchpic/A/AF/AF980A7FCF358B4E4E6A762213C0F309.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	背部特写\n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	海信K520智能电视能够与智能手机、海信I’TV，通过无线网络进行多屏互动，实现大屏传小屏、小屏传大屏、智能云分享、智能云遥控。在此基础上，实现了大屏传小屏后的反向控制，I’TV可以反向控制电视。\n&lt;/p&gt;\n&lt;p&gt;\n	&lt;img border=&quot;0&quot; alt=&quot;接口特写&quot; src=&quot;http://img1.cache.netease.com/catchpic/1/11/116B3AB92FE1CE350A11E11FA0529EE8.jpg&quot; /&gt; \n&lt;/p&gt;\n&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	&lt;br /&gt;\n&lt;/p&gt;'),
(19, 19, '&lt;p style=&quot;text-indent:2em;&quot;&gt;\n	佳能SX240 HS机身厚约为32.7毫米，光学变焦从广角端到远摄端可覆盖约25-500mm的视角。佳能SX240 HS图像感应器有效像素约1210万，并采用了新的DIGIC 5数字影像处理器，由此HS SYSTEM得到进化，在昏暗场所使用高ISO感光度也能拍摄出美丽照片，实现了更高画质。\n&lt;/p&gt;');

-- --------------------------------------------------------

--
-- 表的结构 `dc_expand_content_chanpin`
--

DROP TABLE IF EXISTS `dc_expand_content_chanpin`;
CREATE TABLE IF NOT EXISTS `dc_expand_content_chanpin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `pattern` varchar(250) DEFAULT NULL,
  `listpic` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `dc_expand_content_chanpin`
--

INSERT INTO `dc_expand_content_chanpin` (`id`, `aid`, `price`, `pattern`, `listpic`) VALUES
(1, 19, 1880.00, 'SX240 HS', 'a:4:{i:0;a:3:{s:3:"url";s:31:"/upload/2013-04/13/xcxzcxc1.jpg";s:5:"title";N;s:5:"order";N;}i:1;a:3:{s:3:"url";s:31:"/upload/2013-04/13/xcxzcxc2.jpg";s:5:"title";N;s:5:"order";N;}i:2;a:3:{s:3:"url";s:31:"/upload/2013-04/13/xcxzcxc3.jpg";s:5:"title";N;s:5:"order";N;}i:3;a:3:{s:3:"url";s:31:"/upload/2013-04/13/xcxzcxc4.jpg";s:5:"title";N;s:5:"order";N;}}');

-- --------------------------------------------------------

--
-- 表的结构 `dc_expand_content_images`
--

DROP TABLE IF EXISTS `dc_expand_content_images`;
CREATE TABLE IF NOT EXISTS `dc_expand_content_images` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aid` int(10) DEFAULT NULL,
  `zutu` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- 转存表中的数据 `dc_expand_content_images`
--

INSERT INTO `dc_expand_content_images` (`id`, `aid`, `zutu`) VALUES
(26, 45, 'a:3:{i:0;a:3:{s:3:"url";s:55:"/upload/2013-03-13/7209391df51cbedd0f0be0b36fcec06e.jpg";s:5:"title";s:0:"";s:5:"order";s:1:"0";}i:1;a:3:{s:3:"url";s:55:"/upload/2013-03-13/80c0701cad908aa7c40be0ea08d4d7f7.jpg";s:5:"title";s:0:"";s:5:"order";s:1:"0";}i:2;a:3:{s:3:"url";s:55:"/upload/2013-03-13/f9a85c173021cfb323eacc7388d9dec8.jpg";s:5:"title";s:0:"";s:5:"order";s:1:"0";}}'),
(27, 66, 'N;'),
(28, 67, 'N;');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `dc_expand_model`
--

INSERT INTO `dc_expand_model` (`mid`, `table`, `name`) VALUES
(1, 'chanpin', '产品');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `dc_expand_model_field`
--

INSERT INTO `dc_expand_model_field` (`fid`, `mid`, `name`, `field`, `type`, `property`, `len`, `decimal`, `default`, `sequence`, `tip`, `must`, `config`) VALUES
(1, 1, '价格', 'price', 1, 4, 10, 2, '', 0, '', 1, ''),
(2, 1, '型号', 'pattern', 1, 1, 250, 0, NULL, 0, NULL, 1, NULL),
(3, 1, '产品图片', 'listpic', 5, 3, 0, 0, NULL, 0, NULL, 0, NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

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
(2, '版权所有：&lt;a href=&quot;http://www.duxcms.com&quot; target=&quot;_blank&quot;&gt;DUXCMS&lt;/a&gt; 地址：中国.独享网络小组 电话：+86-000000000 &amp;nbsp;传真：\n+86-0000000', '底部信息', 'dibu');

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
-- 表的结构 `dc_plugin_sitemap`
--

DROP TABLE IF EXISTS `dc_plugin_sitemap`;
CREATE TABLE IF NOT EXISTS `dc_plugin_sitemap` (
  `name` varchar(250) DEFAULT NULL,
  `config` int(1) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `dc_plugin_sitemap`
--

INSERT INTO `dc_plugin_sitemap` (`name`, `config`) VALUES
('status', 0);

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
(3, '首页幻灯片', 0),
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
(45, 3),
(11, 3),
(13, 3),
(16, 3),
(17, 3),
(18, 1),
(18, 3),
(8, 1),
(6, 1),
(2, 1),
(4, 1),
(14, 1),
(5, 4),
(3, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=55 ;

--
-- 转存表中的数据 `dc_tags`
--

INSERT INTO `dc_tags` (`id`, `name`, `click`) VALUES
(1, '小米', 1),
(2, '用户', 1),
(3, '三星', 1),
(4, '行货报价', 1),
(5, '分辨率', 1),
(6, '代言人', 1),
(7, '巨人网络', 1),
(8, '资料图片', 1),
(9, '史玉柱', 1),
(10, '新京报', 1),
(11, '价格波动', 1),
(12, 'iPhone4', 1),
(13, 'iPhone5', 1),
(14, '董事长', 1),
(15, '年轻人', 1),
(16, '留学生', 1),
(17, '地', 1),
(18, '巴基斯坦', 1),
(19, '外国人', 1),
(20, '小伙子', 1),
(21, '合作协议', 1),
(22, '合作伙伴', 1),
(23, '电信', 1),
(24, '微信', 1),
(25, '董事局主席', 1),
(26, 'IT领袖峰会', 1),
(27, '马化腾', 1),
(28, '博物馆', 1),
(29, '浙江省长', 1),
(30, '浙江诸暨', 1),
(31, '吕祖善', 1),
(32, '菲律宾', 1),
(33, '地震', 1),
(34, '地质勘探局', 1),
(35, '奥地利', 1),
(36, '太平洋地区', 1),
(37, '研究报告', 1),
(38, '生物灭绝', 1),
(39, '婴儿游泳馆', 1),
(40, '天河区', 1),
(41, '电影', 1),
(42, '辽宁省', 1),
(43, '知识', 1),
(44, '主演', 1),
(45, 'AngelaBaby', 1),
(46, '蔡卓妍', 1),
(47, '空调', 1),
(48, '消费者', 1),
(49, '智能电视', 1),
(50, '频道', 1),
(51, '佳能', 1),
(52, '处理器', 1),
(53, '感光度', 1),
(54, '照片', 1);

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

INSERT INTO `dc_tags_relation` (`aid`, `tid`) VALUES
(1, 1),
(1, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(5, 11),
(5, 12),
(5, 13),
(7, 7),
(7, 9),
(7, 14),
(7, 15),
(8, 16),
(8, 17),
(8, 18),
(8, 19),
(8, 20),
(9, 21),
(9, 22),
(10, 23),
(10, 24),
(10, 25),
(10, 26),
(10, 27),
(11, 28),
(11, 29),
(11, 30),
(11, 31),
(12, 32),
(12, 33),
(12, 34),
(13, 35),
(13, 36),
(13, 37),
(13, 38),
(14, 39),
(14, 40),
(15, 41),
(15, 42),
(15, 43),
(15, 44),
(16, 45),
(16, 46),
(17, 47),
(17, 48),
(18, 49),
(18, 48),
(18, 50),
(19, 51),
(19, 52),
(19, 53),
(19, 54);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `dc_upload`
--

INSERT INTO `dc_upload` (`id`, `file`, `title`, `folder`, `ext`, `size`, `type`, `time`) VALUES
(1, '/upload/2013-04/13/xcxzcxc1.jpg', 'xcxzcxc (1).jpg', '2013-04-13', 'jpg', 12106, NULL, 1365831758),
(2, '/upload/2013-04/13/xcxzcxc2.jpg', 'xcxzcxc (2).jpg', '2013-04-13', 'jpg', 13494, NULL, 1365831758),
(3, '/upload/2013-04/13/xcxzcxc3.jpg', 'xcxzcxc (3).jpg', '2013-04-13', 'jpg', 15394, NULL, 1365831759),
(4, '/upload/2013-04/13/xcxzcxc4.jpg', 'xcxzcxc (4).jpg', '2013-04-13', 'jpg', 15671, NULL, 1365831759),
(5, '/upload/2013-04/13/xcxzcxc1.jpg', 'xcxzcxc (1).jpg', '2013-04-13', 'jpg', 12106, NULL, 1365832032),
(6, '/upload/2013-04/13/xcxzcxc2.jpg', 'xcxzcxc (2).jpg', '2013-04-13', 'jpg', 13494, NULL, 1365832032),
(7, '/upload/2013-04/13/xcxzcxc3.jpg', 'xcxzcxc (3).jpg', '2013-04-13', 'jpg', 15394, NULL, 1365832032),
(8, '/upload/2013-04/13/xcxzcxc4.jpg', 'xcxzcxc (4).jpg', '2013-04-13', 'jpg', 15671, NULL, 1365832033);

-- --------------------------------------------------------

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

