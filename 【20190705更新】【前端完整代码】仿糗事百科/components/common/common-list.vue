<template>
	<view class="common-list u-f animated fadeIn fast">
		<view class="common-list-l">
			<image :src="item.userpic" @tap.stop="openSpace" mode="widthFix" lazy-load></image>
		</view>
		<view class="common-list-r">
			<view class="u-f-ac u-f-jsb">
				<view class="u-f-ac">
					{{item.username}} 
					
					<tag-sex-age :sex="getSex" :age="getAge"></tag-sex-age>
				</view>
				<view v-show="!item.isguanzhu" @tap="guanzhu" 
				class="icon iconfont icon-zengjia">关注</view>
			</view>
			<view @tap.stop="opendetail">{{item.title}}</view>
			<view class="u-f-ajc" @tap.stop="opendetail">
				<template v-if="item.titlepic">
					<!-- 图片 -->
					<image v-if="item.titlepic" :src="item.titlepic" 
					mode="aspectFill" style="height: 350upx;" 
					lazy-load></image>
				</template>
				<!-- 视频 -->
				<template v-if="item.video">
					<view class="common-list-play icon iconfont icon-bofang">
					</view>
					<view class="common-list-playinfo">
						{{item.video.looknum}} 次播放 {{item.video.long}}
					</view>
				</template>
				<!-- 分享 -->
				<view class="common-list-share u-f-ac" v-if="item.share">
					<image :src="item.share.titlepic" 
					mode="widthFix" lazy-load></image>
					<view>{{item.share.title}}</view>
				</view>
			</view>
			<view class="u-f-ac u-f-jsb">
				<view>{{item.path}}</view>
				<view class="u-f-ac">
					<view class="icon iconfont icon-zhuanfa">
					{{item.sharenum}}</view>
					<view class="icon iconfont icon-pinglun1">
					{{item.commentnum}}</view>
					<view class="icon iconfont icon-dianzan1" @tap="caozuo('ding')">
					{{item.goodnum}}</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import tagSexAge from "./tag-sex-age.vue"
	export default {
		components:{
			tagSexAge
		},
		props:{
			nonavigate:{
				type:Boolean,
				default:false
			},
			item:Object,
			index:Number
		},
		computed: {
			getSex() {
				return this.item.sex;
			},
			getAge(){
				return this.item.age;
			}
		},
		methods:{
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
					if (!this.$http.errorCheck(err,res)) return;
					// 通知首页修改数据
					uni.showToast({ title: '关注成功' });
					let resdata = {
					 	type:"guanzhu",
					 	userid:this.item.userid,
					 	data:true
					};
					// 通知父组件
					this.$emit('changeevent',resdata);
					// 通知全局
					uni.$emit('updateData',resdata);
				}catch(e){ return; }
			},
			// 进入详情页
			opendetail(){
				uni.navigateTo({
					url: '../../pages/detail/detail?detailData='+JSON.stringify(this.item),
				});
				this.User.addHistoryList(this.item);
			},
			async caozuo(type){
				let index = (type === 'ding') ? 1 : 2; // 当前操作
				let [err,res] = await this.$http.post('/support',{
					post_id:this.item.id,
					type:index-1
				},{
					token:true,
					checkToken:true,
					checkAuth:true
				});
				if (!this.$http.errorCheck(err,res)) return;
				uni.showToast({ title: "顶成功" });
				// 通知父组件
				let resdata = {
					type:"support",
					post_id:this.item.id,
					do:type
				};
				this.$emit('changeevent',resdata);
				// 通知全局
				return uni.$emit("updateData",resdata);
			},
			openSpace(){
				if (this.nonavigate) return;
				uni.navigateTo({
					url:"../../pages/user-space/user-space?userid="+this.item.userid
				})
			}
		}
	}
</script>

<style scoped>
@import "../../common/list.css";
</style>
