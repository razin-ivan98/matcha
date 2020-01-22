<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="success" fixed="top" v-if="this.username">
      <b-navbar-brand href="/">Matcha</b-navbar-brand>
      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="/settings">Settings</b-nav-item>
          <b-nav-item href="/user">Feed</b-nav-item>
          <b-nav-item href="/my_profile">Profile</b-nav-item>
          <b-nav-item>Likes</b-nav-item>
        </b-navbar-nav>
        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item-dropdown right>
            <!-- Using 'button-content' slot -->
            <template v-slot:button-content>
              <em>{{ username }}</em>
            </template>
            <b-dropdown-item href="#">Profile</b-dropdown-item>
            <b-dropdown-item @click="signOut">Sign Out</b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

    <b-navbar toggleable="lg" type="dark" variant="success" fixed="top" v-else>
      <b-navbar-brand href="/">Matcha</b-navbar-brand>
    </b-navbar>
  </div>
</template>


<script>
import axios from "axios";

export default {
  name: "headcomp",

  // data() {
  //   return{
  //     username: null
  //   }
  // },

  methods: {
    signOut() {
      this.$emit("signed-out");
    }

    // getUserName(){
    //   var self = this;
    //   axios.get('/api/get_username').then(function (response) {
    //       self.username = response.data.username;
    //       console.log(response.data.username);
    //     }, function (error) {
    //       console.log(error)
    //     })
    // }
  },
  computed: {
    username() {
      return this.$store.getters.username;
    }
  }

  // created(){
  //   this.getUserName();
  // }
};
</script>