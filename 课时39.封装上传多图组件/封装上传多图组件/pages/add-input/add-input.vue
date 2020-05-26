<template>
	<view>
		<!-- 自定义导航栏 -->
		<uni-nav-bar :statusBar="true" rightText="发布" left-icon="back" @click-left="back" @click-right="submit">
			<view class="u-f-ajc" @tap="changelook">
				{{yinsi}}
				<view class="icon iconfont icon-xialazhankai"></view>
			</view>
		</uni-nav-bar>
		<!-- 多行输入框 -->
		<view class="uni-textarea">
			<textarea v-model="text" placeholder="说一句话吧~" />
		</view>
		<!-- 上传多图 -->
		<uploud-images @uploud="uploud"></uploud-images>
		
	</view>
</template>

<script>
	let changelook= ['所有人可见', '仅自己可见'];
	import uniNavBar from "../../components/uni-nav-bar/uni-nav-bar.vue";
	import uploudImages from "../../components/common/uploud-images.vue";
	export default {
		components:{
			uniNavBar,
			uploudImages
		},
		data() {
			return {
				yinsi:"所有人可见",
				text:"",
				imglist:[]
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
			},
			uploud(arr){
				this.imglist=arr;
				console.log(this.imglist)
			}
		}
	}
</script>

<style>
.uni-textarea{
	border: 1upx solid #EEEEEE;
}
</style>
