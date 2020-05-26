<template>
	<view>
		<!-- 背景图 + 用户基本信息 -->
		<user-space-head :userinfo="userinfo"></user-space-head>
		<!-- 统计 -->
		<view class="user-space-data">
			<home-data :homedata="spacedata"></home-data>
		</view>
		<view style="height: 20upx; background: #F4F4F4;"></view>
		<!-- tab导航 -->
		<swiper-tab-head 
		:tabBars="tabBars" 
		:tabIndex="tabIndex"
		@tabtap="tabtap"
		scrollItemStyle="width:33.33%;"
		scrollStyle="border-bottom:0;">
		</swiper-tab-head>
		
	</view>
</template>

<script>
	import userSpaceHead from "../../components/user-space/user-space-head.vue";
	import homeData from "../../components/home/home-data.vue";
	import swiperTabHead from "../../components/index/swiper-tab-head.vue";
	export default {
		components:{
			userSpaceHead,
			homeData,
			swiperTabHead
		},
		data() {
			return {
				userinfo:{
					bgimg:1,
					userpic:"../../static/demo/userpic/11.jpg",
					username:"昵称",
					sex:0,
					age:20,
					isguanzhu:false
				},
				spacedata:[
					{ name:"获赞", num:"10k" },
					{ name:"关注", num:11 },
					{ name:"粉丝", num:12 },
				],
				tabIndex:0,
				tabBars:[
					{ name:"主页",id:"zhuye" },
					{ name:"糗事",id:"qiushi" },
					{ name:"动态",id:"dongtai" },
				],
			}
		},
		methods: {
			tabtap(index){
				this.tabIndex=index;
			},
		}
	}
</script>

<style>
.user-space-margin{
	margin: 15upx 0;
}
.user-space-data{
	background: #FFFFFF;
	position: relative;
	z-index: 10;
	border-top-left-radius: 20upx;
	border-top-right-radius: 20upx;
	margin-top: -15upx;
}
</style>
