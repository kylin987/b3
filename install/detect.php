<?php 
if(file_exists('../data/install.lock'))
{
	header("location:../");
}

function file_mode_info($file_path)
{
    if (!file_exists($file_path))
    {
        return false;
    }
    $mark = 0;
    if (strtoupper(substr(PHP_OS, 0, 3)) == 'WIN')
    {
        $test_file = $file_path . '/cf_test.txt';
        if (is_dir($file_path))
        {
            $dir = @opendir($file_path);
            if ($dir === false)
            {
                return $mark;
            }
            if (@readdir($dir) !== false)
            {
                $mark ^= 1;
            }
            @closedir($dir);
            $fp = @fopen($test_file, 'wb');
            if ($fp === false)
            {
                return $mark; 
            }
            if (@fwrite($fp, 'directory access testing.') !== false)
            {
                $mark ^= 2;
            }
            @fclose($fp);
            @unlink($test_file);
            $fp = @fopen($test_file, 'ab+');
            if ($fp === false)
            {
                return $mark;
            }
            if (@fwrite($fp, "modify test.\r\n") !== false)
            {
                $mark ^= 4;
            }
            @fclose($fp);
            if (@rename($test_file, $test_file) !== false)
            {
                $mark ^= 8;
            }
            @unlink($test_file);
        }
        elseif (is_file($file_path))
        {
            $fp = @fopen($file_path, 'rb');
            if ($fp)
            {
                $mark ^= 1;
            }
            @fclose($fp);
            /* 试着修改文件 */
            $fp = @fopen($file_path, 'ab+');
            if ($fp && @fwrite($fp, '') !== false)
            {
                $mark ^= 6;
            }
            @fclose($fp);
            if (@rename($test_file, $test_file) !== false)
            {
                $mark ^= 8;
            }
        }
    }
    else
    {
        if (@is_readable($file_path))
        {
            $mark ^= 1;
        }
        if (@is_writable($file_path))
        {
            $mark ^= 14;
        }
    }
    return $mark;
}

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
<div id="install">
  <h1>DUXCMS安装环境测试</h1>
  <div class="content">
    <div class="title">系统所需功能支持检测</div>
    <div class="list">
      <div class="name">图像处理：</div>
      <div class="value"> <span class="load" id="image">&nbsp;</span> </div>
    </div>
    <div class="list">
      <div class="name">远程获取：</div>
      <div class="value"> <span class="load" id="getfile">&nbsp;</span> </div>
    </div>
    <div class="list">
      <div class="name">ZIP解压：</div>
      <div class="value"> <span class="load" id="zip">&nbsp;</span> </div>
    </div>
    <div class="title">系统所需目录权限</div>
    <span id="dir" class="load">
    
    </span>
  </div>
  <div class="menu">
    <button type="button" class="submit" onclick="window.location.href='data.php'">准备完毕进入安装</button>
  </div>
</div>
</body>
<script>
test_image();
function test_image(){
	setTimeout(function(){
		<?php if (function_exists("imageline")==1){
			echo "$('#image').html('<font color=green><b>√</b></font>');";
		} else {
			echo "$('#image').html('<font color=green><b>×</b></font>');";
		} ?>
		$('#image').removeClass('load');
		test_getfile();
	},200);
}
function test_getfile(){
	setTimeout(function(){
		<?php
	 if (function_exists("curl_init")==1){
		echo "$('#getfile').html('<font color=green><b>√</b></font>');";
		} else if (function_exists("fsockopen")==1){
		echo "$('#getfile').html('<font color=green><b>√</b></font>');";
	 	}else{
		echo "$('#getfile').html('<font color=green><b>×</b></font>');";
		}
	  ?>
		$('#getfile').removeClass('load');
		test_zip();
	},200);
}
function test_zip(){
	setTimeout(function(){
		<?php if (function_exists("zip_open")==1){
			echo "$('#zip').html('<font color=green><b>√</b></font>');";
		} else {
			echo "$('#zip').html('<font color=green><b>×</b></font>');";
		} ?>
		$('#zip').removeClass('load');
		test_dir();
	},200);
}
function test_dir(){
	setTimeout(function(){
		html='';
		<?php
  		$dir=array('data','inc','upload');
  		foreach ($dir as $value) { ?>
		html+='<div class="list">';
      	html+='<div class="name"><?php echo $value; ?></div>';
    	<?php if(file_mode_info('../'.$value.'/')>11){
   		?>
		html+='<div class="value"><font color=green><b>√</b></font></div>';
		<?php }else{ ?>
		html+='<div class="value"><font color=red><b>x</b></font></div>';
		<?php } ?>
		html+='</div>';
		<?php } ?>
		$('#dir').html(html);
  
		$('#dir').removeClass('load');
	},200);
}
</script>
</html>
