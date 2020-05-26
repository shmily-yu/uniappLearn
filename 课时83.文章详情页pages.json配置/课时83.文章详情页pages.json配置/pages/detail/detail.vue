<template>
	<view>
		内容页
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		onLoad(e) {
			this.initdata(JSON.parse(e.detailData))
		},
		// 监听导航右边按钮
		onNavigationBarButtonTap(e) {
			if(e.index==0){
				console.log("分享")
			}
		},
		methods: {
			// 初始化数据
			initdata(obj){
				// 修改窗口标题
				uni.setNavigationBarTitle({ title: obj.title });
			}
		}
	}
</script>

<style>

</style>
