<?php
class jump_categoryModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //模型附加表信息
    public function model_ini_data()
    {
        return array(
            //数据库信息
            'category_jump',
        );
    }
    //模型文件或文件夹信息
    public function model_ini_file()
    {
        return array(
            //前台
            'model/jumpModel.class.php',
            'module/jumpMod.class.php',
            //后台
            'admin/module/jump_categoryMod.class.php',
            'admin/model/jump_categoryModel.class.php',
            'admin/template/jump_category',
        );
    }

    //保存单页内容
    public function jump_save($data) {
        return $this->model->table('category_jump')->data($data)->insert();
    }

    //编辑单页内容
    public function edit_save($data) {
        return $this->model->table('category_jump')->data($data)->where('cid='.$data['cid'])->update();
    }

    //获取跳转内容
    public function jump_info($cid) {
        return $this->model->table('category_jump')->where('cid='.$cid)->find();
    }

    //删除跳转内容
    public function del($cid)
    {
        return $this->model->table('category_jump')->where('cid='.$cid)->delete(); 
    }


}

?>