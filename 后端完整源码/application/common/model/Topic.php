<?php

namespace app\common\model;

use think\Model;

class Topic extends Model
{
    // 获取热门话题列表
    public function gethotlist(){
        return $this->where('type',1)->limit(10)->select()->toArray();
    }

    // 关联文章
    public function post(){
        return $this->belongsToMany('Post','topic_post');
    }

    // 获取指定话题下的文章（分页）
    public function getPost(){
        // 获取所有参数
        $param = request()->param();
        return self::get($param['id'])->post()->with(['user'=>function($query){
            return $query->field('id,username,userpic');
        },'images'=>function($query){
            return $query->field('url');
        },'share'])->page($param['page'],10)->select();
    }

    // 根据标题搜索话题
    public function Search(){
        // 获取所有参数
        $param = request()->param();
        return $this->where('title','like','%'.$param['keyword'].'%')->page($param['page'],10)->select();
    }

}
