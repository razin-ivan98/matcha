<template>
  <div id="app">
    <headcomp @signed-out="onSigningOut" @update="updateAll"></headcomp>

    <div style="height: 50px"></div>

    <div class="text-center" v-if="status=='request'">
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        class="mt-5"
      ></b-spinner>
    </div>

    <router-view
      class="mt-3"
      v-if="status=='ready'"
      @signed-in="onSigning"
      @signed-out="onSigningOut"
    ></router-view>
  </div>
</template>

<script>
import headcomp from "./components/headcomp.vue";
import axios from "axios";

export default {
  name: "app",

  data() {
    return {
      //username: null
    };
  },

  methods: {
    onSigning() {
      this.$router.push("user").catch(e => {
        console.log("ERROR: " + e);
      });
    },

    onSigningOut() {
      this.$store.commit("change_username", false);
      var self = this;
      axios.get("/api/sign_out").then(function() {
        self.$router.push("sign_in");
      });
    },

    updateAll() {
      var self = this;
      axios.get("/api/get_unread_likes_count").then(function(response) {
        if (response.data.answer === true)
          self.$store.commit("change_likes", response.data.likes_count);
      });

      axios.get("/api/get_unread_dialogs_count").then(function(response) {
        if (response.data.answer === true)
          self.$store.commit("change_dialogs", response.data.dialogs_count);
      });
    }

    // isSigned() {
    //   var self = this;
    //   return new Promise((resolve, reject) => {
    //     axios.get('/api/get_username').then(function (response) {
    //       if (response.data.answer === true) {
    //         self.$store.commit('change_username', response.data.username);
    //         self.$store.commit('change_confirmed', response.data.confirmed);
    //         console.log('done');
    //         resolve(true);
    //       }
    //       else {
    //         self.$store.commit('change_username', false);
    //         console.log('done');
    //         resolve(false);
    //       }

    //     }, function (error) {
    //       console.log(error)
    //     })
    //   })

    // },
  },

  computed: {
    username() {
      return this.$store.getters.username;
    },
    confirmed() {
      return this.$store.getters.confirmed;
    },
    status() {
      return this.$store.getters.status;
    }
  },

  components: {
    headcomp
  },

  mounted() {
    this.updateAll();
    setInterval(() => {
      this.updateAll();
    }, 5000);
  }
};
</script>

<style>
body {
  background-color: #bff5d1;
}
</style>
