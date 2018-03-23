<?php
class pages_categoryMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取栏目模型
    public function get_model()
    {
        return model('model_manage')->search('pages');
    }


    //栏目添加
    public function add()
    {
        $this->view()->assign(module('category')->common_info());
        $this->show('pages_category/info');
    }

    //栏目保存
    public function add_save()
    {
        $model=$this->get_model();
        $_POST['mid']=$model['mid'];
        $_POST['type']=0;
        module('category')->common_add_check($_POST);
        /*hook*/
        $_POST=$this->plus_hook_replace('category','add_replace',$_POST);
        /*hook end*/
        $cid=model('category')->add_save($_POST);
        $_POST['cid']=$cid;
        model('pages_category')->page_save($_POST);
        /*hook*/
        $this->plus_hook('category','add',$cid);
        /*hook end*/
        $this->msg('页面添加成功！',1);
    }

    //栏目编辑
    public function edit()
    {
        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        $this->view()->assign(module('category')->common_info($id));
        $this->page_info=model('pages_category')->page_info($id);
        $this->show('pages_category/info');
    }

    //栏目保存
    public function edit_save()
    {
        $this->alert_str($_POST['cid'],'int',true);
        //检查
        module('category')->common_edit_check($_POST);
        $model=$this->get_model();
        $_POST['mid']=$model['mid'];
        /*hook*/
        $_POST=$this->plus_hook_replace('category','edit_replace',$_POST);
        /*hook end*/
        model('category')->edit_save($_POST);
        model('pages_category')->edit_save($_POST);
        /*hook*/
        $this->plus_hook('category','edit');
        /*hook end*/
        $this->msg('页面编辑成功！',1);
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
        model('pages_category')->del($_POST['cid']);
        $this->msg('页面删除成功！',1);
    }

}

?>