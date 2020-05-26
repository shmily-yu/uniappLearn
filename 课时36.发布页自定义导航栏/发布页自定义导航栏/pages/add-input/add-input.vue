<template>
	<view>
		<!-- 自定义导航栏 -->
		<uni-nav-bar :statusBar="true" rightText="发布" left-icon="back" @click-left="back" @click-right="submit">
			<view class="u-f-ajc" @tap="changelook">
				{{yinsi}}
				<view class="icon iconfont icon-xialazhankai"></view>
			</view>
		</uni-nav-bar>
	</view>
</template>

<script>
	let changelook= ['所有人可见', '仅自己可见'];
	import uniNavBar from "../../components/uni-nav-bar/uni-nav-bar.vue";
	export default {
		components:{
			uniNavBar
		},
		data() {
			return {
				yinsi:"所有人可见"
			};
		},
		methods:{
			// 返回
			back(){
				uni.navigateBack({ delta: 1 });
			},
			// 发布
			submit(){
				console.log("发布")
			},
			// 隐私
			changelook(){
				uni.showActionSheet({
					itemList:changelook,
					success: (res)=> {
						this.yinsi=changelook[res.tapIndex]
					}
				});
			}
		}
	}
</script>

<style>

</style>
