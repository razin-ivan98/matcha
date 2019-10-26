<template>

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

  props: {
    username: ''
  },

  mounted(){
   // alert(this.username);
    if (this.username !== null)
      this.$emit('signed-in');
    else
      this.$emit('signed-out');
  }
}
</script>