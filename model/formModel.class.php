<?php
class formModel extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //获取内容
    public function info($form)
    {
        return $this->model->table('form')->where('`table`="'.$form.'"')->find();
    }

    //表单字段
    public function field_list($id){
    	return $this->model->table('form_field')->where('fid='.$id)->select();
    }

    //表单内容列表
    public function form_list($table,$limit,$order,$where){
        $lang=model('lang')->langid();
        if($where){
            $where=$where.' AND lang='.$lang;
        }else{
            $where='lang='.$lang;
        }
    	return $this->model->table('form_data_'.$table)->limit($limit)->where($where)->order($order)->select();
    }

    //表单内容统计
    public function form_count($table,$where){
        $lang=model('lang')->langid();
        if($where){
            $where=$where.' AND lang='.$lang;
        }else{
            $where='lang='.$lang;
        }
    	return $this->model->table('form_data_'.$table)->where($where)->count();
    }

    //添加内容
    public function add($data,$form)
    {
        $this->model->table('form_data_'.$form)->data($data)->insert();
    }

    //格式化录入字段内容
    public function field_in($value,$type,$field) {
        switch ($type) {
            case '1':
            case '4':
                return html_in($value);
                break;
            
            case '2':
            case '3':
                return html_in($value,true);
                break;
            case '5':
                if(is_array($value)){
                    $str1=$field.'_title';
                    $str2=$field.'_order';
                    eval('$title=$_POST[\''.$str1.'\'];');
                    eval('$order=$_POST[\''.$str2.'\'];');
                   foreach ($value as $key=>$vo) {
                        $list[$key]['url']=$vo;
                        $list[$key]['title']=$title[$key];
                        $list[$key]['order']=$order[$key];
                   }
                }
                return serialize($list);
                break;
            case '6':
            case '8':
                return intval($value);
                break;
            case '7':
                return strtotime($value);
                break;
            case '9':
                return serialize($value);
                break;
            default:
                return html_in($value);
                break;
        }
    }


}
?>