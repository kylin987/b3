<?php
class contentMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //公共列表信息
    public function common_list_where()
    {
        //排序
        $sequence=intval($_GET['sequence']);
        switch ($sequence) {
            case '1':
                $order='A.updatetime DESC';
                $where_url='1';
                break;
            case '2':
                $order='A.updatetime ASC';
                $where_url='2';
                break;
            case '3':
                $order='A.aid DESC';
                $where_url='3';
                break;
            case '4':
                $order='A.aid ASC';
                $where_url='4';
                break;
            case '5':
                $order='A.inputtime DESC';
                $where_url='5';
                break;
            case '6':
                $order='A.inputtime ASC';
                $where_url='6';
                break;
            case '7':
                $order='A.views DESC';
                $where_url='7';
                break;
            case '8':
                $order='A.views ASC';
                $where_url='8';
                break;
        }
        if(!empty($order)){
        $order=$order.',';
        $where_url='-sequence-'.$where_url;
        }

        //状态
        $status=intval($_GET['status']);
        switch ($status) {
            case '1':
                $where=' AND A.status=1';
                $where_url='1';
                break;
            case '2':
                $where=' AND A.status=0';
                $where_url='2';
                break;
        }
        if(!empty($status)){
        $where_url='-status-'.$where_url;
        }

        //搜索
        $search=in(urldecode($_GET['search']));
        if(!is_utf8($search)){
            $search=auto_charset($search);
        }
        if(!empty($search)){
        $where=' AND A.title like "%' . $search . '%"';
        $where_url='-search-'.urlencode($search);
        }

        //推荐位
        $position=intval($_GET['position']);
        if(!empty($position)){
            $where=' AND D.pid='.$position;
            $where_url='-position-'.$position;
        }
        return array(
            'order'=>$order,
            'where'=>$where,
            'url'=>$where_url
            );

    }
    public function common_list()
    {
        $position_list=model('position')->position_list();
        $category_list=model('category')->category_list();
        $model_info=module('content_category')->get_model();
        $data['position_list']=$position_list;
        $data['category_list']=$category_list;
        $data['model_info']=$model_info;
        //权限部分
        if(model('user_group')->model_power('content','past')){
            $data['past_power']=true;
        }
        if(model('user_group')->model_power('content','cancel')){
            $data['cancel_power']=true;
        }
        if(model('user_group')->model_power('content','del')){
            $data['del_power']=true;
        }
        if(model('user_group')->model_power('content','edit')){
            $data['edit_power']=true;
        }
        return $data;
    }

    //公共调用信息
    public function common_info($id,$status=false)
    {
        if($status){
            $info=model('content')->info($id);
            $info_data=model('content')->info_content($id);
            $position_array=model('position')->relation_array($id);
            $file_id=model('upload')->get_relation('content',$id);
            $cid=$info['cid'];
            $action_name='编辑';
            $action='edit';
        }else{
            $cid=$id;
            $action_name='添加';
            $action='add';
        }
        $class_info = model('category')->info($cid);
        $category_list=model('category')->category_list();
        $position_list=model('position')->position_list();
        $tpl_list=model('category')->tpl_list();

        $data['info']=$info;
        $data['info_data']=$info_data;
        $data['position_array']=$position_array;
        $data['file_id']=$file_id;
        $data['action_name']=$action_name;
        $data['action']=$action;
        $data['class_info']=$class_info;
        $data['category_list']=$category_list;
        $data['position_list']=$position_list;
        $data['tpl_list']=$tpl_list;

        
        return $data;
    }

    //公共保存检测信息
    public function common_data_check($data)
    {
        model('expand_model')->content_check($data);
    }


    //获取关键词
    public function get_keyword(){
        
        $title=$_POST['title'];
        $content=$_POST['content'];
        $keyword=model('content')->get_keyword($title,$content);
        if(!empty($keyword)){
            $this->msg($keyword);
        }else{
            $this->msg('暂时无法获取到关键词！',0);
        }
    }

    // 内容列表
    public function index()
    {
    	$id=intval($_GET['id']);
        $this->alert_str($id,'int');
        //获取公共信息条件
        $where=$this->common_list_where();
        $this->view()->assign($this->common_list());
        //栏目信息
        $this->class_info = model('category')->info($id);
        //分页信息
        $listRows=20;
        $url = __URL__ . '/index/id-' . $id . '-page-{page}'.$where['url'].'.html'; //分页基准网址
        $limit=$this->pagelimit($url,$listRows);
        //内容列表
        $this->list=model('content')->content_list($id,$limit,$where['where'],$where['order']);
        $count=model('content')->count($id,$where['where']);
        $this->page=$this->page($url, $count, $listRows);
        $this->show();
    }

    public function common_data_info()
    {
        $model_info=module('content_category')->get_model();
        if(!empty($model_info['befrom'])){
            $befrom=explode("\n",$model_info['befrom']);
            foreach ($befrom as $value) {
                $befrom_list[]=$value;
            }
        }
        $data['model_info']=$model_info;
        $data['befrom_list']=$befrom_list;
        return $data;
    }

    //内容添加
    public function add()
    {
        $cid=intval($_GET['cid']);
        $this->alert_str($cid,'int');
        $this->view()->assign($this->common_info($cid));
        $this->view()->assign($this->common_data_info($cid));
        $this->show('content/info');
    }

    //内容保存
    public function add_save()
    {
        /*hook*/
        $_POST=$this->plus_hook_replace('content','add_replace',$_POST);
        /*hook end*/
        $this->common_data_check($_POST);
    	//保存内容信息
    	$_POST['aid']=model('content')->add_save($_POST);
    	model('content')->add_content_save($_POST);
        /*hook*/
        $this->plus_hook('content','add',$_POST);
        /*hook end*/
    	$this->msg('内容添加成功！',1);
    }

    //内容编辑
    public function edit()
    {
        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        $this->view()->assign($this->common_info($id,true));
        $this->view()->assign($this->common_data_info($cid));
        $this->show('content/info');
    }

    //内容保存
    public function edit_save()
    {
        /*hook*/
        $_POST=$this->plus_hook_replace('content','edit_replace',$_POST);
        /*hook end*/
        $this->common_data_check($_POST);
        //保存内容信息
        $status=model('content')->edit_save($_POST);
        model('content')->edit_content_save($_POST);
        /*hook*/
        $this->plus_hook('content','edit');
        /*hook end*/
        $this->msg('内容编辑成功！',1);
    }

    //内容删除
    public function del()
    {
        $id=intval($_POST['aid']);
        $this->alert_str($id,'int',true);
        /*hook*/
        $this->plus_hook('content','del',$id);
        /*hook end*/
        $status=model('content')->del($id);
        model('content')->del_content($id);
        $this->msg('内容删除成功！',1);
    }

    //批量操作
    public function batch(){
        if(empty($_POST['status'])||empty($_POST['id'])){
            $this->msg('请先选择内容！',0);
        }
        $id_array=substr($_POST['id'],0,-1);
        $id_array=explode(',', $id_array);
        switch ($_POST['status']) {
            case '1':
                //审核
                foreach ($id_array as $value) {
                    model('content')->status($value,1);
                }
                break;
            case '2':
                //草稿
                foreach ($id_array as $value) {
                    model('content')->status($value,0);
                }
                break;
            case '3':
                //删除
                foreach ($id_array as $value) {
                    /*hook*/
                    $this->plus_hook('content','del',$value);
                    /*hook end*/
                    model('content')->del($value);
                    model('content')->del_content($value);
                }
                break;
            case '4':
                //转移栏目
                $cid=intval($_POST['cid']);
                if(empty($cid)){
                    $this->msg('请先选择目标栏目！',0);
                }
                foreach ($id_array as $value) {
                    model('content')->edit_cid($value,$cid);
                }
                break;
			case '5':
				//复制文章
				$copy_cid=intval($_POST['copy_cid']);
                if(empty($copy_cid)){
                    $this->msg('请先选择目标栏目！',0);
                }
				foreach ($id_array as $value) {
                    model('content')->add_cid($value,$copy_cid);
                }
				
        }
        $this->msg('操作执行完毕！',1);

    }
	

}

?>