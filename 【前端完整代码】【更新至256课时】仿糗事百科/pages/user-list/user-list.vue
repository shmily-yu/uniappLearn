<template>
	<view class="body">
		<!-- tab切换 -->
		<swiper-tab-head 
		:tabBars="tabBars" 
		:tabIndex="tabIndex"
		@tabtap="tabtap"
		scrollItemStyle="width:33%;"
		scrollStyle="border-bottom:0;">
		</swiper-tab-head>
		
		<!-- 好友列表 -->
		<!-- <block v-for="(item,index) in list" :key="index">
			<user-list :item="item" :index="index"></user-list>
		</block> -->
		
		<view class="uni-tab-bar">
		<swiper class="swiper-box" 
		:style="{height:swiperheight+'px'}" 
		:current="tabIndex"
		@change="tabChange">
			<swiper-item v-for="(items,index) in newslist" :key="index"> 
				<scroll-view scroll-y class="list" @scrolltolower="loadmore(index)">
					<template v-if="items.list.length>0">
						<!-- 图文列表 -->
						<block v-for="(item,index1) in items.list" :key="index1">
							<user-list :item="item" :index="index1"></user-list>
						</block>
						<!-- 上拉加载 -->
						<load-more :loadtext="items.loadtext"></load-more>
					</template>
					<template v-else-if="!items.firstload">
						<view style="font-size: 50upx;font-weight: bold;color: #CCCCCC;
						padding-top: 100upx;" class="u-f-ajc">Loading ...</view>
					</template>
					<template v-else>
						<!-- 无内容默认 -->
						<no-thing></no-thing>
					</template>
				</scroll-view>
			</swiper-item>
		</swiper>   
		</view>
		
		
	</view>
</template>

<script>
	import swiperTabHead from "../../components/index/swiper-tab-head.vue";
	import userList from "../../components/user-list/user-list.vue";
	import loadMore from "../../components/common/load-more.vue";
	import noThing from "../../components/common/no-thing.vue";
	export default {
		components:{
			swiperTabHead,
			userList,
			loadMore,
			noThing
		},
		data() {
			return {
				swiperheight:500,
				tabIndex:0,
				tabBars:[
					{ name:"互关",id:"huguan",num:10 },
					{ name:"关注",id:"guanzhu",num:20 },
					{ name:"粉丝",id:"fensi",num:30 },
				],
				
				newslist:[
					{
						loadtext:"上拉加载更多",
						list:[],
						page:1,
						firstload:false,
					},
					{
						loadtext:"上拉加载更多",
						list:[],
						page:1,
						firstload:false,
					},
					{
						loadtext:"上拉加载更多",
						list:[],
						page:1,
						firstload:false,
					}
				]
				
			};
		},
		onLoad() {
			uni.getSystemInfo({
				success: (res)=> {
					let height=res.windowHeight-uni.upx2px(100)
					this.swiperheight=height;
				}
			});
		},
		// 监听导航按钮事件
		onNavigationBarButtonTap(e) {
			if(e.index==0){
				uni.navigateBack({
					delta: 1
				});
			}
		},
		onNavigationBarSearchInputClicked() {
			uni.navigateTo({
				url: '../search/search?searchType=user',
			});
		},
		onShow() {
			this.__init();
		},
		methods:{
			__init(){
				this.tabBars[0].num = this.User.counts.friend_count < 100 ? this.User.counts.friend_count : '99+';
				this.tabBars[1].num = this.User.counts.withfollow_count < 100 ? this.User.counts.withfollow_count : '99+';
				this.tabBars[2].num = this.User.counts.withfen_count < 100 ? this.User.counts.withfen_count : '99+';
				this.getList();
			},
			getUrl(){
				let arr = ['/friends/','/follows/','/fens/'];
				return arr[this.tabIndex]+this.newslist[this.tabIndex].page;
			},
			// 获取列表
			async getList(){
				try{
					let currentIndex = this.tabIndex;
					let [err,res] = await this.$http.get(this.getUrl(),{},{
						token:true,
						checkToken:true
					});
					// 错误处理
					if (!this.$http.errorCheck(err,res)) {
						this.newslist[currentIndex].loadtext="上拉加载更多";
						return;
					}
					// 获取成功
					let arr = [];
					console.log(res)
					let list = res.data.data.list;
					for (let i = 0; i < list.length; i++) {
						arr.push(this.__format(list[i],currentIndex));
					}
					this.newslist[currentIndex].list = this.newslist[currentIndex].page > 1 ? this.newslist[currentIndex].list.concat(arr) : arr;
					this.newslist[currentIndex].firstload = true;
					this.newslist[currentIndex].loadtext= list.length < 10 ? "没有更多数据了" : "上拉加载更多";
					return;
				}catch(e){
					return;
				}
			},
			__format(item,currentIndex){
				return {
					id:item.userinfo.user_id,
					userpic:item.userpic,
					username:item.username,
					age:item.userinfo.age,
					sex:item.userinfo.sex,
					isguanzhu:currentIndex !== 2 
				}
			},
			loadmore(index){
				if(this.newslist[index].loadtext!=="上拉加载更多")  return;
				// 修改状态
				this.newslist[index].loadtext="加载中...";
				this.newslist[index].page++;
				this.getList();
			},
			// tabbar点击事件
			tabtap(index){
				this.tabIndex=index;
			},
			// 滑动事件
			tabChange(e){
				this.tabIndex=e.detail.current;
				// 判断是否首次加载过了
				if (!this.newslist[this.tabIndex].firstload) {
					this.getList();
				}
			}
		}
	}
</script>

<style>

</style>
