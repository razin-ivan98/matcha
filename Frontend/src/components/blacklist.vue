<template>
  <div>
    <div class="text-center" v-if="waiting === true">
      <b-spinner
        variant="warning"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        class="mt-5"
      ></b-spinner>
    </div>

    <div v-if="waiting === false">
      <b-container>
        <b-card>
          <b-card
            v-for="(user, key) in blacklist"
            :key="key"
            :img-src="'/api/get_avatar?username=' + user.name"
            img-left
            img-width="80"
            img-height="80"
          >
            {{ user.firstname + " " + user.lastname }}
            <b-button
              @click="$router.push('/profile/' + user.name)"
              variant="primary"
            >
              Profile
            </b-button>
            <b-button
              @click="unblock(user.name)"
              style="position: inline block"
              variant="success"
              >Unblock</b-button
            >
          </b-card>
        </b-card>
      </b-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "blaclist",

  data() {
    return {
      waiting: true,
      blacklist: []
    };
  },

  methods: {
    unblock(username) {
      var self = this;
      axios.get("/api/unblock?username=" + username).then(function() {
        self.getBlacklist();
      });
    },
    getBlacklist() {
      var self = this;
      self.waiting = true;
      axios.get("/api/get_blacklist").then(function(response) {
        if (response.data.answer === true) {
          self.blacklist = response.data.blacklist;
        }
        self.waiting = false;
      });
    }
  },
  mounted() {
    this.getBlacklist();
  }
};
</script>
