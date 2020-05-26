<template>
	<view class="user-chat-bottom u-f-ac animated fadeInDown fast">
		<textarea placeholder="文明发言" auto-height fixed v-model="text"/>
		<!-- <input type="text" placeholder="文明发言" v-model="text"/> -->
		<view class="icon iconfont icon-fabu u-f-ajc" @tap="submit"></view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				text:""
			}
		},
		methods:{
			submit(){
				this.$emit('submit',this.text);
				this.text="";
			}
		}
	}
</script>

<style scoped>
.user-chat-bottom{
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	height: 120upx;
	padding: 0 20upx;
	background: #FFFFFF;
	border-top: 1upx solid #EEEEEE;
}
.user-chat-bottom>textarea{
	flex: 1;
	margin-right: 20upx;
	padding: 20upx 20upx;
	border-radius: 10upx;
	background: #F7F7F7;
	min-height: 75upx;
	max-height: 100upx;
	box-sizing: border-box;
}
.user-chat-bottom>view{
	width: 80upx;
	font-size: 45upx;
}
</style>
