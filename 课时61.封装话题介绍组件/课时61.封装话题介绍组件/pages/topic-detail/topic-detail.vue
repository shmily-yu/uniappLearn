<template>
	<view>
		<!-- 话题介绍 -->
		<topic-info :item="topicInfo"></topic-info>
		
	</view>
</template>

<script>
	import topicInfo from "../../components/topic/topic-info.vue";
	export default {
		components:{
			topicInfo
		},
		data() {
			return {
				topicInfo:{
					titlepic:"../../static/demo/topicpic/13.jpeg",
					title:"忆往事，敬余生",
					desc:"我是描述",
					totalnum:1000,
					todaynum:1000,
				}
			};
		}
	}
</script>

<style>

</style>
