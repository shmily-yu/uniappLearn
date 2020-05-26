<template>
	<view class="other-login u-f-ac">
		<!-- #ifdef APP-PLUS || MP-ALIPAY -->
		<block v-for="(item,index) in providerList" :key="index">
			<view class="u-f-ajc u-f1" @tap="tologin(item)">
				<view class="icon iconfont u-f-ajc" 
				:class="['icon-'+item.icon]">
				<!-- #ifdef MP-ALIPAY -->
				支
				<!-- #endif -->
				</view>
			</view>
		</block>
		<!-- #endif -->
		
		<!-- #ifdef MP-WEIXIN -->
		<button type="primary" open-type="getUserInfo" @getuserinfo="mpGetUserInfo">微信登录</button>
		<!-- #endif -->
		
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
			// #ifdef APP-PLUS || MP-ALIPAY
			this.getLoginAuth();
			// #endif
		},
		methods:{
			// #ifdef MP-WEIXIN
			mpGetUserInfo(result) {
				uni.showLoading({ title: '登录中...', mask: true });
				// 获取失败
				if (result.detail.errMsg !== 'getUserInfo:ok') {
					uni.hideLoading();
					uni.showModal({
						title: '获取用户信息失败',
						content: '错误原因' + result.detail.errMsg,
						showCancel: false
					});
					return;
				}
				let userinfo = result.detail.userInfo;
				uni.login({
					provider:"weixin",
					success: (res) => {
						this.MpLogin({
							url:"/wxlogin",
							code:res.code,
							nickName:userinfo.nickName,
							avatarUrl:userinfo.avatarUrl
						})
					},
					complete: () => {
						uni.hideLoading();
					}
				})
			},
			// #endif
			MpLogin(options){
				this.$http.post(options.url,{
					code:options.code,
					nickName:options.nickName,
					avatarUrl:options.avatarUrl
				}).then(data=>{
					let [err2,res2] = data;
					// 登录失败
					if (!this.$http.errorCheck(err2,res2)){
						return false;
					}
					console.log(res2.data.data)
					// 登录成功 保存状态
					this.User.token = res2.data.data.token;
					this.User.userinfo = this.User.__formatUserinfo(res2.data.data);
					// 本地存储
					uni.setStorageSync("userinfo",this.User.userinfo);
					uni.setStorageSync("token", this.User.token);
					// 获取用户相关统计
					if (this.User.userinfo.id) {
						this.User.getCounts();
					}
					// 连接socket
					if (this.User.userinfo.id) {
						this.$chat.Open();
					}
					// 成功提示
					uni.showToast({ title: '登录成功' });
					// 登录成功，重新加载数据
					this.$emit('logining')
					if (!this.noback) {
						uni.navigateBack();
					}
				});
			},
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
								// #ifdef MP-ALIPAY
								case 'alipay':
									providerName = '支付宝登录';
									icon='changyonglogo30';
									break;
								// #endif
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
					// #ifdef MP-ALIPAY
					scopes: 'auth_user',  //支付宝小程序需设置授权类型
					// #endif
					success: (res) => {
						uni.showLoading({
							title: '登陆中...',
							mask: false
						});
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
						console.log(res)
						
						uni.getUserInfo({
						  provider:provider.id,
						  success: (infoRes)=> {
							  console.log(infoRes)
							  //支付宝登录
							  // #ifdef MP-ALIPAY
							  this.MpLogin({
							  	url:"/alilogin",
							  	code:res.code,
							  	avatarUrl:infoRes.userInfo.avatarUrl,
							  	nickName:infoRes.userInfo.nickName
							  })
							  // #endif
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
							// app登录
							// #ifndef MP-ALIPAY
							console.log(JSON.stringify(infoRes.userInfo))
							let data = this.User.__formatOtherLogin(provider.id,Object.assign(infoRes,res));
							this.loginEvent(data);
							// #endif
						  }
						});
						
						// 更新保存在 store 中的登录状态
						console.log('登录成功，保存到本地存储，修改当前用户登录状态')
					},
					fail: (err) => {
						console.log('login fail:', err);
					},
					complete:()=>{
						uni.hideLoading();
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
	font-size: 55upx!important;
	color: #FFFFFF!important;
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
.other-login .icon-changyonglogo30{
	background: #007AFF;
}
</style>
