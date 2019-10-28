import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VueRosource from 'vue-resource'
import VueRouter from 'vue-router'
import Vuex from 'vuex'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import 'es6-promise/auto';

import signIn from './components/signIn.vue'
import signUp from './components/signUp.vue'
import user from './components/user.vue'
import index from './components/index.vue'
import input_data from './components/input_data.vue'


Vue.use(BootstrapVue);
Vue.use(VueRosource);
Vue.use(VueRouter);
Vue.use(Vuex)

Vue.config.productionTip = false;

var router = new VueRouter({
  mode: 'history',
  routes: [
    { name: 'index', path: '/', component: index },
    { name: 'sign_in', path: '/sign_in', component: signIn },
    { name: 'sign_up', path: '/sign_up', component: signUp },
    { name: 'user', path: '/user', component: user },
    { name: 'input_data', path: '/input_data', component: input_data }

  ]
})

const store = new Vuex.Store({
  state: {
    username: null,
    confirmed: null,
  },
  mutations: {
    change_username(state, new_username) {
      state.username = new_username;
    },
    change_confirmed(state, new_confirmed) {
      state.confirmed = new_confirmed;
    }
  },
  getters: {
    username: state => {
      return state.username;
    },
    confirmed: state => {
      return state.confirmed;
    }
  },

})

new Vue({

  render: h => h(App),
  router: router,
  store: store,

}).$mount('#app')
