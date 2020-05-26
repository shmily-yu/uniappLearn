<template>
	<view class="other-login u-f-ac">
		
		<block v-for="(item,index) in providerList" :key="index">
			<view class="u-f-ajc u-f1" @tap="tologin(item)">
				<view class="icon iconfont u-f-ajc" 
				:class="['icon-'+item.icon]"></view>
			</view>
		</block>
		
	</view>
</template>

<script>
	export default {
		props:{
			noback:{
				type:Boolean,
				default:true
			}
		},
		data() {
			return {
				providerList: []
			}
		},
		onReady() {
			this.getLoginAuth();
		},
		methods:{
			// 获取当前登录渠道
			getLoginAuth(){
				uni.getProvider({
					service: 'oauth',
					success: (result) => {
						this.providerList = result.provider.map((value) => {
							let providerName = '';
							let icon='';
							switch (value) {
								case 'weixin':
									providerName = '微信登录';
									icon='weixin';
									break;
								case 'qq':
									providerName = 'QQ登录';
									icon='QQ';
									break;
								case 'sinaweibo':
									providerName = '新浪微博登录';
									icon='xinlangweibo';
									break;
								case 'alipay':
									providerName = '支付宝登录';
									icon='';
									break;
							}
							return {
								name: providerName,
								icon:icon,
								id: value
							}
						});
						
					},
					fail: (error) => {
						console.log('获取登录通道失败', error);
					}
				});
			},
			// 登录
			tologin(provider) {
				uni.login({
					provider: provider.id,
					success: (res) => {
						/*
						{
							"authResult":{
								"access_token":"21_AugyUhnuM1xV7uyteOB9bwGiYSmTXFNGuRdILKlT__px2-ntmVKOMwpzQS1pZ2OScGfEMTVnEjCEgWBBpPNvdOkxO_oVU5x2MVHvU8iGxbY",
								"expires_in":7200,
								"refresh_token":"21_FnpsnuNn7LdtFr3rrwFE6djQwFmtfovPMWCT0oOgRivR3hC7AVPxn6i4n2koYWzQpnWnYF5NPMMtk4_RDX5DMJ0JVD1I3Kj4HPVQFGDcRmc",
								"openid":"oRrdQt3HS3Ns2TFCVLMOyxbR9DcM",
								"scope":"snsapi_userinfo",
								"unionid":"oU5Yytz7ielo7Xw00LMgZsPeSDkQ"
							},
							"errMsg":"login:ok"
						}
						*/
						console.log(JSON.stringify(res))
						
						uni.getUserInfo({
						  provider:provider.id,
						  success: (infoRes)=> {
							  /*
							  * {
							  	"openId":"oRrdQt3HS3Ns2TFCVLMOyxbR9DcM",
							  	"nickName":"楚绵",
							  	"gender":1,
							  	"city":"北帕默斯顿",
							  	"province":"北部地区",
							  	"country":"澳大利亚",
							  	"avatarUrl":"http://thirdwx.qlogo.cn/mmopen/vi_32/WiaWkkJjnG4WhI2KERDGPanF9GlNM3SWDTibibKEuHru1Jrd4pfGwialjn5tTCVLvEOq8RnZ8QmqkxyNAYXtuuGcBg/132",
							  	"unionId":"oU5Yytz7ielo7Xw00LMgZsPeSDkQ"
							  },
							  * 
							  * */
							console.log(JSON.stringify(infoRes.userInfo))
							let data = this.User.__formatOtherLogin(provider.id,Object.assign(infoRes,res));
							this.loginEvent(data);
						  }
						});
						
						// 更新保存在 store 中的登录状态
						console.log('登录成功，保存到本地存储，修改当前用户登录状态')
					},
					fail: (err) => {
						console.log('login fail:', err);
					}
				});
			},
			async loginEvent(data){
				let res = await this.User.login({
					url:'/user/otherlogin',
					data:data,
					Noback:this.noback
				});
				if (res) {
					// 登录成功，重新加载数据
					this.$emit('logining')
				}
			}
		}
	}
</script>

<style>
.other-login{
	padding: 20upx 80upx;
}
.other-login>view>view{
	width: 100upx;
	height: 100upx;
	border-radius: 100%;
	font-size: 55upx;
	color: #FFFFFF;
}
.other-login .icon-QQ{
	background: #2CAEFC;
}
.other-login .icon-weixin{
	background: #2BD19B;
}
.other-login .icon-xinlangweibo{
	background: #FC7729;
}
</style>
