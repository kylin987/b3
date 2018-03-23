<?php
class menuModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取主菜单
    public function main_menu(){
        $menu_list=array(
            0=>array(
                'pid'=>1,
                'name'=>'首页',
                'url'=>__APP__.'/menu/index',
                ),
            1=>array(
                'pid'=>30,
                'name'=>'栏目',
                'url'=>__APP__.'/menu/category',
                ),
            2=>array(
                'pid'=>40,
                'name'=>'内容',
                'url'=>__APP__.'/menu/content',
                ),
            3=>array(
                'pid'=>10,
                'name'=>'扩展',
                'url'=>__APP__.'/menu/expand',
                ),
            4=>array(
                'pid'=>50,
                'name'=>'表单',
                'url'=>__APP__.'/menu/form',
                ),
            5=>array(
                'pid'=>20,
                'name'=>'用户',
                'url'=>__APP__.'/menu/user',
                ),
            );
        $user=model('user')->current_user();
        $menu_power=unserialize($user['menu_power']);
        
        foreach ($menu_list as $value) {
            if(in_array($value['pid'], (array)$menu_power)){
                $list[]=$value;
            }
        }
        
        if($user['keep']<>1){
            return $list;
        }else{
            return $menu_list;
        }
        
        
    }

    //获取菜单
    public function admin_menu($pid=0) {
        $list=$this->model->table('admin_menu')->where('status=1 AND pid='.$pid)->order('id asc')->select();
        $data=array();
        if(!empty($list)){
            foreach ($list as $value) {
               if(model('user_group')->model_power($value['module'],'visit')){
                    $data[]=$value;
               }
            }
        }
        return $data;
    }

    //获取菜单项目
    public function menu_list($pid=0) {
        return $this->model->table('admin_menu')->where('pid='.$pid)->order('id asc')->select();
    }

    //格式化内容菜单
    public function content_menu($gid=null) {
        $lang=model('lang')->current_lang();
        $data=$this->model->field('A.cid,A.pid,A.mid,A.type,A.name,B.admin_category,B.admin_content')
                ->table('category','A')
                ->add_table('model','B','A.mid = B.mid')
                ->where('A.lang='.$lang['id'])
                ->order('A.sequence DESC,A.cid ASC')
                ->select();
        if(!empty($gid)){
            $user=model('user')->current_user();
            $class_power=explode(',', $user['class_power']);
            if($user['keep']<>1){
                $keep=false;
            }else{
				$keep=true;	
			}
        }
        return $this->gentree($data,$class_power,$keep);
    }

    //检测模块
    public function module_menu($module) {
        return $this->model->table('admin_menu')->where('module="'.$module.'"')->find();
    }

    //输出数据
    public function gentree($data,$class_power=array(),$keep=true){
        if(!empty($data)){
            foreach ($data as $key=>$value) {
                $tree[$key]=$value;
                if(in_array($value['cid'],(array)$class_power)||$keep==true){
                    $tree[$key]['pw']=0;
                }else{
                    $tree[$key]['pw']=1;
                }
            }
        }
        return $tree;

    }

}

?>