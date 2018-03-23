<?php 
if(file_exists('../data/install.lock'))
{
	header("location:../");
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DUXCMS安装向导</title>

<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="install">
	<h1>DUXCMS使用协议</h1>
    <div class="content">
    

版权所有(C) 2011-2013 DUXCMS保留所有权利。<br />
为了保证您和他人的利益请遵循以下几条使用规则：<br />
1、您可以完全遵循本协议的情况下，将本软件用于商业用途，而不必支付软件的使用费用，但我们也不承诺对非赞助用户提供任何形式的技术支持与帮助。<br />
2、使用本程序您可以不用在明显页面保留程序版权信息，但程序最终版权贵原作者所有，为了程序能持续发展建议您在网站底部注明：powered by duxcms.com ，另外我们可能不会对不保留版权信息的用户提供帮助。<br />
3、您可以免费使用本软件，但是禁止对软件进行改名发布，禁止以任何形式对DUXCMS形成竞争。<br />
4、您可以对程序进行二次开发，但是二次开发后的软件也禁止公开发布，可以自己分配使用版权参考第三条。<br />
5、非赞助用户我们可能不会提供程序方面支持与改写。<br />
    </div>
    <div class="menu">
    	<button type="button" onclick="no()">不同意</button>
        <button type="button" class="submit" onclick="window.location.href='detect.php'">同意</button>
    </div>
</div>
</body>
<script>
function no(){
	alert('感谢您对DUXCMS的支持！');
	window.close();
}
</script>
</html>
