<template>
	<view>
		<detail-info :item="detail"></detail-info>
	</view>
</template>

<script>
	import detailInfo from "../../components/detail/detail-info.vue";
	export default {
		components:{
			detailInfo
		},
		data() {
			return {
				detail:{
					userpic:"../../static/demo/userpic/12.jpg",
					username:"哈哈",
					sex:0, //0 男 1 女
					age:25,
					isguanzhu:false,
					title:"我是标题",
					titlepic:"../../static/demo/datapic/13.jpg",
					morepic:["../../static/demo/datapic/13.jpg","../../static/demo/datapic/14.jpg","../../static/demo/datapic/15.jpg"],
					video:false,
					share:false,
					path:"深圳 龙岗",
					sharenum:20,
					commentnum:30,
					goodnum:20
				},
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
