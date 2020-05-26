<template>
	<view class="index-list animated fadeIn fast">
		<view class="index-list1 u-f-ac u-f-jsb">
			<view class="u-f-ac">
				<image @tap.stop="openSpace" :src="item.userpic" 
				mode="widthFix" 
				lazy-load></image>
				{{item.username}}
			</view>
			<view class="u-f-ac" v-show="!item.isguanzhu" @tap="guanzhu">
				<view class="icon iconfont icon-zengjia"></view>关注
			</view>
		</view>
		<view class="index-list2" @tap="opendetail">{{item.title}}</view>
		<view class="index-list3 u-f-ajc" @tap="opendetail">
			<template v-if="item.titlepic">
				<!-- 图片 -->
				<image :src="item.titlepic" 
				mode="aspectFill" style="height: 350upx;" 
				lazy-load></image>
			</template>
			<!-- 视频 -->
			<template v-if="item.type=='video'">
				<view class="icon iconfont icon-bofang index-list-play"></view>
				<view class="index-list-playinfo">
					{{item.playnum}}次播放 {{item.long}}
				</view>
			</template>
		</view>
		<view class="index-list4 u-f-ac u-f-jsb">
			<view class="u-f-ac">
				<view class="u-f-ac" :class="{'active':(item.infonum.index==1)}"
				@tap="caozuo('ding')">
					<view class="icon iconfont icon-icon_xiaolian-mian"></view>
					{{item.infonum.dingnum}}
				</view>
				<view class="u-f-ac" :class="{'active':(item.infonum.index==2)}"
				@tap="caozuo('cai')">
					<view class="icon iconfont icon-kulian"></view>
					{{item.infonum.cainum}}
				</view>
			</view>
			<view class="u-f-ac">
				<view class="u-f-ac">
					<view class="icon iconfont icon-pinglun1"></view>
					{{item.commentnum}}
				</view>
				<view class="u-f-ac">
					<view class="icon iconfont icon-zhuanfa"></view>
					{{item.sharenum}}
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		props:{
			item:Object,
			index:Number
		},
		methods:{
			openSpace(){
				uni.navigateTo({
					url:"../../pages/user-space/user-space?userid="+this.item.userid
				})
			},
			// 关注
			async guanzhu(){
				try{
					let [err,res] = await this.$http.post('/follow',{
						follow_id:this.item.userid
					},{
						token:true,
						checkToken:true,
						checkAuth:true
					});
					// 错误处理
					if (!this.$http.errorCheck(err,res)){
						return;
					}
					// 通知首页修改数据
					uni.showToast({ title: '关注成功' });
					let resdata = {
					 	type:"guanzhu",
					 	userid:this.item.userid,
					 	data:true
					};
					// 通知父组件
					this.$emit('changeevent',resdata);
					// 通知首页
					uni.$emit('updateData',resdata);
				}catch(e){ return; }
			},
			// 顶踩
			async caozuo(type){
				try{
					let index = (type === 'ding') ? 1 : 2; // 操作后的状态
					if(this.item.infonum.index === index) return; // 状态相同不修改
					let [err,res] = await this.$http.post('/support',{
						post_id:this.item.id,
						type:index-1
					},{
						token:true,
						checkToken:true,
						checkAuth:true
					});
					// 错误处理
					if (!this.$http.errorCheck(err,res)) return;
					uni.showToast({
						title: index == 1 ? "顶成功" : "踩成功"
					});
					let resdata = {
						type:"support",
						post_id:this.item.id,
						do:type
					};
					// 通知父组件
					this.$emit('changeevent',resdata);
					// 通知全局
					uni.$emit("updateData",resdata);
				}catch(e){ return; }
			},
			// 进入详情页
			opendetail(){
				uni.navigateTo({
					url: '../../pages/detail/detail?detailData='+JSON.stringify(this.item),
				});
				this.User.addHistoryList(this.item);
			}
		}
	}
</script>

<style scoped>
.index-list{
	padding: 20upx;
	border-bottom: 1upx solid #EEEEEE;
}
.index-list1>view:first-child{
	color: #999999;
}
.index-list1>view:first-child image{
	width: 85upx;
	height: 85upx;
	border-radius: 100%;
	margin-right: 10upx;
}
.index-list1>view:last-child{
	background: #F4F4F4;
	border-radius:5upx;
	padding: 0 10upx;
}
.index-list2{
	padding-top: 15upx;
	font-size: 32upx;
}
.index-list3{
	position: relative;
	padding-top: 15upx;
}
.index-list3>image{
	width: 100%;
	border-radius: 20upx;
}
.index-list4 view{
	color: #999999;
}
.index-list4{
	padding: 15upx 0;
}
.index-list4>view>view>view,.index-list4>view>view:first-child{
	margin-right: 10upx;
}
.index-list-play{
	position: absolute;
	font-size: 140upx;
	color: #FFFFFF;
}
.index-list-playinfo{
	position: absolute;
	background: rgba(51, 51, 51, 0.72);
	color: #FFFFFF;
	bottom: 8upx;
	right: 8upx;
	border-radius: 40upx;
	font-size: 22upx;
	padding: 0 12upx;
}
.index-list4 .active,.index-list4 .active>view{
	color: #C5F61C;
}
</style>
