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
import input_data from './components/input_data.vue'
import settings from './components/settings.vue'
import my_profile from './components/my_profile.vue'
import profile from './components/profile.vue'
import likes from './components/likes.vue'

import axios from 'axios'


Vue.use(BootstrapVue);
Vue.use(VueRosource);
Vue.use(VueRouter);
Vue.use(Vuex)

Vue.config.productionTip = false;

var router = new VueRouter({
  mode: 'history',
  routes: [
    { name: 'index', path: '/', redirect: { name: 'user' } },

    { name: 'sign_in', path: '/sign_in', component: signIn, meta: { guest: true } },

    { name: 'sign_up', path: '/sign_up', component: signUp, meta: { guest: true } },

    { name: 'user', path: '/user', component: user, meta: { requiresAuth: true, requiresConfirm: true } },

    { name: 'settings', path: '/settings', component: settings, meta: { requiresAuth: true, requiresConfirm: true } },

    { name: 'my_profile', path: '/my_profile', component: my_profile, meta: { requiresAuth: true, requiresConfirm: true } },

    { name: 'input_data', path: '/input_data', component: input_data, meta: { requiresAuth: true } },

    { name: 'profile', path: '/profile/:username', component: profile, meta: { requiresAuth: true, requiresConfirm: true } },

    { name: 'likes', path: '/likes', component: likes, meta: { requiresAuth: true, requiresConfirm: true } }

  ]
})

router.beforeEach(async function (to, from, next) {

  store.commit('change_status', 'request');
  await store.dispatch('isSigned');
  store.commit('change_status', 'ready');

  console.log('Username: ' + store.getters.username);

  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (store.getters.username === false) {
      next({
        name: 'sign_in'
      })
      return;
    }
  }

  if (to.matched.some(record => record.meta.guest)) {
    if (store.getters.username !== false) {
      next({
        name: 'user'
      })
      return;
    }
  }

  if (to.matched.some(record => record.meta.requiresConfirm)) {
    if (store.getters.confirmed === false) {
      next({
        name: 'input_data'
      })
      return;
    }

  }
  next(); // всегда так или иначе нужно вызвать next()!
})

const store = new Vuex.Store({
  state: {
    username: null,
    confirmed: null,
    user_info: null,
    likes: null,
    status: 'ready'
  },
  mutations: {
    change_username(state, new_username) {
      state.username = new_username;
    },
    change_confirmed(state, new_confirmed) {
      state.confirmed = new_confirmed;
    },
    change_status(state, new_status) {
      state.status = new_status;
    },
    change_user_info(state, new_info) {
      state.user_info = new_info;
    },
    change_likes(state, new_likes) {
      state.likes = new_likes;
    }
  },
  getters: {
    username: state => {
      return state.username;
    },
    confirmed: state => {
      return state.confirmed;
    },
    status: state => {
      return state.status;
    },
    user_info: state => {
      return state.user_info;
    },
    likes: state => {
      return state.likes;
    }
  },
  actions: {
    isSigned({ commit }) {

      return new Promise((resolve, reject) => {
        axios.get('/api/get_username').then(function (response) {
          if (response.data.answer === true) {
            commit('change_username', response.data.username);
            commit('change_confirmed', response.data.confirmed);
            commit('change_user_info', response.data.user_info);
            console.log('done');
            resolve(true);
          }
          else {
            commit('change_username', false);
            console.log('done');
            resolve(false);
          }


        }, function (error) {
          console.log(error)
        })
      })

    },
  }

})

new Vue({

  render: h => h(App),
  router: router,
  store: store,

}).$mount('#app')
