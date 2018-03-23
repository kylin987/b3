<?php
if(file_exists('../data/install.lock'))
{
	header("location:../");
}
if(@$_GET['action']=='test_data'){
	$link=@mysql_connect($_POST['DB_HOST'].':'.$_POST['DB_PORT'],$_POST['DB_USER'],$_POST['DB_PWD']);
	if(!$link){
		echo '数据库连接失败，请检查连接信息是否正确！';
		return;
	}
	if($_POST['create']==1){
		echo 1;
		return;
	}
	$status=@mysql_select_db($_POST['DB_NAME'],$link);
	if($status){
		echo 1;
	}else{
		echo '数据库连接成功，请先建立数据库！';
	}
	return;
}
class GetChar{
function getCode ($length = 5, $mode = 0){
    switch ($mode) {
    default:
    $str = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    break;
    }

    $result = '';
    $l = strlen($str)-1;
    $num=0;

    for($i = 0;$i < $length;$i ++){
        $num = rand(0, $l);
        $a=$str[$num];
        $result =$result.$a;
    }
return $result.'_';
}
}

$code = new GetChar;

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DUXCMS安装向导</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script src="../public/js/jquery.js"></script>
</head>

<body>
<form action="install.php" method="post" name="form" id="form">
<div id="install" class="data">
  <h1>DUXCMS安装配置</h1>
  <div class="content">
    <div class="list">
      <div class="name">数据库地址：</div>
      <div class="value"><input type="text" class="input" name="DB_HOST" id="DB_HOST" value="localhost" onblur="test_data()" /></div>
    </div>
    <div class="list">
      <div class="name">数据库端口：</div>
      <div class="value"><input type="text" class="input" name="DB_PORT" id="DB_PORT" value="3306" onblur="test_data()" /></div>
    </div>
    <div class="list">
      <div class="name">数据库名称：</div>
      <div class="value"><input type="text" class="input" name="DB_NAME" id="DB_NAME" value="duxcms"  onblur="test_data()" /> </div>
      <div class="tip"> <input name="create" type="checkbox" id="create" value="1" checked="checked" onclick="test_data()" />自动创建</div>
    </div>
    <div class="list">
      <div class="name">数据库用户名：</div>
      <div class="value"><input type="text" class="input" name="DB_USER" id="DB_USER" value="root"  onblur="test_data()" /></div>
    </div>
    <div class="list">
      <div class="name">数据库密码：</div>
      <div class="value"><input type="text" class="input" name="DB_PWD" id="DB_PWD" value="" onblur="test_data()" /></div>
    </div>
    <div class="list">
    <div class="name">数据库状态：</div><div class="msg" style="float:left;"><span style="color:#666">等待检测中...</span></div>
    </div>
    <div class="list">
      <div class="name">数据表前缀：</div>
      <div class="value"><input type="text" class="input" name="DB_PREFIX"  value="dc_" id="DB_PREFIX" /></div>
    </div>
    <div class="list">
      <div class="name">安全加密码：</div>
      <div class="value"><input type="text" class="input" name="spot" value="<?php echo $code->getCode(); ?>" /></div>
    </div>
    <div class="list">
      <div class="name">安装测试数据：</div>
      <div class="value"><input name="test" type="checkbox" id="test" value="1" /></div>
    </div>
    
  </div>
  <div class="menu">
    <input name="KEY" id="KEY" type="hidden" value="<?php echo $code->getCode(10); ?>" />
    <button type="button" class="submit" onclick="ins_form();" >准备完毕进入安装</button>
  </div>
</div>
</form>
</body>
<script>
function ins_form(){
	test_data();
	if($('#test_conn').val()==0){
		return false();
	}else{
		$("form").submit();
	}
}

function test_data(){
	 val=$('#create').attr("checked");
     if(val){
		 create=1;
     }else{
     	create=0;
     } 
	 $.post(
	 'data.php?action=test_data',
	 {
		 DB_HOST:$('#DB_HOST').val(),
		 DB_PORT:$('#DB_PORT').val(),
		 DB_NAME:$('#DB_NAME').val(),
		 DB_USER:$('#DB_USER').val(),
		 DB_PWD:$('#DB_PWD').val(),
		 create:create
	 },
	 function(html){
		 if(html==1){
			 $('.msg').html('<span style="color:green">数据库连接成功</span>');
			 $('#test_conn').val('1');
		 }else{
			 $('.msg').html('<span style="color:red">'+html+'</span>');
			 $('#test_conn').val('0');
		 }
	 },'html');
}

</script>
</html>
