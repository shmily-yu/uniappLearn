<template>
	<view>
		<detail-info :item="detail" @changeevent="updateData"></detail-info>
		
		<view class="u-comment-title">最新评论 {{comment.count}}</view>
		<view class="uni-comment u-comment">
			<block v-for="(item,index) in comment.list" :key="index">
				<comment-list :item="item" :index="index" @reply="reply"></comment-list>
			</block>
		</view>
		
		<view style="height: 120upx;"></view>
		
		<!-- 输入框 -->
		<user-chat-bottom @submit="submit" :focus="focus" @blur="blur"></user-chat-bottom>

		<!-- 分享 -->
		<more-share :show="shareshow" @togle="togle" :sharedata="sharedata"></more-share>
		
	</view>
</template>

<script>
	import detailInfo from "../../components/detail/detail-info.vue";
	import time from "../../common/time.js";
	import commentList from "../../components/detail/comment-list.vue";
	import userChatBottom from "../../components/user-chat/user-chat-bottom.vue";
	import moreShare from "../../components/common/more-share.vue";
	export default {
		components:{
			detailInfo,
			commentList,
			userChatBottom,
			moreShare
		},
		data() {
			return {
				focus:false,
				reply_id:0, // 回复id
				// 分享内容
				sharedata:{
					title:"",
					url:"",
					titlepic:"",
					shareType:0,
				},
				shareshow:false,
				comment:{
					count:0,
					list:[]
				},
				detail:{
					userpic:"",
					username:"",
					sex:0, //0 男 1 女
					age:0,
					content:"",
					isguanzhu:false,
					title:"",
					titlepic:"",
					morepic:[],
					video:false,
					share:false,
					path:"",
					sharenum:0,
					commentnum:0,
					goodnum:0,
					creat_time:0
				},
			}
		},
		onLoad(e) {
			this.initdata(JSON.parse(e.detailData));
		},
		// 监听导航右边按钮
		onNavigationBarButtonTap(e) {
			if(e.index==0){
				this.togle();
			}
		},
		// #ifndef APP-PLUS
		// 微信小程序分享
		onShareAppMessage(res) {
			return {
			  title: this.detail.title,
			  path: '/pages/detail/detail?detailData='+JSON.stringify(this.detail)
			}
		 },
		// #endif
		methods: {
			// 初始化分享内容
			__initShare(obj){
				this.sharedata = {
					title:obj.title,
					content:obj.title,
					url:"http://www.dishaxy.com/",
					titlepic:obj.titlepic ? obj.titlepic : 'https://img-cdn-qiniu.dcloud.net.cn/uniapp/app/share-logo@3.png',
					shareType:0,
				}
			},
			updateData(data){
				switch (data.type){
					case "guanzhu":
					this.updateGuanZhu(data);
						break;
					case "support":
					this.updateSupport(data);
						break;
				}
			},
			updateGuanZhu(data){
				this.detail.isguanzhu = data.data;
			},
			updateSupport(data){
				if (data.do == 'ding') {
					this.detail.infonum.index = 1;
					this.detail.goodnum++;
				}
			},
			// 初始化数据
			initdata(obj){
				// 修改窗口标题
				uni.setNavigationBarTitle({ title: obj.title });
				// 加载分享内容
				this.__initShare(obj);
				// 加载中
				uni.showLoading({ title: 'Loading...',mask:true });
				obj.morepic = [];
				obj.content = "";
				obj.goodnum = obj.infonum.dingnum;
				this.detail = obj;
				this.comment.count = obj.commentnum;
				// 获取文章详情
				this.getdetail();
				if (this.comment.count) {
					this.getcomment();
				}
			},
			async getdetail(){
				let [err,res] =await this.$http.get('/post/'+this.detail.id);
				let error = this.$http.errorCheck(err,res,()=>{
					uni.hideLoading();
				},()=>{
					uni.hideLoading();
				});
				if (!error) return;
				let data = res.data.data.detail;
				this.detail.content = data.content;
				let images = [];
				for (let i = 0; i < data.images.length; i++) {
					images.push(data.images[i].url);
				}
				this.detail.morepic = images;
				this.detail.age = data.user.userinfo.age;
				this.detail.sex = data.user.userinfo.sex;
				this.detail.creat_time = data.creat_time;
				return uni.hideLoading();
			},
			togle(){
				return uni.showToast({ title: '申请中...',icon:"none" });
				this.shareshow=!this.shareshow
			},
			// 发布评论
			async submit(data){
				uni.showLoading({ title: '评论中...',mask: false });
				let reply_id = this.reply_id;
				let [err,res] = await this.$http.post('/post/comment',{
					post_id:this.detail.id,
					fid:reply_id,
					data:data
				},{
					token:true,
				});
				// 错误处理
				if (err || res.data.errorCode) {
					let msg = res.data.errorCode ? res.data.msg : '发送失败，请检查网络~';
					uni.hideLoading();
					return uni.showToast({
						title: msg ,icon:"none"
					});
				}
				// 发送成功
				uni.hideLoading();
				uni.showToast({ title: "发送成功~" });
				let result = {
					id:res.data.data.id,
					fid:reply_id,
					userpic:this.User.userinfo.userpic,
					username:this.User.userinfo.username,
					time:time.gettime.gettime(new Date().getTime()),
					data:data,
				};
				// 评论数+1
				this.comment.count++;
				this.detail.commentnum++;
				// 一级评论
				if (reply_id === 0) {
					return this.comment.list.push(result);
				}
				// 二级评论
				// 找出被评论id的索引
				let index = this.comment.list.findIndex((val)=>{
					return val.id === reply_id;
				});
				if (index > -1) {
					// 中间插入
					this.comment.list.splice(index+1,0,result);
				}
				// 通知首页更新评论数，通知会员中心更新评论数
				uni.$emit('updateData',{
					type:'updateComment',
					post_id:this.detail.id
				});
			},
			// 获取评论
			async getcomment(){
				let [err,res] = await this.$http.get('/post/'+this.detail.id+'/comment');
				if (!this.$http.errorCheck(err,res)) return;
				let list = res.data.data.list;
				this.comment.list = this.comment.list.concat(this.__ArrSort(list));
			},
			__ArrSort(arr,id = 0){
				var temp = [],lev=0;
				var forFn = function(arr, id,lev){
					for (var i = 0; i < arr.length; i++) {
						var item = arr[i];
						if (item.fid==id) {
							item.lev=lev;
							temp.push({
								id:item.id,
								fid:item.fid,
								userid:item.user.id,
								userpic:item.user.userpic,
								username:item.user.username,
								time:time.gettime.gettime(item.create_time),
								data:item.data,
							});
							forFn(arr,item.id,lev+1);
						}
					}
				};
				forFn(arr, id,lev);
				return temp;
			},
			reply(id){
				this.reply_id = id;
				this.focus = true;
			},
			blur(){
				this.focus = false;
				this.reply_id = 0;
			},
		}
	}
</script>

<style>
/* 评论 */	
.u-comment{
	padding: 0 20upx;
}
.u-comment-title{
	padding: 20upx;
	font-size: 30upx;
	font-weight: bold;
}
</style>
