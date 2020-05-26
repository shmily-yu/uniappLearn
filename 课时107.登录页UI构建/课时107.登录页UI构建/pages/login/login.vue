<template>
	<view>
		<!-- 状态栏 -->
		<uni-status-bar bgcolor="#FFE933"></uni-status-bar>
		<!-- 关闭按钮 -->
		<view class="icon iconfont icon-guanbi" @tap="back"></view>
		<!-- 引入背景图 -->
		<image class="loginhead" src="../../static/common/loginhead.png" mode="widthFix" lazy-load></image>
		<!-- 输入框+按钮 -->
		<view class="body">
			<!-- <input type="text"
			class="uni-input common-input"
			placeholder="昵称/手机号/邮箱" />
			
			<view class="login-input-box">
				<input type="text"
				class="uni-input common-input forget-input"
				placeholder="请输入密码" />
				<view class="forget u-f-ajc login-font-color">忘记密码</view>
			</view> -->
			
			<view class="login-input-box">
				<view class="phone u-f-ajc">+86</view>
				<input type="text"
				class="uni-input common-input phone-input"
				placeholder="手机号" />
			</view>
			<view class="login-input-box">
				<input type="text"
				class="uni-input common-input forget-input"
				placeholder="请输入验证码" />
				<view class="forget u-f-ajc login-font-color yanzhengma">
					<view class="u-f-ajc">获取验证码</view>
				</view>
			</view>
			
			<button class="user-set-btn" 
			:loading="loading" :class="{'user-set-btn-disable':disabled}" 
			type="primary" @tap="submit" :disabled="disabled">登录</button>
		</view>
		
		<!-- 登录状态切换 -->
		<view class="login-status u-f-ajc login-padding login-font-color">
			验证码登录<view class="icon iconfont icon-jinru login-font-color"></view>
		</view>
		
		<!-- 第三方登陆 -->
		<view class="other-login-title u-f-ajc login-padding login-font-color">第三方登录</view>
		<other-login></other-login>
		
		<!-- 协议 -->
		<view class="login-rule u-f-ajc login-padding login-font-color">
			注册即代表您同意<view>《XXX协议》</view>
		</view>
		
	</view>
</template>

<script>
	import uniStatusBar from "../../components/uni-status-bar/uni-status-bar.vue";
	import otherLogin from "../../components/home/other-login.vue";
	export default {
		components:{
			uniStatusBar,
			otherLogin
		},
		data() {
			return {
				disabled:true,
				loading:false
			}
		},
		methods: {
			// 返回上一步
			back(){
				console.log("返回上一步")
			},
			// 提交登录
			submit(){
				console.log("提交登录")
			}
		}
	}
</script>

<style>
@import "../../common/form.css";
.login-font-color{ color: #BBBBBB; }
.login-padding{ padding: 20upx 0; }
.icon-guanbi{
	position: fixed;
	top: 60upx;
	left: 30upx;
	font-size: 40upx;
	font-weight: bold;
	color: #332F0A;
}
.loginhead{ width: 100%; }
.other-login-title{
	position: relative;
}
.other-login-title:before,.other-login-title:after{
	content: "";
	position: absolute;
	background: #BBBBBB;
	height: 1upx;
	width: 100upx;
	top: 50%;
}
.other-login-title:before{
	left: 25%;
}
.other-login-title:after{
	right: 25%;
}
.login-input-box{
	position: relative;
}
.login-input-box .forget-input{
	padding-right: 150upx;
}
.login-input-box .forget,.login-input-box .phone{
	position: absolute;
	top: 0;
	height: 100%;
	z-index: 100;
}
.login-input-box .forget{
	width: 150upx;
	right: 0;
}
.login-input-box .phone{
	width:100upx;
	left: 0;
	font-weight: bold;
}
.login-input-box .phone-input{
	padding-left: 100upx;
}
.yanzhengma view{
	background: #EEEEEE;
	border-radius: 10upx;
	font-size: 25upx;
	width: 150upx;
	padding: 10upx 0;
}
</style>
