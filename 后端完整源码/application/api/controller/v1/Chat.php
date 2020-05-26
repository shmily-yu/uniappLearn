<?php

namespace app\api\controller\v1;

use think\Controller;
use think\Request;
use app\common\controller\BaseController;
use app\common\validate\ChatValidate;
use GatewayWorker\Lib\Gateway;
use think\facade\Cache;

class Chat extends BaseController
{

    // 初始化registerAddress
    public function __construct(){
        Gateway::$registerAddress = config('gateway_worker.registerAddress');
    }


    // 接收未接收信息
    public function get(Request $request){
        // 判断当前用户是否在线
        if (!Gateway::isUidOnline($request->userId)) return;
        // 获取并清除所有未接收信息
        $Cache = Cache::pull('userchat_'.$request->userId);
        if (!$Cache || !is_array($Cache)) return;
        // 开始推送
        return self::showResCode('ok',$Cache);
    }

    // 发送信息
    public function send(Request $request){
        // 1. 验证数据是否合法
        (new ChatValidate)->goCheck('send');
        // 2. 组织数据
        $data = $this->resdata($request);
        $to_id = $request->to_id;
        // 3. 验证对方用户是否在线
        if (Gateway::isUidOnline($to_id)) {
            // 直接发送
            Gateway::sendToUid($to_id,json_encode($data));
            // 写入数据库
            // 返回发送成功
            return self::showResCodeWithOutData('ok');
        }
        // 不在线，写入消息队列
        // 获取之前消息
        $Cache = Cache::get('userchat_'.$to_id);
        if (!$Cache || !is_array($Cache)) $Cache = [];
        $Cache[] = $data;
        // 写入数据库
        // 写入消息队列（含id）
        Cache::set('userchat_'.$to_id,$Cache);
        return self::showResCodeWithOutData('ok',200);
    }


    // 组织数据
    public function resdata($request){
        return [
            'to_id'=>$request->to_id,
            'from_id'=>$request->userId,
            'from_userpic'=>$request->from_userpic,
            'type'=>$request->type,
            'data'=>$request->data,
            'time'=>time()
        ];
    }

}
