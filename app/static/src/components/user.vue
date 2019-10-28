<template>
  <div>
    
      <b-card
      title="Prifile"
      style="max-width: 20rem;"
      class="mb-2 mt-5 mx-auto">
        <h2>Hello, {{this.username}}</h2>
      </b-card>
    
  </div>
</template>

<script>


export default {

  name: 'user',

  data(){
    return{
      //username: 'user',
    }
  },

  
  computed:{
    username(){
      return this.$store.getters.username;
    }
  },

}
</script>