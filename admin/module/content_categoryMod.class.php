<?php
class content_categoryMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取栏目模型
    public function get_model()
    {
        return model('model_manage')->search('content');
    }


    //栏目添加
    public function add()
    {
        $this->view()->assign(module('category')->common_info());
        $this->show('content_category/info');
    }

    //栏目保存
    public function add_save()
    {
        $model=$this->get_model();
        $_POST['mid']=$model['mid'];
        $list = explode("\n", $_POST['namelist']);
        if(empty($list)){
            $this->msg('栏目名称未填写',0);
        }
        module('category')->common_add_check($_POST);
        foreach ($list as $name) {
            if(empty($name)){
                continue;
            }
            $name_array=explode('|',$name);
            if(empty($name_array)){
                continue;
            }
            $_POST['name']=$name_array[0];
            $_POST['urlname']=$name_array[1];
            /*hook*/
            $_POST=$this->plus_hook_replace('category','add_replace',$_POST);
            /*hook end*/
            $cid=model('category')->add_save($_POST);
            /*hook*/
            $this->plus_hook('category','add',$cid);
            /*hook end*/
        }
        $this->msg('栏目添加成功！');
    }

    //栏目编辑
    public function edit()
    {
        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        $this->view()->assign(module('category')->common_info($id));
        $this->show('content_category/info');
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
        model('category')->del($_POST['cid']);
        $list=model('content')->get_list_id($_POST['cid']);
        if($list){
            foreach ($list as $value) {
                model('content')->del($value['aid']);
                model('content')->del_content($value['aid']);
            }
        }
        $this->msg('栏目删除成功！',1);
    }


    

}

?>