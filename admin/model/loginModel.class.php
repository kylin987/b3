<?php
class loginModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取用户信息
    public function user_info($user) {
        return $this->model->table('admin')->where('user="'.$user.'"')->find();
    }

    //获取用户信息ID
    public function user_info_id($uid) {
        return $this->model->table('admin')->where('id='.$uid)->find();
    }

    //更新用户信息
    public function edit($data,$id) {
    	$condition['id']=$id;
        $this->model->table('admin')->data($data)->where($condition)->update();
    }



}

?>