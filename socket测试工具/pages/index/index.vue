<template>
	<view>
		<view class="uni-common-mt">
			<view class="uni-form-item uni-column">
				<view class="title">socket连接地址</view>
				<input class="uni-input" v-model="socketUrl" placeholder="socket连接地址" />
			</view>
			<view class="uni-padding-wrap uni-common-mt">
				<button type="primary" @tap="connect" :disabled="isconnect" style="width: 80%;">连接</button>
				<button type="warn" @tap="close" :disabled="!isconnect" style="width: 80%;">断开</button>
			</view>
			<view class="uni-form-item uni-column">
				<picker mode="selector" :range="userArr" @change="changetoken">
				<view class="title">
					<button type="default" size="mini">选择当前用户</button>
				</view>
				</picker>
				<input class="uni-input" v-model="token" placeholder="用户token" />
			</view>
			<view class="uni-form-item">
				<button type="primary" @tap="online" :disabled="!isconnect || isonline" style="width: 80%;">上线</button>
			</view>
			<!-- 设置聊天对象 -->
			<view class="uni-form-item uni-column">
				<picker mode="selector" :range="userArr" @change="changetoid">
				<view class="title">
					<button type="default" size="mini">设置聊天对象id</button>
				</view>
				</picker>
				<input class="uni-input" type="number" v-model="to_id" placeholder="设置聊天对象id" />
			</view>
			<view class="uni-form-item">
				<button type="primary" @tap="ToDetail" :disabled="!isconnect || !isonline" style="width: 80%;">进入聊天</button>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isconnect:this.Chat.IsOpen,
				socketUrl:this.Config.socketUrl,
				token:this.Config.token,
				to_id:0,
				isonline:this.Chat.IsOnline,
				userArr:this.Config.userArr
			}
		},
		onLoad() {
			this.isconnect = this.Chat.IsOpen;
		},
		methods: {
			changetoken(e){
				this.token = this.Config.tokenArr[this.userArr[e.detail.value]];
			},
			changetoid(e){
				this.to_id = this.userArr[e.detail.value];
			},
			connect(){
				this.Chat.url = this.socketUrl;
				this.Chat.Open();
				// 监听开启
				this.Chat.SocketTask.onOpen(()=>{
					this.isconnect = true;
				});
				// 监听断开
				this.Chat.SocketTask.onClose(()=>{
					this.isonline = false;
					this.isconnect = false;
				});
			},
			close(){
				this.isonline = false;
				this.isconnect = this.Chat.Close();
			},
			// 绑定
			online(){
				this.Chat.SocketTask.send({
					data:JSON.stringify({
						token:this.token,
						type:'bind'
					}),
					complete: (e) => {
						console.log(e)
					}
				});
				this.Chat.Message((res)=>{
					console.log(res)
					if (res.status && res.type == 'bind') {
						this.isonline = true;
						this.getChatMessages();
					}
				});
			},
			// 进入详情
			ToDetail(){
				if (!this.to_id) {
					return uni.showToast({ title: '请填写要聊天的对象',icon:"none" });
				}
				if (uni.getStorageSync('userid') == this.to_id) {
					return uni.showToast({ title: '不能跟自己聊天', icon:"none" });
				}
				uni.navigateTo({
					url: '../chat/chat?to_id='+this.to_id,
				});
			},
			// 获取未接收消息
			getChatMessages(){
				uni.request({
					url: this.Config.webUrl+'/chat/get',
					method: 'POST',
					data: {},
					header:{token:this.token,'content-type':'application/x-www-form-urlencoded'},
					success: res => {
						if (res.statusCode == 200) {
							console.log(JSON.stringify(res.data))
							if (Array.isArray(res.data)) {
								uni.showToast({
									title: '接收到'+res.data.length+'条待接收信息',
									icon:"none"
								});
							}
							return;
						}
						uni.showToast({
							title: '获取未接收消息失败',icon:"none"
						});
					},
					fail: () => {
						uni.showToast({
							title: '获取未接收消息失败',icon:"none"
						});
					}
				});
			}
		}
	}
</script>

<style>
</style>
