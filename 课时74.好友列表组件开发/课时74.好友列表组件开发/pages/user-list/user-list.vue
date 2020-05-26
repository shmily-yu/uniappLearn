<template>
	<view class="body">
		<!-- tab切换 -->
		<swiper-tab-head 
		:tabBars="tabBars" 
		:tabIndex="tabIndex"
		@tabtap="tabtap"
		scrollItemStyle="width:33%;"
		scrollStyle="border-bottom:0;">
		</swiper-tab-head>
		
		<!-- 好友列表 -->
		<view class="user-list u-f-ac">
			<image src="../../static/demo/userpic/12.jpg" mode="widthFix" lazy-load></image>
			<view>
				<view>昵称</view>
				<view style="display: inline-block;">
					<tag-sex-age age="20" sex="0"></tag-sex-age>
				</view>
			</view>
			<view class="icon iconfont icon-xuanze-yixuan u-f-ajc"></view>
		</view>
		
	</view>
</template>

<script>
	import swiperTabHead from "../../components/index/swiper-tab-head.vue";
	import tagSexAge from "../../components/common/tag-sex-age.vue";
	export default {
		components:{
			swiperTabHead,
			tagSexAge
		},
		data() {
			return {
				tabIndex:0,
				tabBars:[
					{ name:"互关",id:"huguan",num:10 },
					{ name:"关注",id:"guanzhu",num:20 },
					{ name:"粉丝",id:"fensi",num:30 },
				],
			};
		},
		// 监听导航按钮事件
		onNavigationBarButtonTap(e) {
			if(e.index==0){
				uni.navigateBack({
					delta: 1
				});
			}
		},
		methods:{
			// tabbar点击事件
			tabtap(index){
				this.tabIndex=index;
			},
		}
	}
</script>

<style>
.body{
	padding: 0 20upx;
}
.user-list{
	padding: 20upx 0;
	border-bottom: 1upx solid #EEEEEE;
}
.user-list>image{
	width: 100upx;
	height: 100upx;
	border-radius: 100%;
	margin-right: 20upx;
	flex-shrink: 0;
}
.user-list>view:first-of-type{
	flex: 1;
}
.user-list>view:first-of-type>view:first-child{
	font-size: 35upx;
}
.user-list>view:last-of-type{
	width: 80upx;
	color: #CCCCCC;
}

</style>
