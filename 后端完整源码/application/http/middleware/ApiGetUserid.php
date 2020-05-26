<?php

namespace app\http\middleware;

class ApiGetUserid
{
    public function handle($request, \Closure $next)
    {
        // 获取头部信息
        $param = $request->header();
        if (array_key_exists('token',$param)){
            $user = \Cache::get($param['token']);
            if ($user) {
                $request->userId = array_key_exists('type',$user) ? $user['user_id'] : $user['id'];
            }
        }
        return $next($request);
    }
}
