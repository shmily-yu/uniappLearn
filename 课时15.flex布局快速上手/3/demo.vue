<!-- 
display:flex;
flex-direction:row | row-reverse | column | column-reverse;
flex-wrap: nowrap | wrap | wrap-reverse;
justify-content: flex-start | flex-end | center | space-between | space-around;
align-items: flex-start | flex-end | center | baseline | stretch;
align-content: flex-start | flex-end | center | space-between | space-around | stretch;
flex-shrink: 0,不被压缩
align-self: auto | flex-start | flex-end | center | baseline | stretch; 
 -->
<template>
	<view>
		
		<view class="box">
			
			<view class="box-item">1</view>
			<view class="box-item">2</view>
			 <view class="box-item">3</view>
			<!--<view class="box-item">4</view>
			<view class="box-item">5</view>
			<view class="box-item">6</view> -->
			
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
.box{
	height: 500upx;
	width: 100%;
	border: 1upx solid #333333;
	display: flex;
	/* flex-direction: column; */
	/* justify-content: center;
	align-items:center; */
}
.box-item{
	color: #FFFFFF;
	height: 200upx;
	/* width: 200upx; */
	/* width: 50%; */
	flex: 1;
	font-size: 30upx;
	font-weight: bold;
	display: flex;
	justify-content: center;
	align-items: center;
}
.box-item:nth-of-type(odd){
	background: #007AFF;
}
.box-item:nth-of-type(even){
	background:#09BB07;
}
/* .box-item:first-of-type{
	flex-shrink: 0;
} */
.box-item:nth-of-type(1){
	flex: 100;
}
.box-item:nth-of-type(2){
	flex: 200;
	align-self: flex-end;
}
.box-item:nth-of-type(3){
	flex: 100;
}
</style>
