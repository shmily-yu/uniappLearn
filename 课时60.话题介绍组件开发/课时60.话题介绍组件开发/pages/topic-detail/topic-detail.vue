<template>
	<view>
		<!-- 模糊背景 -->
		<view class="topic-bg">
			<image src="../../static/demo/topicpic/13.jpeg" mode="aspectFill" lazy-load></image>
		</view>
		<!-- 话题信息 -->
		<view class="topic-info">
			<view class="topic-info-t u-f-ac">
				<image src="../../static/demo/topicpic/13.jpeg" mode="widthFix" lazy-load></image>
				<view>#忆往事，敬余生#</view>
			</view>
			<view class="topic-info-c u-f-ac">
				<view>动态 1000</view>
				<view>今日 1000</view>
			</view>
			<view class="topic-info-b">
				我是描述
			</view>
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
.topic-bg{
	width: 100%;
	height: 300upx;
	position: relative;
	overflow: hidden;
}
.topic-bg>image{
	width: 100%;
	position: absolute;
	filter: blur(10px);
}
.topic-info{
	padding: 0 25upx;
}
.topic-info-t{
	position: relative;
}
.topic-info-t>image{
	width: 150upx;
	height: 150upx;
	border-radius: 20upx;
	position: absolute;
	top: -75upx;
}
.topic-info-t>view{
	font-size: 35upx;
	margin-left: 170upx;
	flex: 1;
}
.topic-info-c{
	padding: 35upx 0 15upx 0;
}
.topic-info-c view{
	color: #CDCDCD;
}
.topic-info-b{
	color: #A3A3A3;
	font-size: 32upx;
	padding-bottom: 10upx;
}
</style>
