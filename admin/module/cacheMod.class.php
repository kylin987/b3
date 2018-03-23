<?php
//缓存处理
class cacheMod extends commonMod {

	public function __construct()
    {
        parent::__construct();
    }

    //删除模板缓存
    public function clear_tpl()
    {
        model('cache')->clear_tpl();
        $this->msg('删除模板缓存成功!');
    }

    //删除html缓存
    public function clear_html()
    {
        model('cache')->clear_html();
        $this->msg('删除HTML缓存成功! ');
    }

    //删除数据缓存
    public function clear_data()
    {
        model('cache')->clear_data();
        $this->msg('删除数据缓存成功! ');
    }

    //删除所有缓存
    public function clear_all()
    {
    	model('cache')->clear_all();
        $this->msg('已经删除所有缓存! ');
    }

}