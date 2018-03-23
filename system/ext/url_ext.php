<?php
//url解析扩展函数
/*
.htaccess

<IfModule mod_rewrite.c>
RewriteEngine on
RewriteBase /
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . index.php
</IfModule>

*/
if( !function_exists('url_parse_ext')) {
	function url_parse_ext(){
		return url_ext();
	}
}
function url_ext(){
	$rewrite_rules = cpConfig::get('URL_REWRITE_RULE');
	if( !empty($rewrite_rules) ){
		if( ($pos = strpos( $_SERVER['REQUEST_URI'], '?' )) !== false )
			parse_str( substr( $_SERVER['REQUEST_URI'], $pos + 1 ), $_GET );
		$rewrite_rules['<m>/<a>'] = '<m>/<a>';
		foreach($rewrite_rules as $rule => $mapper){
			if(0!==stripos($rule, 'http://'))
				$rule = 'http://'.$_SERVER['HTTP_HOST'].rtrim(dirname($_SERVER["SCRIPT_NAME"]), '/\\') .'/'.$rule;
			$rule = '/'.str_ireplace(array(
				'\\\\', 'http://', '/', '<', '>',  '.', 
			), array(
				'', '', '\/', '(?<', '>\w+)', '\.', 
			), $rule).'/i';
			if(preg_match($rule, 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'], $matchs)){
				foreach($matchs as $matchkey => $matchval){
					if('c' === $matchkey)
						$mapper = str_ireplace('<m>', $matchval, $mapper);
					elseif('a' === $matchkey)
						$mapper = str_ireplace('<a>', $matchval, $mapper);
					else
						if(!is_int($matchkey))$_GET[$matchkey] = $matchval;
				}
				list(cpApp::$module, cpApp::$action) = explode('/', $mapper);
				break;
			}
		}
	} else {
		cpApp::$module=$_GET['m'];
		cpApp::$action=$_GET['a'];
	}
}

function url($module='', $action='', $param=array()){
	$route=$module.'/'.$action;
	$module=empty($module)?'':'?m='.$module;
	$action=empty($action)?'':'&a='.$action;
	$params=empty($param)?'':'&'.http_build_query($param);
	$url = $_SERVER["SCRIPT_NAME"].$module.$action.$params;

	$rewrite_rules = cpConfig::get('URL_REWRITE_RULE');
	if( !empty($rewrite_rules) ) {
		static $urlArray=array();
		if(!isset($urlArray[$url])){
			foreach($rewrite_rules as $rule => $mapper){
				$mapper = '/'.str_ireplace(array('/', '<a>', '<m>'), array('\/', '(?<a>\w+)', '(?<m>\w+)'), $mapper).'/i';
				if(preg_match($mapper, $route, $matchs)){
					list($controller, $action) = explode('/', $route);
					$urlArray[$url] = str_ireplace(array('<a>', '<m>'), array($action, $controller), $rule);
					if(!empty($param)){
						$_args = array();
						foreach($param as $argkey => $arg){
							$count = 0;
							$urlArray[$url] = str_ireplace('<'.$argkey.'>', $arg, $urlArray[$url], $count);
							if(!$count)$_args[$argkey] = $arg;
						}
						$urlArray[$url] = preg_replace('/<\w+>/', '', $urlArray[$url]).
							(!empty($_args) ? '?'.http_build_query($_args) : '');
					}
					
					if(0!==stripos($urlArray[$url], 'http://'))
						$urlArray[$url] = 'http://'.$_SERVER['HTTP_HOST'].rtrim(dirname($_SERVER["SCRIPT_NAME"]), '/\\') .'/'.$urlArray[$url];
					return $urlArray[$url];
				}
			}
		}
	}
	return $url;
}
?>