<?php
class menuMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }


    //后台首页菜单
    public function index()
    {
        $this->list=model('menu')->admin_menu(1);
        $this->display();
    }

	// 分类菜单
    public function category()
    {
        if(model('user_group')->model_power('category',2)){
        $this->model_list=model('model_manage')->model_list();
        }
        $this->list=model('menu')->admin_menu(30);
        $this->display();
    }
    
	// 内容菜单
    public function content()
    {
       $this->user=model('user')->current_user();
       $tree=model('menu')->content_menu($this->user['gid']);
       $data='';
       if(!empty($tree)){
           foreach ($tree as $value) {
                if(empty($value['admin_content'])){
                    $url=' , url:"'.__APP__.'/'.$value['admin_category'].'/edit/id-'.$value['cid'].'-type-content", target:"main" , icon:"'.__PUBLICURL__.'/ztree/css/img/ico2.gif" '; 
                }else{
                    if($value['type']==1){
                        $url=' , url:"'.__APP__.'/'.$value['admin_content'].'/index/id-'.$value['cid'].'", target:"main" , icon:"'.__PUBLICURL__.'/ztree/css/img/ico3.gif" '; 
                    }else{
                        $url=' , icon:"'.__PUBLICURL__.'/ztree/css/img/ico1.gif" '; 
                    }
                }
                if($value['pw']==1){
                    $purview=' , isHidden:true ';
                }else{
                    $purview=' , isHidden:false ';
                }
               $data.='{cid:'.$value['cid'].',pid:'.$value['pid'].', name:"'.$value['name'].'" '.$url.$purview.' }, '."\n";
           }
           $data.='{name:" ", isHidden:true  }'."\n";
       }
       $this->class_tree=$data;
       $this->display();

    }
    //扩展菜单
    public function expand()
    {
        $this->list=model('menu')->admin_menu(10);
        $this->display();
    }

    //表单管理
    public function form() {
        $list=model('form')->form_list();
        $data=array();
        if(!empty($list)){
            foreach ($list as $value) {
               if(model('user_group')->form_power($value['table'],'visit')){
                    $data[]=$value;
               }
            }
        }
        $this->list=$data;
        $this->assign('display',$display);
        $this->assign('user',$user);
        $this->assign('menu',$menu);
        $this->display();
    }

    //用户管理
    public function user() {
        $this->list=model('menu')->admin_menu(20);
        $this->display();
    }

    public function error() {
        $this->success('很抱歉，暂时没有可显示的功能！');
    }


}

?>