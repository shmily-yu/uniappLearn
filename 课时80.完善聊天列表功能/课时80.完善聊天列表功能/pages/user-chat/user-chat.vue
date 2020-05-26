<template>
	<view>
		
		<scroll-view id="scrollview" scroll-y :scroll-top="scrollTop" 
		:scroll-with-animation="true"
		:style="{height:style.contentH+'px'}">
			<!-- 聊天列表 -->
			<block v-for="(item,index) in list" :key="index">
				<user-chat-list :item="item" :index="index"></user-chat-list>
			</block>
		</scroll-view>
		
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
				scrollTop:0,
				style:{
					contentH:0,
					itemH:0
				},
				list:[]
			};
		},
		onLoad() {
			this.getdata();
			this.initdata();
		},
		onReady() {
			this.pageToBottom();
		},
		methods:{
			// 初始化参数
			initdata(){
				try {
					const res = uni.getSystemInfoSync();
					this.style.contentH=res.windowHeight - uni.upx2px(120);
				} catch (e) { }
			},
			pageToBottom(){
				let q=uni.createSelectorQuery();
				q.select('#scrollview').boundingClientRect();
				q.selectAll('.user-chat-item').boundingClientRect();
				
				q.exec((res)=>{
					res[1].forEach((ret)=>{
						this.style.itemH += ret.height;
					});
					
					if(this.style.itemH > this.style.contentH){
						this.scrollTop=this.style.itemH;
					}
					
				})
			},
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
				// 构建数据
				let now=new Date().getTime();
				let obj={
					isme:true,
					userpic:"../../static/demo/userpic/10.jpg",
					type:"text",
					data:data,
					time:now,
					gstime:time.gettime.getChatTime(now,this.list[this.list.length-1].time)
				};
				this.list.push(obj);
				this.pageToBottom();
			}
		}
	}
</script>

<style>

</style>
