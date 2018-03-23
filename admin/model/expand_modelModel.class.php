<?php
class  expand_modelModel extends commonModel
{
    public function __construct()
    {
        parent::__construct();
    }

    //列表
    public function model_list() {
        return $this->model->table('expand_model')->order('mid asc')->select();
    }

    //获取模型信息
    public function table_info($table,$mid=null) {
        $where="`table`='".$table."'";
        if(!empty($mid)){
        $where.=' AND mid<>'.$mid;
        }
        return $this->model->table('expand_model')->where($where)->find();
    }
    //获取模型信息
    public function info($mid) {
        $where['mid']=$mid;
        return $this->model->table('expand_model')->where($where)->find();
    }
    //修改关联信息
    public function associate_edit() {
        $info=$this->model->table('expand_model')->order('mid desc')->find();
        $data['mid']=$info['mid'];
        $condition['mid']='101010';
        return $this->model->table('expand_model_field')->data($data)->where($condition)->update();
    }

    //添加
    public function add($data) {
        //建立模型添加表
        $sql="
        CREATE TABLE IF NOT EXISTS `{$this->model->pre}expand_content_{$data['table']}` (
          `id` int(10) NOT NULL AUTO_INCREMENT,
          `aid` int(10) DEFAULT NULL,
          PRIMARY KEY (`id`)
        ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
        ";
        $this->model->query($sql);
        return $this->model->table('expand_model')->data($data)->insert();
    }

    //修改
    public function edit($data) {
        $info=$this->info($data['mid']);
        //修改模型表
        $sql="
        ALTER TABLE {$this->model->pre}expand_content_{$info['table']} RENAME TO {$this->model->pre}expand_content_{$data['table']}
        ";
        $this->model->query($sql);
        //修改信息
        $condition['mid']=intval($data['mid']);
        return $this->model->table('expand_model')->data($data)->where($condition)->update(); 
    }

    //删除
    public function del($data)
    {
        $info=$this->info($data['mid']);
        //删除表
        $sql="
        DROP TABLE `{$this->model->pre}expand_content_{$info['table']}`
        ";
        $this->model->query($sql);
        //删除表内字段
        $this->model->table('expand_model_field')->where('mid='.$data['mid'])->delete(); 
        return $this->model->table('expand_model')->where('mid='.$data['mid'])->delete(); 
    }

    //字段列表
    public function field_list_data($mid)
    {
        return $this->model->table('expand_model_field')->where('mid='.$mid)->order('sequence asc,fid asc')->select();
    }


    //字段列表
    public function field_list($mid)
    {
        $list=$this->field_list_data($mid);
        if(empty($list)){
            return;
        }
        foreach ($list as $key => $vo) {
            $data[$key]=$vo;
            $data[$key]['type_id']=$vo['type'];
            $data[$key]['type']=$this->field_type($vo['type'],true);
            $data[$key]['property']=$this->field_property($vo['property'],true);
        }
        return $data;
    }

    //获取字段类型名称
    public function field_type($id=null,$name=false)
    {
        $list=array(
            1=> array(
                'name'=>'文本框'
                ),
            2=> array(
                'name'=>'多行文本'
                ),
            3=> array(
                'name'=>'编辑器'
                ),
            4=> array(
                'name'=>'文件上传'
                ),
            10=> array(
                'name'=>'单图片上传'
                ),
            5=> array(
                'name'=>'组图上传'
                ),
            6=> array(
                'name'=>'下拉菜单'
                ),
            7=> array(
                'name'=>'日期和时间'
                ),
            8=> array(
                'name'=>'单选'
                ),
            9=> array(
                'name'=>'多选'
                ),
        );
        if(!empty($id)){
            if($name){
                return $list[$id]['name'];
            }else{
                return $list[$id];
            }
        }else{
            return $list;
        }
    }

    //获取字段属性
    public function field_property($id=null,$name=false)
    {
        $list=array(
            1=> array(
                'name'=>'varchar',
                'maxlen'=>255,
                ),
            2=> array(
                'name'=>'int',
                'maxlen'=>10,
                ),
            3=> array(
                'name'=>'text',
                'maxlen'=>0,
                ),
            4=> array(
                'name'=>'decimal',
                'maxlen'=>10,
                ),
        );
        if(!empty($id)){
            if($name){
                return $list[$id]['name'];
            }else{
                return $list[$id];
            }
        }else{
            return $list;
        }
    }

    //获取字段信息
    public function field_info($field,$mid,$fid=null) {
        $where='field="'.$field.'"';
        $where.=' AND mid='.$mid;
        if(!empty($fid)){
        $where.=' AND fid<>'.$fid;
        }
        return $this->model->table('expand_model_field')->where($where)->find();
    }

    //获取字段信息通过ID
    public function field_info_id($fid) {
        $where['fid']=$fid;
        return $this->model->table('expand_model_field')->where($where)->find();
    }

    //格式化字段
    public function field_data($data) {
        $property=$this->field_property($data['property']);
        if($data['property']==4){
            $data['decimal_len']=','.$data['decimal'];
        }else{
            $data['decimal_len']='';
        }

        if(intval($data['len'])>$property['maxlen']){
            $data['len']=$property['maxlen'];
        }
        $data['default']=html_in($data['default']);
        $data['config']=html_in($data['config']);
        return $data;
    }

    public function field_add($data) {
        $model=$this->info($data['mid']);
        $property=$this->field_property($data['property']);
        $data=$this->field_data($data);
        //添加真实字段
        $sql="
        ALTER TABLE {$this->model->pre}expand_content_{$model['table']} ADD {$data['field']} {$property['name']}({$data['len']}{$data['decimal_len']}) DEFAULT NULL
        ";
        $this->model->query($sql);
        return $this->model->table('expand_model_field')->data($data)->insert();
        
    }

    public function field_edit($data) {
        $info=$this->field_info_id($data['fid']);
        $model=$this->info($data['mid']);
        $property=$this->field_property($data['property']);
        $data=$this->field_data($data);
        //添加真实字段
        $sql="
        ALTER TABLE {$this->model->pre}expand_content_{$model['table']} CHANGE {$info['field']} {$data['field']} {$property['name']}({$data['len']}{$data['decimal_len']})
        ";
        $this->model->query($sql);
        $condition['fid']=intval($data['fid']);
        return $this->model->table('expand_model_field')->data($data)->where($condition)->update(); 
    }

    //字段删除
    public function field_del($data)
    {
        $model=$this->info($data['mid']);
        $info=$this->field_info_id($data['fid']);
        $sql="
             ALTER TABLE {$this->model->pre}expand_content_{$model['table']} DROP {$info['field']}
            ";
        $this->model->query($sql);
        $condition['fid']=intval($info['fid']);
        return $this->model->table('expand_model_field')->where($condition)->delete(); 
    }

    //获取扩展内容字段数据
    public function get_file_content($aid,$mid)
    {
        if(empty($aid)||empty($mid)){
            return;
        }
        //获取字段信息
        $model=$this->info($mid);
        //获取扩展表内容
        $condition['aid']=$aid;
        return $this->model->table('expand_content_'.$model['table'])->where($condition)->find(); 

    }

    //获取字段显示
    public function get_list_model($type,$str,$config){
        switch ($type) {
            case '1':
            case '2':
            case '4':
                return $str;
                break;
            case '3':
                return html_out($str);
                break;
            case '5':
                if(!empty($str)){
                    $array=unserialize($str);
                    if(!empty($array)){
                        foreach ($array as $value) {
                            $strs.=$value['url'].'<br>';
                        }
                    }
                }
                return $strs;
                break;
            case '6':
            case '8':
                $list=explode("\n",html_out($config));
                foreach ($list as $key) {
                    $value=explode('|',$key);
                    if($value[1]==$str){
                        return $value[0];
                    }
                }
                break;

            case '7':
                return date('Y-m-d H:i:s',$str);
                break;
            case '9':
                $list=explode("\n",html_out($config));
                foreach ($list as $key) {
                    $value=explode('|',$key);
                    if($value[1]==$str){
                        $strs.=$value[0].' ';
                    }
                }
                return $strs;
                break;
            case '10':
                return '<img name="" src="'.$str.'" alt="" style="max-width:170px; max-height:90px; _width:170px; _height:90px;" />';
                break;
            default:
                return $str;
                break;
        }

    }

    //获取字段HTML
    public function get_field_html($info,$data=null){
        $info['default']=html_out($info['default']);

        if(!empty($data)){
            $info['default']=$data;
        }

        $html='';
        switch ($info['type']) {
            case '1':
                $html.='
                <tr>
                    <td align="right">'.$info['name'].'</td>
                    <td>
                    <input name="'.$info['field'].'" type="text" class="text_value" id="'.$info['field'].'" value="'.$info['default'].'" 
                ';
                if(!empty($info['must'])){
                    $html.=' reg="\S" msg="'.$info['name'].'不能为空！" ';
                }
                $html.='/>
                    </td>
                    <td>'.$info['tip'].'</td>
                </tr>
                ';
                break;
            case '2':
                $html.='
                <tr>
                    <td align="right">'.$info['name'].'</td>
                    <td><textarea name="'.$info['field'].'" class="text_textarea" id="'.$info['field'].'" >'.$info['default'].'</textarea>
                    </td>
                    <td>'.$info['tip'].'</td>
                </tr>
                ';
                break;
            case '3':
                
                $html.='
                <tr>
                    <td align="right">'.$info['name'].'</td>
                    <td colspan="2"><textarea name="'.$info['field'].'" style="width:100%; height:350px;" id="'.$info['field'].'">'.$info['default'].'</textarea>
                    '.module('editor')->get_editor_upload($info['field'].'_upload','editor_'.$info['field']).'
                    <input type="button" id="'.$info['field'].'_upload" class="button_small" style="margin-top:10px;" value="上传图片和文件到编辑器" />
                    </td>
                </tr>
                ';
                $html.=module('editor')->get_editor($info['field'],true);
                break;
            case '4':
                
                $html.='
                <tr>
                    <td align="right">'.$info['name'].'</td>
                    <td>
                    <input name="'.$info['field'].'" type="text"  class="text_value"  style="width:200px; float:left"  id="'.$info['field'].'" value="'.$info['default'].'" 
                ';
                if(!empty($info['must'])){
                    $html.=' reg="\S"  msg="'.$info['name'].'不能为空！" ';
                }
                $html.='/>
                &nbsp;&nbsp;<input type="button" id="'.$info['field'].'_botton" class="button_small" value="选择文件" />
                    </td>
                    <td>'.$info['tip'].'</td>
                </tr>
                ';
                $html.=module('editor')->get_file_upload($info['field'].'_botton',$info['field'],true);
                break;
            case '10':
                
                $html.='
                <tr>
                    <td align="right">'.$info['name'].'</td>
                    <td>
                    <input name="'.$info['field'].'" type="text"  class="text_value"  style="width:200px; float:left"  id="'.$info['field'].'" value="'.$info['default'].'" 
                ';
                if(!empty($info['must'])){
                    $html.=' reg="\S"  msg="'.$info['name'].'不能为空！" ';
                }
                $html.='/>
                &nbsp;&nbsp;<input type="button" id="'.$info['field'].'_botton" class="button_small" value="选择图片" />
                    </td>
                    <td>'.$info['tip'].'</td>
                </tr>
                ';
                $html.=module('editor')->get_image_upload($info['field'].'_botton',$info['field'],true);
                break;
            case '5':
                
                $html.='
                <tr>
                    <td align="right">'.$info['name'].'</td>
                    <td colspan="2">
                    <input type="button" id="'.$info['field'].'_button" class="button_small" value="上传多图" />
                    <div class="fn_clear"></div>
                    <div class="images">
                    <ul id="'.$info['field'].'_list" class="images_list">';

                if(!empty($data)){
                $info['default']=unserialize($info['default']);
                if(!empty($info['default'])){
                foreach ($info['default'] as $value) {
                $html.="<li>
                        <div class='pic' id='images_button'>
                        <img src='".$value['url']."' width='125' height='105' />
                        <input  id='".$info['field']."[]' name='".$info['field']."[]' type='hidden' value='".$value['url']."' />
                        <input  id='".$info['field']."_original[]' name='".$info['field']."_original[]' type='hidden' value='".$value['original']."' />
                        </div>
                        <div class='title'>标题： <input name='".$info['field']."_title[]' type='text' id='".$info['field']."_title[]' value='".$value['title']."' /></div>
                        <div class='title'>排序： <input id='".$info['field']."_order[]' name='".$info['field']."_order[]' value='".$value['order']."' type='text' style='width:50px;' /> <a href='javascript:void(0);' onclick='$(this).parent().parent().remove()'>删除</a></div>
                    </li>";
                }
                }
                }

                $html.="</ul>
                    <div style='clear:both'></div>
                    </div>
                    </td>
                </tr>
                ";
                $html.=module('editor')->get_images_upload($info['field'],$ajax=true);
                break;
            case '6':
                $html.='<tr>';
                $html.='<td align="right">';
                $html.=$info['name'];
                $html.='</td>';
                $html.='<td>';
                $select_list='<select name="'.$info['field'].'" id="'.$info['field'].'">';
                $list=explode("\n",html_out($info['config']));
                foreach ($list as $key) {
                    $value=explode('|',$key);
                    $select_list.='<option ';
                    if($info['default']==$value[1]){
                        $select_list.='selected="selected" ';
                    }
                    $select_list.=' value="'.$value[1].'">'.$value[0].'</option>';
                }
                $select_list.='</select>';
                $html.=$select_list;
                $html.='</td>';
                $html.='<td>';
                $html.=$info['tip'];
                $html.='</td>';
                $html.='</tr>';
                break;
            case '7':
                $config=explode("\n", $info['config']);
                if(empty($config[0])){
                    $config[0]='Y-m-d H:i:s';
                }
                if(empty($config[1])){
                    $config[1]='yyyy-MM-dd HH:mm:ss';
                }
                if($data){
                    $info['default']=date($config[0],intval($info['default']));
                }else{
                    $info['default']=date($config[0]);
                }
                $html.='<tr>';
                $html.='<td align="right">';
                $html.=$info['name'];
                $html.='</td>';
                $html.='<td>';
                $html.='<input name="'.$info['field'].'"  id="'.$info['field'].'" type="text" class="text_value" style="width:210px; float:left" value="'.$info['default'].'"';
                if($info['must']==1){
                    $html.=' reg="\S" msg="'.$info['name'].'不能为空" ';
                }
                $html.='/><div  id="'.$info['field'].'_button" class="time"></div></td>';
                $html.='<td>';
                $html.=$info['tip'];
                $html.='</td>';
                $html.='</tr>';
                $html.='<script>';
                $html.="$('#".$info['field']."_button').calendar({ id:'#".$info['field']."',format:'".$config[1]."'});";
                $html.='</script>';
                break;
            case '8':
                $html.='<tr>';
                $html.='<td align="right">';
                $html.=$info['name'];
                $html.='</td>';
                $html.='<td>';
                $list=explode("\n",html_out($info['config']));
                foreach ($list as $key) {
                    $value=explode('|',$key);
                    $select_list.='<input name="'.$info['field'].'" type="radio" value="'.$value[1].'" ';
                    if($info['default']==''){
                        $info['default']=1;
                    }
                    if($info['default']==$value[1]){
                        $select_list.='checked="checked" ';
                    }
                    $select_list.=' /> '.$value[0].'&nbsp;&nbsp;';
                }
                $html.=$select_list;
                $html.='</td>';
                $html.='<td>';
                $html.=$info['tip'];
                $html.='</td>';
                $html.='</tr>';
                break;
            case '9':
                $html.='<tr>';
                $html.='<td align="right">';
                $html.=$info['name'];
                $html.='</td>';
                $html.='<td>';
                $list=explode("\n",html_out($info['config']));
                
                if(!empty($data)){
                   $default=unserialize($info['default']);
                }else{
                   $default=explode('|', $info['default']);
                }
                foreach ($list as $key) {
                    $value=explode('|',$key);
                    $select_list.='<input name="'.$info['field'].'[]" type="checkbox" value="'.$value[1].'" ';
                    if($default<>''){
                    if(in_array($value[1], $default)){
                        $select_list.='checked="checked" ';
                    }
                    }
                    $select_list.=' /> '.$value[0].'&nbsp;&nbsp;';
                }
                $html.=$select_list;
                $html.='</td>';
                $html.='<td>';
                $html.=$info['tip'];
                $html.='</td>';
                $html.='</tr>';
                break;
        }
        return $html;
    }

    //格式化录入字段内容
    public function field_in($value,$type,$field,$data='') {
        switch ($type) {
            case '1':
            case '4':
                return in($value);
                break;
            
            case '2':
            case '3':
                return html_in($value);
                break;
            case '5':
                if(is_array($value)){
                    $str1=$field.'_title';
                    $str2=$field.'_order';
                    $str3=$field.'_original';
                    $title=$data[$str1];
                    $order=$data[$str2];
                    $original=$data[$str3];
                   foreach ($value as $key=>$vo) {
                        $list[$key]['url']=$vo;
                        $list[$key]['original']=$original[$key];
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
                return in($value);
                break;
        }
    }

    //检测扩展字段是否必填
    public function content_check($data)
    {
        //获取栏目信息
        $category=model('category')->info($data['cid']);
        if(empty($category['expand'])){
            return;
        }
        //获取扩展模型信息
        $model=$this->info($category['expand']);
        //获取字段列表
        $field_list=$this->field_list($model['mid']);
        if(empty($field_list)){
            return;
        }
        foreach ($field_list as $value) {
            if($value['must']==1){
                if(empty($data[$value['field']])){
                    $this->msg($value['name'].'不能为空！',0);
                }
            }
        }
    }

    //保存内容数据
    public function add_content_save($data,$aid)
    {
        //获取栏目信息
        $category=model('category')->info($data['cid']);
        if(empty($category['expand'])){
            return;
        }
        //获取扩展模型信息
        $model=$this->info($category['expand']);
        //获取字段列表
        $field_list=$this->field_list($model['mid']);
        if(empty($field_list)){
            return;
        }
        $data_save=array();
        foreach ($field_list as $value) {
            $data_save[$value['field']]=$this->field_in($data[$value['field']],$value['type_id'],$value['field'],$data);
        }
        $data_save['aid']=$aid;
        return $this->model->table('expand_content_'.$model['table'])->data($data_save)->insert();
    }

    //编辑内容数据
    public function edit_content_save($data)
    {
        //获取栏目信息
        $category=model('category')->info($data['cid']);
        if(empty($category['expand'])){
            return;
        }
        //获取扩展模型信息
        $model=$this->info($category['expand']);
        //获取字段列表
        $field_list=$this->field_list($model['mid']);
        if(empty($field_list)){
            return;
        }

        $data_save=array();
        foreach ($field_list as $value) {
            $data_save[$value['field']]=$this->field_in($data[$value['field']],$value['type_id'],$value['field'],$data);
        }
        $data_save['aid']=$data['aid'];
		$condition['aid']=$data['aid']; //这里
        if($this->model->table('expand_content_'.$model['table'])->where($condition)->count()){
			//$condition['aid']=$data['aid']; 这句话移动到if上面
            return $this->model->table('expand_content_'.$model['table'])->data($data_save)->where($condition)->update(); 
        }else{
            return $this->model->table('expand_content_'.$model['table'])->data($data_save)->insert();
        }
    }

    //删除内容数据
    public function del_content($aid){
        if(empty($aid)){
            return;
        }
        //获取内容信息
        $content_info=model('content')->info($aid);
        //获取栏目信息
        $category=model('category')->info($content_info['cid']);
        if(empty($category['expand'])){
            return;
        }
        //获取扩展模型信息
        $model=$this->info($category['expand']);
        //删除操作
        $condition['aid']=$aid;
        return $this->model->table('expand_content_'.$model['table'])->where($condition)->delete(); 
        
    }

    
}

?>