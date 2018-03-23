<?php
class jump_categoryMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取栏目模型
    public function get_model()
    {
        return model('model_manage')->search('jump');
    }

    //栏目添加
    public function add()
    {
        $this->view()->assign(module('category')->common_info());
        $this->show('jump_category/info');
    }

    //栏目保存
    public function add_save()
    {
        $model=$this->get_model();
        $_POST['mid']=$model['mid'];
        $_POST['type']=0;
        /*hook*/
        $_POST=$this->plus_hook_replace('category','add_replace',$_POST);
        /*hook end*/
        $cid=model('category')->add_save($_POST);
        $_POST['cid']=$cid;
        model('jump_category')->jump_save($_POST);
        /*hook*/
        $this->plus_hook('category','add',$cid);
        /*hook end*/
        $this->msg('栏目添加成功！',1);
    }

    //栏目编辑
    public function edit()
    {
        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        $this->view()->assign(module('category')->common_info($id));
        $this->jump_info=model('jump_category')->jump_info($id);
        $this->show('jump_category/info');
    }

    //栏目保存
    public function edit_save()
    {
        $this->alert_str($_POST['cid'],'int',true);
        $model=$this->get_model();
        $_POST['mid']=$model['mid'];
        /*hook*/
        $_POST=$this->plus_hook_replace('category','edit_replace',$_POST);
        /*hook end*/
        model('category')->edit_save($_POST);
        model('jump_category')->edit_save($_POST);
        /*hook*/
        $this->plus_hook('category','edit');
        /*hook end*/
        $this->msg('栏目编辑成功！',1);
    }

    //栏目删除
    public function del()
    {
        $this->alert_str($_POST['cid'],'int',true);
        module('category')->common_del_check($_POST);
        /*hook*/
        $this->plus_hook('category','del');
        /*hook end*/
        $class_status=model('category')->del($_POST['cid']);
        model('jump_category')->del($_POST['cid']);
        $this->msg('栏目删除成功！',1);
    }


    

}

?>