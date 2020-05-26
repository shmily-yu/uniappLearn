<template>
	<view>
		<!-- #ifndef APP-PLUS -->
		<uni-nav-bar :shadow="false" :border="false" right-text="清除" title="浏览历史" @click-right="clickRight"></uni-nav-bar>
		<!-- #endif -->
		<template v-if="list.length > 0">
		<uni-list>
			<block v-for="(item,index) in list" :key="index">
				<uni-list-item :title="item.title" 
				:thumb="item.titlepic"
				@click="openDetail(item)"></uni-list-item>
			</block>
		</uni-list>
		</template>
		<template v-else-if="!firstload">
			<view style="font-size: 50upx;font-weight: bold;color: #CCCCCC;
			padding-top: 100upx;" class="u-f-ajc">Loading ...</view>
		</template>
		<template v-else>
			<!-- 无内容默认 -->
			<no-thing></no-thing>
		</template>
	</view>
</template>

<script>
	// #ifndef APP-PLUS
	import uniNavBar from "../../components/uni-nav-bar/uni-nav-bar.vue";
	// #endif
	import uniList from "../../components/uni-list/uni-list.vue";
	import uniListItem from "../../components/uni-list-item/uni-list-item.vue";
	import noThing from "../../components/common/no-thing.vue";
	export default {
		components: {
			uniList,
			uniListItem,
			noThing,
			// #ifndef APP-PLUS
			uniNavBar
			// #endif
		},
		data() {
			return {
				firstload:false,
				list:[]
			}
		},
		onLoad() {
			this.getList();
		},
		onNavigationBarButtonTap() {
			this.clear()
		},
		methods: {
			// #ifndef APP-PLUS
			clickRight(){
				this.clear()
			},
			// #endif
			clear(){
				uni.showModal({
					title: '提示',
					content: '是否要清除浏览历史？',
					success: res => {
						if (res.confirm) {
							this.User.clearHistory();
							this.list = [];
							uni.showToast({ title: '清除成功' });
						}
					}
				});
			},
			getList(){
				try{
					let list = uni.getStorageSync('HistoryList_'+this.User.userinfo.id);
					this.list = list ? JSON.parse(list) : [];
				}catch(e){
					uni.showToast({ title: '加载失败~', icon: 'none' });
				}
				this.firstload = true;
			},
			openDetail(item){
				uni.navigateTo({
					url: '/pages/detail/detail?detailData='+JSON.stringify(item),
				});
			}
		}
	}
</script>

<style>

</style>
