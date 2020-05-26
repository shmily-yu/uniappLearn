<template>
	<view>
		<!-- 自定义导航栏 -->
		<news-nav-bar 
		:tabBars="tabBars" 
		:tabIndex="tabIndex" 
		@change-tab="changeTab">
		</news-nav-bar>
		
		<view class="uni-tab-bar">
		<swiper class="swiper-box" 
		:style="{height:swiperheight+'px'}" 
		:current="tabIndex"
		@change="tabChange">
			<!-- 关注 -->
			<swiper-item> 
				<scroll-view scroll-y class="list" @scrolltolower="loadmore()">
					<template v-if="guanzhu.list.length>0">
						<block v-for="(item,index) in guanzhu.list" :key="index">
							<common-list :item="item" :index="index"></common-list>
						</block>
						<!-- 上拉加载 -->
						<load-more :loadtext="guanzhu.loadtext"></load-more>
					</template>
					<template v-else-if="!guanzhu.firstload">
						<view style="font-size: 50upx;font-weight: bold;color: #CCCCCC;
						padding-top: 100upx;" class="u-f-ajc">Loading ...</view>
					</template>
					<template v-else>
						<!-- 无内容默认 -->
						<no-thing></no-thing>
					</template>
				</scroll-view>
			</swiper-item>
			<!-- 话题 -->
			<swiper-item> 
				<scroll-view scroll-y class="list">
					<!-- 搜索框 -->
					<view class="search-input">
						<input class="uni-input" placeholder-class="icon iconfont icon-sousuo topic-search" placeholder="搜索话题" disabled @tap="openSearch" 
						 :style="getSearchWidth"/>
					</view>
					<!-- 轮播图 -->
					<swiper class="topic-swiper" :indicator-dots="true" :autoplay="true" :interval="3000" :duration="1000" :style="getSwiperHeight">
						<block v-for="(item,index) in topic.swiper" :key="index">
							<swiper-item :style="getSwiperHeight">
								<image :src="item.src" mode="widthFix" lazy-load :style="getSwiperHeight"></image>
							</swiper-item>
						</block>
					</swiper>
					<!-- 热门分类 -->
					<topic-nav :nav="topic.nav"></topic-nav>
					<!-- 最近更新 -->
					<view class="topic-new">
						<view>最近更新</view>
						<block v-for="(item,index) in topic.list" :key="index">
							<topic-list :item="item" :index="index"></topic-list>
						</block>
					</view>
				</scroll-view>
			</swiper-item>
		</swiper>   
		</view>


	</view>
</template>

<script>
	import newsNavBar from "../../components/news/news-nav-bar.vue";
	import commonList from "../../components/common/common-list.vue";
	import loadMore from "../../components/common/load-more.vue";
	import topicNav from "../../components/news/topic-nav.vue";
	import topicList from "../../components/news/topic-list.vue";
	import noThing from "../../components/common/no-thing.vue";
	export default {
		components:{
			newsNavBar,
			commonList,
			loadMore,
			topicNav,
			topicList,
			noThing
		},
		computed: {
			getSearchWidth() {
				// #ifdef MP-ALIPAY
				return "width:700upx;";
				// #endif
			},
			getSwiperHeight() {
				// #ifdef MP-ALIPAY
				return "height: 150px;";
				// #endif
			}
		},
		data() {
			return {
				swiperheight:500,
				tabIndex:0,
				tabBars:[
					{name:"关注",id:"guanzhu"},
					{name:"话题",id:"topic"}
				],
				guanzhu:{
					firstload:false,
					loadtext:"上拉加载更多",
					page:1,
					list:[]
				},
				topic:{
					swiper:[],
					nav:[],
					list:[]
				}
			};
		},
		onLoad() {
			uni.getSystemInfo({
				success: (res)=> {
					let height=res.windowHeight-uni.upx2px(100)
					this.swiperheight=height;
				}
			});
			this.__init();
		},
		onShow() {
			this.getFollowPostList();
		},
		methods:{
			// 初始化数据
			__init(){
				this.getSwiper();
				this.getNav();
				this.getHot();
				// 开启监听
				uni.$on('updateData',this.updateData);
			},
			updateData(data){
				switch (data.type){
					case "support":
					this.updateSupport(data);
						break;
					case 'updateComment':
					this.updateComment(data);
						break;
				}
			},
			// 更新评论数
			updateComment(data){
				// 拿到当前对象
				let obj = this.guanzhu.list.find(value =>{
					return value.id === data.post_id;
				});
				if (!obj) return;
				obj.commentnum++; // 评论数+1
			},
			updateSupport(data){
				let obj = this.guanzhu.list.find((item)=>{
					return item.id === data.post_id;
				})
				if(!obj || obj.infonum.index === 1) return;
				if (data.do == 'ding') {
					obj.infonum.index = 1;
					obj.goodnum++;
				}
			},
			// 打开搜索页
			openSearch(){
				uni.navigateTo({
					url: '../search/search?searchType=topic'
				});
			},
			// 获取动态列表
			async getFollowPostList(){
				let url = `/followpost/${this.guanzhu.page}`;
				let [err,res] = await this.$http.get(url,{},{
					token:true
				});
				if (!this.$http.errorCheck(err,res)) {
					this.guanzhu.firstload = true;
					return this.guanzhu.loadtext="上拉加载更多";
				}
				let arr = [];
				console.log(res)
				let list = res.data.data.list;
				for (let i = 0; i < list.length; i++) {
					arr.push(this.__format(list[i]));
				}
				this.guanzhu.list = this.guanzhu.page > 1 
									? this.guanzhu.list.concat(arr) : arr;
				this.guanzhu.firstload = true;
				this.guanzhu.loadtext=list.length < 10 ? "没有更多数据了" : "上拉加载更多";
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
					sex:item.user.userinfo.sex,
					age:item.user.userinfo.age,
					goodnum:item.ding_count,
					commentnum:item.comment_count,
					sharenum:item.sharenum,
				};
				if (item.user_id === this.User.userinfo.id) {
					obj.isguanzhu = true;
				}
				return obj;
			},
			// 获取广告
			async getSwiper(){
				let [err,res] = await this.$http.get('/adsense/0');
				if (!this.$http.errorCheck(err,res)) return;
				let arr = [];
				let list = res.data.data.list;
				for (let i = 0; i < list.length; i++) {
					arr.push({
						src:list[i].src,
						url:list[i].url
					})
				}
				this.topic.swiper = arr;
			},
			// 获取热门分类
			async getNav(){
				let [err,res] = await this.$http.get('/topicclass');
				if (!this.$http.errorCheck(err,res)) return;
				let arr = [];
				let list = res.data.data.list;
				for (let i = 0; i < list.length; i++) {
					arr.push({
						id:list[i].id,
						name:list[i].classname
					})
				}
				this.topic.nav = arr;
			},
			// 获取热门话题
			async getHot(){
				let [err,res] = await this.$http.get('/hottopic');
				if (!this.$http.errorCheck(err,res)) return;
				let arr = [];
				let list = res.data.data.list;
				for (let i = 0; i < list.length; i++) {
					arr.push({
						id:list[i].id,
						titlepic:list[i].titlepic,
						title:list[i].title,
						desc:list[i].desc,
						totalnum:list[i].post_count,
						todaynum:list[i].todaypost_count,
					})
				}
				this.topic.list = arr;
			},
			// 点击切换
			changeTab(index){
				this.tabIndex=index;
			},
			// 滑动事件
			tabChange(e){
				this.tabIndex=e.detail.current;
			},
			// 上拉加载
			loadmore(){
				if(this.guanzhu.loadtext!="上拉加载更多") return;
				// 修改状态
				this.guanzhu.loadtext="加载中...";
				this.guanzhu.page++;
				this.getFollowPostList();
			}
		}
	}
</script>

<style>
.search-input{
	padding: 20upx;
}
.search-input>input{
	background: #F4F4F4;
	border-radius:10upx;
}
.topic-search{
	display: flex;
	justify-content: center;
	font-size: 27upx;
}

.topic-swiper{
	padding:0 20upx 20upx 20upx;
}
.topic-swiper image{
	width: 100%;
	border-radius:10upx;
}

.topic-new{
	padding: 20upx;
}
.topic-new>view:first-child{
	padding-bottom: 5upx;
	font-size: 32upx;
}
</style>
