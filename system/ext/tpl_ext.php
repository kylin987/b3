<?php
if( !function_exists('tpl_parse_ext')) {
	template_ext($template,$config);
}
//自定义模板标签解析函数
function template_ext($template,$config=array())
{
    if($config['LANG_OPEN']){
        $lang_tpl=__LANG__.'/';
    }
    if(MOBILE){
        $mobile_tpl='mobile'.'/';
    }

    //替换文件路径
    $template = preg_replace("/<(.*?)(src=|href=|value=|background=)[\"|\'](images\/|img\/|css\/|js\/|style\/)(.*?)[\"|\'](.*?)>/i",
        "<$1$2\"".__ROOT__."/<?php echo \$config['TPL_TEMPLATE_PATH']; ?>".$lang_tpl.$mobile_tpl."$3$4\"$5>", $template);

    //替换载入模板
    $template = preg_replace('/<!--#include\s*file=[\"|\'](.*)[\"|\']-->/iU',
                    "<?php \$file=explode('.', \"$1\"); ?>{include file=\"".$lang_tpl.$mobile_tpl."\$file[0]\"}", $template);

    //替换菜单与内容的反向超链接
    $template = preg_replace("/\{\\\$curl\.([a-z0-9_]+)\}/iU",
        "<?php echo module('label')->get_curl($1); ?>", $template);
    $template = preg_replace("/\{\\\$aurl\.([a-z0-9_]+)\}/iU",
        "<?php echo module('label')->get_aurl($1); ?>", $template);

    //替换菜单超链接
    $template = preg_replace("/\{(\\$[a-z0-9_]+)\.curl\}/iU",
        "<?php if(!empty($1['url'])){ echo module('common')->return_tpl(html_out($1['url'])); }else{ echo module('label')->get_curl($1['cid']); } ?>", $template);

    //替换内容超链接
    $template = preg_replace("/\{(\\$[a-z0-9_]+)\.aurl\}/iU",
        "<?php if(!empty($1['url'])){ echo module('common')->return_tpl(html_out($1['url'])); }else{ echo module('label')->get_aurl($1['aid']); } ?>", $template);

    //生成表单访问地址
    $template = preg_replace("/\{\\$([a-z0-9_]+)\.form\}/iU",
        "<?php echo module('label')->get_furl($1); ?>", $template);

    //碎片替换
    $template = preg_replace("/\{\\\$my\.([a-z0-9_]+)\}/iU",
        "<?php echo model('fragment')->out('$1'); ?>", $template);


	//PHP语句
    /*{$php(xxx)}替换成 <?php xxx ?>*/
    $template = preg_replace ('/\{\\$php\((.+?)\)\}/iU', '<?php $1 ?>', $template);

    //处理 $list_i 循环条件标签
    $template = preg_replace("/\{\\$([a-zA-Z_]+)\.\i\}/i", "<?php echo \$$1_i ?>", $template);

    //添加循环解析标签
    /*<!--foreach:{$arr $vo}-->替换成 <?php $vo_i=1; if (is_array($arr) foreach($arr as $vo){ ?>*/
    $template = preg_replace ('/<!--foreach:{(\S+)\s+(\S+)}-->\s*/i','<?php \$i=0; $2_i=0; if(is_array($1)) foreach($1 AS $2) { \$i++; $2_i++;  ?>', $template);
    /*<!--foreach:{$arr $key $vo}-->替换成 <?php $vo_i=1; if (is_array($arr) foreach($arr as $key => $vo){ ?>*/
    $template = preg_replace ('/<!--foreach:{(\S+)\s+(\S+)\s+(\S+)}-->\s*/i','<?php \$i=0; $3_i=0;  if(is_array($1)) foreach($1 AS $2 => $3) { \$i++; $3_i++;  ?>', $template);
    /*<!--{/foreach}-->替换成 <?php } ?>*/
    $template = preg_replace ('/<!--\{\/foreach\}-->\s*/iU', '<?php }unset(\$i) ?>', $template);

    //添加判断标签
    /*<!--if:{}-->替换成 <?php if(condition){ ?>*/
    $template = preg_replace ('/<!--\if:{(.+?)\}-->/i', '<?php if($1) { ?>', $template);
    /*<!--elseif:{}-->替换成 <?php }else if(condition){ ?>*/
    $template = preg_replace ('/<!--\elseif:{(.+?)\}-->/i', '<?php }else if($1) { ?>', $template);
    /*<!--{else}-->替换成 <?php }else{ ?>*/
    $template = preg_replace ('/<!--\{else\}-->/i', '<?php }else{ ?>', $template);
    /*<!--{/if}-->替换成 <?php } ?>*/
    $template = preg_replace ('/<!--\/if-->/i', '<?php } ?>', $template);
    $template = preg_replace ('/<!--\{\/if\}-->/i', '<?php } ?>', $template);

    //添加打印标签
    $template = preg_replace ('/<!--dump\{(.+?)\}-->/iU', '<?php print_r($1) ?>', $template);

    //HTML输出
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+html\}/iU", "<?php echo html_out($1['$2']); ?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\s+html\}/iU", "<?php echo html_out($1[\'$2\'][\'$3\']); ?>", $template);

    //时间标签
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+time\=[\"|\'](.*)[\"|\']\}/iU", "<?php echo date('$3',$1['$2']); ?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\s+time\=[\"|\'](.*)[\"|\']\}/iU", "<?php echo date('$4',$1[\'$2\'][\'$3\']); ?>", $template);

    //图片裁剪
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+cutout\=[\"|\'](.*)[\"|\']\}/iU", "<?php echo module('label')->get_cutout($1['$2'],'$3'); ?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\s+cutout\=[\"|\'](.*)[\"|\']\}/iU", "<?php echo module('label')->get_cutout($1[\'$2\'][\'$3\'],'$4'); ?>", $template);
    
    //为空默认值
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+empty\=[\"|\'](.*)[\"|\']\}/iU", "<?php if(!empty($1['$2'])){echo $1['$2'];}else{echo '$3';}?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\s+empty\=\"(.*)\"\}/iU", "<?php if(!empty($1[\'$2\'][\'$3\'])){echo $1[\'$2\'][\'$3\'];}else{echo '$4';}?>", $template);

    //不存在默认值
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+isset\=[\"|\'](.*)[\"|\']\}/iU", "<?php if(isset($1['$2'])){echo $1['$2'];}else{echo '$3';}?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\s+isset\=\"(.*)\"\}/iU", "<?php if(isset($1[\'$2\'][\'$3\'])){echo $1[\'$2\'][\'$3\'];}else{echo '$4';}?>", $template);

    //TAG标签
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+tag\}/iU", "<?php \$tag=explode(',', $1['$2']); foreach (\$tag as \$value) { \$tags.= '<a href=\"'.module('label')->get_turl(\$value).'\" title=\"'.\$value.'\">'.\$value.'</a>,'; } echo substr(\$tags, 0,-1); unset(\$tags); ?>", $template); 

    //标题样式
    $template = preg_replace("/\{(\\$[a-z0-9_]+)\.titlex\}/iU", "<?php \$titlex=$1['title']; if(!empty($1['font_color'])){ \$titlex='<font color=\"'.$1['font_color'].'\">'.\$titlex.'</font>'; } if($1['font_bold']==1){ \$titlex='<strong>'.\$titlex.'</strong>'; }  echo \$titlex;  unset(\$titlex); ?>",
        $template);

    //样式+字数
    $template = preg_replace("/\{(\\$[a-z0-9_]+)\.titlex\s+len\=[\"|\'](.*)[\"|\']\}/iU", "<?php \$titlex=msubstr($1['title'],0,$2); if(!empty($1['font_color'])){ \$titlex='<font color=\"'.$1['font_color'].'\">'.\$titlex.'</font>'; } if($1['font_bold']==1){ \$titlex='<strong>'.\$titlex.'</strong>'; }  echo \$titlex; unset(\$titlex); ?>",
        $template);

    //字符截取
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\s+len\=[\"|\'](.*)[\"|\']\}/iU", "<?php echo msubstr($1['$2'],0,$3); ?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\s+len\=[\"|\'](.*)[\"|\']\}/iU", "<?php echo msubstr($1[\'$2\'][\'$3\'],0,$4); ?>", $template);
	
	//数组标签
	/*{$info.xxx}替换成 <?php echo $info['xxx'] ?>*/
	$template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\}/i", "<?php echo $1['$2']; ?>", $template);
    $template = preg_replace ( "/\{(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)\}/i", "<?php echo $1[\'$2\'][\'$3\']; ?>", $template);

    //转义循环  
    $test=preg_match_all('/<!--(\S+):{(.*)}-->/i',$template,$ms);
    foreach ($ms[2] as $value) {
        $template=str_replace($value, addslashes($value), $template);
    }

    //处理循环内条件标签
    $template = preg_replace ( "/\<(\\$[a-z0-9_]+)\.([a-z0-9_]+)\>/i", "'.$1['$2'].'", $template);
    $template = preg_replace ( "/\<(\\$[a-z0-9_]+)\.([a-z0-9_]+)\.([a-z0-9_]+)>/i", "'.$1['$2']['$3'].'", $template);

    //替换万能表单循环
    $template = preg_replace('/<!--form:{(.*)}-->\s*/i', '<?php $form=module("label")->get_form(\'$1\'); \$form_i=0; if(is_array($form)) foreach($form as $form){  \$form_i++; ?> ',
        $template);

    //数据统计循环
    $template = preg_replace('/<!--count:{(.*)}-->/i', '<?php echo module("label")->get_count(\'$1\');  ?> ',
        $template);

    //替换通用循环
    $template = preg_replace('/<!--(\S+):{(.*)}-->\s*/i', '<?php $$1=module("label")->getlist(\'$2\'); \$$1_i=0; if(is_array($$1)) foreach($$1 as $$1){  \$$1_i++; ?> ',
        $template);

    //循环结束标识

    $template = preg_replace('/<!--\/([a-zA-Z_]+)-->/i', '<?php }unset($$1) ?>', $template);
    $template = preg_replace('/<!--\{\/([a-zA-Z_]+)\}-->/i', '<?php }unset($$1) ?>', $template);

    return $template;

}
?>