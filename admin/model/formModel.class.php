<?php
class formModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取表单列表
    public function form_list($where=null) {
        return $this->model->table('form')->where($where)->order('id asc')->select();
    }

    //获取表单信息
    public function table_info($table,$fid=null) {
        $where="`table`='".$table."'";
        if(!empty($fid)){
        $where.=' AND id<>'.$fid;
        }
        return $this->model->table('form')->where($where)->find();
    }

    //表单信息
    public function info($id)
    {
        return $this->model->table('form')->where('id='.$id)->find();
    }

    //修改关联信息
    public function associate_edit() {
        $info=$this->model->table('form')->order('id desc')->find();
        $data['fid']=$info['id'];
        $condition['fid']='101010';
        return $this->model->table('form_field')->data($data)->where($condition)->update();
    }

    //添加表单
    public function add($data)
    {
        $where['table']=$data['table'];
        if($this->model->table('form')->where($where)->find()){
            return false;
        }
         //添加初始表
        $sql="
        CREATE TABLE IF NOT EXISTS `{$this->model->pre}form_data_{$data['table']}` (
          `id` int(10) NOT NULL AUTO_INCREMENT,
          `lang` int(10) DEFAULT '1',
          PRIMARY KEY (`id`)
        ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
        ";
        $this->model->query($sql);
        return $this->model->table('form')->data($data)->insert();
    }

    //修改表单
    public function edit($data)
    {
        $info=$this->info($data['id']);
        //修改表
        $sql="
        ALTER TABLE {$this->model->pre}form_data_{$info['table']} RENAME TO {$this->model->pre}form_data_{$data['table']}
        ";
        $this->model->query($sql);

        $condition['id']=intval($data['id']);
        return $this->model->table('form')->data($data)->where($condition)->update(); 
    }

    //删除表单
    public function del($id)
    {
        $info=$this->info($id);
        //删除表
        $sql="
        DROP TABLE `{$this->model->pre}form_data_{$info['table']}`
        ";
        $this->model->query($sql);
        //删除表内字段
        $this->model->table('form_field')->where('fid='.$id)->delete();
        return $this->model->table('form')->where('id='.$id)->delete(); 
    }

    public function field_list_data($fid)
    {
        return $this->model->table('form_field')->where('fid='.$fid)->order('sequence asc,id asc')->select();
    }

    //字段列表
    public function field_list($fid)
    {
        $list=$this->field_list_data($fid);
        if(empty($list)){
            return;
        }
        foreach ($list as $key=>$vo) {
            $data[$key]=$vo;
            $data[$key]['type_name']=model('expand_model')->field_type($vo['type'],true);
        }
        return $data;

    }

    //字段信息
    public function field_info($id){
        $condition['id']=$id;
        return $this->model->table('form_field')->where($condition)->find();
    }

    //检测字段重复
    public function field_check($fid,$field,$id=null){
        if(!empty($id)){
            $condition=' AND id<>'.$id;
        }
        return $this->model->table('form_field')->where('fid='.$fid.' AND field="'.$field.'"'.$condition)->count();
    }

    //字段添加
    public function field_add($data)
    {
        $model=$this->info($data['fid']);
        $property=model('expand_model')->field_property($data['property']);
        $data=model('expand_model')->field_data($data);
        //添加真实字段
        $sql="
        ALTER TABLE {$this->model->pre}form_data_{$model['table']} ADD {$data['field']} {$property['name']}({$data['len']}{$data['decimal_len']}) DEFAULT NULL
        ";
        $this->model->query($sql);
        $data['admin_html']=html_in($data['admin_html']);
        return $this->model->table('form_field')->data($data)->insert();
    }

    //字段修改
    public function field_edit($data)
    {
        $model=$this->info($data['fid']);
        $info=$this->field_info($data['id']);
        $property=model('expand_model')->field_property($data['property']);
        $data=model('expand_model')->field_data($data);
        //修改真实字段
        $sql="
        ALTER TABLE {$this->model->pre}form_data_{$model['table']} CHANGE {$info['field']} {$data['field']} {$property['name']}({$data['len']}{$data['decimal_len']})
        ";
        $this->model->query($sql);
        $condition['id']=intval($data['id']);
        $data['admin_html']=html_in($data['admin_html']);
        return $this->model->table('form_field')->data($data)->where($condition)->update(); 
    }

    //字段删除
    public function field_del($data)
    {
        $info=$this->field_info($data['id']);
        $model=$this->info($info['fid']);
        $sql="ALTER TABLE {$this->model->pre}form_data_{$model['table']} DROP {$info['field']}";
        $this->model->query($sql);
        $condition['id']=intval($info['id']);
        return $this->model->table('form_field')->where($condition)->delete(); 
    }

}

?>