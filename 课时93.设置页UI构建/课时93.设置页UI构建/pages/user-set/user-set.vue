<template>
	<view class="body">
		<block v-for="(item,index) in list" :key="index">
			<home-list-item :item="item"
			:index="index"></home-list-item>
		</block>
		<button class="user-set-btn" type="primary">退出登陆</button>
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
				list:[
					{ icon:"",name:"账号与安全" },
					{ icon:"",name:"绑定邮箱" },
					{ icon:"",name:"资料编辑" },
					{ icon:"",name:"小纸条" },
					{ icon:"",name:"清除缓存" },
					{ icon:"",name:"意见反馈" },
					{ icon:"",name:"关于糗百" },
				]
			}
		},
		methods: {
			
		}
	}
</script>

<style>
.body{
	padding: 0 20upx;
}
.user-set-btn{
	width: 100%;
	margin: 20upx 0;
	background: #FFE933!important;
	border: 0!important;
	color: #333333!important;
}
</style>
