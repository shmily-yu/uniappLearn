<template>
	<view class="body">
		
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>头像</view>
			<view class="u-f-ac" @tap="changeimg">
				<image :src="userpic" mode="aspectFill" lazy-load></image>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>昵称</view>
			<view class="u-f-ac">
				<input type="text" v-model="username" />
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>性别</view>
			<view class="u-f-ac" @tap="changeOne('sex')">
				<view>{{sex}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>生日</view>
			<view class="u-f-ac">
				<view>1987-02-07</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>职业</view>
			<view class="u-f-ac" @tap="changeOne('qg')">
				<view>{{qg}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>情感</view>
			<view class="u-f-ac" @tap="changeOne('job')">
				<view>{{job}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>家乡</view>
			<view class="u-f-ac">
				<view>中国广州</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		
		<button class="user-set-btn" 
		type="primary" @tap="submit">完成</button>
		
	</view>
</template>

<script>
	let sex=['不限','男','女'];
	let qg=['秘密','未婚','已婚'];
	let job=['秘密','IT','老师'];
	export default {
		data() {
			return {
				userpic:"../../static/demo/userpic/11.jpg",
				username:"哈哈哈",
				sex:"不限",
				qg:"未婚",
				job:"IT"
			}
		},
		methods: {
			// 修改头像
			changeimg(){
				uni.chooseImage({
					count:1,
					sizeType:['compressed'],
					success: (res) => {
						this.userpic=res.tempFilePaths;
					}
				})
			},
			// 单列选择
			changeOne(val){
				let arr=[];
				switch (val){
					case 'sex':
					arr=sex;
						break;
					case 'qg':
					arr=qg;
						break;
					case 'job':
					arr=job;
						break;
				}
				uni.showActionSheet({
					itemList: arr,
					success: res => {
						switch (val){
							case 'sex':
							this.sex=arr[res.tapIndex];
								break;
							case 'qg':
							this.qg=arr[res.tapIndex];
								break;
							case 'job':
							this.job=arr[res.tapIndex];
								break;
						}
					},
				});
			},
			submit(){
				
			}
		}
	}
</script>

<style>
@import "../../common/form.css";
.user-set-userinfo-list{
	padding: 20upx;
	border-bottom: 1upx solid #F4F4F4;
}
.user-set-userinfo-list>view:first-child{
	font-size: 32upx;
	font-weight: bold;
	color: #9B9B9B;
}
.user-set-userinfo-list>view:last-child>image{
	width: 80upx;
	height: 80upx;
	border-radius: 100%;
}
.user-set-userinfo-list>view:last-child>input{
	text-align: right;
}
.user-set-userinfo-list>view:last-child>view:last-of-type{
	margin-left: 20upx;
	color: #9B9B9B;
}
</style>
