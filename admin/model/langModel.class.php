<?php
class langModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //当前语言
    public function current_lang() {
        return $this->model->table('lang')->where('lang="'.__LANG__.'"')->find();
    }

    //语言列表
    public function lang_list() {
        return $this->model->table('lang')->order('id asc')->select();
    }

    //获取语言信息
    public function info($id) {
        return $this->model->table('lang')->where('id='.$id)->find();
    }

    //添加多国语言
    public function add($data)
    {
        $dir=__ROOTDIR__.'/lang/'.in($data['lang']);
        if (!is_dir($dir)){
            if(!@mkdir($dir, 0777)){
                return false;
            }
            @copy_dir(__ROOTDIR__.'/lang/zh',$dir);
        }
        return $this->model->table('lang')->data($data)->insert();
    }

    //编辑多国语言
    public function edit($data)
    {
        $dir=__ROOTDIR__.'/lang/'.in($data['lang']);
        $info=$this->info($data['id']);
        if (!is_dir($dir)){
            if(!@mkdir($dir, 0777)){
                return false;
            }
            @copy_dir(__ROOTDIR__.'/lang/zh',$dir);
        }else{
            if(!@copy_dir(__ROOTDIR__.'/lang/'.$info['lang'],$dir)){
                return false;
            }

        }
        if (is_dir($dir)){
            @del_dir(__ROOTDIR__.'/lang/'.$info['lang']);
        }
        $condition['id']=intval($data['id']);
        return $this->model->table('lang')->data($data)->where($condition)->update(); 
    }

    //删除语言
    public function del($id)
    {
        $info=$this->info($id);
        $dir=__ROOTDIR__.'/lang/'.$info['lang'];
        if (is_dir($dir)){
            @del_dir($dir);
        }
        if($info['protection']==1){
            return false;
        }
        return $this->model->table('lang')->where('id='.intval($id))->delete(); 
    }

}

?>