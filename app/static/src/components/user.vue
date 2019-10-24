<template>
  <div>
    <headcomp @signed-out="signedOut" :username="this.username"></headcomp>
      <b-card title="Prifile" style="max-width: 20rem;" class="mb-2 mt-5 mx-auto">
        <h2>Hello, {{this.username}}</h2>
      </b-card>
    
  </div>
</template>

<script>

import headcomp from './headcomp.vue'

export default {

  data(){
    return{
      //username: 'user',
    }
  },
  
  props: {
    username: String
  },

  components: {
    headcomp,
  },
  
  methods: {
    signedOut()
    {
      this.$emit('signed-out');
    }

    
  }

}
</script>