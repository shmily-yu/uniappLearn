<template>
	<view>
		好友列表
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			};
		},
		// 监听导航按钮事件
		onNavigationBarButtonTap(e) {
			if(e.index==0){
				uni.navigateBack({
					delta: 1
				});
			}
		}
	}
</script>

<style>

</style>
