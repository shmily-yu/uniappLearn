<template>
	<view class="body">
		
		<!-- 小纸条列表 -->
		<block v-for="(item,index) in list" :key="index">
			<paper-list :item="item" :index="index"></paper-list>
		</block>
		
		
	</view>
</template>

<script>
	import paperList from "../../components/paper/paper-list.vue";
	export default {
		components:{
			paperList
		},
		data() {
			return {
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
					}
				]
			};
		},
		// 监听下拉刷新
		onPullDownRefresh() {
			this.getdata();
		},
		methods:{
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
</style>
