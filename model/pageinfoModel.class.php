<?php
class  pageinfoModel extends commonMod {

	public function __construct()
    {
        parent::__construct();
    }

    public function media($title='',$keywords='',$description='') {

        if(empty($title)){
            $title=$this->config['sitename'];
        }else{
            $title=$title.' - '.$this->config['sitename'];
        }
        if(empty($keywords)){
            $keywords=$this->config['keywords'];
        }
        if(empty($description)){
            $description=$this->config['description'];
        }
        return array(
            'title'=>$title,
            'keywords'=>$keywords,
            'description'=>$description,
            );
    }


}