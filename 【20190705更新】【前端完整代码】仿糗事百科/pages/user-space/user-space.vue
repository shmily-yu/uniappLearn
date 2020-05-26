<template>
	<view>
		<!-- #ifndef APP-PLUS -->
		<view class="iconfont icon-zengjia" style="position: absolute;right: 15upx;top: 15upx;z-index: 1000;color: #FFFFFF;background: rgba(51, 51, 51, 0.4);border-radius: 100%;padding: 20upx;font-size: 32upx;line-height: 1;" @tap="togleShow"></view>
		<!-- #endif -->
		<!-- 背景图 + 用户基本信息 -->
		<user-space-head :userinfo="userinfo" @update="updateGuanZhu"></user-space-head>
		<!-- 统计 -->
		<view class="user-space-data">
			<home-data :homedata="spacedata"></home-data>
		</view>
		<view style="height: 20upx; background: #F4F4F4;"></view>
		<!-- tab导航 -->
		<swiper-tab-head 
		:tabBars="tabBars" 
		:tabIndex="tabIndex"
		@tabtap="tabtap"
		scrollItemStyle="width:33.33%;"
		scrollStyle="border-bottom:0;">
		</swiper-tab-head>
		
		<block v-for="(item,index) in tablist" :key="index">
			<template v-if="tabIndex===0 && tabIndex === index">
				<!-- 主页 -->
				<user-space-userinfo :userinfo="userinfo"></user-space-userinfo>
			</template>
			<template v-else-if="tabIndex==index">
				<template v-if="item.list.length > 0">
					<!-- 列表 -->
					<block v-for="(list,listindex) in item.list" :key="listindex">
						<common-list nonavigate :item="list" :index="listindex"></common-list>
					</block>
					<!-- 上拉加载 -->
					<load-more :loadtext="item.loadtext"></load-more>
				</template>
				<template v-else-if="!item.firstload">
					<view style="font-size: 50upx;font-weight: bold;color: #CCCCCC;
					padding-top: 100upx;" class="u-f-ajc">Loading ...</view>
				</template>
				<template v-else>
					<!-- 无内容默认 -->
					<view style="font-size: 50upx;font-weight: bold;color: #CCCCCC;
					padding-top: 100upx;" class="u-f-ajc">No content~</view>
				</template>
			</template>
		</block>
		
		<!-- 操作菜单 -->
		<user-space-popup :show="show" 
		:isblack="userinfo.isblack"
		@hide="togleShow"
		@lahei="lahei"
		@chat="goToChat"></user-space-popup>
		
	</view>
</template>

<script>
	import userSpaceHead from "../../components/user-space/user-space-head.vue";
	import homeData from "../../components/home/home-data.vue";
	import swiperTabHead from "../../components/index/swiper-tab-head.vue";
	import userSpaceUserinfo from "../../components/user-space/user-space-userinfo.vue";
	import commonList from "../../components/common/common-list.vue";
	import loadMore from "../../components/common/load-more.vue";
	import userSpacePopup from "../../components/user-space/user-space-popup.vue";
	import Time from "../../common/time.js";
	import noThing from "../../components/common/no-thing.vue"
	export default {
		components:{
			userSpaceHead,
			homeData,
			swiperTabHead,
			userSpaceUserinfo,
			commonList,
			loadMore,
			userSpacePopup,
			noThing
		},
		data() {
			return {
				show:false,
				userinfo:{
					bgimg:1,
					userpic:"",
					username:"",
					sex:0,
					age:20,
					isguanzhu:false,
					regtime:"",
					id:0,
					birthday:"",
					job:"",
					path:"",
					qg:""
				},
				spacedata:[
					{ name:"获赞", num:0 },
					{ name:"关注", num:0 },
					{ name:"粉丝", num:0 },
				],
				tabIndex:0,
				tabBars:[
					{ name:"主页",id:"zhuye" },
					{ name:"糗事",id:"qiushi" },
					{ name:"动态",id:"dongtai" },
				],
				tablist:[ {},
					{
						loadtext:"上拉加载更多",
						list:[],
						page:1,
						firstload:false
					},
					{
						loadtext:"上拉加载更多",
						list:[],
						page:1,
						firstload:false
					},
				]
			}
		},
		// 上拉触底事件
		onReachBottom() {
			// 上拉加载
			this.loadmore();
		},
		onNavigationBarButtonTap(e) {
			if(e.index==0){ this.togleShow(); }
		},
		onLoad(e) {
			this.__init(e.userid);
		},
		methods: {
			__init(userid){
				// 初始化用户信息
				this.getUserInfo(userid)
				// 初始化统计数据
				this.getCounts(userid)
			},
			// 初始化用户信息
			async getUserInfo(userid){
				let sexArr=['不限','男','女'];
				let qgArr=['秘密','未婚','已婚'];
				// 用户本人
				let isme,info,isguanzhu,isblack;
				if (userid == this.User.userinfo.id) {
					info = this.User.userinfo;
					isme = true;
					isguanzhu = false;
					isblack = false;
				}else{
					// 非本人，获取用户信息
					let [err,res] = await this.$http.post('/getuserinfo',{
						user_id:userid
					},{
						token:true
					})
					// 错误处理
					if (!this.$http.errorCheck(err,res)) return;
					info = res.data.data;
					isme = false;
					isguanzhu = !!res.data.data.fens.length;
					isblack = !!res.data.data.blacklist.length;
				}
				let regtime = info.create_time ? Time.gettime.dateFormat(new Date(info.create_time*1000),'{Y}-{MM}-{DD}') : "未知";
				this.userinfo = {
					isme:isme,
					bgimg:1,
					userpic:info.userpic,
					username:info.username,
					sex:sexArr[info.userinfo.sex] || "不限",
					age:info.userinfo.age,
					isguanzhu:isguanzhu,
					isblack:isblack,
					regtime:regtime,
					id:info.id,
					birthday:info.userinfo.birthday || "未知",
					job:info.userinfo.job || "未知",
					path:info.userinfo.path || "未知",
					qg:qgArr[info.userinfo.qg] || '秘密'
				}
			},
			// 初始化统计数据
			async getCounts(id){
				let counts;
				if (id == this.User.userinfo.id) {
					counts = this.User.counts;
				}else{
					let [err,res] =await this.$http.get('/user/getcounts/'+id);
					if (!this.$http.errorCheck(err,res)) return;
					counts = res.data.data;
				}
				if (counts) {
					this.spacedata[0].num = counts.post_count;
					this.spacedata[1].num = counts.withfollow_count;
					this.spacedata[2].num = counts.withfen_count;
				}
			},
			// 更新关注状态
			updateGuanZhu(val){
				this.userinfo.isguanzhu = val;
				// 通知全局
				let resdata = {
				 	type:"guanzhu",
				 	userid:this.userinfo.id,
				 	data:val
				};
				uni.$emit('updateData',resdata);
			},
			// 操作菜单显示隐藏
			togleShow(){
				if (this.userinfo.id === this.User.userinfo.id) {
					return this.User.navigate({
						url:"/pages/user-set-userinfo/user-set-userinfo"
					})
				}
				this.show=!this.show;
			},
			// 拉黑
			async lahei(){
				uni.showLoading({ title: 'Loading...', mask: false });
				let url = this.userinfo.isblack ? '/removeblack' : '/addblack';
				let msg = this.userinfo.isblack ? '移除黑名单' : '加入黑名单';
				let [err,res] = await this.$http.post(url,{
					id:this.userinfo.id
				},{
					token:true,
					checkToken:true,
					checkAuth:true
				});
				// 错误处理
				if (!this.$http.errorCheck(err,res)) {
					uni.hideLoading();
					return this.togleShow();
				}
				// 成功
				uni.hideLoading();
				uni.showToast({ title: msg+'成功' });
				this.userinfo.isblack = !this.userinfo.isblack;
				this.togleShow();
			},
			// 聊天
			goToChat(){
				let obj = {
					userid:this.userinfo.id,
					userpic:this.userinfo.userpic,
					username:this.userinfo.username
				};
				this.User.navigate({
					url:"/pages/user-chat/user-chat?userinfo="+JSON.stringify(obj)
				})
				this.togleShow()
			},
			// 上拉加载更多
			loadmore(){
				if(this.tablist[this.tabIndex].loadtext!="上拉加载更多") return;
				// 修改状态
				this.tablist[this.tabIndex].loadtext="加载中...";
				this.tablist[this.tabIndex].page++;
				this.getList();
			},
			tabtap(index){
				this.tabIndex=index;
				if (this.tablist[index].firstload || index === 0) return;
				this.getList();
			},
			// 获取列表
			async getList(){
				let page =this.tablist[this.tabIndex].page;
				let url = this.userinfo.isme ? `/user/post/${page}` : `/user/${this.userinfo.id}/post/${page}`;
				let index = this.tabIndex;
				let [err,res] = await this.$http.get(url,{},{ token:true });
				console.log(res);
				if (!this.$http.errorCheck(err,res)) {
					this.tablist[index].firstload = true;
					return this.tablist[index].loadtext="上拉加载更多";
				}
				let arr = [];
				let list = res.data.data.list;
				for (let i = 0; i < list.length; i++) {
					arr.push(this.__format(list[i]));
				}
				this.tablist[index].list = page > 1 ? this.tablist[index].list.concat(arr) : arr;
				this.tablist[index].firstload = true;
				this.tablist[index].loadtext= list.length < 10 ? "没有更多数据了" : "上拉加载更多";
				return;
			},
			__format(item){
				let obj = {
					userid:item.user.id,
					userpic:item.user.userpic,
					username:item.user.username,
					isguanzhu:!!item.user.fens.length,
					id:item.id,
					title:item.title,
					type:"img", // img:图文,video:视频
					titlepic:item.titlepic,
					video:false,
					path:item.path,
					share:!!item.share,
					infonum:{
						index:(item.support.length>0) ? (item.support[0].type+1) : 0,//0:没有操作，1:顶,2:踩；
						dingnum:item.ding_count,
						cainum:item.cai_count,
					},
					goodnum:item.ding_count,
					commentnum:item.comment_count,
					sharenum:item.sharenum,
					sex:item.user.userinfo.sex,
					age:item.user.userinfo.age,
				};
				if (item.user_id === this.User.userinfo.id) {
					obj.isguanzhu = true;
				}
				return obj;
			},
		}
	}
</script>

<style>
.user-space-margin{
	margin: 15upx 0;
}
.user-space-data{
	background: #FFFFFF;
	position: relative;
	z-index: 10;
	border-top-left-radius: 20upx;
	border-top-right-radius: 20upx;
	margin-top: -15upx;
}

</style>
