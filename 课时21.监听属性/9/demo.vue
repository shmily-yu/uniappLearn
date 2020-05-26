<template>
	<view>
	
		<!-- <view class="font">{{name}}</view> -->
		<view class="font">{{num}}</view>
		<view class="font">{{num>10?'优秀':''}}</view>
	<button type="primary" @tap="change()">修改</button>
	
	</view>
</template>

<script>
	export default {
		data() {
			return {
				name:"我是一个名称",
				num:0
			}
		},
		watch:{
			name:function(val) {
				console.log(val)
			},
			num:function(val){
				console.log(val);
			}
		},
		methods:{
			change:function(){
				// this.name="被修改了";
				this.num++;
			}
		}
	}
</script>

<style>
.font{
	font-size: 50upx;
}
</style>
