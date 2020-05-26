<template>
	<view>
		
		<view class="font">
			{{ ZHweight }}
		</view>
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				//体重
				weight:1500
			}
		},
		computed:{
			ZHweight:function(){
				return this.weight>1000 ? (this.weight/1000)+'kg':this.weight+'g';
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
