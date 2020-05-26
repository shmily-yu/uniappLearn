<?php

namespace app\index\controller;

use think\Controller;
use think\Request;
use app\lib\exception\BaseException;

class Index extends Controller
{

    public function index()
    {

        throw new BaseException(['msg'=>'验证失败']);

        return "111";
    }

}
