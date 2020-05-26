import Vue from 'vue'
import App from './App'

Vue.config.productionTip = false

import Chat from './common/chat.js';
import Config from './common/config.js';
Vue.prototype.Chat = Chat;
Vue.prototype.Config = Config;

App.mpType = 'app'

const app = new Vue({
    ...App
})
app.$mount()
