<?php
class categoryMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $cid = intval($_GET['cid']);
        if (empty($cid)) {
            $this->error404();
        }

        //读取栏目信息
        $this->info=model('category')->info($cid);
        if (!is_array($this->info)){
            $this->error404();
        }
        //模块自动纠正
        model('category')->model_jump($this->info['mid'],'category');

        /*hook*/
        $this->plus_hook('category','index',$this->info);
        $this->info=$this->plus_hook_replace('category','index_replace',$this->info);
        /*hook end*/

        //位置导航
        $this->nav=array_reverse(model('category')->nav($this->info['cid']));

        //设置分页
        $size = intval($this->info['page']); 
        if (empty($size)) {
            $listrows = 10;
        } else {
            $listrows = $size;
        }
        $model_info = model('category')->model_info($this->info['mid']);
        $url=model('category')->url_format($model_info['url_category_page'],$cid,$this->info['urlname']);
        $limit=$this->pagelimit($url,$listrows);

        //设置栏目属性
        if ($this->info['type'] == 0) {
            $son_id = model('category')->getcat($this->info['cid']);
            $where = 'A.status=1 AND B.cid in (' . $son_id . ')';
        } else {
            $where = 'A.status=1 AND B.cid=' . $this->info['cid'];
        }

        //执行查询
        $this->loop=model('category')->content_list($cid,$where,$limit,$this->info['content_order']);
        $count = model('category')->content_count($cid,$where);

        //查询上级栏目信息
        $this->parent_category = model('category')->info($this->info['pid']);
        if (!$this->parent_category) {
            $this->parent_category = array(
                "cid" => "0",
                "pid" => "0",
                "mid" => "0",
                "name" => "无上级栏目");
        }
        //获取分页
        $this->page=$this->page($url, $count, $listrows);
        //获取上一页代码
        $this->prepage=$this->page($url, $count, $listrows,'',1);
        //获取下一页代码
        $this->nextpage=$this->page($url, $count, $listrows,'',2);
        
        $this->count=$count;

        //MEDIA信息
        $this->common=model('pageinfo')->media($this->info['name'],$this->info['keywords'],$this->info['description']);
        
        //获取顶级栏目信息
        $this->top_category = model('category')->info($this->nav[0]['cid']);
        $this->display($this->info['class_tpl']);
    }




}

?>