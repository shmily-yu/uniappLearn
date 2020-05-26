<?php

namespace app\common\model;

use think\Model;

class Post extends Model
{
    // 自动写入时间戳
    protected $autoWriteTimestamp = true;

    // 关联图片表
    public function images(){
        return $this->belongsToMany('Image','post_image');
    }

    // 关联顶踩表
    public function support(){
        return $this->hasMany('Support');
    }

    // 发布文章
    public function createPost(){
        // 获取所有参数
        $params = request()->param();
        $userModel = new User();
        // 获取用户id
        $user_id = request()->userId;
        $currentUser = $userModel->get($user_id);
        $path = $currentUser->userinfo->path;
        // 发布文章
        $title = mb_substr($params['text'],0,30);
        $post = $this->create([
            'user_id'=>$user_id,
            'title'=>$title,
            'titlepic'=>'',
            'content'=>$params['text'],
            'path'=>$path ? $path : '未知',
            'type'=>0,
            'post_class_id'=>$params['post_class_id'],
            'share_id'=>0,
            'isopen'=>$params['isopen']
        ]);
        // 关联图片
        $imglistLength = count($params['imglist']);
        if($imglistLength > 0){
            $ImageModel = new Image();
            $imgidarr = [];
            for ($i=0; $i < $imglistLength; $i++) { 
                // 验证图片是否存在，是否是当前用户上传的
                if ($ImageModel->isImageExist($params['imglist'][$i]['id'],$user_id)) {
                    $imgidarr[] = $params['imglist'][$i]['id'];
                }
            }
            // 发布关联
            if(count($imgidarr)>0) $post->images()->attach($imgidarr,['create_time'=>time()]);
        }
        // 返回成功
        return true;
    }

    // 关联用户表
    public function user(){
        return $this->belongsTo('User');
    }

    // 关联分享
    public function share(){
        return $this->belongsTo('Post','share_id','id');
    }

    // 获取文章详情
    public function getPostDetail(){
        // 获取所有参数
        $param = request()->param();
        return $this->with(['user'=>function($query){
            return $query->field('id,username,userpic');
        },'images'=>function($query){
            return $query->field('url');
        },'share'])->find($param['id']);
    }

    // 根据标题搜索文章
    public function Search(){
        // 获取所有参数
        $param = request()->param();
        return $this->where('title','like','%'.$param['keyword'].'%')->with(['user'=>function($query){
            return $query->field('id,username,userpic');
        },'images'=>function($query){
            return $query->field('url');
        },'share'])->page($param['page'],10)->select();
    }

    // 关联评论
    public function comment(){
        return $this->hasMany('Comment');
    }

    // 获取评论
    public function getComment(){
        $params = request()->param();
        return self::get($params['id'])->comment()->with([
            'user'=>function($query){
                return $query->field('id,username,userpic');
            }
        ])->select();
    }

}
