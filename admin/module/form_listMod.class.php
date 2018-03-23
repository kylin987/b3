<?php
//表单管理
class form_listMod extends commonMod {

	public function __construct()
    {
        parent::__construct();
    }

	public function index() {

        $id=intval($_GET['id']);
        $this->alert_str($id,'int');
        //分页处理
        $url = __URL__ . '/index/id-' . $id . '-page-{page}.html';
        $listRows = 20;
        $limit=$this->pagelimit($url,$listRows);
        $this->info=model('form')->info($id);
        //内容列表
        $count=model('form_list')->count($id);
        $this->list=model('form_list')->form_list($id,$limit,$this->info['order']);
        $this->field_list=model('form_list')->field_list($id);
        $this->page = $this->page($url, $count, $listRows);
		$this->show();
	}

    public function data_check($data)
    {
        //获取所有字段
        $field_list=model('form_list')->list_lod($data['fid']);
        if(empty($field_list)){
            $this->msg('未发现表单字段！',0);
        }
        foreach ($field_list as $value) {
            if($value['must']==1){
                if(empty($data[$value['field']])){
                    $this->msg($value['name'].'不能为空！',0);
                }
            }
            $data[$value['field']]=model('expand_model')->field_in($data[$value['field']],$value['type'],$value['field']);
        }
        return $data;
    }

    //表单添加
    public function add() {
        $id=$_GET['id'];
        $this->alert_str($id,'int');
        $this->field_list=model('form')->field_list($id);
        $this->form_info=model('form')->info($id);
        $this->action_name='添加';
        $this->action='add';
        $this->show('form_list/info'); 
    }

    //表单数据处理
    public function add_save() {
        $this->alert_str($_POST['fid'],'int',true);
        $data=$this->data_check($_POST);
        //处理完毕后交由模型处理数据
        $id=model('form_list')->add($data);
        model('upload')->relation('form',$data['file_id'],$id);
        $this->msg('添加成功！',1);

    }

    //表单编辑
    public function edit() {
        $fid=$_GET['fid'];
        $id=$_GET['id'];
        $this->alert_str($fid,'int');
        $this->alert_str($id,'int');
        $this->field_list=model('form')->field_list($fid);
        $this->form_info=model('form')->info($fid);
        $this->info=model('form_list')->info($id,$this->form_info['table']);
        $this->file_id=model('upload')->get_relation('form',$id);
        $this->action_name='编辑';
        $this->action='edit';
        $this->show('form_list/info');
    }

    //内容编辑数据处理
    public function edit_save() {
        $this->alert_str($_POST['fid'],'int',true);
        $this->alert_str($_POST['id'],'int',true);
        $data=$this->data_check($_POST);
        //模型处理数据
        model('form_list')->edit($data);
        model('upload')->relation('form',$data['file_id'],$data['id']);
        $this->msg('编辑成功！',1);

    }

    //删除
    public function del() {
        $id=$_POST['id'];
        $fid=$_POST['fid'];
        $this->alert_str($_POST['fid'],'int',true);
        $this->alert_str($_POST['id'],'int',true);
        model('form_list')->del($id,$fid);
        model('upload')->del_file('form',$id);
        $this->msg('内容删除成功！',1);
    }


}