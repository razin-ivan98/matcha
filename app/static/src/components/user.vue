<template>
  <div>
    
      

      <b-card
     
      title="Recomendations for u"
      style="background-color: #aaffaa"
      class="m-5">
      
          <div class="text-center" v-if="waiting === true">
          <b-spinner variant="warning"
          style="width: 3rem; height: 3rem;"
          label="Large Spinner"
          class="mt-5">
          </b-spinner>
          </div>

          
        <b-container class="mx-auto"  v-if="waiting === false">
          <b-row align-content='between'>
          <b-col align-self='center' v-for="user in users">
            <b-card
              :title="user.firstname + ' ' + user.lastname"
              :img-src=" '/api/download_image?avatar=' + user.avatar "
              img-alt="Image"
              img-top
              tag="article"
              style="max-width: 20rem; min-width: 20rem;"
              class="mt-2 mx-auto">

              <b-card-text>
                {{ user.gender }}
              </b-card-text>

              <b-card-text>
                {{ user.orientation }}
              </b-card-text>

              <b-button href="#" variant="primary">Go to profile</b-button>
            </b-card>
            </b-col>
          </b-row>
        </b-container>
      </b-card>
    
  </div>
</template>

<script>

import axios from 'axios'

export default {

  name: 'user',

  data(){
    return{
      users: ['ololo'],
      waiting: true
    }
  },

  
  computed:{
    username(){
      return this.$store.getters.username;
    }
  },
  mounted(){
    var self = this;
    console.log(this.users);
    axios.get('/api/get_recomended_users').then(function(response){
      if (response.data.answer === true){
        self.users = response.data.users;
        console.log(self.users);
        self.waiting = false;
      } else {
        ////////////////////////////////
      }
    })
  }

}
</script>

<style>
.as
{
  background-color: green;
}
</style>