<?php
class content_indexMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    // 内容列表
    public function index()
    {
        //获取公共条件
        $where=module('content')->common_list_where();
        $this->view()->assign(module('content')->common_list());
        //分页信息
        $url = __URL__ . '/index/page-{page}'.$where['url'].'.html';
        $listRows=20;
        $limit=$this->pagelimit($url,$listRows);
        if(empty($where['where'])){
            $where['where']=" AND A.status=0";
        }
        //内容列表
        $this->list=model('content')->content_list('',$limit,'A.aid<>"" '.$where['where'],$where['order'],true);
        $count=model('content')->count('','A.aid<>"" '.$where['where'],true);
        $this->page=$this->page($url, $count, $listRows);
        //对内容进行统计
        $this->category_count=model('category')->category_count();
        $this->content_count=model('content')->count('','',true);
        $this->audit_count=model('content')->count('','A.status=0',true);
        $this->show();
    }

    //快速修改
    public function edit()
    {
        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        $this->view()->assign(module('content')->common_info($id,true));
        $this->show();
    }

    //内容保存
    public function edit_save()
    {
        /*hook*/
        $_POST=$this->plus_hook_replace('content','edit_replace',$_POST);
        /*hook end*/
        //保存内容信息
        $status=model('content')->edit_save($_POST,false);
        /*hook*/
        $this->plus_hook('content','edit');
        /*hook end*/
        $this->msg('内容编辑成功！',1);

    }

}

?>