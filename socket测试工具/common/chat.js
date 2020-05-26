export default{
	url:'',
	// 连接状态
	IsOpen:false,
	// SocketTask
	SocketTask:false,
	// 当前客户端id
	Client_id:0,
	// 是否上线
	IsOnline:false,
	// 连接
	Open(){
		if (!this.url) {
			return uni.showToast({
				title: '请先配置连接地址',
				icon:"none"
			});
		}
		if(this.IsOpen) return;
		this.SocketTask = uni.connectSocket({
			url:this.url,
			complete: (e)=> { console.log(JSON.stringify(e)) 
			},
		});
		if (this.SocketTask) {
			// 监听开启
			this.SocketTask.onOpen(()=>{
				console.log('监听开启')
				this.IsOpen = true;
			});
			// 监听信息
			this.Message();
			// 监听关闭
			this.SocketTask.onClose(()=>{
				this.IsOpen = false;
				this.SocketTask = false;
			});
			// 监听错误
			this.SocketTask.onError((e)=>{
				this.IsOpen = false;
				this.SocketTask = false;
				uni.showToast({
					title: '连接失败',
					icon:"none"
				});
			});
			return;
		}
		console.log('请先连接socket')
		return;
	},
	// 监听信息
	Message(fun = ''){
		this.SocketTask.onMessage((e)=>{
			let res = JSON.parse(e.data);
			//if (res.type == 'client_id')  this.Client_id = res.data;
			if(typeof fun === "function") fun(res);
		})
		console.log('监听信息')
	},
	// 关闭连接
	Close(){
		if(!this.IsOpen) return uni.showToast({ title: '请先连接', icon:"none" });
		this.SocketTask.close({
			success(){
				uni.showToast({ title: '关闭成功', icon:"none" });
			}
		});
		return false;
	}
}