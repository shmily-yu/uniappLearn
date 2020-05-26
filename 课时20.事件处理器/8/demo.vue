<template>
	<view>
	
		
	<!-- 	<view class="font">{{name}}</view>
	
		<view class="box" @tap="clickevent()">按钮</view> -->
	
	<view class="box1" @tap.stop="box1event()">
		外面
		<view class="box2" @tap.stop="box2event()">里面</view>
	</view>
	
	
	
	</view>
</template>

<script>
	export default {
		data() {
			return {
				name:"哈哈哈"
			}
		},
		methods:{
			clickevent:function(){
				this.name="嘻嘻嘻";
			},
			box1event:function(){
				console.log("点击了外面");
			},
			box2event:function(){
				console.log("点击了里面")
			}
		}
	}
</script>

<style>
	.box1{
		width: 100%;
		height: 500upx;
		background: #007AFF;
		color: #FFFFFF;
		font-size: 40upx;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.box2{
		width: 300upx;
		height: 300upx;
		background: #09BB07;
		color: #FFFFFF;
		font-size: 40upx;
		display: flex;
		justify-content: center;
		align-items: center;
	}
.box{
	background: #09BB07;
	color: #FFFFFF;
	width: 80%;
	margin: auto;
	height: 80upx;
	font-size: 50upx;
	border-radius:30upx;
	border: 1upx solid #EEEEEE;
	display: flex;
	justify-content: center;
	align-items: center;
}
.font{
	font-size: 50upx;
	border: 1upx solid #CCCCCC;
	padding: 20upx;
}
</style>
