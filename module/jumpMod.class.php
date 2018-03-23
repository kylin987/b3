<?php
//单页
class jumpMod extends commonMod
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
        $info=model('category')->info($cid);
        if (empty($info)) {
            $this->error404();
        }

        //模块自动纠正
        model('category')->model_jump($info['mid'],'jump');

        /*hook*/
        $this->plus_hook('jump','index',$info);
        /*hook end*/

        //读取附加表
        $jump = model('jump')->info($cid);

        $link=$this->return_tpl(html_out($jump['url']));
        header("HTTP/1.1 301 Moved Permanently");
        header("Location: ".$link."");
        exit;
    }




}

?>