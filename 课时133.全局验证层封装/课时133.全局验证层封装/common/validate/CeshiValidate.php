<?php

namespace app\common\validate;

use think\Validate;

class CeshiValidate extends BaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
        'username'=>'require',
        'email'=>'require|email'
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'username.require'=>'用户名不能为空',
        'email.require'=>'邮箱不能为空',
        'email.email'=>'邮箱格式不正确',
    ];

    protected $scene = [
        'login'=>['email']
    ];
}
