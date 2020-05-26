<template>
	<view class="uni-tab-bar">
      
	<!-- 导航栏 -->
	<!-- #ifndef APP-PLUS -->
	<uni-nav-bar :shadow="false" :border="false" 
	@click-left="clickLeft" @click-right="clickRight">
		<!-- 左边图标 -->
		<block slot="left">
			<view class="iconfont icon-qiandao" style="font-size: 22px;color: #FF9619;margin-left: 20upx;"></view>
		</block>
		<!-- 中间搜索框 -->
		<view style="display: flex;justify-content: center;align-items: center;border-radius: 4px;margin-left: -46upx;height: 60upx;margin-top: 12upx;color: #CCCCCC;background: #F7F7F7;" @tap="openSearch">
			<view class="iconfont icon-sousuo" style="margin-right: 6upx;"></view>搜索糗事
		</view>
		<!-- 右边图标 -->
		<block slot="right">
			<view class="icon iconfont icon-bianji1" style="font-size: 22px;color: #000000;"></view>
		</block>
	</uni-nav-bar>
	<!-- #endif -->
	  
	  
	<swiper-tab-head 
	:tabBars="tabBars" 
	:tabIndex="tabIndex"
	@tabtap="tabtap">
	</swiper-tab-head>
	

	<swiper class="swiper-box" 
	:style="getHeight"
	:current="tabIndex"
	@change="tabChange">
		<swiper-item v-for="(items,index) in newslist" :key="index" :style="getHeight"> 
			<scroll-view scroll-y class="list" @scrolltolower="loadmore(index)" :style="getHeight">
				<template v-if="items.list.length>0">
					<!-- 图文列表 -->
					<block v-for="(item,index1) in items.list" :key="index1">
						<index-list @changeevent="updateData" :item="item" :index="index1"></index-list>
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
</template>


<script>
	// #ifndef APP-PLUS
	import uniNavBar from "../../components/uni-nav-bar/uni-nav-bar.vue";
	// #endif
	import indexList from "../../components/index/index-list.vue";
	import swiperTabHead from "../../components/index/swiper-tab-head.vue";
	import loadMore from "../../components/common/load-more.vue";
	import noThing from "../../components/common/no-thing.vue";
	export default {
		components:{
			indexList,
			swiperTabHead,
			loadMore,
			noThing,
			// #ifndef APP-PLUS
			uniNavBar
			// #endif
		},
		data() {
			return {
				tabIndex:0,
				tabBars:[],	
				newslist:[],
			}
		},
		computed: {
			getHeight() {
				// #ifdef MP-ALIPAY
				let height = uni.getSystemInfoSync().windowHeight - uni.upx2px(100) - 44;
				return `height: ${height}px;`;
				// #endif
			}
		},
		onLoad() {
			this.getNav();
			// 开启监听
			uni.$on('updateData',this.updateData);
		},
		// 监听搜索框点击事件
		onNavigationBarSearchInputClicked() {
			uni.navigateTo({
				url: '../search/search',
			});
		},
		// 监听原生标题导航按钮点击事件
		onNavigationBarButtonTap(e){
			switch (e.index){
				case 1:
				// 打开发布页面
				this.User.navigate({
					url: '../add-input/add-input?postclass='+JSON.stringify(this.tabBars),
				})
					break;
			}
		},
		methods: {
			// #ifndef APP-PLUS
			clickLeft(){
				console.log('左边事件')
			},
			clickRight(){
				// 打开发布页面
				this.User.navigate({
					url: '../add-input/add-input?postclass='+JSON.stringify(this.tabBars),
				})
			},
			openSearch(){
				uni.navigateTo({
					url: '../search/search',
				});
			},
			// #endif
			updateData(data){
				switch (data.type){
					case "guanzhu":
					this.updateGuanZhu(data);
						break;
					case "support":
					this.updateSupport(data);
						break;
					case "updateList":
					this.updateList(data);
						break;
					case 'updateComment':
					this.updateComment(data);
						break;
				}
			},
			// 更新评论数
			updateComment(data){
				// 拿到当前对象
				let obj = this.newslist[this.tabIndex].list.find(value =>{
					return value.id === data.post_id;
				});
				if (!obj) return;
				obj.commentnum++; // 评论数+1
			},
			// 更新关注信息
			updateGuanZhu(data){
				this.newslist[this.tabIndex].list.forEach((item,index)=>{
					if (item.userid === data.userid) {
						item.isguanzhu = data.data;
					}
				})
			},
			// 更新顶踩数据状态
			updateSupport(data){
				// 拿到当前对象
				let obj = this.newslist[this.tabIndex].list.find(value =>{
					return value.id === data.post_id;
				});
				if (!obj) return;
				let oldindex = obj.infonum.index; // 操作前的状态
				obj.infonum.index = (data.do == 'ding') ? 1 : 2; // 操作后的状态
				if (oldindex !== 0) { //之前操作过
					oldindex == 1 ? obj.infonum.dingnum-- : obj.infonum.cainum--;
				}
				if (obj.infonum.index !== 0) {  // 当前操作
					obj.infonum.index == 1 
						? obj.infonum.dingnum++ : obj.infonum.cainum++;
				}
			},
			// 更新用户发布信息
			updateList(data){
				// 第一种，直接追加
				let index = this.tabBars.findIndex((val)=>{
					return val.id === data.post_class_id;
				})
				if (index > -1) {
					this.newslist[index].list.push(this.__format(data));
				}
				// 第二种，重新加载当前post_class_id信息
			},
			// 获取文章分类
			async getNav(){
				let [err,res] =await this.$http.get('/postclass');
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
				let currentIndex = this.tabIndex;
				let url = `/postclass/${this.tabBars[this.tabIndex].id}/post/${this.newslist[this.tabIndex].page}`;
				let [err,res] = await this.$http.get(url,{},{token:true});
				let error = this.$http.errorCheck(err,res,()=>{
					this.newslist[currentIndex].loadtext="上拉加载更多";
				},()=>{
					this.newslist[currentIndex].loadtext="上拉加载更多";
				});
				console.log(res)
				if (!error) return;
				let arr = [];
				let list = res.data.data.list;
				for (let i = 0; i < list.length; i++) {
					arr.push(this.__format(list[i]));
				}
				this.newslist[currentIndex].list = this.newslist[currentIndex].page > 1 ? this.newslist[currentIndex].list.concat(arr) : arr;
				this.newslist[currentIndex].firstload = true;
				if (list.length < 10) {
					this.newslist[currentIndex].loadtext="没有更多数据了";
				}else{
					this.newslist[currentIndex].loadtext="上拉加载更多";
				}
				return;
			},
			// 格式转化
			__format(item){
				return {
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
					commentnum:item.comment_count,
					sharenum:item.sharenum,
				}
			},
			// 上拉加载
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
		},
	}
</script>

<style>

</style>
