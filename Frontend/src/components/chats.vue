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
            v-for="(chat, key) in chats"
            :key="key"
            :img-src="'/api/get_avatar?username=' + chat.friend.name"
            img-left
            img-width="80"
            img-height="80"
          >
            {{ chat.friend.firstname + " " + chat.friend.lastname }}
            <b-button
              @click="$router.push('/profile/' + chat.friend.name)"
              variant="primary"
              >Profile</b-button
            >
            <b-button
              @click="$router.push('/chat/' + chat.friend.name)"
              variant="success"
              >Chat</b-button
            >
            <span style="float:right;">
              {{
                "Последнее сообщение " +
                  mom(chat.last_activity, "DD-MM-YYYY hh:mm:ss")
              }}
              <b-badge
                style="float:right;"
                v-if="chat.unread > 0"
                variant="warning"
                >{{ chat.unread }}</b-badge
              >
            </span>
          </b-card>
        </b-card>
      </b-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  name: "chats",

  data() {
    return {
      waiting: false,
      chats: [],
      interId: null
    };
  },

  methods: {
    getMyChats() {
      var self = this;
      axios.get("/api/get_my_chats").then(function(response) {
        if (response.data.answer === true) self.chats = response.data.chats;
      });
    },
    mom(str, pattern) {
      return moment(str, pattern).fromNow();
    }
  },
  computed: {
    username() {
      return this.$store.getters.username;
    }
  },
  mounted() {
    const self = this;
    self.getMyChats();
    moment.locale("ru");
    self.interId = setInterval(self.getMyChats, 4000);

    console.log(this.chats, "chats");
  },
  beforeDestroy() {
    clearInterval(this.interId);
  }
};
</script>
