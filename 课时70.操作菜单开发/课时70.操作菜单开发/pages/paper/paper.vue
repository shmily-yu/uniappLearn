<template>
	<view class="body">
		
		<!-- 操作菜单 -->
		<view class="papar-left-popup-mask" v-show="show" @tap="hidepopup"></view>
		<view class="papar-left-popup" v-show="show">
			<view class="u-f-ac" hover-class="papar-left-popup-h" @tap="addfriend">
				<view class="icon iconfont icon-sousuo"></view> 
				加糗友
			</view>
			<view class="u-f-ac" hover-class="papar-left-popup-h" @tap="clear">
				<view class="icon iconfont icon-qingchu"></view> 
				清除缓存
			</view>
		</view>
		
		<!-- 小纸条列表 -->
		<block v-for="(item,index) in list" :key="index">
			<paper-list :item="item" :index="index"></paper-list>
		</block>
		
		<!-- 上拉加载 -->
		<load-more :loadtext="loadtext"></load-more>
		
	</view>
</template>

<script>
	import paperList from "../../components/paper/paper-list.vue";
	import loadMore from "../../components/common/load-more.vue";
	export default {
		components:{
			paperList,
			loadMore
		},
		data() {
			return {
				show:false,
				loadtext:"上拉加载更多",
				list:[
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:2
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:0
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:0
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:11
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:2
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:0
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:0
					},
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:11
					}
				]
			};
		},
		// 监听下拉刷新
		onPullDownRefresh() {
			this.getdata();
		},
		onReachBottom() {
			this.loadmore();
		},
		// 监听导航按钮点击事件
		onNavigationBarButtonTap(e) {
			switch (e.index){
				case 0:
				console.log("点击了左边按钮");
				this.hidepopup();
					break;
				case 1:
				this.showpopup();
					break;
			}
		},
		methods:{
			// 操作菜单
			addfriend(){
				console.log("加糗友");
				this.hidepopup();
			},
			clear(){
				console.log("清除缓存");
				this.hidepopup();
			},
			hidepopup(){
				this.show=false;
			},
			showpopup(){
				this.show=true;
			},
			// 上拉加载
			loadmore(){
				if(this.loadtext!="上拉加载更多"){ return; }
				// 修改状态
				this.loadtext="加载中...";
				// 获取数据
				setTimeout(()=> {
					//获取完成
					let obj={
						userpic:"../../static/demo/userpic/12.jpg",
						username:"昵称",
						time:"10:21",
						data:"我是信息",
						noreadnum:11
					};
					this.list.push(obj);
					this.loadtext="上拉加载更多";
				}, 1000);
				//this.loadtext="没有更多数据了";
			},
			// 获取数据
			getdata(){
				setTimeout(()=> {
					// 服务器获取数据
					let arr=[
						{
							userpic:"../../static/demo/userpic/12.jpg",
							username:"昵称1111",
							time:"10:21",
							data:"我是信息",
							noreadnum:2
						},
						{
							userpic:"../../static/demo/userpic/12.jpg",
							username:"昵称222",
							time:"10:21",
							data:"我是信息",
							noreadnum:0
						},
						{
							userpic:"../../static/demo/userpic/12.jpg",
							username:"昵称333",
							time:"10:21",
							data:"我是信息",
							noreadnum:0
						},
						{
							userpic:"../../static/demo/userpic/12.jpg",
							username:"昵称444",
							time:"10:21",
							data:"我是信息",
							noreadnum:11
						}
					];
					// 赋值
					this.list=arr;
					// 关闭下拉刷新
					uni.stopPullDownRefresh();
				}, 2000);
			}
		}
	}
</script>

<style>
.body{
	padding: 0 20upx;
}
.papar-left-popup-mask{
	position: fixed;
	right: 0;
	left: 0;
	top: 0;
	bottom: 0;
	z-index: 1999;
}
.papar-left-popup{
	position: fixed;
	right: 0;
	top: 10upx;
	background: #FFFFFF;
	z-index: 2000;
	width: 55%;
	box-shadow: 1upx 1upx 20upx 2upx #CCCCCC;
}
.papar-left-popup>view{
	padding: 20upx;
	font-size: 35upx;
}
.papar-left-popup>view>view{
	margin-right: 10upx;
	font-weight: bold;
}
.papar-left-popup-h{
	background: #EEEEEE;
}
</style>
