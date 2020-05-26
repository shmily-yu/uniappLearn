<script>
	export default {
		onLaunch: function () {
			// 网路监听（用户目前断网，切换wifi）
			// 更新检测
			console.log('App Launch')
			console.log(this.config.webUrl)
			this.lib.ceshi('1111')
			console.log(this.lib.Chat.isopen)
			this.lib.Chat.get();
			this.lib.Chat.send('哈哈哈')
		},
		onShow: function () {
			console.log('App Show')
		},
		onHide: function () {
			console.log('App Hide')
		}
	}
</script>

<style>
	/*每个页面公共css */
	/* 引入官方css库 */
	@import './common/uni.css';
	/* 引入自定义图标库 */
	@import './common/icon.css';
	/* 引入动画库 */
	@import './common/animate.css';
	/* 公共样式 */
	@import './common/common.css';
</style>
