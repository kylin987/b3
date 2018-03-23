<?php
//用户组管理
class user_groupMod extends commonMod {

	public function __construct()
    {
        parent::__construct();
    }

	public function index() {
		$this->list=model('user_group')->admin_list();
		$this->show();  
	}

	//用户组添加
	public function add() {
        $this->user=model('user')->current_user();
        //获取栏目树
        $tree=model('menu')->content_menu();
        if(!empty($tree)){
            $data='';
            foreach ($tree as $value) {
               $data.='{cid:'.$value['cid'].',pid:'.$value['pid'].', name:"'.$value['name'].'"  ,title:"'.$value['name'].'" }, '."\n";
            }
            $data.='{name:" ", isHidden:true  }'."\n";
        }
        $this->class_tree=$data;

        //获取模块权限
        $this->menu_list=model('menu')->menu_list();
        $this->form_list=model('form')->form_list();
        $this->action_name='添加';
        $this->action='add';
        $this->show('user_group/info');
	}


    public function data_save($data) {
        if(!empty($data['class_power'])){
            $data['class_power']=substr($data['class_power'],0,-1);   
        }else{
            $data['class_power']='';
        }
        $data['model_power']=serialize($data['model_power']);
        $data['menu_power']=serialize($data['menu_power']);
        $data['form_power']=serialize($data['form_power']);
        return $data;
    }



	public function add_save() {
        $data=$this->data_save($_POST);
        //录入模型处理
        model('user_group')->add($data);
        $this->msg('用户组添加成功！',1);
	}

    //用户组修改
    public function edit() {
        $id=$_GET['id'];
        $this->alert_str($id,'int');
        //用户组信息
        $this->info=model('user_group')->info($id);
        $this->user=model('user')->current_user();
        if($this->info['grade']<$this->user['grade']){
            $this->msg('请勿越权操作！',0);
        }
        //获取栏目树
        $tree=model('menu')->content_menu();
        $class_power=explode(',', $this->info['class_power']);
        $data='';
        if(!empty($tree)){
            foreach ($tree as $value) {
                if(!empty($this->info['class_power'])){
                    if(in_array($value['cid'],$class_power)){
                        $purview=' , checked:true ';
                    }else{
                        $purview=' ';
                    }
                }
               $data.='{cid:'.$value['cid'].',pid:'.$value['pid'].',name:"'.$value['name'].'" ,title:"'.$value['name'].'" '.$purview.' }, '."\n";
            }
            $data.='{name:" ", isHidden:true  }'."\n";
        }
        $this->class_tree=$data;

        //获取模块权限
        $this->menu_list=model('menu')->menu_list();
        $this->form_list=model('form')->form_list();
        $this->model_power=unserialize($this->info['model_power']);
        $this->form_power=unserialize($this->info['form_power']);
        $this->menu_power=unserialize($this->info['menu_power']);
        $this->action_name='编辑';
        $this->action='edit';
        $this->show('user_group/info');
    }

    //用户组修改
    public function edit_save() {
        $this->alert_str($_POST['id'],'int',true);
        $data=$this->data_save($_POST);
        //录入模型处理
        model('user_group')->edit($data);
        $this->msg('用户组修改成功! ',1);
    }

    //用户组删除
    public function del() {
        $id=intval($_POST['id']);
        $this->alert_str($id,'int',true);
        $info=model('user_group')->info($id);
        if($info['keep']==1){
            $this->msg('内置管理组无法删除！',0);
        }
        $this->user=model('user')->current_user();
        if($info['grade']<$this->user['grade']){
            $this->msg('越权操作！',0);
        }
        //录入模型处理
        model('user_group')->del($id);
        $this->msg('用户组删除成功！',1);
    }
	

	

}