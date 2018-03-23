<?php
class expand_modelMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }


    //模型列表
    public function index()
    {
        $this->list=model('expand_model')->model_list();
        $this->show();
    }

    public function data_check($data)
    {
        if(model('expand_model')->table_info($data['table'],$data['mid'])){
            $this->msg('表名不能重复！',0);
        }
    }

    //模型添加
    public function add()
    {
        $this->action_name='添加';
        $this->action='add';
        $this->list=model('expand_model')->model_list();
        $this->display('expand_model/info');
    }

    public function add_save()
    {
        $this->data_check($_POST);    
        model('expand_model')->add($_POST);    
        $this->msg('模型添加成功！',1);
    }

    //模型修改
    public function edit()
    {
        $mid=intval($_GET['mid']);
        $this->alert_str($mid,'int');
        $this->action_name='编辑';
        $this->action='edit';
        $this->info=model('expand_model')->info($mid);
        $this->display('expand_model/info');
    }

    public function edit_save()
    {
        //录入模型处理
        $mid=intval($_POST['mid']);
        $this->alert_str($mid,'int',true);
        $this->data_check($_POST);
        model('expand_model')->edit($_POST);
        $this->msg('模型修改成功！',1);
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
        $dir=__ROOTDIR__.'/data/ext_module/'.$table;
        $config = @Xml::decode(file_get_contents($dir.'/ext_model.xml'));
        $config = $config['config'];
        if(empty($config)){
            $this->msg('无法获取模型配置！',0);
        }
        if(!file_exists($dir)||!file_exists($dir.'/dbbak/')){
            $this->msg($table.'目录不存在！或者目录结构错误！',0);
        }
        if(model('expand_model')->table_info($config['table'])){
            $this->msg($table.'模型已经存在，无法重复导入！',0);
        }
        //导入数据库
        $db = new Dbbak($this->config['DB_HOST'],$this->config['DB_USER'],$this->config['DB_PWD'],$this->config['DB_NAME'],'utf8',$dir.'/dbbak/');
        if(!$db->importSql('',$config['prefix'],$this->config['DB_PREFIX'])){
            $this->msg('数据库导入失败！',0);
        }
        //修改关联信息
        $info=model('expand_model')->associate_edit();
        $this->msg('模型导入完毕！',1);

    }

    //模型导出
    public function out()
    {
        $mid=intval($_POST['mid']);
        $info=model('expand_model')->info($mid);

        //创建文件夹
        $dir=__ROOTDIR__.'/data/ext_module/'.$info['table'];
        @mkdir($dir,0777,true);
        if(!file_exists($dir)){
            $this->msg('文件夹创建失败，请保证"/data/ext_module/"有写入权限',0);
        }
        @mkdir($dir.'/dbbak/',0777,true);
        if(!file_exists($dir.'/dbbak/')){
            $this->msg('文件夹创建失败，请保证"/data/ext_module/dbbak/"有写入权限',0);
        }
        $data_array=model('expand_model')->field_list_data($mid);
        if(empty($data_array)){
            $this->msg('无法获取扩展模型字段',0);
        }
        //导出数据库
        $db = new Dbbak($this->config['DB_HOST'],$this->config['DB_USER'],$this->config['DB_PWD'],$this->config['DB_NAME'],'utf8',$dir.'/dbbak/');

        $sql="INSERT INTO ".$this->config['DB_PREFIX']."expand_model VALUES(null, '".mysql_escape_string($info['table'])."', '".mysql_escape_string($info['name'])."')\n";
        foreach ($data_array as $vo) {
            $sql.="INSERT INTO ".$this->config['DB_PREFIX']."expand_model_field VALUES(null, 101010, '".mysql_escape_string($vo['name'])."', '".mysql_escape_string($vo['field'])."', '".mysql_escape_string($vo['type'])."', '".mysql_escape_string($vo['property'])."', '".mysql_escape_string($vo['len'])."', '".mysql_escape_string($vo['decimal'])."', '".mysql_escape_string($vo['default'])."', '".mysql_escape_string($vo['sequence'])."', '".mysql_escape_string($vo['tip'])."', '".mysql_escape_string($vo['must'])."', '".mysql_escape_string($vo['config'])."')\n";
        }
        if(!$db->exportSql($this->config['DB_PREFIX'].'expand_content_'.$info['table'],0,$sql)){
            $this->msg('数据库导出失败！',0);
        }

        //写入模型信息
        $html='<?xml version="1.0" encoding="utf-8"?>' . PHP_EOL;
        $html.='<config>' . PHP_EOL;
        $html.='<name>'.$info['name'].'</name>' . PHP_EOL;
        $html.='<table>'.$info['table'].'</table>' . PHP_EOL;
        $html.='<prefix>'.$this->config['DB_PREFIX'].'</prefix>' . PHP_EOL;
        $html.='</config>' . PHP_EOL;
        @file_put_contents($dir.'/ext_model.xml',$html);
        if(!file_exists($dir.'/ext_model.xml')){
            $this->msg('扩展模型信息导出失败，请检查目录权限！',0);
        }

        $this->msg('扩展模型导出完毕，请自行到"data/ext_module"中下载文件',1);
        
    }

    //删除
    public function del()
    {
        $mid=intval($_POST['mid']);
        $this->alert_str($mid,'int',true);
        //删除模型
        model('expand_model')->del($_POST);
        $this->msg('模型删除成功！',1);

    }

    //字段列表
    public function field_list()
    {
        $mid=intval($_GET['mid']);
        $this->alert_str($mid,'int');
        $this->info=model('expand_model')->info($mid);
        $this->list=model('expand_model')->field_list($mid);
        $this->show();
    }

    public function field_data_check($data)
    {
        if(model('expand_model')->field_info($data['field'],$data['mid'],$data['fid'])){
            $this->msg('字段不能重复！',0);
        }
    }

    public function data_info()
    {
        $data['field_type']=model('expand_model')->field_type();
        $data['field_property']=model('expand_model')->field_property();
        return $data;
    }

    //字段添加
    public function field_add()
    {
        $mid=intval($_GET['mid']);
        $this->alert_str($mid,'int');
        $this->view()->assign($this->data_info());
        $this->model_info=model('expand_model')->info($mid); 
        $this->action_name='添加';
        $this->action='add';
        $this->display('expand_model/field_info');
    }

    public function field_add_save()
    {
        //录入模型处理
        $mid=intval($_POST['mid']);
        $this->alert_str($mid,'int',true);
        $this->field_data_check($_POST);
        model('expand_model')->field_add($_POST);
        $this->msg('字段添加成功！',1);
    }

    //字段修改
    public function field_edit()
    {
        $fid=intval($_GET['fid']);
        $this->alert_str($fid,'int');
        $this->view()->assign($this->data_info());
        $this->info=model('expand_model')->field_info_id($fid);
        $this->model_info=model('expand_model')->info($this->info['mid']);
        $this->action_name='编辑';
        $this->action='edit';
        $this->display('expand_model/field_info');
    }

    public function field_edit_save()
    {
        $fid=intval($_POST['fid']);
        $this->alert_str($fid,'int',true);
        $this->field_data_check($_POST);
        //录入模型处理
        $id=model('expand_model')->field_edit($_POST);
        $this->msg('字段修改成功！',1);
    }

    //字段删除
    public function field_del()
    {
        $mid=intval($_POST['mid']);
        $this->alert_str($mid,'int',true);
        $fid=intval($_POST['fid']);
        $this->alert_str($fid,'int',true);
        //录入模型处理
        model('expand_model')->field_del($_POST);
        $this->msg('字段删除成功！',1);

    }

    //获取内容字段
    public function get_field()
    {
        $cid=intval($_POST['cid']);
        $aid=intval($_POST['aid']);
        if(empty($cid)){
            return;
        }
        $category_info=model('category')->info($cid);
        if(empty($category_info['expand'])){
            return;
        }
        //获取字段列表
        $list=model('expand_model')->field_list($category_info['expand']);
        if(empty($list)){
            return;
        }
        $html='';
        $info=model('expand_model')->get_file_content($aid,$category_info['expand']);
        foreach ($list as $value) {
            $field_info=model('expand_model')->field_info_id($value['fid']);
            $html.=model('expand_model')->get_field_html($field_info,$info[$value['field']]);  

        }
        echo $html;
    }







}

?>