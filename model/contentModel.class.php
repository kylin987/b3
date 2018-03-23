<?php
class contentModel extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //模块修正
    public function model_jump($mid,$module){
        $model_info = model('category')->model_info($mid);
        if (!empty($model_info['module_content'])&&$model_info['module_content']<>$module) {
            module($model_info['module_content'])->index();
            if ( $this->config['HTML_CACHE_ON'] ) {
                cpHtmlCache::write();
            }
            exit;
        }
    }

    //获取内容
    public function info($aid)
    {
        return $this->model->table('content')->where('aid='.$aid)->find();
    }

    public function info_content($aid)
    {
        return $this->model->table('content_data')->where('aid='.$aid)->find();
    }

    //完整内容
    public function model_content($aid,$ext_id)
    {
        if(!empty($ext_id)){
            $model_info=model('category')->expand_model_info($ext_id);
            $expand="LEFT JOIN {$this->model->pre}expand_content_{$model_info['table']} C ON C.aid = A.aid";
            $expand_field="C.*,";
        }
        $info="
            SELECT {$expand_field}A.*
             FROM {$this->model->pre}content A 
             {$expand}
             WHERE A.aid={$aid} LIMIT 1
            ";
            $info=$this->model->query($info);
            return $info[0]; 

    }

    //上一篇
    public function prev_content($aid,$cid,$ext_id){
        if(!empty($ext_id)){
            $model_info=model('category')->expand_model_info($ext_id);
            $expand="LEFT JOIN {$this->model->pre}expand_content_{$model_info['table']} C ON C.aid = A.aid";
            $expand_field="C.*,";
        }
        $info="
            SELECT {$expand_field}A.*
             FROM {$this->model->pre}content A 
             LEFT JOIN {$this->model->pre}category B ON B.cid = A.cid
             {$expand}
             WHERE A.aid<{$aid} AND A.status=1 AND B.cid={$cid} ORDER BY A.aid desc LIMIT 1
            ";
            $info=$this->model->query($info);
        return $info[0]; 
    }

    //下一篇
    public function next_content($aid,$cid,$ext_id){
        if(!empty($ext_id)){
            $model_info=model('category')->expand_model_info($ext_id);
            $expand="LEFT JOIN {$this->model->pre}expand_content_{$model_info['table']} C ON C.aid = A.aid";
            $expand_field="C.*,";
        }
        $info="
            SELECT {$expand_field}A.*
             FROM {$this->model->pre}content A 
             LEFT JOIN {$this->model->pre}category B ON B.cid = A.cid
             {$expand}
             WHERE A.aid>{$aid} AND A.status=1 AND B.cid={$cid} ORDER BY A.aid asc LIMIT 1
            ";
            $info=$this->model->query($info);
        return $info[0];
    }

    //替换后内容
    public function format_content($content){

        $replace = $this->model->table('replace')->select();
        $content=html_out($content);
        if (!empty($replace)) {
            foreach ($replace as $export) {
                if(empty($export['key'])){
                    if(empty($export['num'])){
                        $export['num']=1;
                    }
                    $content = preg_replace("/(?!<[^>]+)".preg_quote($export['key'],'/')."(?![^<]*>)/",$export['content'], $content,$export['num']);
                }
            }
        }
        return $content;
    }

    //增加TAG链接
    public function tag_link($content,$aid){
        $taglist = $this->model
            ->field('A.*')
            ->table('tags','A')
            ->add_table('tags_relation','B','B.tid=A.id')
            ->where('B.aid='.$aid)
            ->select();
        $content=html_out($content);
        if (!empty($taglist)) {
            foreach ($taglist as $export) {
                if(!empty($export['name'])){
                    $content = preg_replace("/(?!<[^>]+)".preg_quote($export['name'],'/')."(?![^<]*>)/", '<a href="'.__INDEX__.'/tags-'.$export['name'].'/"  target="_blank">'.$export['name'].'</a>',$content,1);
                }
            }
        }
        return $content;
    }

    //访问计数
    public function views_content($aid,$views){
        $data['views'] = $views + 1;
        $condition['aid'] = $aid;
        $this->model->table('content')->data($data)->where($condition)->update();
    }

    //URL路径
    public function url_format($dir,$cid,$cname,$info){
            $patterns =array(  
            "{EXT}",
            "{CDIR}",
            "{YY}",
            "{YYYY}",
            "{M}",
            "{D}",
            "{AID}",
            "{URLTITLE}",
            "{P}", 
            );
            $replacements=array(  
            '.html',
            $cname,
            date('y',$info['inputtime']),
            date('Y',$info['inputtime']),
            date('m',$info['inputtime']),
            date('d',$info['inputtime']),
            $info['aid'],
            $info['urltitle'],
            '{page}',
            );
            $url_content=str_replace($patterns,$replacements,$dir);
            return  __INDEX__ .$lang.'/'. $url_content;

    }


}

?>