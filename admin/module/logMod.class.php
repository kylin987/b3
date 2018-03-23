<?php
//登录记录
class logMod extends commonMod {

	public function __construct()
    {
        parent::__construct();
    }

	public function index() {

        //分页处理
        $url = __URL__ . '/index/page-{page}.html'; //分页基准网址
        $listRows = 50;
        $limit=$this->pagelimit($url,$listRows);
        //内容列表
        $this->list=model('log')->log_list($limit);
        //统计总内容数量
        $count=model('log')->count();
        //分页处理
		$this->assign('page', $this->page($url, $count, $listRows));
		$this->show();  
	}


}