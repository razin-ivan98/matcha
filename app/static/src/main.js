import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VueRosource from 'vue-resource'
import VueRouter from 'vue-router'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import signIn from './components/signIn.vue'
import signUp from './components/signUp.vue'
import user from './components/user.vue'
import index from './components/index.vue'

Vue.use(BootstrapVue);
Vue.use(VueRosource);
Vue.use(VueRouter);

Vue.config.productionTip = false;

var router = new VueRouter({
  mode: 'history',
  routes: [
    { name: 'index', path: '/', component: index },
    { name: 'sign_in', path: '/sign_in', component: signIn },
    { name: 'sign_up', path: '/sign_up', component: signUp },
    { name: 'user', path: '/user', component: user }
  ]
})

new Vue({

  render: h => h(App),
  router: router
}).$mount('#app')
