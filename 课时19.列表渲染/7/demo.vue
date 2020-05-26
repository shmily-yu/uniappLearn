<template>
	<view>
		
	<!-- 循环一维数组 -->
	<!-- <view class="font" v-for="(val,index) in list1" :key="index">
		{{index}} - {{val}}
	</view> -->
	<!-- <view 
	class="font" 
	v-for="(val,index) in list2" 
	:key="index">
		{{index}} - {{val.name}} - {{val.id}}
	</view> -->
	<!-- 循环二维数组 -->
	<!-- <view 
	class="font" 
	v-for="(val1,index1) in list3" 
	:key="index1">
		
		<view class="font">{{val1.name}}</view>
		<view class="font" 
		v-for="(val2,index2) in val1.list"
		:key="index2">
			{{index2}} - {{val2}}
		</view>
		
	</view> -->
	<!-- 循环对象 -->
	<!-- <view 
	class="font"
	v-for="(val,key) in objlist"
	:key="key">
	  {{key}} - {{val}}
	</view> -->
	
	<block v-for="(val,key) in objlist" :key="key">
		<view class="font">
		  {{key}} - {{val}}
		</view>
	</block>
	
	</view>
</template>

<script>
	export default {
		data() {
			return {
				list1:["篮球","足球","羽毛球"],
				list2:[
					{ name:"篮球",id:"lanqiu" },
					{ name:"足球",id:"zuqiu" },
					{ name:"羽毛球",id:"yumaoqiu" },
				],
				list3:[
					{ 
						name:"广东",
						list:["广州","深圳","佛山"]
					},
					{ 
						name:"四川",
						list:["重庆","不知道"]
					},
				],
				objlist:{
					name1:"篮球",
					name2:"足球",
					name3:"羽毛球"
				}
			}
		},
		methods:{
			
		}
	}
</script>

<style>
.font{
	font-size: 50upx;
}
</style>
