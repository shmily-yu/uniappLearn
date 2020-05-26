<template>
	<view style="overflow: hidden;">
		<!-- 自定义导航栏 -->
		<uni-nav-bar :statusBar="true" rightText="发布" left-icon="back" @click-left="back" @click-right="submit">
			<view class="u-f-ajc" @tap="changelook">
				{{getType}}
				<view class="icon iconfont icon-xialazhankai"></view>
			</view>
		</uni-nav-bar>
		<!-- 多行输入框 -->
		<view class="uni-textarea">
			<textarea v-model="text" placeholder="说一句话吧~" />
		</view>
		<!-- 上传多图 -->
		<uploud-images @upload="upload" @del='delImageList' :image-list="imglist"></uploud-images>
		<!-- 弹出公告 -->
		<uni-popup :show="showpopup" position="middle" mode="fixed" @hidePopup="hidePopup">
			<view class="gonggao">
				<view class="u-f-ajc">
					<image src="../../static/common/addinput.png" mode="widthFix"></image>
				</view>
				<view>1.涉及黄色，政治，广告及骚扰信息</view>
				<view>2.涉及黄色，政治，广告及骚扰信息</view>
				<view>3.涉及黄色，政治，广告及骚扰信息</view>
				<view>4.涉及黄色，政治，广告及骚扰信息</view>
				<button type="default" @tap="hidePopup">朕知道了</button>
			</view>
		</uni-popup>
		
		<!-- 底部 -->
		<view class="u-f-ac addinput-foot">
			
			<picker class="u-f1 u-f-ajc" mode="selector" :range="postclass.range" @change="changePostClass">
				<view class="u-f1 u-f-ajc">
				{{postclass.title ? postclass.title : "选择分类"}}
				</view>
			</picker>
			
			<view class="u-f1 u-f-ajc" 
			hover-class="addinput-foot-btn"
			@tap="changeTopic">{{topic.title ? topic.title : "选择话题"}}</view>
		</view>
		
	</view>
</template>

<script>
	let changelook= ['仅自己可见','所有人可见'];
	import uniNavBar from "../../components/uni-nav-bar/uni-nav-bar.vue";
	import uploudImages from "../../components/common/uploud-images.vue";
	import uniPopup from "../../components/uni-popup/uni-popup.vue";
	export default {
		components:{
			uniNavBar,
			uploudImages,
			uniPopup
		},
		data() {
			return {
				isget:false,
				showpopup:true,
				yinsi:1,
				text:"",
				imglist:[],
				imglistIds:[],
				postclass:{
					id:0,     // 当前选中分类id
					title:"", // 当前选中分类名称
					range:[], // 可选项
					list:[]   // 服务端获取到的分类列表
				},
				topic:{
					id:0,	  // 当前选中话题id
					title:""  // 当前选中话题名称
				}
			};
		},
		onBackPress() {
			// 如果有值
			if(!this.text && this.imglist.length<1) return;
			if(!this.isget){
				this.baocun();
				return true;
			}
		},
		computed: {
			getType() {
				return changelook[this.yinsi];
			}
		},
		onLoad(e) {
			// 读取缓存
			let res = uni.getStorageSync('addinput');
			if (res) {
				res = JSON.parse(res);
				this.yinsi = res.yinsi;
				this.imglistIds = res.imglistIds || [];
				if (this.imglistIds.length) {
					this.imglist = res.imglist;
				}
				this.text = res.text;
				if (res.postclass) {
					this.postclass = res.postclass;
				}
				if (res.topic) {
					this.topic = res.topic;
				}
			}
			// 获取文章分类
			let postclass = e.postclass ? JSON.parse(e.postclass) : false;
			this.getPostClass(postclass);
			// 监听所属话题选择
			uni.$on('changeTopic',(data)=>{
				this.topic.id = data.id;
				this.topic.title = `#${data.title}#`;
			})
		},
		methods:{
			changeTopic(){
				uni.navigateTo({
					url:"/pages/topic-nav/topic-nav?ischange="+true,
				});
			},
			async getPostClass(postclass){
				if (postclass) {
					this.postclass.list = postclass;
					let arr = [];
					for (let i = 0; i < postclass.length; i++) {
						arr.push(postclass[i].name)
					}
					return this.postclass.range = arr;
				}
				try{
					let [err,res] = await this.$http.get('/postclass');
					if (!this.$http.errorCheck(err,res)) return;
					let list = res.data.data.list;
					let arr = [] , arr2 = [];
					for (let i = 0; i < list.length; i++) {
						arr.push(list[i].classname);
						arr2.push({
							id:list[i].id,
							name:list[i].classname
						})
					}
					this.postclass.range = arr;
					this.postclass.list = arr2;
				}catch(e){
					return;
				}
			},
			changePostClass(e){
				console.log(e)
				// 当前选中的id
				this.postclass.id = this.postclass.list[e.target.value].id;
				// 当前选中的名称
				this.postclass.title = this.postclass.list[e.target.value].name;
				console.log(this.postclass.list[e.target.value])
			},
			// 保存为草稿
			baocun(){
				uni.showModal({
					content: '是否要保存为草稿？',
					cancelText: '不保存',
					confirmText: '保存',
					success: res => {
						if(res.confirm){
							// 本地存储
							let obj = {
								yinsi:this.yinsi,
								text:this.text,
								imglist:this.imglist,
								imglistIds:this.imglistIds,
								postclass:this.postclass,
								topic:this.topic
							};
							uni.setStorageSync('addinput',JSON.stringify(obj))
						}else{
							uni.removeStorage({ key:"addinput" }) // 清除缓存
						}
						this.isget=true;
						uni.navigateBack({
							delta: 1
						});
					},
				});
			},
			// 返回
			back(){
				uni.navigateBack({ delta: 1 });
			},
			// 发布
			async submit(){
				if (!this.postclass.id) {
					return uni.showToast({
						title: '请选择分类',icon:"none"
					});
				}
				uni.showLoading({ title: '发布中...', mask: true });
				try{
					let [err,res] = await this.$http.post('/post/create',{
						imglist:JSON.stringify(this.imglistIds),
						text:this.text,
						isopen:this.yinsi,
						topic_id:this.topic.id,
						post_class_id:this.postclass.id
					},{
						token:true,
						checkToken:true,
						checkAuth:true
					});
					// 发布失败
					if (!this.$http.errorCheck(err,res)) {
						return uni.hideLoading();
					}
					// 发布成功
					uni.hideLoading();
					uni.showToast({
						title: '发布成功！'
					});
					this.isget = true;
					uni.$emit('updateData',{ 
						type:"updateList",
						data:res.data.data.detail
					});
					uni.navigateBack({ delta: 1 });
					
				}catch(e){
					return;
				}
			},
			// 隐私
			changelook(){
				uni.showActionSheet({
					itemList:changelook,
					success: (res)=> {
						this.yinsi = res.tapIndex
					}
				});
			},
			upload(item){
				this.imglist.push(item.url);
				this.imglistIds.push({ id:item.id });
			},
			delImageList(index){
				this.imglist.splice(index,1);
				this.imglistIds.splice(index,1);
			},
			hidePopup(){
				this.showpopup=false;
			}
		}
	}
</script>

<style>
.uni-textarea{
	border: 1upx solid #EEEEEE;
}
.gonggao{
	width: 500upx;
}
.gonggao image{
	width: 75%;
	margin-bottom: 20upx;
}
.gonggao button{
	margin-top: 20upx;
	background: #FFE934;
	color: #171606;
}
.addinput-foot{
	background: #FFFFFF;
	position: fixed;bottom: 0;left: 0;right: 0;height: 88upx;border-top:1upx solid #DDDDDD
}
.addinput-foot view{
	height: 100%;
}
.addinput-foot-btn{
	background: #F4F4F4;
}
</style>
