<template>
	<view>
		<template v-if="!islogin">
			<!-- 未登录 -->
			<view class="u-f-ajc">登陆仿糗百，体验更多功能</view>
			<!-- 第三方登陆 -->
			<view class="other-login u-f-ac">
				<view class="u-f-ajc u-f1"><view class="icon iconfont icon-weixin u-f-ajc"></view></view>
				<view class="u-f-ajc u-f1"><view class="icon iconfont icon-xinlangweibo u-f-ajc"></view></view>
				<view class="u-f-ajc u-f1"><view class="icon iconfont icon-QQ u-f-ajc"></view></view>
			</view>
			<!-- 账号密码登陆 -->
			<view class="u-f-ajc">账号密码登陆 <view class="icon iconfont icon-jinru"></view> </view>
		</template>
		
		<!-- 登陆 -->
		<view class="home-info u-f-ac">
			<image src="../../static/demo/userpic/11.jpg" mode="widthFix" lazy-load></image>
			<view class="u-f1">
				<view>昵称</view>
				<view>总访客 0  今日 0</view>
			</view>
			<view class="icon iconfont icon-jinru"></view>
		</view>
		
		<!-- 数据 -->
		<view class="home-data u-f-ac">
			<view class="u-f1 u-f-ajc u-f-column"><view>0</view>糗事</view>
			<view class="u-f1 u-f-ajc u-f-column"><view>0</view>动态</view>
			<view class="u-f1 u-f-ajc u-f-column"><view>0</view>评论</view>
			<view class="u-f1 u-f-ajc u-f-column"><view>0</view>收藏</view>
		</view>
		<!-- 广告位 -->
		<view class="home-adv u-f-ajc" >
			<image src="../../static/demo/demo20.jpg" mode="widthFix" lazy-load></image>
		</view>
		<!-- 功能列表 -->
		<view class="home-list">
			<view class="home-list-item u-f-ac u-f-jsb" hover-class="home-list-hover">
				<view class="u-f-ac">
					<view class="icon iconfont icon-liulan"></view>浏览历史
				</view>
				<view class="icon iconfont icon-jinru"></view>
			</view>
		</view>
		
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				islogin:true
			};
		},
		onNavigationBarButtonTap(e) {
			if(e.index==0){
				console.log("跳转设置页")
			}
		}
	}
</script>

<style>
.home-info{
	padding: 20upx 40upx;
}
.home-info>image{
	flex-shrink: 0;
	width: 100upx;
	height: 100upx;
	border-radius: 100%;
	margin-right: 15upx;
}
.home-info>view:first-of-type>view:first-child{
	font-size: 32upx;
}
.home-info>view:first-of-type>view:last-child{
	color: #BBBBBB;
}
.home-info>view:last-of-type{
	height: 100%;
}

.home-list{
	padding: 20upx;
}
.home-list-item{
	padding: 20upx;
	border-top: 1upx solid #EEEEEE;
	border-bottom: 1upx solid #EEEEEE;
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
.home-data{
	padding: 20upx 40upx;
}
.home-data>view{
	color: #989898;
}
.home-data>view>view{
	font-size: 32upx;
	color: #333333;
}
.home-adv{
	padding: 20upx;
}
.home-adv>image{
	border-radius: 20upx;
	height: 150upx;
}
</style>
