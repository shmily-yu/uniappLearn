<template>
	<view class="body">
		
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>头像</view>
			<view class="u-f-ac" @tap="changeimg">
				<image :src="userpic" mode="aspectFill" lazy-load></image>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>昵称</view>
			<view class="u-f-ac">
				<input type="text" v-model="username" />
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>性别</view>
			<view class="u-f-ac" @tap="changeOne('sex')">
				<view>{{sexArr[sex]}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>生日</view>
			<picker mode="date" :value="birthday" :start="startDate" :end="endDate" @change="bindDateChange">
			<view class="u-f-ac">
				<view>{{birthday}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
			</picker>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>情感</view>
			<view class="u-f-ac" @tap="changeOne('qg')">
				<view>{{qgArr[qg]}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>职业</view>
			<view class="u-f-ac" @tap="changeOne('job')">
				<view>{{job}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		<view class="user-set-userinfo-list u-f-ac u-f-jsb">
			<view>家乡</view>
			<view class="u-f-ac" @tap="showMulLinkageThreePicker">
				<view>{{pickerText}}</view>
				<view class="icon iconfont icon-bianji1"></view>
			</view>
		</view>
		
		<button class="user-set-btn" 
		type="primary" @tap="submit">完成</button>
		
		
		<mpvue-city-picker themeColor="#007AFF" ref="mpvueCityPicker" :pickerValueDefault="cityPickerValueDefault" @onConfirm="onConfirm"></mpvue-city-picker>
		
	</view>
</template>

<script>
	let sexArr=['不限','男','女'];
	let qgArr=['秘密','未婚','已婚'];
	let job=['秘密','IT','老师'];
	import mpvueCityPicker from "../../components/mpvue-citypicker/mpvueCityPicker.vue";
	import Time from '../../common/time.js';
	export default {
		components:{
			mpvueCityPicker
		},
		data() {
			return {
				sexArr:sexArr,
				qgArr:qgArr,
				userpic:"",
				username:"",
				sex:0,
				qg:0,
				job:"",
				birthday:"",
				cityPickerValueDefault: [0, 0, 1],
				pickerText: '',
			}
		},
		onLoad() {
			this.userpic = this.User.userinfo.userpic;
			this.username = this.User.userinfo.username;
			this.sex = this.User.userinfo.userinfo.sex || 0;
			this.qg = this.User.userinfo.userinfo.qg || 0;
			this.job = this.User.userinfo.userinfo.job || "请填写";
			this.birthday = this.User.userinfo.userinfo.birthday || "请填写";
			this.pickerText = this.User.userinfo.userinfo.path || "请填写";
		},
		onBackPress() {
		  if (this.$refs.mpvueCityPicker.showPicker) {
		  	this.$refs.mpvueCityPicker.pickerCancel();
		    return true;
		  }
		},
		onUnload() {
			if (this.$refs.mpvueCityPicker.showPicker) {
				this.$refs.mpvueCityPicker.pickerCancel()
			}
		},
		computed: {
			startDate() {
				return this.getDate('start');
			},
			endDate() {
				return this.getDate('end');
			}
		},
		methods: {
			// 三级联动
			showMulLinkageThreePicker() {
				this.$refs.mpvueCityPicker.show()
			},
			onConfirm(e) {
				this.pickerText = e.label;
			},
			// 修改生日
			bindDateChange(e) {
				this.birthday = e.target.value
			},
			// 修改头像
			async changeimg(){
				let [err,res] =await uni.chooseImage({
					count:1,
					sizeType:['compressed']
				});
				if (!res) return;
				// 上传
				uni.showLoading({ title: '上传中...', mask: false });
				let [err2,res2] = await this.$http.upload('/edituserpic',{
					name: 'userpic',
					filePath: res.tempFilePaths[0],
					token:true,
					checkToken:true
				});
				// 请求失败
				let data = JSON.parse(res2.data);
				// 上传失败
				if (err2 || data.errorCode) {
					uni.showToast({ title: data.msg ? data.msg : '上传失败', icon:"none" });
					uni.hideLoading();
					return false;
				}
				// 成功
				uni.hideLoading();
				uni.showToast({ title: '修改头像成功!' });
				this.userpic = data.data;
				// 修改状态，存储
				this.User.userinfo.userpic = this.userpic;
				uni.setStorageSync("userinfo",this.User.userinfo);
			},
			// 单列选择
			changeOne(val){
				let arr=[];
				switch (val){
					case 'sex':
					arr=sexArr;
						break;
					case 'qg':
					arr=qgArr;
						break;
					case 'job':
					arr=job;
						break;
				}
				uni.showActionSheet({
					itemList: arr,
					success: res => {
						switch (val){
							case 'sex':
							this.sex=res.tapIndex;
								break;
							case 'qg':
							this.qg=res.tapIndex;
								break;
							case 'job':
							this.job=arr[res.tapIndex];
								break;
						}
					},
				});
			},
			// 完成
			async submit(){
				let data = {
					name:this.username,
					sex:this.sex,
					qg:this.qg,
					job:this.job,
					birthday:this.birthday,
					path:this.pickerText,
					age:Time.gettime.getAgeByBirthday(this.birthday),
				};
				let [err,res] = await this.$http.post('/edituserinfo',data,{
					token:true,
					checkToken:true
				});
				// 请求失败处理
				if (!this.$http.errorCheck(err,res)) return;
				// 成功
				uni.showToast({ title: '修改成功！' });
				// 修改状态，缓存
				this.User.userinfo.username = this.username;
				this.User.userinfo.userinfo = data;
				uni.setStorageSync('userinfo',this.User.userinfo);
			},
			getDate(type) {
				const date = new Date();
				let year = date.getFullYear();
				let month = date.getMonth() + 1;
				let day = date.getDate();

				if (type === 'start') {
					year = year - 60;
				} else if (type === 'end') {
					year = year + 2;
				}
				month = month > 9 ? month : '0' + month;;
				day = day > 9 ? day : '0' + day;
				return `${year}-${month}-${day}`;
			}
		}
	}
</script>

<style>
@import "../../common/form.css";
.user-set-userinfo-list{
	padding: 20upx;
	border-bottom: 1upx solid #F4F4F4;
}
.user-set-userinfo-list>view:first-child{
	font-size: 32upx;
	font-weight: bold;
	color: #9B9B9B;
}
.user-set-userinfo-list>view:last-child>image{
	width: 80upx;
	height: 80upx;
	border-radius: 100%;
}
.user-set-userinfo-list>view:last-child>input{
	text-align: right;
}
.user-set-userinfo-list>view:last-child>view:last-of-type{
	margin-left: 20upx;
	color: #9B9B9B;
}
</style>
