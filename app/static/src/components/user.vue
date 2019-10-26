<template>
  <div>
    
      <b-card title="Prifile" style="max-width: 20rem;" class="mb-2 mt-5 mx-auto">
        <h2>Hello, {{this.username}}</h2>
      </b-card>
    
  </div>
</template>

<script>


export default {

  data(){
    return{
      //username: 'user',
    }
  },
  
  props: {
    username: null
  },

  
  methods: {

    
  },

  updated(){
    //if (this.username === null)
     // this.$emit('signed-out');
  }
}
</script>