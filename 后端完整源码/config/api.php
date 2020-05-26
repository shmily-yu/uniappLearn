<?php

return [
    // token过期时间
    'token_expire'=>0,
    // 阿里大于
    'aliSMS'=>[
        'isopen'=> false,//开启阿里大于
        'accessKeyId'=>'<accessKeyId>',
        'accessSecret'=>'<accessSecret>',
        'regionId'=>'cn-hangzhou',
        'product'=>'Dysmsapi',
        'version'=>'2017-05-25',
        'SignName'=>'<YourSignName>',
        'TemplateCode'=>'<YourTemplateCode>',
        // 验证码有效期
        'expire'=>60
    ]
];