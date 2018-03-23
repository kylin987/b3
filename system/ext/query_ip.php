
<?php

function getIPLoc($queryIP)
{

    $url = 'http://ip.qq.com/cgi-bin/searchip?searchip1=' . $queryIP;

    $ch = curl_init($url);

    curl_setopt($ch, CURLOPT_ENCODING, 'gb2312');

    curl_setopt($ch, CURLOPT_TIMEOUT, 10);

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // 获取数据返回

    $result = curl_exec($ch);

    $result = mb_convert_encoding($result, "utf-8", "gb2312"); // 编码转换，否则乱码

    curl_close($ch);

    preg_match("@<span>(.*)</span></p>@iU", $result, $ipArray);

    $loc = $ipArray[1];

    return $loc;

}

?>