<template>
	<view class="home-list-item u-f-ac u-f-jsb" 
	hover-class="home-list-hover">
		<view class="u-f-ac">
			<view class="icon iconfont"
			:class="['icon-'+item.icon]"></view>
			{{item.name}}
		</view>
		<view class="icon iconfont icon-jinru"></view>
	</view>
</template>

<script>
	export default {
		props:{
			item:Object,
			index:Number
		}
	}
</script>

<style scoped>
.home-list-item{
	padding: 20upx;
	border-top: 1upx solid #F4F4F4;
	border-bottom: 1upx solid #F4F4F4;
}
.home-list-item>view:first-child{
	color: #333333;
}
.home-list-item>view:first-child>view{
	margin-right: 10upx;
}
.home-list-item>view:last-child{
	color: #CCCCCC;
}
.home-list-hover{
	background: #f4f4f4;
}
</style>
