<template>
	<view>
		
		<!-- 自定义导航 -->
		<!-- #ifndef APP-PLUS -->
		<view style="display: flex;
		align-items: center;
		padding:0 20upx;height: 88upx;
		position: fixed;z-index: 9999;
		left: 0;
		top: 0;
		right: 0;
		background: #FFFFFF;">
			<view class="iconfont icon-sousuo" 
			style="position: absolute;left: 30upx;color: #CCCCCC;"></view>
			<input style="flex: 1;padding: 5upx 0 5upx 50upx;border-radius: 4px;background: #F7F7F7;" 
			type="text" v-model="searchtext" @confirm="getdata"
			:placeholder="getPlaceholder" 
			placeholder-style="color: #CCCCCC;"/>
			<text style="padding-left:20upx;"
			@click="goBack">取消</text>
		</view>
		<view style="height: 88upx;"></view>
		<!-- #endif -->
		
		<template v-if="list.length>0">
			<block v-for="(item,index) in list" :key="index">
				<template v-if="searchType == 'post'">
					<index-list @changeevent="updateData" :item="item" :index="index"></index-list>
				</template>
				<template v-else-if="searchType == 'topic'">
					<view style="padding:0 20upx;">
						<topic-list :item="item" :index="index"></topic-list>
					</view>
				</template>
				<template v-else>
					<view style="padding:0 20upx;">
						<user-list :item="item" :index="index" hidden></user-list>
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
	import userList from "../../components/user-list/user-list.vue";
	export default {
		components:{
			indexList,
			noThing,
			loadMore,
			topicList,
			userList
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
		computed: {
			getPlaceholder() {
				let type = '文章'
				if (this.searchType == 'post') {
					type = '文章';
				}else if(this.searchType == 'topic'){
					type = '话题';
				}else if(this.searchType == 'user'){
					type = '用户';
				}
				return '搜索'+type;
			}
		},
		onLoad(e) {
			if (!e) return;
			this.searchType = e.searchType || 'post';
			// #ifdef APP-PLUS
			let pageTitle = '搜索文章';
			if (this.searchType == 'topic') {
				pageTitle = '搜索话题';
			} else if(this.searchType == 'user'){
				pageTitle = '搜索用户';
			}
			let currentWebview = this.$mp.page.$getAppWebview();  
			let tn = currentWebview.getStyle().titleNView;  
			tn.searchInput.placeholder = pageTitle; 
			currentWebview.setStyle({  
				titleNView: tn  
			});
			// #endif
			// 开启监听
			uni.$on('updateData',this.updateData);
		},
		methods:{
			// #ifndef APP-PLUS
			goBack(){
				uni.navigateBack({
					delta: 1
				});
			},
			// #endif
			updateData(data){
				switch (data.type){
					case "guanzhu":
					this.updateGuanZhu(data)
						break;
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
				let obj = this.list.find(value =>{
					return value.id === data.post_id;
				});
				if (!obj) return;
				obj.commentnum++; // 评论数+1
			},
			// 更新顶踩数据状态
			updateSupport(data){
				// 拿到当前对象
				let obj = this.list.find(value =>{
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
			// 更新关注信息
			updateGuanZhu(data){
				this.list.forEach((item,index)=>{
					if (item.userid === data.userid) {
						item.isguanzhu = data.data;
					}
				})
			},
			// 搜索事件
			async getdata(){
				uni.showLoading({title:"Loading..."});
				let url = '/search/'+this.searchType;
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
				this.loadtext= list.length < 10 ? "没有更多数据了" : "上拉加载更多";
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
						sex:item.user.userinfo.sex,
						age:item.user.userinfo.age,
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
					case "user":
					return {
						id:item.id,
						userpic:item.userpic,
						username:item.username,
						age:item.userinfo.age,
						sex:item.userinfo.sex,
						isguanzhu:false
					}
						break;
				}
				
			},
		}
	}
</script>

<style>

</style>
