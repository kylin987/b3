<?php
define('__ADMINDIR__', strtr(dirname(__FILE__),'\\','/'));//后台目录
define('__ROOTDIR__', str_replace("\\",'/',substr(dirname(__FILE__), 0, strrpos(dirname(__FILE__), DIRECTORY_SEPARATOR))));
$root=str_replace(basename($_SERVER["SCRIPT_NAME"]),'',$_SERVER["SCRIPT_NAME"]);
$admindir=explode('/', __ADMINDIR__);
$adminfile='/'.(end($admindir));
$root=substr($root,0,-1);
$root=str_replace($adminfile,'',$root);	
define('__ROOTURL__', $root); //根URL
define('__PUBLICURL__', $root.'/public'); //根公共URL
define('__UPDURL__', $root.'/upload'); //根上传目录
define('__ROOTUPD__', $root.'/public/upload'); //根公共上传
define('__UPDDIR__', __ROOTDIR__.'/upload'); //根上传目录
?>