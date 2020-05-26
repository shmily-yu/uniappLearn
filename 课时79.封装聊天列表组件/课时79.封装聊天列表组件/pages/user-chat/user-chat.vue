<template>
	<view>
		<!-- 聊天列表 -->
		<block v-for="(item,index) in list" :key="index">
			<user-chat-list :item="item" :index="index"></user-chat-list>
		</block>
		<!-- 输入框 -->
		<user-chat-bottom @submit="submit"></user-chat-bottom>
	</view>
</template>

<script>
	import userChatBottom from "../../components/user-chat/user-chat-bottom.vue";
	import time from "../../common/time.js";
	import userChatList from "../../components/user-chat/user-chat-list.vue";
	export default {
		components:{
			userChatBottom,
			userChatList
		},
		data() {
			return {
				list:[]
			};
		},
		onLoad() {
			this.getdata();
		},
		methods:{
			// 获取聊天数据
			getdata(){
				// 从服务器获取到的数据
				let arr=[
					{
						isme:false,
						userpic:"../../static/demo/userpic/11.jpg",
						type:"text",
						data:"哈哈哈",
						time:"1555146412"
					},
					{
						isme:true,
						userpic:"../../static/demo/userpic/10.jpg",
						type:"img",
						data:"../../static/demo/3.jpg",
						time:"1555146414",
					},
				];
				for (let i = 0; i < arr.length; i++) {
					arr[i].gstime=time.gettime.getChatTime(arr[i].time,i>0?arr[i-1].time:0);
				}
				this.list=arr;
			},
			submit(data){
				// 发送逻辑
				console.log("当前输入的是"+data)
			}
		}
	}
</script>

<style>

</style>
