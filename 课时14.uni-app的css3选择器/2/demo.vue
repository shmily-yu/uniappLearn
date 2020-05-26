<template>
	<view>
		
		
		<!-- <view class="view-box" id="view2">第一个view</view>
		<text>text组件</text> -->
		
		<view class="box">
			<text>text组件</text>
			<view>1</view>
			<view>2</view>
			<view>3</view>
			<view>4</view>
			<view>5</view>
			<view>6</view>
		</view>
		
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			};
		}
	}
</script>

<style>
.view-box{
	width: 200upx;
	height: 200upx;
	background: #007AFF;
	color: #FFFFFF;
	margin: 100upx;
}
.view-box-hover{
	background: red;
}
#view2,text{
	background: yellow;
}
.box{
	width: 300upx;
	height: 300upx;
	background: #007AFF;
	color: #FFFFFF;
	margin: 100upx;
	padding: 50upx;
}
.box view{
	font-size: 40upx;
}
/* .box>view:nth-child(1){
	background: #09BB07;
}
.box>view:nth-child(2){
	background: red;
}
.box>view:nth-child(3){
	background: pink;
}
.box>view:nth-of-type(1){
	background: #09BB07;
}
.box>view:nth-of-type(2){
	background: red;
}
.box>view:nth-of-type(3){
	background: pink;
} */
/* .box>view:first-child{
	background: red;
}
.box>view:last-child{
	background: pink;
} */
/* .box>view:first-of-type{
	background: red;
}
.box>view:last-of-type{
	background: pink;
} */
/* 奇数 */
/* .box>view:nth-of-type(2n-1){
	background: red;
}
/* 偶数 */
.box>view:nth-of-type(2n){
	background: pink;
} */
/* 偶数 */
.box>view:nth-of-type(even){
	background: red;
}
/* 奇数 */
.box>view:nth-of-type(odd){
	background: pink;
}
</style>
