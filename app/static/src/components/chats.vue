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
            :img-src=" '/api/get_avatar?username=' + chat.friend.name"
            img-left
            img-width="80"
            img-height="80"
          >
            {{ chat.friend.firstname + ' ' + chat.friend.lastname }}
            <b-button :href="'/profile/' + chat.friend.name" variant="primary">Profile</b-button>
            <b-button :href="'/chat/'+chat.friend.name" variant="success">Chat</b-button>
          </b-card>
        </b-card>
      </b-container>
    </div>
  </div>
</template>



<script>
import axios from "axios";

export default {
  name: "chats",

  data() {
    return {
      waiting: false,
      chats: []
    };
  },

  methods: {
    getMyChats() {
      var self = this;
      axios.get("/api/get_my_chats" + username).then(function(response) {
        if (response.data.answer === true) self.chats = response.data.chats;
      });
    }
  },
  mounted() {
    getMyChats();
  }
};
</script>