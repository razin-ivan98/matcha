<template>

  <div id="app">
    <headcomp
    @signed-out="onSigningOut"
    :username="this.username"
    ></headcomp>

    <router-view
    @signed-in="onSigning"
    @signed-out="onSigningOut"
    :username="this.username"
    ></router-view>

  </div>
</template>

<script>

import headcomp from './components/headcomp.vue'
import axios from 'axios'

export default {
  name: 'app',
  
  data(){
    return {
      username: null
    }
  },

  methods: {
    onSigning(name){
      this.$router.push('user');
      this.username = name;
    },

    onSigningOut(){
      this.username = null;
      var self = this;
      axios.get('/api/sign_out');

      this.$router.push('sign_in');
    },

    isSigned(){
      var self = this;
      axios.get('/api/get_username').then(function (response) {
        ///  console.log(response);
         // alert(response.data.answer);
         //alert(response.data.username);
          if (response.data.answer === true)
          {
            //alert(response.data.username);
            self.username = response.data.username;
          }
          else
            self.username = null;
        }, function (error) {
          console.log(error)
        })
    }


  },

  components: {
    headcomp
  },

  async created() {///////////////////////////////////////////////////////////////////
    const value = new Promise((resolve) => this.isSigned())////////////////////////////
    //this.isSigned();//////////////////////////////
  }//////////////////////////////////////////
}
</script>

<style>

</style>
