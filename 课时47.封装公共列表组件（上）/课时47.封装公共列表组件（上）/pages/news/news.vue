<template>
	<view>
		<!-- 自定义导航栏 -->
		<uni-nav-bar :fixed="true" :statusBar="true" @click-right="openAdd">
			<!-- 左边 -->
			<block slot="left">
				<view class="nav-left">
					<view class="icon iconfont icon-qiandao"></view>
				</view>
			</block>
			<!-- 中间 -->
			<view class="nav-tab-bar u-f-ajc">
				<block v-for="(tab,index) in tabBars" :key="tab.id">
					<view class="u-f-ajc" 
					:class="{'active':tabIndex==index}" 
					@tap="changeTab(index)">
						{{tab.name}}
						<view v-if="(tabIndex==index)" class="nav-tab-bar-line"></view>
					</view>
				</block>
			</view>
			<!-- 右边 -->
			<block slot="right">
				<view class="nav-right u-f-ajc">
					<view class="icon iconfont icon-bianji1"></view>
				</view>
			</block>
		</uni-nav-bar>
		<!-- 列表 -->
		<block v-for="(item,index) in list" :key="index">
			<view class="common-list u-f">
				<view class="common-list-l">
					<image :src="item.userpic" mode="widthFix" lazy-load></image>
				</view>
				<view class="common-list-r">
					<view class="u-f-ac u-f-jsb">
						<view class="u-f-ac">
							{{item.username}} 
							<view class="tag-sex icon iconfont"
							:class="[item.sex==0?'icon-nan':'icon-nv']">
								{{item.age}}
							</view> 
						</view>
						<view v-show="!item.isguanzhu" 
						class="icon iconfont icon-zengjia">关注</view>
					</view>
					<view>{{item.title}}</view>
					<view class="u-f-ajc">
						<!-- 图片 -->
						<image v-if="item.titlepic" :src="item.titlepic" 
						mode="widthFix" 
						lazy-load></image>
						<!-- 视频 -->
						<template v-if="item.video">
							<view class="common-list-play icon iconfont icon-bofang">
							</view>
							<view class="common-list-playinfo">
								{{item.video.looknum}} 次播放 {{item.video.long}}
							</view>
						</template>
						<!-- 分享 -->
						<view class="common-list-share u-f-ac" v-if="item.share">
							<image :src="item.share.titlepic" 
							mode="widthFix" lazy-load></image>
							<view>{{item.share.title}}</view>
						</view>
					</view>
					<view class="u-f-ac u-f-jsb">
						<view>{{item.path}}</view>
						<view class="u-f-ac">
							<view class="icon iconfont icon-zhuanfa">
							{{item.sharenum}}</view>
							<view class="icon iconfont icon-pinglun1">
							{{item.commentnum}}</view>
							<view class="icon iconfont icon-dianzan1">
							{{item.goodnum}}</view>
						</view>
					</view>
				</view>
			</view>
		</block>

	</view>
</template>

<script>
	import uniNavBar from "../../components/uni-nav-bar/uni-nav-bar.vue";
	export default {
		components:{
			uniNavBar
		},
		data() {
			return {
				tabIndex:0,
				tabBars:[
					{name:"关注",id:"guanzhu"},
					{name:"话题",id:"topic"}
				],
				list:[
					// 文字
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"哈哈",
						sex:0, //0 男 1 女
						age:25,
						isguanzhu:false,
						title:"我是标题",
						titlepic:"",
						video:false,
						share:false,
						path:"深圳 龙岗",
						sharenum:20,
						commentnum:30,
						goodnum:20
					},
					// 图文
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"哈哈",
						sex:0, //0 男 1 女
						age:25,
						isguanzhu:false,
						title:"我是标题",
						titlepic:"../../static/demo/datapic/13.jpg",
						video:false,
						share:false,
						path:"深圳 龙岗",
						sharenum:20,
						commentnum:30,
						goodnum:20
					},
					// 视频
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"哈哈",
						sex:0, //0 男 1 女
						age:25,
						isguanzhu:false,
						title:"我是标题",
						titlepic:"../../static/demo/datapic/13.jpg",
						video:{
							looknum:"20w",
							long:"2:47"
						},
						share:false,
						path:"深圳 龙岗",
						sharenum:20,
						commentnum:30,
						goodnum:20
					},
					// 分享
					{
						userpic:"../../static/demo/userpic/12.jpg",
						username:"哈哈",
						sex:0, //0 男 1 女
						age:25,
						isguanzhu:false,
						title:"我是标题",
						titlepic:"",
						video:false,
						share:{
							title:"我是分享的标题",
							titlepic:"../../static/demo/datapic/14.jpg"
						},
						path:"深圳 龙岗",
						sharenum:20,
						commentnum:30,
						goodnum:20
					},
				]
			};
		},
		methods:{
			changeTab(index){
				this.tabIndex=index;
			},
			openAdd(){
				// 打开发布页面
				uni.navigateTo({
					url: '../add-input/add-input',
				});
			}
		}
	}
</script>

<style>
.common-list{
	padding: 20upx;
}
.common-list-l{
	flex-shrink: 0;
}
.common-list-l image{
	width: 90upx;
	height: 90upx;
	border-radius:100%;
}
.common-list-r{
	flex: 1;
	margin-left: 15upx;
	border-bottom: 1upx solid #EEEEEE;
	padding-bottom: 10upx;
}
.common-list-r>view:nth-child(3)>image{
	width: 100%;
	border-radius:10upx;
}
.common-list-r>view:nth-child(1)>view:first-child{
	color: #999999;
	font-size: 32upx;
}
.tag-sex{
	background: #007AFF;
	color: #FFFFFF;
	font-size: 23upx;
	padding: 5upx 10upx;
	margin-left: 10upx;
	border-radius:20upx;
	line-height: 22upx;
}
.common-list-r>view:nth-child(1)>view:last-child{
	background: #EEEEEE;
	padding: 0 10upx;
	font-size: 26upx;
}
.common-list-r>view:nth-child(2){
	font-size: 32upx;
	padding: 12upx 0;
}
.common-list-r>view:nth-child(3){
	position: relative;
}
.common-list-play,.common-list-playinfo{
	position: absolute;
	color: #FFFFFF;
}
.common-list-play{
	font-size: 130upx;
}
.common-list-playinfo{
	right: 10upx;
	bottom: 10upx;
	background: rgba(51, 51, 51, 0.73);
	border-radius: 20upx;
	padding: 0 20upx;
	font-size: 26upx;
}
.common-list-r>view:nth-child(4)>view{
	color: #AAAAAA;
}
.common-list-r>view:nth-child(4)>view:nth-child(2)>view{
	margin-left: 10upx;
	padding-left: 5upx;
}
.common-list-share{
	background: #EEEEEE;
	width: 100%;
	padding: 10upx;
	border-radius: 10upx;
}
.common-list-share>image{
	width: 200upx;
	height: 150upx;
	margin-right: 10upx;
}


.nav-left>view,.nav-right>view{
	font-size: 40upx;
}
.nav-left>view{
	color: #FF9619;
}
.nav-left{
	margin-left: 16upx;
}
.nav-right{
	width: 100%;
}
.nav-tab-bar{
	width: 100%;
	margin-left: -20upx;
	position: relative;
}
.nav-tab-bar>view{
	font-size: 32upx;
	padding: 0 15upx;
	font-weight: bold;
	color: #969696;
}
.active{
	color: #333333!important;
}
.nav-tab-bar-line{
	border-bottom: 5upx solid #FEDE33;
	border-top: 5upx solid #FEDE33;
	width: 70upx;
	border-radius: 20upx;
	position: absolute;
	bottom: 12upx;
}
</style>
