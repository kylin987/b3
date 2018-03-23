<?php
//单页
class pagesMod extends commonMod
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
        $info = model('category')->info($cid);
        if (!is_array($info)){
            $this->error404();
        }

        //模块自动纠正
        model('category')->model_jump($info['mid'],'pages');

        /*hook*/
        $this->plus_hook('category','index',$info);
        $this->info=$this->plus_hook_replace('category','index_replace',$this->info);
        /*hook end*/

        //位置导航
        $this->nav=array_reverse(model('category')->nav($info['cid'])); 

        //查询单页内容
        $content=model('pages')->content($info['cid']);
		if(empty($content['content'])){
			$content['content']='暂无内容';
		}
        $info['content']=html_out($content['content']);

        //读取内容替换
        $content=model('content')->format_content($info['content']);

        //URL路径
        $model_info = model('category')->model_info($info['mid']);
        $url=model('category')->url_format($model_info['url_category_page'],$cid,$info['urlname']);

        $page = new Page();
        $content = $page->contentPage(html_out($content),"<hr class=\"ke-pagebreak\" />",
        $url, 10, 4); //文章分页

        $info['content']=$content['content'];
        $this->page=$content['page'];

        $this->info=$info;

        //查询上级栏目信息
        $this->parent_category = model('category')->info($this->info['pid']);
        if (empty($this->parent_category)) {
            $this->parent_category = array(
                "cid" => "0",
                "pid" => "0",
                "mid" => "0",
                "name" => "无上级栏目");
        }

        //MEDIA信息
        $this->common=model('pageinfo')->media($this->info['name'],$this->info['keywords'],$this->info['description']);

        //获取顶级栏目信息
        $this->top_category = model('category')->info($this->nav[0]['cid']);
        $this->display($info['class_tpl']);
    }




}

?>