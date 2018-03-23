<?php

class model_manageMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }
    // 模型管理
    public function index()
    {
        $this->list=model('model_manage')->model_list();
        $this->show();
    }

    public function setting()
    {
        $id=intval($_GET['id']);
        $this->info=model('model_manage')->info($id);
        $this->display();
    }

    public function setting_save()
    {
        if(!strstr($_POST['url_category'],'{CDIR}')){
            $this->msg('栏目URL必须含有{CDIR}！',0);
        }
        if(!strstr($_POST['url_category_page'],'{CDIR}')){
            $this->msg('栏目分页URL必须含有{CDIR}！',0);
        }
        if(!strstr($_POST['url_category_page'],'-{P}')){
            $this->msg('栏目分页URL必须含有-{P}！',0);
        }
        if(!strstr($_POST['url_content'],'{AID}')&&!strstr($_POST['url_content'],'{URLTITLE}')){
            $this->msg('内容URL必须含有{AID}或者{URLTITLE}！',0);
        }
        if(!strstr($_POST['url_content_page'],'{AID}')&&!strstr($_POST['url_content_page'],'{URLTITLE}')){
            $this->msg('内容分页URL必须含有{AID}或者{URLTITLE}！',0);
        }
        if(!strstr($_POST['url_content_page'],'-{P}')){
            $this->msg('内容分页URL必须含有-{P}！',0);
        }

        $status=model('model_manage')->setting_save($_POST);
        $this->msg('模型配置成功！',1);

    }

    //模型导入
    public function in()
    {
        $this->display();
    }

    public function in_data(){
        $table=$_POST['table'];
        if(empty($table)){
            $this->msg('文件夹名尚未填写！',0);
        }
        $dir=__ROOTDIR__.'/data/module/'.$table;
        $config = @Xml::decode(file_get_contents($dir.'/model.xml'));
        $config = $config['config'];
        if(empty($config)){
            $this->msg('无法获取模型配置！',0);
        }
        if(!file_exists($dir)||!file_exists($dir.'/file/')||!file_exists($dir.'/dbbak/')){
            $this->msg($table.'目录不存在！或者目录结构错误！',0);
        }
        if(model('model_manage')->search($config['model'])){
            $this->msg($table.'模型已经存在，无法重复导入！',0);
        }
        //复制文件
        if(!copy_dir($dir.'/file/',__ROOTDIR__)){
            $this->msg('模型文件导入失败，可能网站目录没有写入权限！',0);
        }
        //导入数据库
        $db = new Dbbak($this->config['DB_HOST'],$this->config['DB_USER'],$this->config['DB_PWD'],$this->config['DB_NAME'],'utf8',$dir.'/dbbak/');
        if(!$db->importSql('',$config['prefix'],$this->config['DB_PREFIX'])){
            $this->msg('数据库导入失败！',0);
        }
        if(method_exists($info['model'],'model_ini_in')){
            model($info['model'])->model_ini_in();
        }
        $this->msg('模型导入完毕！',1);

    }

    //模型导出
    public function out()
    {
        $mid=intval($_POST['mid']);
        $info=model('model_manage')->info($mid);
        if(!empty($info['admin_category'])){
            $data=@model($info['admin_category'])->model_ini_data();
            $file_array=@model($info['admin_category'])->model_ini_file();
        }
        if(empty($data)||empty($file_array)){
            $this->msg('读取配置信息失败！可能该模型受保护无法导出！',0);
        }
        $data_array=array();
        foreach ($data as $value) {
            $data_array[]=$this->config['DB_PREFIX'].$value;
        }
        //创建文件夹
        $dir=__ROOTDIR__.'/data/module/'.$info['model'];
        @mkdir($dir,0777,true);
        if(!file_exists($dir)){
            $this->msg('文件夹创建失败，请保证"/data/module/"有写入权限',0);
        }
        @mkdir($dir.'/dbbak/',0777,true);
        if(!file_exists($dir.'/dbbak/')){
            $this->msg('文件夹创建失败，请保证"/data/module/dbbak/"有写入权限',0);
        }
        //导出数据库
        $db = new Dbbak($this->config['DB_HOST'],$this->config['DB_USER'],$this->config['DB_PWD'],$this->config['DB_NAME'],'utf8',$dir.'/dbbak/');
        $sql="INSERT INTO ".$this->config['DB_PREFIX']."model VALUES(null, '".mysql_escape_string($info['model'])."', '".mysql_escape_string($info['name'])."', '".mysql_escape_string($info['admin_category'])."', '".mysql_escape_string($info['admin_content'])."', '".mysql_escape_string($info['module_category'])."', '".mysql_escape_string($info['module_content'])."', '".mysql_escape_string($info['url_category'])."', '".mysql_escape_string($info['url_category_page'])."', '".mysql_escape_string($info['url_content'])."', '".mysql_escape_string($info['url_content_page'])."', '".mysql_escape_string($info['table'])."', '".mysql_escape_string($info['file'])."', '".mysql_escape_string($info['config'])."', '".mysql_escape_string($info['befrom'])."')\n";

        if(!$db->exportSql($data_array,0,$sql)){
            $this->msg('数据库导出失败！',0);
        }

        foreach ($file_array as $value) {
            $file=__ROOTDIR__.'/'.$value;
            $copyfile=$dir.'/file/';
            if(file_exists($file)){
                if(is_dir($file)){
                    @mkdir($copyfile.$value,0777,true);
                    if(!copy_dir($file,$copyfile.$value)){
                        $this->msg('文件导出失败，可能由于导出目录没有写入权限！',0);
                    }
                }else{
                    @mkdir(dirname($copyfile.$value),0777,true);
                    if(!@copy($file, $copyfile.$value)){
                        $this->msg('文件导出失败，可能由于导出目录没有写入权限！',0);
                    }
                }
            }
        }

        //写入模型信息
        $html='<?xml version="1.0" encoding="utf-8"?>' . PHP_EOL;
        $html.='<config>' . PHP_EOL;
        $html.='<name>'.$info['name'].'</name>' . PHP_EOL;
        $html.='<model>'.$info['model'].'</model>' . PHP_EOL;
        $html.='<prefix>'.$this->config['DB_PREFIX'].'</prefix>' . PHP_EOL;
        $html.='</config>' . PHP_EOL;
        @file_put_contents($dir.'/model.xml',$html);
        if(!file_exists($dir.'/model.xml')){
            $this->msg('模型信息导出失败，请检查目录权限！',0);
        }

        if(method_exists($info['model'],'model_ini_out')){
            model($info['model'])->model_ini_out();
        }
        $this->msg('模型导出完毕，请自行到"data/module"中下载文件',1);
        
    }

    //模型删除
    public function del()
    {
        $mid=intval($_POST['mid']);
        $info=model('model_manage')->info($mid);
        if(!empty($info['admin_category'])){
            $data=@model($info['admin_category'])->model_ini_data();
            $file_array=@model($info['admin_category'])->model_ini_file();
        }
        if(empty($data)||empty($file_array)){
            $this->msg('读取配置信息失败！该模型受保护无法删除！',0);
        }
        //删除表
        foreach ($data as $value) {
            $model('model_manage')->del_table($value);
        }
        //删除模型记录
        $model('model_manage')->del($mid);

        //删除文件
        foreach ($file_array as $value) {
            $file=__ROOTDIR__.'/'.$value;
            if(file_exists($file)){
                if(is_dir($file)){
                    del_dir($file);
                }else{
                    @unlink($file);
                }
            }
        }
        if(method_exists($info['model'],'model_ini_del')){
            model($info['model'])->model_ini_del();
        }
        $this->msg('模型删除成功！',1);


    }


}

?>