<template>
	<view>
		
		<scroll-view id="scrollview" scroll-y :scroll-top="scrollTop" 
		:scroll-with-animation="true"
		:style="{height:style.contentH+'px'}">
			<!-- 聊天列表 -->
			<block v-for="(item,index) in list" :key="index">
				<view class="chat-item">
					<user-chat-list :item="item" :index="index"></user-chat-list>
				</view>
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
				to_id:0,
				Myuserinfo:{
					id:0,
					userpic:'../../static/logo.png'
				},
				scrollTop:0,
				style:{
					contentH:0,
					itemH:0
				},
				list:[]
			};
		},
		onLoad(e) {
			this.to_id = e.to_id;
			this.Myuserinfo.id = uni.getStorageSync('userid');
		},
		onReady() {
			// 获取信息
			this.getdata();
			// 初始化
			this.initdata();
			// 接收信息
			this.Chat.Message(this.getChatMessage);
		},
		methods:{
			// 接受信息
			getChatMessage(e){
				if (e.type == 'text') {
					// 震动提示
					uni.vibrateLong();
					let obj = this.SetPageData(e,false);
					// 渲染到页面
					this.list.push(obj);
					// 写入本地缓存
					this.SetStore(obj)
					// 置于底部
					this.pageToBottom();
				}
			},
			// 初始化参数
			initdata(){
				try {
					const res = uni.getSystemInfoSync();
					this.style.contentH=res.windowHeight - uni.upx2px(120);
				} catch (e) { }
			},
			pageToBottom(isfirst = false){
				let query = uni.createSelectorQuery().in(this);
				let itemH = query.selectAll('.chat-item');
				this.$nextTick(()=>{
					itemH.fields({
						size: true
					}, data => {
						if (data) {
							if (isfirst) {
								for (let i = 0; i < data.length; i++) {
									this.style.itemH += data[i].height;
								}
							}else{
								this.style.itemH += data[data.length-1].height;
							}
							this.scrollTop = (this.style.itemH > this.style.contentH) ? this.style.itemH : 0;
						}
					}).exec();	
				})
			},
			// 获取聊天数据
			getdata(){
				// 获取缓存
				try{
					let list = uni.getStorageSync('chat_'+this.to_id);
					this.list = list ? JSON.parse(list) : [];
					this.pageToBottom(true);
				}catch(e){
					console.log(JSON.stringify(e))
				}
			},
			submit(data){
				let obj = this.SetPageData(data);
				// 渲染到页面
				this.list.push(obj);
				// 写入本地缓存
				this.SetStore(obj)
				// 发送到服务器
				this.ToSend(data);
				// 置于底部
				this.pageToBottom();
			},
			// 发送到服务器
			ToSend(data){
				let obj = this.SetSendData(data);
				//console.log(JSON.stringify(obj))
				uni.request({
					url: this.Config.webUrl+'/chat/send',
					method: 'POST',
					data: obj,
					header:{token:this.Config.token,'content-type':'application/x-www-form-urlencoded'},
					success: res => {
						console.log(JSON.stringify(res))
						if (res.statusCode == 200 && res.data.msg == 'ok') {
							return uni.showToast({
								title: '发送成功'
							});
						}
						uni.showToast({
							title: res.data.msg ? res.data.msg :'发送失败',icon:"none"
						});
					},
					fail: () => {
						uni.showToast({
							title: '发送失败,请检查网络',icon:"none"
						});
					}
				});
			},
			// 构建渲染到页面数据
			SetPageData(data,isme = true){
				let chattime = isme ? (new Date().getTime()) : data.time;
				let length = this.list.length;
				return {
					isme:isme,
					userpic:isme ? this.Myuserinfo.userpic : data.from_userpic,
					type:"text",
					data:isme ? data : data.data,
					time:chattime,
					gstime:time.gettime.getChatTime(chattime,(length > 0) ? this.list[length-1].time : 0)
				};
			},
			// 构建要发送的数据
			SetSendData(data){
				return {
					to_id:this.to_id,
					from_id:this.Myuserinfo.id,
					from_userpic:this.Myuserinfo.userpic,
					type:'text',
					data:data
				};
			},
			// 写入本地缓存
			SetStore(obj){
				try{
					// 获取缓存
					let list = uni.getStorageSync('chat_'+this.to_id);
					list = list ? JSON.parse(list) : [];
					list.push(obj);
					// 存储
					uni.setStorage({
						key:'chat_'+this.to_id,
						data:JSON.stringify(list)
					})
				}catch(e){
					console.log(JSON.stringify(e))
				}
			}
		}
	}
</script>

<style>
page{
	background: #FFFFFF;
}
</style>
