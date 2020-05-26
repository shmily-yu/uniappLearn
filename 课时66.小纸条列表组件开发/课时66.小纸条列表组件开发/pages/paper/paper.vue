<template>
	<view class="body">
		
		<!-- 小纸条列表 -->
		<view class="paper-list u-f-ac">
			<image src="../../static/demo/userpic/12.jpg" mode="widthFix" lazy-load></image>
			<view>
				<view class="u-f-ac u-f-jsb">昵称 <view>10:21</view></view>
				<view class="u-f-ac u-f-jsb">我是信息<uni-badge text="123" type="error"></uni-badge></view>
			</view>
		</view>
		
		
	</view>
</template>

<script>
	import uniBadge from "../../components/uni-badge/uni-badge.vue";
	export default {
		components:{
			uniBadge
		},
		data() {
			return {
				
			};
		}
	}
</script>

<style>
.body{
	padding: 0 20upx;
}
.paper-list{
	border-bottom: 1upx solid #EEEEEE;
	padding: 20upx 0;
}
.paper-list>image{
	width: 100upx;
	height: 100upx;
	border-radius: 100%;
	margin-right: 20upx;
	flex-shrink: 0;
}
.paper-list>view{
	flex: 1;
}
.paper-list>view>view:first-child{
	font-size: 35upx;
}
.paper-list>view>view:first-child>view{
	color: #CBCBCB;
}
.paper-list>view>view:last-child{
	color: #999999;
}
</style>
