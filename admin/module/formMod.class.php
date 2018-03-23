<?php
class formMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }
    //表单首页
    public function index()
    {
        $this->list=model('form')->form_list();
        $this->show();
    }

    //表单添加
    public function add() {
        $this->action_name='添加';
        $this->action='add';
        $this->show('form/info'); 
    }

    public function data_check($data) {
        if(model('form')->table_info($data['table'],$data['id'])){
            $this->msg('表名不能重复！',0);
        }
    }

    //表单添加数据处理
    public function add_save() {
        $this->data_check($_POST);
        model('form')->add($_POST);
        $this->msg('表单添加成功！',1);
    }

    //表单修改
    public function edit() {
        $id=$_GET['id'];
        $this->alert_str($id,'int');
        $this->info=model('form')->info($id);
        $this->action_name='编辑';
        $this->action='edit';
        $this->show('form/info'); 
    }

    //表单修改
    public function edit_save() {
        $this->data_check($_POST);
        //录入模型处理
        model('form')->edit($_POST);
        $this->msg('表单修改成功! ',1);
    }

    //导入
    public function in()
    {
        $this->display();
    }

    public function in_data(){
        $table=$_POST['table'];
        if(empty($table)){
            $this->msg('文件夹名尚未填写！',0);
        }
        $dir=__ROOTDIR__.'/data/form/'.$table;
        $config = @Xml::decode(file_get_contents($dir.'/form.xml'));
        $config = $config['config'];
        if(empty($config)){
            $this->msg('无法获取模型配置！',0);
        }
        if(!file_exists($dir)||!file_exists($dir.'/dbbak/')){
            $this->msg($table.'目录不存在！或者目录结构错误！',0);
        }
        if(model('form')->table_info($config['table'])){
            $this->msg($table.'表单已经存在，无法重复导入！',0);
        }
        //导入数据库
        $db = new Dbbak($this->config['DB_HOST'],$this->config['DB_USER'],$this->config['DB_PWD'],$this->config['DB_NAME'],'utf8',$dir.'/dbbak/');
        if(!$db->importSql('',$config['prefix'],$this->config['DB_PREFIX'])){
            $this->msg('数据库导入失败！',0);
        }
        //修改关联信息
        $info=model('form')->associate_edit();
        $this->msg('模型导入完毕！',1);

    }

    //模型导出
    public function out()
    {
        $id=intval($_POST['id']);
        $info=model('form')->info($id);
        //创建文件夹
        $dir=__ROOTDIR__.'/data/form/'.$info['table'];
        @mkdir($dir,0777,true);
        if(!file_exists($dir)){
            $this->msg('文件夹创建失败，请保证"/data/form/"有写入权限',0);
        }
        @mkdir($dir.'/dbbak/',0777,true);
        if(!file_exists($dir.'/dbbak/')){
            $this->msg('文件夹创建失败，请保证"/data/form/dbbak/"有写入权限',0);
        }
        $data_array=model('form')->field_list_data($id);
        if(empty($data_array)){
            $this->msg('无法获取多用表单字段',0);
        }
        //导出数据库
        $db = new Dbbak($this->config['DB_HOST'],$this->config['DB_USER'],$this->config['DB_PWD'],$this->config['DB_NAME'],'utf8',$dir.'/dbbak/');

        $sql="INSERT INTO ".$this->config['DB_PREFIX']."form VALUES(null, '".mysql_escape_string($info['name'])."', '".mysql_escape_string($info['table'])."','".mysql_escape_string($info['display'])."','".mysql_escape_string($info['page'])."','".mysql_escape_string($info['tpl'])."','".mysql_escape_string($info['alone_tpl'])."','".mysql_escape_string($info['order'])."','".mysql_escape_string($info['where']).",'".mysql_escape_string($info['return_type']).",'".mysql_escape_string($info['return_msg'])."')\n";
        foreach ($data_array as $vo) {
            $sql.="INSERT INTO ".$this->config['DB_PREFIX']."form_field VALUES(null, 101010, '".mysql_escape_string($vo['name'])."', '".mysql_escape_string($vo['field'])."', '".mysql_escape_string($vo['type'])."', '".mysql_escape_string($vo['property'])."', '".mysql_escape_string($vo['len'])."', '".mysql_escape_string($vo['decimal'])."', '".mysql_escape_string($vo['default'])."', '".mysql_escape_string($vo['sequence'])."', '".mysql_escape_string($vo['tip'])."', '".mysql_escape_string($vo['config'])."', '".mysql_escape_string($vo['must'])."', '".mysql_escape_string($vo['admin_display'])."', '".mysql_escape_string($vo['admin_html'])."')\n";
        }
        if(!$db->exportSql($this->config['DB_PREFIX'].'form_data_'.$info['table'],0,$sql)){
            $this->msg('数据库导出失败！',0);
        }

        //写入表单信息
        $html='<?xml version="1.0" encoding="utf-8"?>' . PHP_EOL;
        $html.='<config>' . PHP_EOL;
        $html.='<name>'.$info['name'].'</name>' . PHP_EOL;
        $html.='<table>'.$info['table'].'</table>' . PHP_EOL;
        $html.='<prefix>'.$this->config['DB_PREFIX'].'</prefix>' . PHP_EOL;
        $html.='</config>' . PHP_EOL;
        @file_put_contents($dir.'/form.xml',$html);
        if(!file_exists($dir.'/form.xml')){
            $this->msg('表单信息导出失败，请检查目录权限！',0);
        }

        $this->msg('扩展模型导出完毕，请自行到"data/form"中下载文件',1);
        
    }

    //表单删除
    public function del() {
        $id=intval($_POST['id']);
        $this->alert_str($id,'int',true); 
        //录入模型处理
        model('form')->del($id);
        $this->msg('表单删除成功！',1);
    }

    //表单字段
    public function field_list() {
        $id=$_GET['id'];
        $this->alert_str($id,'int');
        $this->info=model('form')->info($id);
        $this->list=model('form')->field_list($id);
        $this->show();
    }

    public function field_data_check($data) {
        if(model('form')->field_check($data['fid'],$data['field'],$_POST['id'])){
            $this->msg('字段名不能重复',0);
        }
    }

    //添加字段
    public function field_add(){
        $fid=$_GET['fid'];
        $this->alert_str($fid,'int');
        $this->table_info=model('form')->info($fid);
        $this->view()->assign(module('expand_model')->data_info());
        $this->action_name='添加';
        $this->action='add';
        $this->show('form/field_info'); 
    }

    //字段添加
    public function field_add_save() {
        $fid=$_POST['fid'];
        $this->alert_str($fid,'int',true);
        $this->field_data_check($_POST);
        //录入模型处理
        model('form')->field_add($_POST);
        $this->msg('字段添加成功！',1);
    }

    //修改字段
    public function field_edit()
    {
        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        $this->info=model('form')->field_info($id);
        $this->table_info=model('form')->info($this->info['fid']);
        $this->view()->assign(module('expand_model')->data_info());
        $this->action_name='编辑';
        $this->action='edit';
        $this->show('form/field_info'); 
    }

    //字段数据修改
    public function field_edit_save()
    {
        $this->alert_str($_POST['fid'],'int',true);
        $this->alert_str($_POST['id'],'int',true);
        $this->field_data_check($_POST);
        //录入模型处理
        model('form')->field_edit($_POST);
        $this->msg('字段修改成功！',1);
    }

    //字段删除
    public function field_del()
    {
        $this->alert_str($_POST['id'],'int',true);
        //录入模型处理
        model('form')->field_del($_POST);
        $this->msg('字段删除成功！',1);
    }

}

?>