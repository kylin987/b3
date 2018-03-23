<?php
//分类页
class categoryModel extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //栏目信息
    public function info($cid)
    {
        return $this->model->table('category')->where('cid=' . $cid)->find(); 
    }

    //模型信息
    public function model_info($mid)
    {
        return $this->model->table('model')->where('mid='.$mid)->find();
    }

    //扩展模型信息
    public function expand_model_info($mid)
    {
        return $this->model->table('expand_model')->where('mid='.$mid)->find();
    }

    //模块修正
    public function model_jump($mid,$module){
        $model_info = $this->model_info($mid);
        if (!empty($model_info['module_category'])&&$model_info['module_category']<>$module) {
            module($model_info['module_category'])->index();
            if ( $this->config['HTML_CACHE_ON'] ) {
                cpHtmlCache::write();
            }
            exit;
        }
    }

    //内容列表
    public function content_list($cid,$where,$limit,$list_sort)
    {
        $category=model('category')->info($cid);
        $expand_id=$category['expand'];
        if(!empty($expand_id)){
            $model_info=model('category')->expand_model_info($expand_id);
            $expand="LEFT JOIN {$this->model->pre}expand_content_{$model_info['table']} C ON C.aid = A.aid";
            $expand_field="C.*,";
        }
        $loop="
            SELECT {$expand_field}A.*,B.name as cname,B.subname as csubname,B.mid
             FROM {$this->model->pre}content A 
             LEFT JOIN {$this->model->pre}category B ON A.cid = B.cid
             {$expand}
             WHERE {$where} ORDER BY {$list_sort} LIMIT {$limit}
            ";
            return $this->model->query($loop);
    }

    //内容统计
    public function content_count($cid,$where)
    {
        $count=$this->model
                ->table('content','A')
                ->add_table('category','B','A.cid = B.cid')
                ->where($where)
                ->count();
        return $count;
    }


    //栏目导航
    public function nav($id)
    {
        $data = $this->model->field('cid,pid,name,urlname')->table('category')->select();
        $cat = new Category(array(
            'cid',
            'pid',
            'name',
            'urlname',
            'cname'));
        if(empty($data)){
             return;
        }
        $cat = $cat->getPath($data, $id);
        return $cat; 
    }

    //栏目树
    public function getcat($cid)
    {
        $id = $cid;
        $data = $this->model->field('cid,pid,name')->table('category')->select();
        $cat = new Category(array(
            'cid',
            'pid',
            'name',
            'cname')); //初始化无限分类

        $cat_for = $cat->getTree($data, $id); //获取分类数据树结构
        if(empty($cat_for)){
            return $id;
        }
        foreach ($cat_for as $v) {
            $cat_id .= $v['cid'] . ",";
        }

        if (!empty($cat_id)) {
            return $cat_id . $id;
        } else {
            return $id;
        }
    }

    //URL路径
    public function url_format($dir,$cid,$cname){
        $patterns =array(  
        "{EXT}",
        "{CDIR}",
        "{P}", 
        );
        $replacements=array(  
        '.html',
        $cname,
        '{page}',
        );
        $url_catrgory_page=str_replace($patterns,$replacements,$dir);
        return __INDEX__ .'/'.$url_catrgory_page;
    }


}

?>