<?php

namespace app\common\model;

use think\Model;
use think\facade\Cache;
use app\lib\exception\BaseException;

class User extends Model
{
    //发送验证码
    public function sendCode(){
        // 获取用户提交手机号码
        $phone = request()->param('phone');
        // 判断是否已经发送过
        if(Cache::get($phone)) throw new BaseException(['code'=>200,'msg'=>'你操作得太快了','errorCode'=>30001]);
        // 生成4位验证码
        $code = random_int(1000,9999);
        // 发送验证码
        // $res = AlismsController::SendSMS($phone,$code);
        //发送成功 写入缓存
        // if($res['Code']=='OK') return Cache::set($phone,$code,config('api.alisms.expire'));
        // 模拟发送验证码
        Cache::set($phone,$code,60);
        throw new BaseException(['code'=>200,'msg'=>'验证码：'.$code,'errorCode'=>30005]);
        // 发送失败
        throw new BaseException(['code'=>200,'msg'=>'发送失败','errorCode'=>30004]);
    }
}
