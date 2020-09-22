<template>
  <div id="app">
    <headcomp @signed-out="onSigningOut" @update="updateAll"></headcomp>

    <div style="height: 50px"></div>

    <div class="text-center" v-if="status == 'request'">
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        class="mt-5"
      ></b-spinner>
    </div>

    <router-view
      class="mt-3"
      v-if="status == 'ready'"
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
      this.$router.push("user").catch(e => {});
    },

    onSigningOut() {
      this.$store.commit("change_username", false);
      this.$store.commit("change_likes", 0);
      this.$store.commit("change_dialogs", 0);
      this.$store.commit("change_guests", 0);
      this.$store.commit("change_user_info", false);

      var self = this;
      axios.get("/api/sign_out").then(function() {
        self.$router.push("sign_in");
      });
    },

    updateAll() {
      var self = this;
      if (!self.$store.getters.username) return;
      if (!self.$store.getters.registration_ended) return;
      axios.get("/api/get_unread_likes_count").then(function(response) {
        if (response.data.answer === true)
          self.$store.commit("change_likes", response.data.likes_count);
      });

      axios.get("/api/get_unread_dialogs_count").then(function(response) {
        if (response.data.answer === true)
          self.$store.commit("change_dialogs", response.data.dialogs_count);
      });

      axios.get("/api/get_unread_guests_count").then(function(response) {
        if (response.data.answer === true)
          self.$store.commit("change_guests", response.data.guests_count);
      });
    }
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
    this.updateAllInterval = setInterval(() => {
      this.updateAll();
    }, 5000);
  },
  beforeDestroy() {
    clearInterval(this.updateAllInterval);
  }
};
</script>

<style>
body {
  background-color: #bff5d1;
}
</style>
