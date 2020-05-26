<!-- class 支持的语法: -->
<!-- <view :class="{ 'active': isActive}">111</view>
<view :class="{ 'active': isActive, 'text-danger': hasError}">111</view>
<view :class="[class1,class2]">111</view>
<view class="static" :class="[num>10 ? 'active' : 'text-danger',class3]">444</view> -->
		
<!-- style 支持的语法: -->
<!-- <view :style="{ color: activeColor, fontSize: fontSize +'px' }">666</view> -->
<template>
	<view>
		
		<!-- class 支持的语法: -->
		<!-- <view class="box" :class="['bor','fs']">box</view> -->
		<!-- <view class="box" :class="[class1,class2]">box</view> -->
	<!-- <view class="box" :class="[age>10?class1:'',sex=='女'?class2:'']">box</view> -->
	<!-- <view class="box" :class="{'bor':isActive,'fs':isfs}">111</view> -->
		
		<!-- style 支持的语法: -->
		<view class="box" :style="{'color': Color,'font-size': size+'px'}">box</view>
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				class1:"bor",
				class2:"fs",
				age:11,
				sex:"男",
				isActive:false,
				isfs:false,
				Color:"#333333",
				size:50
			}
		},
		methods:{
			
		}
	}
</script>

<style>
.box{
	background: #09BB07;
	color: #FFFFFF;
	width: 350upx;
	height: 350upx;
	border-radius:100%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 50upx;
}
.bor{
	border: 10upx solid #007AFF;
}
.fs{
	font-size: 80upx;
	color: red;
}
</style>
