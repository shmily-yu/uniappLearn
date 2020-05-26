<template>
	<view>
		
		
		<view class="view-box animated" hover-stay-time="800" 
		hover-class="view-box-hover rubberBand">第一个view</view>
		
		
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
</style>
