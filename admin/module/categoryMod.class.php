<?php
class categoryMod extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }
    // 分类首页
    public function index()
    {
        $this->model_list=model('model_manage')->model_list();
        $this->list=model('category')->category_list();
        //权限部分
        if(model('user_group')->model_power('category','edit')){
            $this->edit_power=true;
        }
        if(model('user_group')->model_power('category','del')){
            $this->del_power=true;
        }
        $this->show();
    }

    //排序
    public function sequence(){
        $cid=intval($_POST['cid']);
        $sequence=intval($_POST['sequence']);
        model('category')->sequence($cid,$sequence);
        $this->msg('排序成功！');
    }


    public function common_info($id=null)
    {
        if(!empty($id)){
            $info=model('category')->info($id);
            $file_id=model('upload')->get_relation('category',$id);
            $action_name='编辑';
            $action='edit';
        }else{
            $action_name='添加';
            $action='add';
        }
        $category_list=model('category')->category_list();
        $model_list=model('expand_model')->model_list();
        $tpl_list=model('category')->tpl_list();
        if($_GET['type']<>'content'){
            $return_list=__APP__.'/category';
        }else{
            $return_list=__APP__.'/content_index';
        }
        $data['info']=$info;
        $data['file_id']=$file_id;
        $data['action_name']=$action_name;
        $data['action']=$action;
        $data['category_list']=$category_list;
        $data['model_list']=$model_list;
        $data['tpl_list']=$tpl_list;
        $data['return_list']=$return_list;
        return $data;
    }

    public function common_add_check($data)
    {
        if(empty($data['class_tpl'])&&empty($data['content_tpl'])){
            $this->msg('栏目或内容模板未选择！',0);
        }

    }

    public function common_edit_check($data)
    {
        if(empty($data['name'])){
            $this->msg('栏目名称未填写',0);
        }
        if(empty($data['class_tpl'])&&empty($data['content_tpl'])){
            $this->msg('栏目或内容模板未选择！',0);
        }
        
        // 分类检测
        if ($data['pid'] == $data['cid']){
            $this->msg('不可以将当前栏目设置为上一级栏目！',0);
            return;
        }
        $cat = model('category')->category_list($data['cid']);
        if (!empty($cat)) {
            foreach ($cat as $vo) {
                if ($data['pid'] == $vo['cid']) {
                    $this->msg('不可以将上一级栏目移动到子栏目！',0);
                    return;
                }
            }
        }
    }

    public function common_del_check($data)
    {
        if(model('category')->list_count($data['cid'])){
            $this->msg('请先删除子栏目！',0);
        }
    }



}

?>