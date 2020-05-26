<?php

namespace app\index\controller;

use think\Controller;
use think\Request;
use app\lib\exception\BaseException;
use app\common\validate\CeshiValidate;

class Index extends Controller
{
    // 账号密码登录
    public function index()
    {
        (new CeshiValidate())->goCheck();
        return "111";
    }

}
