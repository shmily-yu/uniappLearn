<template>
	<view>
		<view class="body">
			<block v-for="(item,index) in list" :key="index">
				<home-list-item :item="item"
				:index="index" @updateuserbind='__init()' ></home-list-item>
			</block>
		</view>
	</view>
</template>

<script>
	import homeListItem from "../../components/home/home-list-item.vue";
	export default {
		components:{
			homeListItem
		},
		data() {
			return {
				list:[]
			}
		},
		onShow(){
			this.__init();
		},
		methods: {
			async __init(){
				// 获取当前用户绑定情况
				this.list = [
					{ icon:"",name:"手机号",clicktype:"navigateTo",url:"../../pages/user-bind-phone/user-bind-phone?phone="+this.User.userinfo.phone || false ,data:this.User.userinfo.phone || "未绑定" },
					{ icon:"",name:"登录密码",clicktype:"navigateTo",url:"../../pages/user-set-repassword/user-set-repassword?password="+this.User.userinfo.password ,data:this.User.userinfo.password ? "修改密码" : "未设置"},
					{ icon:"",name:"邮箱绑定",clicktype:"navigateTo",url:"../../pages/user-set-email/user-set-email?email="+this.User.userinfo.email || false ,data:this.User.userinfo.email || "未绑定"}
				]
				// #ifdef APP-PLUS
				// 获取当前用户第三方登录绑定情况
				let arr = [
					{ icon:"",name:"微信账号",clicktype:"bind",url:"" ,data:"未绑定" ,provider:"weixin"},
					{ icon:"",name:"微博账号",clicktype:"bind",url:"" ,data:"未绑定",provider:"sinaweibo"},
					{ icon:"",name:"QQ账号",clicktype:"bind",url:"" ,data:"未绑定",provider:"qq"},
				];
				if (!this.User.userbind) {
					await this.User.getUserBind();
				} 
				/*
				* {
						"weixin": {
							"id": 7,
							"nickname": "楚绵1111"
						},
					   "qq": {
							"id": 7,
							"nickname": "楚绵1111"
						},
						"sinawebo": {
							"id": 7,
							"nickname": "楚绵1111"
						}
					}
				* **/
				arr[0].data = this.User.userbind.weixin ? this.User.userbind.weixin.nickname : "未绑定";
				arr[1].data = this.User.userbind.sinaweibo ? this.User.userbind.sinaweibo.nickname : "未绑定";
				arr[2].data = this.User.userbind.qq ? this.User.userbind.qq.nickname : "未绑定";
				this.list = [...this.list,...arr];
				// #endif
			}
		}
	}
</script>

<style>
@import "../../common/form.css";
</style>
