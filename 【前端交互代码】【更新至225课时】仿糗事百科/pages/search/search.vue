<template>
	<view>
		<template v-if="list.length>0">
			<block v-for="(item,index) in list" :key="index">
				<template v-if="searchType == 'post'">
					<index-list :item="item" :index="index"></index-list>
				</template>
				<template v-else-if="searchType == 'topic'">
					<view style="padding:0 20upx;">
						<topic-list :item="item" :index="index"></topic-list>
					</view>
				</template>
			</block>
			<load-more :loadtext="loadtext"></load-more>
		</template>
		<template v-else-if="issearch && list.length<1">
			<no-thing></no-thing>
		</template>
	</view>
</template>

<script>
	import indexList from "../../components/index/index-list.vue";
	import noThing from "../../components/common/no-thing.vue";
	import loadMore from "../../components/common/load-more.vue";
	import topicList from "../../components/news/topic-list.vue";
	export default {
		components:{
			indexList,
			noThing,
			loadMore,
			topicList
		},
		data() {
			return {
				issearch:false,
				loadtext:"上拉加载更多",
				list:[],
				searchtext:"",
				page:1,
				searchType:"post"
			};
		},
		// 监听原生标题导航按钮点击事件(取消按钮)
		onNavigationBarButtonTap(e){
			if(e.index==0){
				uni.navigateBack({
					delta: 1
				});
			}
		},
		// 监听搜索框文本变化
		onNavigationBarSearchInputChanged(e){
			this.searchtext=e.text;
		},
		// 监听点击搜索按钮事件
		onNavigationBarSearchInputConfirmed(e){
			if(e.text){ this.getdata(); }
		},
		// 监听页面触底事件
		onReachBottom() {
			this.loadmore();
		},
		// 监听下拉刷新
		onPullDownRefresh() {
			this.getdata();
			uni.stopPullDownRefresh();
		},
		onLoad(e) {
			if (!e) return;
			this.searchType = e.searchType || 'post';
			// #ifdef APP-PLUS
			if (this.searchType == 'topic') {
				let currentWebview = this.$mp.page.$getAppWebview();  
				let tn = currentWebview.getStyle().titleNView;  
				tn.searchInput.placeholder = '搜索话题'; 
				currentWebview.setStyle({  
					titleNView: tn  
				});
			} 
			// #endif
		},
		methods:{
			// 搜索事件
			async getdata(){
				uni.showLoading({title:"Loading..."});
				let url = '/search/post';
				switch (this.searchType){
					case "post":
					url = '/search/post';
						break;
					case "topic":
					url = '/search/topic';
						break;
				}
				let [err,res] =await this.$http.post(url,{
					keyword:this.searchtext,
					page:this.page
				},{token:true});
				let error = this.$http.errorCheck(err,res,()=>{
					uni.hideLoading();
					this.issearch=true;
				},()=>{
					uni.hideLoading();
					this.issearch=true;
				});
				if (!error) return;
				let arr = [];
				let list = res.data.data.list;
				console.log(res)
				for (let i = 0; i < list.length; i++) {
					arr.push(this.__format(list[i]));
				}
				this.list = this.page > 1 ? this.list.concat(arr) : arr;
				this.issearch = true;
				if (list.length < 10) {
					this.loadtext="没有更多数据了";
				}else{
					this.loadtext="上拉加载更多";
				}
				uni.hideLoading();
			},
			// 上拉加载
			loadmore(){
				if(this.loadtext!="上拉加载更多"){ return; }
				// 修改状态
				this.loadtext="加载中...";
				this.page++;
				this.getdata();
			},
			// 格式转化
			__format(item){
				switch (this.searchType){
					case "post":
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
							index:(item.support.length>0) ? (item.support[0].type+1) : 0,
							dingnum:item.ding_count,
							cainum:item.cai_count,
						},
						commentnum:item.comment_count,
						sharenum:item.sharenum,
					}
						break;
					case "topic":
					return {
						id:item.id,
						titlepic:item.titlepic,
						title:item.title,
						desc:item.desc,
						totalnum:item.post_count,
						todaynum:item.todaypost_count,
					}
						break;
				}
				
			},
		}
	}
</script>

<style>

</style>
