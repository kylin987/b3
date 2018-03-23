<?php
class settingMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    // 显示系统设置页面
    public function index()
    {
        require (__ROOTDIR__.'/inc/config.php'); 
        $this->tpl_list=model('category')->tpl_list();
        $this->themes_list=model('setting')->themes_list();
        $langCon=Lang::langCon();
        $this->config_array = array_merge((array)$config,(array)$langCon);
        $this->show();
    }

    // 修改系统设置
    public function save()
    {
        $config = $_POST; //接收表单数据
        $config_array = array();
        foreach ($config as $key => $value) {
            if(!strpos($key,'|')){
                $config_array["config['" . $key . "']"] = $value;
            }else{
                $strarray=explode('|', $key);
                $str="config['" . $strarray[0] . "']";
                foreach ($strarray as $keys=>$values) {
                    if($keys<>0){
                    $str.="['".$values."']";
                    }
                }
                unset($strarrays);
                $config_array[$str] = $value;
            }
        }
        $config_file=__ROOTDIR__.'/inc/config.php';
        $lang_config_file=__ROOTDIR__.'/lang/'.__LANG__.'/config.php';
        $status1=model('setting')->save($config_array,$config_file);
        $status2=model('setting')->save($config_array,$lang_config_file);
        if($status1&&$status2){
            $this->msg('网站配置成功！',1);
        }else{
            $this->msg('网站配置失败，请建站多语言文件夹与inc目录文件是否有写入权限！',0);
        }
    }

}
?>