<template>
	<view style="padding: 20upx;">
		<view class="user-set-about-t u-f-ajc u-f-column animated fadeIn fast">
			<image src="../../static/common/logo.png" 
			mode="widthFix" lazy-load></image>
			<!-- #ifdef APP-PLUS -->
			<view>version {{version}}</view>
			<!-- #endif -->
		</view>
		<block v-for="(item,index) in list" :key="index">
			<home-list-item :item="item"
			:index="index"></home-list-item>
		</block>
	</view>
</template>

<script>
	import homeListItem from "../../components/home/home-list-item.vue";
	export default {
		components:{
			homeListItem
		},
		data() {
			return {
				version:"",
				list:[
					// #ifdef APP-PLUS
					{ icon:"",name:"新版本检测",clicktype:"update",url:"" },
					// #endif
					{ icon:"",name:"仿糗事百科用户协议",clicktype:"",url:"" },
				]
			}
		},
		onLoad() {
			// #ifdef APP-PLUS
			plus.runtime.getProperty(plus.runtime.appid, (widgetInfo)=>{ 
				this.version = widgetInfo.version;
			})
			// #endif
		},
		methods: {
			
		}
	}
</script>

<style>
.user-set-about-t{
	padding: 40upx 0;
}
.user-set-about-t>image{
	margin-top: 50upx;
	margin-bottom: 30upx;
	width: 65%;
}
.user-set-about-t>view{
	color: #CCCCCC;
}
</style>
