<?php
class userModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //当前用户信息
    public function current_user($cache=true,$del=false) {
        $uid=$_SESSION[$this->config['SPOT'].'_user'];
        if(empty($uid)){
            return ;
        }
        if($del){
            $this->cache->del('current_user_'.$uid);
            return ;
        }
        $user=$this->cache->get('current_user_'.$uid);
        if(empty($user)||$cache==false){
            $user=$this->model->table('admin')->where('id='.$uid)->find();
            $user_group=$this->model->table('admin_group')->where('id='.$user['gid'])->find();
            $user['gname']=$user_group['name'];
            $user['model_power']=$user_group['model_power'];
            $user['class_power']=$user_group['class_power'];
            $user['menu_power']=$user_group['menu_power'];
            $user['form_power']=$user_group['form_power'];
            $user['grade']=$user_group['grade'];
            $user['keep']=$user_group['keep'];
            $this->cache->set('current_user_'.$uid, $user);
        }
        return $user;
    }

    //获取用户列表
    public function admin_list()
    {
        $user=$this->current_user();
        if(model('user_group')->model_power('user','current')&&$user['keep']<>1){
            $where=' AND A.id='.$user['id'];
        }
        $data=$this->model->field('A.*,B.name as gname')
                ->table('admin','A')
                ->add_table('admin_group','B','A.gid = B.id')
                ->where('B.grade>='.$user['grade'].$where)
                ->order('id asc')
                ->select();
        return $data;

    }

    //获取用户内容
    public function info($id)
    {
        return $this->model->table('admin')->where('id='.$id)->find();
    }

    //检测重复用户
    public function count($user,$id=null)
    {
        if(!empty($id)){
            $where=' AND id<>'.$id;
        }
        return $this->model->table('admin')->where('user="'.$user.'"'.$where)->count(); 
    }

    //添加用户内容
    public function add($data)
    {
        $_POST['regtime']=time();
        return $this->model->table('admin')->data($data)->insert();
    }

    //编辑用户内容
    public function edit($data)
    {
        $condition['id']=intval($data['id']);
        $id=$this->model->table('admin')->data($data)->where($condition)->update();
        return $id;
    }

    //删除用户内容
    public function del($id)
    {
        return $this->model->table('admin')->where('id='.intval($id))->delete(); 
    }

}

?>