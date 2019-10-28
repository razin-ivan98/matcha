<template>
  <div id="app">
    <headcomp
    @signed-out="onSigningOut"
    ></headcomp>

    <router-view 
    v-if="this.$store.getters.username !== null"
    @signed-in="onSigning"
    @signed-out="onSigningOut"
    ></router-view>

    <div class="text-center" v-if="this.$store.getters.username === null">
    <b-spinner variant="success"
    style="width: 3rem; height: 3rem;"
    label="Large Spinner"
    class="mt-5">
    </b-spinner>
    </div>

  </div>
</template>

<script>

import headcomp from './components/headcomp.vue'
import axios from 'axios'

export default {
  name: 'app',
  
  data(){
    return {
      //username: null
    }
  },

  methods: {
    onSigning(name = null){
      if (name !== null)
        this.$store.commit('change_username', name);
      this.$router.push('user');
     
    },

    onSigningOut(){
      this.$store.commit('change_username', false);
      var self = this;
      axios.get('/api/sign_out').then(function(){
         self.$router.push('sign_in');
       // this.$emit('signed-out');
      });

     
    },

   isSigned(){
      var self = this;
      axios.get('/api/get_username').then(function (response) {
          if (response.data.answer === true)
          {
            self.$store.commit('change_username', response.data.username);
            self.$store.commit('change_confirmed', response.data.confirmed);
          }
          else
            self.$store.commit('change_username', false);
        }, function (error) {
          console.log(error)
        })
    },


  },

  computed: {
    username(){
      return this.$store.getters.username;
    }
  },

  components: {
    headcomp
  },

  watch: {
    username: function(value){
      if ((this.$route.name === 'sign_in' || this.$route.name === 'sign_up') && this.username !== false)
        this.$router.push('user');
      else if ((this.$route.name !== 'sign_in' && this.$route.name !== 'sign_up') && this.username === false)
        this.$router.push('sign_in');
    }
  },

 /* async */created() {///////////////////////////////////////////////////////////////////
    console.log('isSigned started');
    /*await*/ this.isSigned();//////////////////////////////
    console.log('isSigned should be done');
  }//////////////////////////////////////////
}
</script>

<style>

</style>
