<?php
//语言管理
class langMod extends commonMod {

	public function __construct()
    {
        parent::__construct();
    }

	public function index() {
		$this->assign('list',model('lang')->lang_list());
		$this->show();  
	}

	//添加
	public function add() {
		$this->action_name='添加';
        $this->action='add';
        $this->show('lang/info');
	}

	public function add_save() {
        //录入模型处理
        if(model('lang')->add($_POST)){
            $this->msg('语言添加成功！',1);
        }else{
            $this->msg('语言添加失败，请确认目录有读写权限! ',1);
        }
        
	}

    //修改
    public function edit() {
        $id=$_GET['id'];
        $this->alert_str($id,'int');
        $this->info=model('lang')->info($id);
        $this->action_name='编辑';
        $this->action='edit';
        $this->show('lang/info');
    }

    public function edit_save() {
        // 表单验证
        $this->alert_str($_POST['id'],'int',true);
        //录入模型处理
        if(model('lang')->edit($_POST)){
            $this->msg('语言修改成功! ',1);
        }else{
            $this->msg('语言修改失败，请确认目录有读写权限! ',1);
        }
        
    }

    //删除
    public function del() {
        $id=intval($_POST['id']);
        $this->alert_str($id,'int',true);
        //录入模型处理
        model('lang')->del($id);
        $this->msg('语言删除成功！',1);
    }
	

	

}