<template>
	<view class="uni-tab-bar">
		
		<swiper-tab-head 
		:tabBars="tabBars" 
		:tabIndex="tabIndex"
		@tabtap="tabtap">
		</swiper-tab-head>
		

		<swiper class="swiper-box" 
		:current="tabIndex"
		:style="getHeight"
		@change="tabChange">
			<swiper-item v-for="(items,index) in newslist" :key="index" :style="getHeight"> 
				<scroll-view scroll-y class="list" @scrolltolower="loadmore(index)" :style="getHeight">
					<template v-if="items.list.length>0">
						<!-- 话题列表 -->
						<view class="topic-view">
						<block v-for="(item,index1) in items.list" :key="index1">
							<topic-list :ischange="ischange" :item="item" :index="index1"></topic-list>
						</block>	
						</view>
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
</template>

<script>
	import swiperTabHead from "../../components/index/swiper-tab-head.vue";
	import noThing from "../../components/common/no-thing.vue";
	import loadMore from "../../components/common/load-more.vue";
	import topicList from "../../components/news/topic-list.vue";
	export default {
		components:{
			swiperTabHead,
			noThing,
			loadMore,
			topicList
		},
		data() {
			return {
				ischange:false,
				tabIndex:0,
				tabBars:[],
				newslist:[],
			};
		},
		computed: {
			getHeight() {
				// #ifdef MP-ALIPAY
				let height = uni.getSystemInfoSync().windowHeight - uni.upx2px(100);
				return `height: ${height}px;`;
				// #endif
			}
		},
		onLoad(e) {
			if (e.ischange) {
				this.ischange = true;
				// 修改页面标题
				uni.setNavigationBarTitle({
					title:"选择所属话题"
				})
			}
			this.getNav();
		},
		methods:{
			// 获取文章分类
			async getNav(){
				let [err,res] =await this.$http.get('/topicclass');
				if (!this.$http.errorCheck(err,res)) return;
				let list = res.data.data.list;
				let arr = [];
				let arr2 = [];
				for (let i = 0; i < list.length; i++) {
					arr.push({
						id:list[i].id,
						name:list[i].classname
					})
					arr2.push({
						loadtext:"上拉加载更多",
						list:[],
						page:1,
						firstload:false
					});
				}
				this.tabBars = arr;
				this.newslist = arr2;
				this.tabBars.length > 0 && this.getList();
			},
			// 获取指定列表
			async getList(){
				let url = `/topicclass/${this.tabBars[this.tabIndex].id}/topic/${this.newslist[this.tabIndex].page}`;
				let [err,res] = await this.$http.get(url);
				let error = this.$http.errorCheck(err,res,()=>{
					this.newslist[this.tabIndex].loadtext="上拉加载更多";
				},()=>{
					this.newslist[this.tabIndex].loadtext="上拉加载更多";
				});
				if (!error) return;
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
					});
				}
				this.newslist[this.tabIndex].list = this.newslist[this.tabIndex].page > 1 ? this.newslist[this.tabIndex].list.concat(arr) : arr;
				this.newslist[this.tabIndex].firstload = true;
				if (list.length < 10) {
					this.newslist[this.tabIndex].loadtext="没有更多数据了";
				}else{
					this.newslist[this.tabIndex].loadtext="上拉加载更多";
				}
				return;
			},
			loadmore(index){
				if(this.newslist[index].loadtext!="上拉加载更多"){ return; }
				// 修改状态
				this.newslist[index].loadtext="加载中...";
				this.newslist[this.tabIndex].page++;
				this.getList();
			},
			// tabbar点击事件
			tabtap(index){
				this.tabIndex=index;
				// #ifdef MP-ALIPAY
				this.getList();
				// #endif
			},
			// 滑动事件
			tabChange(e){
				this.tabIndex=e.detail.current;
				this.getList();
			}
		}
	}
</script>

<style>
.topic-view{
	padding: 0 20upx;
}
</style>
