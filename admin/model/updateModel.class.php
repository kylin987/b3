<?php
//升级文件
class updateModel extends commonModel {

  public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        //增加配置文件
        $dir=__ROOTDIR__.'/inc/config.php';
        $file=file_get_contents($dir);
        if(!strstr($file,"['HTML_CACHE_RULE']['empty']['*']")){
            $file=str_replace('?>', '', $file);
            $config='
            $config[\'HTML_CACHE_RULE\'][\'index\'][\'*\']=5000;//缓存时间,单位：秒
            $config[\'HTML_CACHE_RULE\'][\'empty\'][\'*\']=5000;//缓存时间,单位：秒
            $config[\'WATERMARK_CUTOUT\']=false; //缩图方式
            ';
            $data=$file.$config;
            @file_put_contents($dir, $data);
        }
    }

}