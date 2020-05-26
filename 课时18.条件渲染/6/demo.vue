<template>
	<view>
		
		<!-- <view class="box" v-if="isshow">box</view> -->
		<!-- <button type="default" @tap="changeShow()">隐藏</button> -->
		
		<!-- <view class="box" v-if="(age>20)">{{ age>30?'中年人':'年轻人' }}</view>
		<button type="default" @tap="changeAge()">修改</button> -->
	
		<!-- <view class="box" v-show="isshow">显示</view>
		<button type="default" @tap="changeShow()">隐藏</button> -->
		
		<!-- <view class="box" v-show="(age>20)">{{age}}</view>
		<button type="default" @tap="changeAge()">隐藏</button> -->
		
		<template v-if="isshow">
			<view class="box">box</view>
		</template>
		<template v-else-if="isshow2">
			<view class="box" style="background: red;">box2</view>
		</template>
		<template v-else>
			<view class="box" style="background: #09BB07;">box2</view>
		</template>
	
	<button type="default" @tap="changeShow()">隐藏</button>
	
	
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isshow:true,
				age:10,
				isshow2:true
			}
		},
		methods:{
			changeShow:function(){
				this.isshow=!this.isshow;
			},
			changeAge:function(){
				this.age+=11;
			}
		}
	}
</script>

<style>
.box{
	background: #007AFF;
	color: #FFFFFF;
	font-size: 50upx;
	width: 350upx;
	height: 350upx;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
