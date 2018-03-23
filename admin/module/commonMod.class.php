<?php
//公共类
class commonMod
{
    protected $model = NULL; //数据库模型
    protected $layout = NULL; //布局视图
    protected $config = array();
    private $_data = array();

    protected function init(){}
    
    public function __construct(){
        global $config;
         $session_name = session_name();
        if(!isset($_COOKIE[$session_name]))
        {
            foreach($_COOKIE as $key=>$val)
            {
                $key = strtoupper($key);
                if(strpos($key,$session_name))
                {
                  session_id($_COOKIE[$key]);
                }
            }
        }
        @session_start();
        $config['PLUGIN_PATH']=__ROOTDIR__.'/plugins/';
        $this->config = $config;
        $this->model = self::initModel( $this->config);
        $this->init();
        $this->check_login();
        Plugin::init('Admin',$config); 
        $langCon=Lang::langCon();
        $this->config = array_merge((array)$config,(array)$langCon);       
    }


    //初始化模型
    static public function initModel($config){
        static $model = NULL;
        if( empty($model) ){
            $model = new cpModel($config);
        }
        return $model;
    }

    public function __get($name){
        return isset( $this->_data[$name] ) ? $this->_data[$name] : NULL;
    }

    public function __set($name, $value){
        $this->_data[$name] = $value;
    }


    //获取模板对象
    public function view(){
        static $view = NULL;
        if( empty($view) ){
            $view = new cpTemplate( $this->config );
        }
        return $view;
    }
    
    //模板赋值
    protected function assign($name, $value){
        return $this->view()->assign($name, $value);
    }

    //模板显示
    protected function display($tpl = '', $return = false, $is_tpl = true ,$diy_tpl=false){
        if( $is_tpl ){
            $tpl = empty($tpl) ? $_GET['_module'] . '/'. $_GET['_action'] : $tpl;
            if( $is_tpl && $this->layout ){
                $this->__template_file = $tpl;
                $tpl = $this->layout;
            }
        }

        $this->assign("model", $this->model);
        $this->assign('sys', $this->config);
        $this->assign('config', $this->config);
        $this->assign('js', $this->load_js());
        $this->assign('css', $this->load_css());
        $this->assign('user', model('user')->current_user());
        $this->view()->assign( $this->_data );
        return $this->view()->display($tpl, $return, $is_tpl,$diy_tpl);
    }

    //包含内模板显示
    protected function show($tpl = ''){
        $content=$this->display($tpl,true);
        $body=$this->display('index/common',true);
        $html=str_replace('<!--body-->', $content, $body);
        echo $html;
    }

    //脚本运行时间
    public function runtime(){
        $GLOBALS['_endTime'] = microtime(true);
        $runTime = number_format($GLOBALS['_endTime'] - $GLOBALS['_startTime'], 4);
        echo $runTime;
    }


    //判断是否是数据提交 
    protected function isPost(){
        return $_SERVER['REQUEST_METHOD'] == 'POST';
    }

    //登录检测
    protected function check_login() {

        if($_GET['_module']=='login'||substr($_GET['_action'],-6)=='ignore'){
            return true;
        }
        if(!empty($_GET['key'])){
            $key=urldecode($_GET['key']);
            $syskey=$this->config['SPOT'].$this->config['DB_NAME'];
            if($key==$syskey){
                return true;
            }
        }
        $uid=$_SESSION[$this->config['SPOT'].'_user'];
        //读取登录信息
        if(empty($uid)){
            $this->redirect(__APP__ . '/login');
        }
        $user=model('login')->user_info_id($uid);
        if(empty($user)){
            $this->redirect(__APP__ . '/login');
        }
        $this->check_pw($user);
        return true;
    }

    //检测模块权限
    protected function check_pw($user){
        if($user['keep']==1){
            return true;
        }
        
        if(empty($user['model_power'])){
            return true;
        }
        $module=in($_GET['_module']);
        //处理栏目权限
        if(substr($module,-8)=='category'){
            $module='category';
        }
        $info=model('menu')->module_menu($module);
        if(!in_array($info['id'], $user['model_power'])){
            $this->msg('您没有权限进行操作！');
        }
    }

    //直接跳转
    protected function redirect($url)
    {
        header('location:' . $url, false, 301);
        exit;
    }

    //操作成功之后的提示
    protected function success($msg, $url = null)
    {
        if ($url == null)
            $url = 'javascript:history.go(-1);';
        $this->assign('msg', $msg);
        $this->assign('url', $url);
        $this->display('index/msg');
        exit;
    }

    //弹出信息
    protected function alert($msg, $url = NULL){
        header("Content-type: text/html; charset=utf-8"); 
        $alert_msg="alert('$msg');";
        if( empty($url) ) {
            $gourl = 'history.go(-1);';
        }else{
            $gourl = "window.location.href = '{$url}'";
        }
        echo "<script>$alert_msg $gourl</script>";
        exit;
    }

    //判断空值
    public function alert_str($srt,$type=0,$json=false)
    {
        switch ($type) {
            case 'int':
                $srt=intval($srt);
                break;
            default:
                $srt=in($srt);
                break;
        }
        if(empty($srt)){
            if($json){
                $this->msg('内部通讯错误！',0);
            }else{
                $this->alert('内部通讯错误！');
            }
        }
    }

    

    //提示
    public function msg($message,$status=1) {
        if (is_ajax()){
            @header("Content-type:text/html");
            echo json_encode(array('status' => $status, 'message' => $message));
            exit;
        }else{
            $this->success($message);
        } 
    }

    //JSUI库
    public function load_js() {
        $js='';
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/js/jquery.js"></script>' . PHP_EOL;
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/js/duxui.js"></script>' . PHP_EOL;
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/dialog/jquery.artDialog.js?skin=default"></script>' . PHP_EOL;
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/dialog/plugins/iframeTools.js"></script>' . PHP_EOL;
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/kindeditor/kindeditor-min.js"></script>' . PHP_EOL;
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/kindeditor/lang/zh_CN.js"></script>' . PHP_EOL;
        $js .= '<script type=text/javascript src="' . __PUBLICURL__ . '/js/common.js"></script>' . PHP_EOL;
        return $js;
    }
    //CSSUI库
    public function load_css()
    {
        $css='';
        $css .= '<link href="' . __PUBLICURL__ . '/css/base.css" rel="stylesheet" type="text/css" />' . PHP_EOL;
        $css .= '<link href="' . __PUBLICURL__ . '/css/style.css" rel="stylesheet" type="text/css" />' . PHP_EOL;
        $css .= '<link href="' . __PUBLICURL__ . '/kindeditor/themes/default/default.css" rel="stylesheet" type="text/css" />' . PHP_EOL;
        return $css;
    }

    //分页 $url:基准网址，$totalRows: $listRows列表每页显示行数$rollPage 分页栏每页显示的页数
    protected function page($url, $totalRows, $listRows =20, $rollPage = 5)
    {
        $page = new Page();
        return $page->show($url, $totalRows, $listRows, $rollPage);
    }

    //获取分页条数
    protected function pagelimit($url,$listRows)
    {
        $page = new Page();
        $cur_page = $page->getCurPage($url);
        $limit_start = ($cur_page - 1) * $listRows;
        return  $limit_start . ',' . $listRows;
    }

    //插件接口
    public function plus_hook($module,$action,$data=NULL,$return=false)
    {
        $action_name='hook_'.$module.'_'.$action;
        $list=$this->model->table('plugin')->where('status=1')->select();
        $plugin_list=Plugin::get();
        if(!empty($list)){
            foreach ($list as $value) {
                $action_array=$plugin_list[$value['file']];
                if(!empty($action_array)){
                    if(in_array($action_name,$action_array))
                    {
                        if($return){
                            return Plugin::run($value['file'],$action_name,$data,$return);
                        }else{
                            Plugin::run($value['file'],$action_name,$data);
                        }
                    }
                }
            }
        }
    }

        

    //替换插件接口
    public function plus_hook_replace($module,$action,$data=NULL)
    {
        $hook_replace=$this->plus_hook($module,$action,$data,true);
        if(!empty($hook_replace)){
            return $hook_replace;
        }else{
            return $data;
        }
    }

}