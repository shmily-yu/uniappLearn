<template>
	<view class="home-list-item u-f-ac u-f-jsb animated fadeIn fast" 
	hover-class="home-list-hover"
	@tap="clickevent">
		<view class="u-f-ac">
			<view v-if="item.icon"
			class="icon iconfont"
			:class="['icon-'+item.icon]"></view>
			{{item.name}}
		</view>
		<view class="icon iconfont" :class="{'icon-jinru':!item.data}">{{item.data || ''}}</view>
	</view>
</template>

<script>
	export default {
		props:{
			item:Object,
			index:Number
		},
		methods:{
			clickevent(){
				switch (this.item.clicktype){
					case "navigateTo":
					if(this.item.url){
						let option = { url:this.item.url};
						if (this.item.auth) {
							if (this.item.NoCheck) {
								return this.User.navigate(option,true);
							}
							return this.User.navigate(option);
						}
						uni.navigateTo(option);
					}
						break;
					case "switchTab":
					if(this.item.url){ uni.switchTab({url:this.item.url}) }
						break;
					case "clear":
					uni.showModal({
						title: '提示',
						content: '是否要清除缓存？',
						confirmText: '立刻清除',
						success: res => {
							if(res.confirm){
								uni.clearStorage();
								uni.showToast({ title: '清除缓存成功！'});
								this.User.logout(false)
							}
						},
					});
						break;
					case "bind":
					if (this.User.userbind[this.item.provider]) return;
					this.bindother();
						break;
					case "nothing":
					uni.showToast({ title: '更新中...', icon: 'none' });
						break;
					case "update":
					this.lib.Update(true);
						break;
				}
			},
			// 绑定第三方登录
			bindother(){
				uni.login({
					provider: this.item.provider,
					// #ifdef MP-ALIPAY
					scopes: 'auth_user',  //支付宝小程序需设置授权类型
					// #endif
					success: (res) => {
						uni.getUserInfo({
						  provider:this.item.provider,
						  success: (infoRes)=> {
							let options = Object.assign(infoRes,res);
							this.bindEvent(this.User.__formatOtherLogin(this.item.provider,options));
						  }
						});
					},
					fail: (err) => {
						uni.showToast({ title: '绑定失败',icon:"none" });
						console.log('login fail:', err);
					}
				});
			},
			async bindEvent(data){
				uni.showLoading({ title: '绑定中...', mask: false });
				let [err,res] = await this.$http.post("/user/bindother",data,{
					token:true,
					checkToken:true
				})
				if (!this.$http.errorCheck(err,res)) return uni.hideLoading();
				// 绑定成功
				uni.hideLoading();
				uni.showToast({ title: '绑定成功！' });
				// 修改状态，缓存
				this.User.userbind[this.item.provider] = {
					nickname:data.nickName
				}
				uni.setStorageSync("userbind", this.User.userbind);
				this.$emit('updateuserbind');
			}
		}
	}
</script>

<style scoped>
.home-list-item{
	padding: 20upx;
	border-top: 1upx solid #F4F4F4;
	border-bottom: 1upx solid #F4F4F4;
}
.home-list-item>view:first-child{
	color: #333333;
}
.home-list-item>view:first-child>view{
	margin-right: 10upx;
}
.home-list-item>view:last-child{
	color: #CCCCCC;
}
.home-list-hover{
	background: #f4f4f4;
}
</style>
