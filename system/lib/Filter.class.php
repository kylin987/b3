<?php
/**
 * \Library\Filter
 * @category   过滤浏览器输入的内容
 * @package    核心包
 * @author     HuangYi
 * @copyright  Copyright (c) 2012-4-1——至今
 * @license    New BSD License
 * @version    $Id: \Library\Filter.php 版本号 2013-1-1 $
 *
 */
class Filter
{
    /**
     * @static
     * 压缩空白字符
     * @param array|string $data
     * @return array|string
     */
    public static function compressWhite($data) {
        if(is_array($data)) return array_map(__METHOD__ , $data);
        $data = preg_replace ( '/\s+/',' ', $data );//压缩空白
        $data = preg_replace ( '/\s+(\r?\n)/','$1', $data );//压缩行尾空白
        $data = preg_replace ( '/(\r?\n)+/','$1', $data );//压缩回车换行
        return $data;
    }
    /**
     * @static
     * 防止XSS攻击代码——0
     * 删除html和php标签，使得结果只剩下文本
     * 注意<br>不会被删除，同时\n等换行符号也会转换为<br>
     * @param array|string $data
     * @return string
     */
    public static function xssToText($data){
        if(is_array($data)) return array_map(__METHOD__ , $data);
        $data=trim(strip_tags($data,'<br>'));
        $data=self::_del_redundance($data);
        $data = str_replace('\n','<br>',   $data);
        $data = addslashes($data);
        return $data;
    }
    /**
     * @static
     * 防止XSS攻击代码——1
     * 编码为HTML文本
     * @param  array|string $data 需要过滤的值
     * @return string
     */
    public static function xssToHtml($data) {
        if(is_array($data)) return array_map(__METHOD__ , $data);
        if (function_exists('htmlspecialchars')) $data=htmlspecialchars($data);
        else $data=str_replace(array('&', '"', '\'', '<', '>'), array('&amp;', '&quot;', '&#039;', '&lt;', '&gt;'), $data);
        $data = str_replace( array('%3C','%3E',' '),array('&lt;', '&gt;','&nbsp;'), $data);
        $data = self::_del_redundance($data);
        $data = str_replace(' ', '&nbsp;', $data);
        $data = str_replace('\n','<br>',   $data);
        return $data;
    }
    /**
     * @static
     * 防止XSS攻击代码——3
     * 删除javascript,iframes,object等代码，保留html样式
     * @param  array|string $data 需要过滤的字符串或数组
     * @return array|string
     */
    public static function xssDeleteScript($data) {
        if(is_array($data)) return array_map(__METHOD__ , $data);
        //过滤恶意重复空白
        $data=self::_del_redundance($data);
        //完全过滤注释
        $data = preg_replace ( '/<!--.*?-->/s', '', $data );
        $data = preg_replace ( '/\/\*.*?\*\//s', '', $data );
        //完全过滤动态代码
        $data = preg_replace ( '/<\?.*?\?>/s', '', $data );
        //过滤危险的属性，如：过滤on事件lang js
        $data = preg_replace('/(<[^><]+)(lang|on|action|background|codebase|dynsrc|lowsrc)(\b)/i','$1$3',$data);
        $data = preg_replace('/(<[^><]+)(window\.|javascript:|js:|about:|file:|document\.|vbs:|cookie)(.*?\b)/i','$1$3',$data);
        //完全过滤js
        $data = preg_replace('/<script(.*?)>(.*?)<\/script>/si','',$data);
        $data = preg_replace('/<iframe(.*?)>(.*?)<\/iframe>/si','',$data);
        $data = preg_replace('/<object.+<\/object>/iesU', '', $data);
        //对空格编码
        $data = str_replace(' ', '&nbsp;', $data);
        $data = str_replace('\n','<br>',   $data);
        return $data;
    }
    //过滤恶意重复空白
    private static function _del_redundance($data){
        $data = preg_replace ( '/\s+(\r?\n)/','$1', $data );//去除恶意空格
        $data = preg_replace ( '/\s{8,}/',' ', $data );//去除恶意空格
        $data = preg_replace ( '/(\r?\n){3,}/','$1', $data );//去除恶意换行
        return $data;
    }
    /**
     * @static
     * 转化文本中的换行符号为<br/>
     * @param array|string $data 需要过滤的字符串
     * @return array|string
     */
    public static function nl2br($data) {
        if(is_array($data)) return array_map(__METHOD__ , $data);
        return trim (preg_replace ( '/(\015)?(\012)/', '<br/>', $data ));
    }
    /**
     * @static
     * 删除文本中的换行符号
     * @param array|string $data 需要过滤的字符串
     * @return array|string
     */
    public static function nl2delete($data) {
        if(is_array($data)) return array_map(__METHOD__ , $data);
        return trim (preg_replace ( '/(\015)?(\012)/', '', $data ));
    }
    /**
     * @static
     * 编码PHP标签
     * @param array|string $data 需要过滤的字符串或数组
     * @return array|string
     */
    public static function phptag($data) {
        if(is_array($data)) return array_map(__METHOD__ , $data);
        return str_replace(array('<?', '?>'), array('&lt;?', '?&gt;'), $data);
    }
}
