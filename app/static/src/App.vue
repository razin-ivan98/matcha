<template>

  <div id="app">
  
    <router-view
    @signed-out="onSigningOut"
    @signed-in="onSigning"
    :username="this.username"
    ></router-view>

  </div>
</template>

<script>

//  import signIn from './components/signIn.vue'


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
      console.log('ou');
      this.$router.push('sign_in');
    },


  },

  created(){
    this.isSigned();
  }
}
</script>

<style>

</style>
