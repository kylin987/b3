<?php
header("content-type:text/html; charset=utf-8");
@date_default_timezone_set('PRC');

if(!empty($_SERVER['HTTP_X_REWRITE_URL']) ){
	$_SERVER['REQUEST_URI'] = $_SERVER['HTTP_X_REWRITE_URL'];
} else if (!isset($_SERVER['REQUEST_URI'])) {
	if (isset($_SERVER['argv']))
	{
		$_SERVER['REQUEST_URI'] = $_SERVER['PHP_SELF'] .'?'. $_SERVER['argv'][0]; 
	}else{
		$_SERVER['REQUEST_URI'] = $_SERVER['PHP_SELF'] .'?'. $_SERVER['QUERY_STRING']; 
	} 
}

//定义框架目录
define('CP_PATH', dirname(__file__) . '/system/'); //指定内核目录
require (dirname(__file__) . '/inc/config.php');
require (CP_PATH . 'core/cpApp.class.php');

//处理多语言
$lang=$config['LANG_DEFAULT'];
if($config['LANG_OPEN']){
	$lang_file=scandir($config['LANG_PACK_PATH']);
	$url=$_SERVER['REQUEST_URI'];
	foreach ($lang_file as $value) {
		$url=strtolower($url);
		if(strstr($url,'/'.$value)){
			$lang=$value;
			$url = preg_replace('`/'.$value.'`', '', $url,1);
			break;
		}
	}
	$_SERVER['REQUEST_URI']=$url;
}
define('__LANG__', $lang);

//处理手机版
if($config['MOBILE_OPEN']&&$config['MOBILE_DOMAIN']){
	if($config['MOBILE_DOMAIN']==$_SERVER["HTTP_HOST"]){
		define('MOBILE', true);
	}else{
		define('MOBILE', false);
	}
}else{
	define('MOBILE', false);
}

//定义自定义目录
$root = $config['URL_HTTP_HOST'] . str_replace(basename($_SERVER["SCRIPT_NAME"]), '', $_SERVER["SCRIPT_NAME"]);
define('__ROOT__', substr($root, 0, -1));
define('__ROOTDIR__', strtr(dirname(__FILE__),'\\','/'));
define('__UPDIR__', strtr(dirname(__FILE__),'\\','/upload/'));
define('__TPL__', __ROOT__.'/'.$config['TPL_TEMPLATE_PATH']);
define('__UPL__', __ROOT__.'/upload/');

//实例化入口
$app = new cpApp($config);
Lang::init($config);
$app->run();

?>