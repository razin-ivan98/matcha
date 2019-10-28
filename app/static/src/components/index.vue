<template>
<div>GOVONO</div>
</template>

<script>

import axios from 'axios'

export default {

  methods: {
    // isSigned(){
    //   var self = this;
    //   axios.get('/api/is_signed').then(function (response) {
    //     ///  console.log(response);
    //      // alert(response.data.answer);
    //       if (response.data.answer === true)
    //         self.$emit('signed-in', response.data.username);
    //       else
    //         self.$emit('signed-out', response.data.username);
    //     }, function (error) {
    //       console.log(error)
    //     })
    // }

    
  },



  // watch:{
  //   username: function(val){
  //     if (this.username === false)
  //       this.$emit('signed-out');
  //     else if (this.username === null){}
  //     else{
  //       this.$emit('signed-in');
  //     }
  //   }
  // },
  created(){
    if (this.username === false)
      this.$emit('signed-out');
    else if (this.username === null){}
    else
      this.$emit('signed-in');
  },

  // computed:{
  //   username(){
  //     return this.$store.getters.username;
  //   }
  // },
}
</script>