<template>
	<view>
		<!-- 输入框 -->
		<user-chat-bottom @submit="submit"></user-chat-bottom>
		
	</view>
</template>

<script>
	import userChatBottom from "../../components/user-chat/user-chat-bottom.vue";
	export default {
		components:{
			userChatBottom
		},
		data() {
			return {
				
			};
		},
		methods:{
			submit(data){
				// 发送逻辑
				console.log("当前输入的是"+data)
			}
		}
	}
</script>

<style>

</style>
