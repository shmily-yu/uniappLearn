<template>
	<view>
		
		<view :class="classname">
			<view>{{username}}</view>
			<view>{{userinfo.username}}</view>
			<!-- <view>{{itemdata}}</view> -->
		</view>
		<button type="default" @tap="changeUsername('嘻嘻嘻')">修改名字</button>
		<button type="default" @tap="changeClass()">修改样式</button>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				classname:"box",
				username:"哈哈哈",
				userinfo:{
					username:"双手合十",
				}
			}
		},
		methods:{
			changeUsername:function(name){
				this.userinfo.username="和额呵呵"+name;
			},
			changeClass:function(){
				this.classname="box2";
			}
		}
	}
</script>

<style>
.box{
	border: 1upx solid #333333;
	height: 500upx;
	width: 100%;
	display: flex;
}
.box2{
	border: 1upx solid #333333;
	height: 800upx;
	width: 100%;
	display: flex;
}
.box>view{
	background: #007AFF;
	color: #FFFFFF;
	font-weight: bold;
	font-size: 40upx;
	flex: 1;
	height: 500upx;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1upx solid #FFFFFF;
}
</style>
