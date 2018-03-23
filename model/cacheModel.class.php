<?php
class cacheModel extends commonMod
{
    public function __construct()
    {
        parent::__construct();
    }

    //清除html缓存
    public function clear_html($url)
    {
        $config=cpConfig::get('APP');
        cpHtmlCache::refresh($config['HTML_CACHE_PATH'],$url);
    }

}

?>