<template>
	<view>
		<!-- 背景图 + 用户基本信息 -->
		<user-space-head :userinfo="userinfo"></user-space-head>
		
	</view>
</template>

<script>
	import userSpaceHead from "../../components/user-space/user-space-head.vue";
	export default {
		components:{
			userSpaceHead
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
				}
			}
		},
		methods: {
			
		}
	}
</script>

<style>
.user-space-margin{
	margin: 15upx 0;
}
</style>
